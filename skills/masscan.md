---
name: masscan
description: Fast asynchronous TCP port scanner capable of scanning the entire Internet in under 6 minutes. Use when high-speed port discovery is required over large network ranges, performing Internet-wide surveys, or when Nmap is too slow for the target scope.
---

# masscan

## Overview
MASSCAN is an asynchronous TCP port scanner that transmits SYN packets independently of the operating system's stack. It produces results similar to Nmap but operates more like scanrand or ZMap, allowing for extreme speeds by not waiting for responses before sending the next packet. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume masscan is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install masscan
```

## Common Workflows

### Scan a subnet for specific ports
```bash
masscan 192.168.1.0/24 -p22,80,445
```

### High-speed Internet-wide scan for a single port
```bash
masscan 0.0.0.0/0 -p443 --rate 100000
```
*Note: Requires significant bandwidth and careful coordination.*

### Generate a configuration file
```bash
masscan -p80,443,8080 10.0.0.0/8 --echo > myscan.conf
```

### Run a scan using a configuration file
```bash
masscan -c myscan.conf
```

## Complete Command Reference

### Basic Usage
```
masscan <IP range> -p <ports> [options]
```

### Target Specification
| Flag | Description |
|------|-------------|
| `<IP range>` | IPv4 address, range (e.g., `10.0.0.1-10.0.0.10`), or CIDR (e.g., `10.0.0.0/8`) |
| `-p <ports>`, `--ports <ports>` | Specify port ranges (e.g., `80`, `22-25`, `80,443,U:53`) |
| `--exclude <range>` | Blacklist specific IP ranges from the scan |
| `--excludefile <file>` | Read blacklist ranges from a file |

### Performance Options
| Flag | Description |
|------|-------------|
| `--rate <number>` | Set transmit rate in packets per second (default: 100) |
| `--wait <seconds>` | How long to wait for receive packets after sending is done (default: 10) |

### Network Adapter Options
| Flag | Description |
|------|-------------|
| `--adapter-ip <IP>` | Source IP address for the scan |
| `--adapter-mac <MAC>` | Source MAC address for the scan |
| `--router-mac <MAC>` | Destination MAC address for the gateway/router |
| `--interface <name>` | Specify the network interface to use |

### Output Options
| Flag | Description |
|------|-------------|
| `-oX <file>` | Output in XML format |
| `-oG <file>` | Output in Grepable format |
| `-oJ <file>` | Output in JSON format |
| `-oL <file>` | Output in List format (simple text) |
| `-oB <file>` | Output in Binary format |
| `--echo` | Don't run; instead, output current configuration to stdout |

### Configuration Options
| Flag | Description |
|------|-------------|
| `-c <filename>`, `--conf <filename>` | Read settings from a configuration file |
| `--randomize-hosts` | Randomize the order of targets (enabled by default) |
| `--seed <number>` | Seed for the random number generator |

### Advanced Options
| Flag | Description |
|------|-------------|
| `--banners` | Attempt to grab banners (TCP only) |
| `--ping` | Include ICMP echo requests in the scan |
| `--source-port <port>` | Use a specific source port for all packets |
| `--ttl <number>` | Set the TTL of outgoing packets |
| `-v`, `--verbose` | Increase output verbosity |

## Notes
- **Performance**: Masscan is designed for speed. On a gigabit Ethernet connection, it can reach 1.6 million packets per second.
- **Safety**: High rates can overwhelm local network infrastructure or trigger ISP abuse alerts. Always use `--rate` responsibly.
- **Root Privileges**: Because masscan uses raw sockets, it must be run as root or with `sudo`.
- **IP Stack**: Masscan has its own TCP/IP stack. If the local OS stack also responds to the scan's SYN-ACKs with RSTs, it may interfere with banner grabbing. Using a separate IP address via `--adapter-ip` is recommended for complex scans.