---
name: dhcpig
description: Perform advanced DHCP exhaustion attacks to consume all available IP addresses on a local network, preventing new users from connecting. Use when testing network resilience against DHCP starvation, performing denial-of-service (DoS) simulations, or testing DHCP server security during vulnerability assessments.
---

# dhcpig

## Overview
DHCPig is an advanced DHCP exhaustion script written in Python using the Scapy library. It is designed to consume all available IP addresses in a DHCP pool, release existing IPs, and use gratuitous ARP to knock Windows hosts offline. Category: Vulnerability Analysis.

## Installation (if not already installed)

Assume dhcpig is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install dhcpig
```

Dependencies: python3, python3-scapy.

## Common Workflows

### Basic DHCP Exhaustion
Exhaust all available IPv4 addresses on a specific interface:
```bash
sudo dhcpig eth0
```

### Aggressive Neighbor Attack
Exhaust the pool and actively attempt to disconnect existing hosts using gratuitous ARP and release packets:
```bash
sudo dhcpig -g -r eth0
```

### IPv6 Exhaustion with Rapid Commit
Perform a DHCPv6 exhaustion attack using the 2-way assignment process:
```bash
sudo dhcpig -6 -1 eth0
```

### Stealthy/Fuzzed Exhaustion
Use randomized MAC addresses and packet fuzzing to test DHCP server robustness:
```bash
sudo dhcpig -f -c eth0
```

## Complete Command Reference

```bash
pig.py [-h -v -6 -1 -s -f -t -a -i -o -l -x -y -z -g -r -n -c ] <interface>
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--verbosity` | Set verbosity level: 0 (none), 1 (minimal), 10 (default), 99 (debug) |
| `-c`, `--color` | Enable colorized output |

### Protocol Options

| Flag | Description |
|------|-------------|
| `-6`, `--ipv6` | Use DHCPv6 (default is DHCPv4) |
| `-1`, `--v6-rapid-commit` | Enable RapidCommit (2-way IP assignment instead of 4-way) |
| `-s`, `--client-src` | List of client MACs (e.g., `00:11:22:33:44:55,00:11:22:33:44:56`). Default: random |
| `-O`, `--request-options` | Option-codes to request (e.g., `21,22,23` or `12,14-19,23`). Default: 0-80 |
| `-f`, `--fuzz` | Randomly fuzz packets |

### Performance & Timing Options

| Flag | Description |
|------|-------------|
| `-t`, `--threads` | Number of sending threads (Default: 1) |
| `-x`, `--timeout-threads` | Thread spawn timer (Default: 0.4) |
| `-y`, `--timeout-dos` | DOS timeout (wait time to mass gratuitous ARP). Default: 8 |
| `-z`, `--timeout-dhcprequest` | DHCP request timeout (Default: 2) |

### Monitoring Options

| Flag | Description |
|------|-------------|
| `-a`, `--show-arp` | Detect and print ARP WHO_HAS requests |
| `-i`, `--show-icmp` | Detect and print ICMP requests |
| `-o`, `--show-options` | Print lease information |
| `-l`, `--show-lease-confirm` | Detect and print DHCP replies |

### Neighbor Attack Options

| Flag | Description |
|------|-------------|
| `-g`, `--neighbors-attack-garp` | Knock off network segment using gratuitous ARPs |
| `-r`, `--neighbors-attack-release` | Send release packets for all neighbor IPs |
| `-n`, `--neighbors-scan-arp` | Perform an ARP neighbor scan |

## Notes
- **Privileges**: This tool requires root/admin privileges to craft and send raw network packets.
- **Impact**: This is a disruptive tool. It can cause a total Denial of Service for the local network segment by preventing new devices from obtaining IP addresses and disconnecting existing ones.
- **Windows Hosts**: The gratuitous ARP attack (`-g`) is particularly effective against Windows-based systems.