---
name: driftnet
description: Capture and display images or MPEG audio streams from network traffic in real-time. Use when performing network sniffing, visual reconnaissance, or monitoring unencrypted web traffic (HTTP) to intercept media files during penetration testing or security audits.
---

# driftnet

## Overview
Driftnet is a network sniffing tool that monitors TCP streams and extracts images (and optionally MPEG audio) for display or storage. It is particularly effective on networks with significant unencrypted web traffic. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume driftnet is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install driftnet
```

## Common Workflows

### Basic GUI Monitoring
Listen on all interfaces and display captured images in a GTK window:
```bash
sudo driftnet
```

### Monitor Specific Interface with Audio Extraction
Listen on `eth0` and attempt to extract both images and MPEG audio:
```bash
sudo driftnet -i eth0 -s
```

### Adjunct Mode (Headless)
Capture images without a display window, saving them to a specific directory and printing filenames to stdout:
```bash
sudo driftnet -a -d /tmp/captured_images -x target_prefix_
```

### Analyzing a PCAP File
Extract images from a previously captured traffic file:
```bash
driftnet -f capture.pcap
```

### Filtered Capture
Capture images only from a specific host using tcpdump-style filters:
```bash
sudo driftnet host 192.168.1.50
```

## Complete Command Reference

```
driftnet [options] [filter code]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h` | Display help message |
| `-v` | Verbose operation |
| `-b` | Beep when a new image is captured |
| `-i <interface>` | Select the interface on which to listen (default: all interfaces) |
| `-f <file>` | Read captured packets from a pcap dump file or named pipe (e.g., from Kismet) |
| `-p` | Do not put the listening interface into promiscuous mode |
| `-l` | List the system capture interfaces |
| `-p` | Put the interface in monitor mode (not supported on all interfaces) |
| `-Z <username>` | Drop privileges to specified user after starting pcap |

### Display & Output Options

| Flag | Description |
|------|-------------|
| `-g` | Enable GTK display (default behavior) |
| `-w` | Enable the HTTP server to display images |
| `-W <port>` | Port number for the HTTP server (implies `-w`, default: 9090) |
| `-a` | Adjunct mode: do not display images on screen; save to temp directory and announce names on stdout |
| `-m <number>` | Maximum number of images to keep in temporary directory in adjunct mode |
| `-d <directory>` | Use the named temporary directory for saving images |
| `-x <prefix>` | Prefix to use when saving images |

### Audio Extraction Options

| Flag | Description |
|------|-------------|
| `-s` | Attempt to extract streamed audio data (MPEG only) in addition to images |
| `-S` | Extract streamed audio but NOT images |
| `-M <command>` | Command to play MPEG audio data (default: `mpg123 -`) |

### Filter Code
Filter code can be specified after options using `tcpdump` syntax. Driftnet automatically prepends `tcp and ` to any user-supplied filter.

## Notes
- **Privacy**: Driftnet is a highly intrusive tool; ensure you have explicit permission before monitoring network traffic.
- **Encryption**: Driftnet cannot extract media from encrypted traffic (HTTPS/TLS).
- **Interactive Use**: In the GTK display window, you can click on an image to save it to the current working directory.
- **Adjunct Mode**: This mode is ideal for piping driftnet output into other automation scripts or tools.