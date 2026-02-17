---
name: netdiscover
description: Active and passive network address reconnaissance tool using ARP requests. Use to discover live hosts on local Ethernet or wireless networks, identify hardware vendors via OUI tables, and map network topologies when DHCP is unavailable or during initial internal network penetration testing.
---

# netdiscover

## Overview
Netdiscover is an active/passive address reconnaissance tool designed for wireless and switched networks. Built on libnet and libpcap, it identifies online hosts by actively sending ARP requests or passively sniffing ARP traffic. It is particularly effective for wardriving or auditing networks without DHCP. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume netdiscover is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install netdiscover
```

## Common Workflows

### Active scan of a specific range
```bash
sudo netdiscover -r 192.168.1.0/24
```

### Passive listening (stealth mode)
```bash
sudo netdiscover -p -i eth0
```
Does not send any packets; only listens for ARP traffic to identify hosts.

### Fast automated scan of common LAN ranges
```bash
sudo netdiscover -f
```
Scans common private IP ranges (192.168.0.0/16, 172.16.0.0/12, 10.0.0.0/8) quickly.

### Scan using a range list and output for parsing
```bash
sudo netdiscover -l ranges.txt -P -N
```
Reads ranges from a file and outputs results in a machine-readable format without headers.

## Complete Command Reference

```
netdiscover [-i device] [-r range | -l file | -p] [-m file] [-F filter] [-s time] [-c count] [-n node] [-dfPLNS]
```

### Scan Target Options

| Flag | Description |
|------|-------------|
| `-r range` | Scan a given range instead of auto scan (e.g., 192.168.6.0/24, /16, or /8) |
| `-l file` | Scan the list of network ranges contained in the specified file |
| `-p` | **Passive mode**: Do not send any packets, only sniff existing ARP traffic |
| `-m file` | Scan and compare against a list of known MAC addresses and host names |

### Connection and Timing Options

| Flag | Description |
|------|-------------|
| `-i device` | Specify the network interface to use (e.g., eth0, wlan0) |
| `-s time` | Time to sleep between each ARP request in milliseconds |
| `-c count` | Number of times to send each ARP request (useful for networks with packet loss) |
| `-n node` | Last source IP octet used for scanning (valid range: 2 to 253) |
| `-S` | **Hardcore mode**: Enable sleep time suppression between each request |
| `-f` | **Fast mode**: Enable fastmode scan; saves time, recommended for auto-scanning |

### Output and Configuration Options

| Flag | Description |
|------|-------------|
| `-F filter` | Customize pcap filter expression (default: "arp") |
| `-d` | Ignore home configuration files for autoscan and fast mode |
| `-R` | Assume user is root or has required capabilities without performing checks |
| `-P` | Print results in a format suitable for parsing and stop after active scan |
| `-L` | Similar to `-P` but continue listening/sniffing after the active scan is completed |
| `-N` | Do not print the header (only valid when `-P` or `-L` is enabled) |

## Notes
- Netdiscover requires root privileges or `CAP_NET_RAW` capabilities to craft ARP packets and put the interface into promiscuous mode.
- If no target option (`-r`, `-l`, or `-p`) is provided, the tool defaults to scanning common local network addresses.
- The tool uses an internal OUI (Organizationally Unique Identifier) table to map MAC addresses to hardware vendors (e.g., Apple, Cisco, VMware).