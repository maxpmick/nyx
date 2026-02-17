---
name: tcpick
description: Track, reassemble, and reorder TCP streams from live network traffic or PCAP files. Use when performing network forensics, traffic analysis, or session reconstruction to view TCP flows in various formats (hexdump, ASCII, raw) or save them to disk.
---

# tcpick

## Overview
A libpcap-based textmode sniffer that tracks TCP connections and reassembles streams. It can handle various interface types (Ethernet, PPP) and provides multiple display modes including colorized output and hexdumps. Category: Digital Forensics / Sniffing & Spoofing.

## Installation (if not already installed)
Assume tcpick is already installed. If the command is missing:

```bash
sudo apt install tcpick
```

## Common Workflows

### Monitor live traffic with colorized status
```bash
tcpick -i eth0 -C
```
Displays connection status (SYN, ESTABLISHED, FIN) with colors.

### Reassemble and display TCP payload as ASCII
```bash
tcpick -i eth0 -yP "port 80"
```
Filters for port 80 and displays the data payload in printable ASCII format.

### Save all captured streams to files
```bash
tcpick -i eth0 -wR
```
Saves every TCP stream into separate files in raw format for later analysis.

### Analyze a PCAP file and show hexdump
```bash
tcpick -r capture.pcap -yx
```
Reads a saved capture file and displays the payload in hexadecimal format.

## Complete Command Reference

```
tcpick [options] ["filter"]
```

### General Options

| Flag | Description |
|------|-------------|
| `-i <interface>` | Specify the network interface to listen on (e.g., eth0, ppp0) |
| `-r <file>` | Read packets from a tcpdump/libpcap generated file |
| `-a` | Resolve IP addresses to hostnames |
| `-n` | Numeric output only (do not resolve hostnames/ports) |
| `-C` | Enable colorized output for connection status |
| `-S` | Display the sequence numbers |
| `--separator` | Add a separator between packets |
| `-v [level]` | Set verbosity level |
| `-h` | Display a short help message |
| `--help` | Display the full help message |
| `--version` | Display version and license information |

### Display Options (Terminal Output)
These flags determine how the payload is displayed in the terminal.

| Flag | Description |
|------|-------------|
| `-yH` | Display payload in Hexadecimal |
| `-yP` | Display payload in Printable ASCII (non-printable chars shown as dots) |
| `-yR` | Display payload in Raw mode (includes non-printable characters) |
| `-yU` | Display payload in Unprintable mode (shows hex values for non-printable chars) |
| `-yx` | Display payload in Hexdump format |
| `-yX` | Display payload in Hexdump + ASCII format |

### Buffer Options (Client/Server Separation)
These flags allow you to see only one side of the communication.

| Flag | Description |
|------|-------------|
| `-bH` | Hexadecimal buffer |
| `-bP` | Printable ASCII buffer |
| `-bR` | Raw buffer |
| `-bU` | Unprintable buffer |
| `-bx` | Hexdump buffer |
| `-bX` | Hexdump + ASCII buffer |

### Write Options (Save to File)
These flags save the reassembled streams to the local directory.

| Flag | Description |
|------|-------------|
| `-wH` | Write streams to files in Hexadecimal |
| `-wP` | Write streams to files in Printable ASCII |
| `-wR` | Write streams to files in Raw format (best for binary files/images) |
| `-wU` | Write streams to files in Unprintable format |

## Notes
- **Filters**: tcpick uses standard pcap filter syntax (e.g., `"port 80"`, `"host 192.168.1.1"`).
- **File Naming**: When using `-w` flags, tcpick creates files named by the connection ID and direction.
- **Root Privileges**: Running on a live interface usually requires `sudo`.