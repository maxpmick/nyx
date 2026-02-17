---
name: sniffjoke
description: Transparent TCP/UDP connection scrambler that delays, modifies, and injects fake packets into transmissions to evade passive wiretapping, IDS, and sniffers. Use when performing network evasion, bypassing deep packet inspection (DPI), or testing the resilience of IDS/IPS systems against packet manipulation and fragmentation attacks.
---

# sniffjoke

## Overview
SniffJoke is a transparent proxy that mangles TCP/UDP traffic to make it unreadable by passive monitoring technologies. It operates by injecting evasion packets and altering headers, requiring a "location" configuration to ensure compatibility with the local ISP's packet handling policies. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume sniffjoke is already installed. If missing:

```bash
sudo apt install sniffjoke
```

## Common Workflows

### Initial Location Setup
Before using SniffJoke, you must test your current network environment to create a "location" profile.
```bash
sudo sniffjoke-autotest -l home_wifi
```

### Starting Evasion in Background
Start the service using a previously defined location and begin mangling immediately.
```bash
sudo sniffjoke --location home_wifi --start
```

### Monitoring and Control
Use the control utility to check status or pause the evasion.
```bash
sniffjokectl stat
sniffjokectl stop
```

### Debugging Packet Mangling
Run in the foreground with high verbosity to see packet-level details.
```bash
sudo sniffjoke --location home_wifi --foreground --debug 5
```

## Complete Command Reference

### sniffjoke
The main daemon for packet mangling and evasion.

| Flag | Description |
|------|-------------|
| `--location <name>` | Specify the network environment [default: generic] |
| `--dir <name>` | Base directory for location files [default: /usr/local/var/sniffjoke/] |
| `--user <username>` | Downgrade privilege to specified user [default: nobody] |
| `--group <groupname>` | Downgrade privilege to specified group [default: nogroup] |
| `--no-tcp` | Disable TCP mangling |
| `--no-udp` | Disable UDP mangling |
| `--whitelist` | Inject evasion packets ONLY in specified IP addresses |
| `--blacklist` | Inject evasion packets in all sessions EXCLUDING blacklisted IPs |
| `--start` | Activate evasion immediately on startup |
| `--chain` | Enable chained hacking for increased entropy |
| `--debug <0-5>` | Set verbosity (0: silent, 1: common, 2: verbose, 3: debug, 4: session, 5: packets) |
| `--foreground` | Run in foreground instead of background |
| `--admin <ip>[:port]` | Administration IP/port [default: 127.0.0.1:8844] |
| `--force` | Force restart if another instance is running |
| `--gw-mac-addr` | Specify gateway MAC (otherwise autodetected) |
| `--version` | Show version |
| `--help` | Show help |

### sniffjokectl
Command-line tool to control a running sniffjoke daemon.

**Options:**
- `--address <ip>[:port]`: Admin address [default: 127.0.0.1:8844]
- `--timeout`: Timeout in milliseconds [default: 500]
- `--version`: Show version
- `--help`: Show help

**Commands:**
- `start`: Start hijacking/injection
- `stop`: Pause evasion
- `quit`: Terminate sniffjoke service
- `saveconf`: Dump current configuration
- `stat`: Get configuration and network statistics
- `info`: Get active session statistics
- `ttlmap`: Show mapped hop counts for destinations
- `showport`: Show port-aggressivity configuration
- `debug [0-5]`: Change log level on the fly

### sniffjoke-autotest
Tests plugins against various OS targets to determine which evasion techniques work in the current network.

| Flag | Description |
|------|-------------|
| `-h` | Show help |
| `-l` | Location name (required) |
| `-n` | Number of replicas for a single hack (default: 1) |
| `-g` | Group for privilege downgrade (default: nogroup) |
| `-u` | User for privilege downgrade (default: nobody) |

### sj-iptcpopt-probe
Helper script for autotest to probe IP/TCP header option handling.

| Flag | Description |
|------|-------------|
| `-h` | Show help |
| `-w` | Working directory (required) |
| `-u` | Testing URL (required) |
| `-n` | Username for privilege downgrade |
| `-g` | Group for privilege downgrade |
| `-i` | Server IPv4 address (required) |

### sj-commit-results
Helper script to submit autotest results.

| Flag | Description |
|------|-------------|
| `-l` | Target location to send remotely (required) |
| `-u` | URL to commit to (required) |

## Notes
- **Critical Requirement**: You must run `sniffjoke-autotest` for every new network environment (ISP, VPN, or physical location) to ensure the evasion techniques do not drop legitimate traffic.
- SniffJoke requires `iptables` to redirect traffic into its mangling engine.
- Running with `--chain` increases entropy but may impact performance or connection stability depending on the network.