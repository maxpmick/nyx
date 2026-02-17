---
name: libfindrtp
description: A specialized library and utility used for identifying and analyzing Real-time Transport Protocol (RTP) streams within network traffic. Use when performing VoIP security assessments, identifying active media streams, or as a dependency for other VoIP exploitation and analysis tools during vulnerability research.
---

# libfindrtp

## Overview
libfindrtp is a library and supporting utility designed to find RTP (Real-time Transport Protocol) streams in pcap files or live network traffic. It is primarily used in the security domain of VoIP (Voice over IP) analysis and vulnerability assessment to isolate media sessions for further inspection or eavesdropping. Category: Vulnerability Analysis / Sniffing & Spoofing.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing, install via:

```bash
sudo apt update
sudo apt install libfindrtp
```

## Common Workflows

### Identify RTP streams in a pcap file
```bash
findrtp -f capture.pcap
```
Scans the provided packet capture file and lists identified RTP streams, including source/destination IPs and ports.

### Live RTP stream discovery
```bash
sudo findrtp -i eth0
```
Monitors the specified network interface in real-time to detect active RTP sessions.

## Complete Command Reference

The package provides the `findrtp` utility to interface with the library.

```
findrtp [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-i <interface>` | Listen on a specific network interface (e.g., eth0, wlan0) |
| `-f <pcap_file>` | Read and analyze packets from a saved pcap file |
| `-p <port>` | Filter for RTP traffic on a specific port |
| `-v` | Enable verbose output for detailed packet information |
| `-h` | Display help and usage information |

## Notes
- This tool is often a prerequisite for more advanced VoIP tools like `rtpbreak` or `enumiax`.
- Root privileges (`sudo`) are required when capturing traffic from a live network interface.
- RTP streams are often found on dynamic UDP ports; if the standard range (16384-32767) is not used, the tool helps pinpoint the exact ports in use.