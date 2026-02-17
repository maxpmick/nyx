---
name: wig-ng
description: Perform Wi-Fi device fingerprinting by analyzing IEEE 802.11 network traffic to identify protocols like AWDL, CCX, and WPS. Use during wireless reconnaissance and information gathering to identify device types, manufacturers, and specific features of Wi-Fi clients and access points.
---

# wig-ng

## Overview
WIG (Wi-Fi Information Gathering) is a utility for Wi-Fi device fingerprinting. It identifies devices by analyzing specific information elements and protocols within 802.11 frames. It supports Apple Wireless Direct Link (AWDL), Cisco Client Extension (CCX), HP Printers Custom Information Elements, Wi-Fi Direct (P2P), and Wi-Fi Protected Setup (WPS). Category: Wireless Attacks / Reconnaissance.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install wig-ng
```

Dependencies: python3, python3-impacket, python3-pcapy, python3-setproctitle.

## Common Workflows

### Live Monitoring
Analyze traffic in real-time from a monitor-mode interface. Note: `wig-ng` does not perform channel hopping; use `airodump-ng` or `chopping` in a separate terminal to rotate channels.
```bash
sudo wig-ng -i wlan0mon
```

### Offline PCAP Analysis
Analyze a previously captured packet trace for device fingerprints.
```bash
wig-ng -r capture.pcap
```

### Batch Processing
Process an entire directory of PCAP files using multiple concurrent threads.
```bash
wig-ng -R ./captures/ -c 4 -v
```

### Active Fingerprinting
Enable modules that perform frame injection to elicit responses from devices.
```bash
sudo wig-ng -i wlan0mon -a
```

## Complete Command Reference

```
wig-ng [-h] [-v] [-c count] [-a] (-i network interface | -r pcap file | -R pcap directory)
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-v`, `--verbose` | Increase output verbosity (incremental, e.g., `-vv`). |
| `-c`, `--concurrent <count>` | Number of PCAP capture files to process simultaneously when using the `-R` option. |
| `-a`, `--active` | Enable active mode. Some modules can perform frame injection to gather more data. |
| `-i <interface>` | Specify an IEEE 802.11 network interface already in monitor mode. |
| `-r <pcap file>` | Read and analyze an IEEE 802.11 network traffic PCAP capture file. |
| `-R <pcap directory>` | Read and analyze all PCAP capture files within the specified directory. |

## Notes
- **Channel Hopping**: This tool does not hop channels automatically. To see traffic on multiple frequencies during live capture, you must run a separate channel hopper (like `airodump-ng wlan0mon`) alongside `wig-ng`.
- **Permissions**: Using the `-i` (interface) or `-a` (active) flags typically requires root privileges (`sudo`).
- **Supported Standards**:
    - Apple Wireless Direct Link (AWDL)
    - Cisco Client Extension (CCX)
    - HP Printers Custom Information Element
    - Wi-Fi Direct (P2P)
    - Wi-Fi Protected Setup (WPS)