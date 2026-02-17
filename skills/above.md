---
name: above
description: Invisible network protocol sniffer for passive traffic analysis and vulnerability discovery. Use to detect insecure configurations in discovery protocols, dynamic routing, FHRP, STP, and LLMNR/NBT-NS without generating network noise. Ideal for reconnaissance and sniffing/spoofing phases where stealth is required.
---

# above

## Overview
Above is an invisible protocol sniffer designed for security professionals to find vulnerabilities in network hardware through passive traffic analysis. It automates the discovery of misconfigured protocols (L2/L3) such as STP, CDP, LLDP, HSRP, VRRP, OSPF, and more. Because it only listens, it does not perform MITM or active credential capture, making it "invisible" on the wire. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install above
```
Dependencies: `python3`, `python3-colorama`, `python3-scapy`.

## Common Workflows

### Live Traffic Analysis
Monitor a specific interface for protocol vulnerabilities in real-time:
```bash
sudo above --interface eth0
```

### Analyzing a PCAP File
Perform offline analysis on a previously captured traffic dump:
```bash
above --input capture.pcap
```

### Timed Capture with Output
Capture traffic for 60 seconds, analyze it, and save the raw packets to a file:
```bash
sudo above --interface eth0 --timer 60 --output network_audit.pcap
```

### Passive Host and VLAN Discovery
Discover active hosts via ARP and identify VLAN tags without sending probes:
```bash
sudo above --interface eth0 --passive-arp --search-vlan
```

## Complete Command Reference

```
usage: above [-h] [--interface INTERFACE] [--timer TIMER] [--output OUTPUT]
             [--input INPUT] [--passive-arp] [--search-vlan]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--interface INTERFACE` | Specify the network interface for live traffic listening (e.g., eth0, wlan0). |
| `--timer TIMER` | Set the duration in seconds to capture packets. If not set, the tool runs until interrupted. |
| `--output OUTPUT` | Specify a filename to record the captured traffic into a `.pcap` file. |
| `--input INPUT` | Specify a `.pcap` file for offline traffic analysis instead of live sniffing. |
| `--passive-arp` | Enable Passive ARP analysis for stealthy host discovery. |
| `--search-vlan` | Enable VLAN search to identify tagged traffic and 802.1Q configurations. |

## Notes
- **Passive Only**: Above does NOT perform Man-in-the-Middle (MITM) attacks or active credential injection. It is strictly for analysis.
- **Root Privileges**: Running against a live interface (`--interface`) typically requires `sudo` or root privileges to put the interface in promiscuous mode.
- **OUI Database**: The tool includes an OUI database to identify hardware manufacturers based on MAC addresses.