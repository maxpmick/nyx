---
name: netscanner
description: Perform network scanning and diagnostics using a modern Terminal User Interface (TUI). Use for listing hardware interfaces, scanning WiFi networks and signal strengths, pinging IPv4 CIDR ranges for hostname and MAC discovery, and performing packet captures (TCP, UDP, ICMP, ARP, ICMP6). Ideal for quick local network reconnaissance and real-time traffic monitoring during penetration testing.
---

# netscanner

## Overview
Netscanner is a network scanning and diagnostic tool featuring a modern TUI. It allows for hardware interface management, WiFi signal analysis with charts, IPv4 host discovery (including OUI and MAC addresses), and multi-protocol packet dumping. Category: Reconnaissance / Information Gathering, Sniffing & Spoofing.

## Installation (if not already installed)
Assume netscanner is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install netscanner
```

## Common Workflows

### Launching the Interactive TUI
```bash
sudo netscanner
```
Note: Root privileges are typically required for raw socket access (packet dumping) and interface management.

### Adjusting Refresh Rates for High-Performance Displays
```bash
netscanner --tick-rate 2 --frame-rate 30
```
Increases the UI responsiveness and data polling frequency.

### TUI Navigation and Usage
Once the TUI is launched, use the following patterns:
1. **Interface Selection**: List and switch between active hardware interfaces.
2. **WiFi Scanning**: View nearby SSIDs, signal strengths, and live charts.
3. **Network Discovery**: Enter a CIDR range (e.g., 192.168.1.0/24) to ping and resolve hostnames/MACs.
4. **Packet Capture**: Start/Pause live packet dumps for TCP, UDP, ICMP, ARP (IPv4), and ICMP6 (IPv6).

## Complete Command Reference

```
Usage: netscanner [OPTIONS]
```

### Options

| Flag | Description |
|------|-------------|
| `-t, --tick-rate <FLOAT>` | Tick rate, i.e., number of ticks per second [default: 1] |
| `-f, --frame-rate <FLOAT>` | Frame rate, i.e., number of frames per second [default: 10] |
| `-h, --help` | Print help information |
| `-V, --version` | Print version information |

## Notes
- **Privileges**: Running as `root` or with `sudo` is necessary for most features, including WiFi scanning and packet sniffing.
- **TUI Controls**: The tool is primarily driven by keyboard shortcuts within the interface (usually arrow keys for navigation and specific keys for starting/pausing captures).
- **IPv6 Support**: Currently supports ICMP6 packet dumping.
- **Hardware**: WiFi scanning capabilities depend on the wireless card's support for scanning and the drivers installed on the Kali system.