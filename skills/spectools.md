---
name: spectools
description: A suite of utilities for using Wi-Spy USB spectrum analyzer hardware to monitor and analyze wireless spectrum interference. Use when performing wireless site surveys, identifying RF interference, troubleshooting Wi-Fi performance issues, or conducting wireless security audits involving physical layer analysis.
---

# spectools

## Overview
Spectools is a set of userspace utilities for Metageek Wi-Spy USB spectrum analyzer hardware. It includes drivers (via libusb), a network server for remote access, and CLI/curses interfaces for viewing RF spectrum data. Category: Wireless Attacks / Wireless Analysis.

## Installation (if not already installed)
Assume spectools is already installed. If you encounter a "command not found" error:

```bash
sudo apt install spectools
```

## Common Workflows

### List detected Wi-Spy devices
```bash
spectool_curses -l
```

### Monitor spectrum via terminal interface
```bash
spectool_curses -d 0 -r 0
```
Connects to the first detected device and range using the ncurses interface.

### Start a network server for remote analysis
```bash
spectool_net -p 8080 -a 0.0.0.0
```
Allows other spectool clients (like `spectool_gtk` or `spectool_raw`) to connect to the local hardware over the network.

### Stream raw data from a network server
```bash
spectool_raw -n tcp://192.168.1.50:8080
```

## Complete Command Reference

### spectool_curses
Ncurses-based CLI utility for viewing spectrum data.

| Flag | Description |
|------|-------------|
| `-n`, `--net <url>` | Connect to network server (e.g., `tcp://host:port`) |
| `-l`, `--list` | List detected devices and exit |
| `-r`, `--range <#>` | Use specific device range number |
| `-d`, `--device <#>` | Use specific device number |

### spectool_net
Network server to share Wi-Spy hardware over IP.

| Flag | Description |
|------|-------------|
| `-b`, `--broadcast <secs>` | Send broadcast announcement every X seconds |
| `-p`, `--port <port>` | Use alternate TCP port for the server |
| `-a`, `--bindaddr <address>` | Bind to a specific local IP address |
| `-l`, `--list` | List devices and ranges only, then exit |
| `-r`, `--range [dev:]range` | Configure a device for a specific frequency range |

### spectool_raw
Utility for outputting raw data, often used for development or piping to other tools.

| Flag | Description |
|------|-------------|
| `-n`, `--net <url>` | Connect to network server instead of local USB devices |
| `-b`, `--broadcast` | Listen for and connect to broadcast servers |
| `-l`, `--list` | List devices and ranges only, then exit |
| `-r`, `--range [dev:]range` | Configure a device for a specific frequency range |

## Notes
- These tools require physical Wi-Spy USB hardware to function.
- `spectool_net` is useful for placing a sensor in a specific location and monitoring it from a remote workstation.
- Ensure the user has appropriate permissions to access USB devices (often requires `sudo` or specific udev rules).