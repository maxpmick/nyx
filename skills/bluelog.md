---
name: bluelog
description: Bluetooth scanner and logger designed for site surveys and long-term monitoring. It identifies discoverable Bluetooth devices in the environment and logs their details to a file or a live webpage. Use when performing wireless reconnaissance, Bluetooth device discovery, or site auditing to determine the density of Bluetooth targets.
---

# bluelog

## Overview
Bluelog is a Bluetooth site survey tool designed to identify discoverable devices as quickly as possible. Unlike interactive scanners, its primary function is to log discovered devices to a file, making it ideal for unattended data collection over long periods. Category: Wireless Attacks / Reconnaissance.

## Installation (if not already installed)
Assume bluelog is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install bluelog
```

## Common Workflows

### Basic logging with terminal output
Scan using the default interface (hci0) and print discovered devices to the terminal while saving to a file.
```bash
bluelog -v
```

### Comprehensive device logging
Log device MAC addresses, names, manufacturers, and timestamps to a specific file.
```bash
bluelog -n -m -t -o site_survey.log
```

### Background daemon mode
Run the scanner in the background as a daemon for long-term monitoring.
```bash
bluelog -d -o background_scan.log
```

### Bluelog Live mode
Start the scanner in "Live" mode to generate a webpage of results (requires a separate web server to host the output).
```bash
bluelog -l
```

## Complete Command Reference

### Basic Options

| Flag | Description |
|------|-------------|
| `-i <interface>` | Sets scanning device (default: "hci0") |
| `-o <filename>` | Sets output filename (default: "devices.log") |
| `-v` | Verbose; prints discovered devices to the terminal |
| `-q` | Quiet; turns off nonessential terminal output |
| `-d` | Enables daemon mode; Bluelog will run in the background |
| `-k` | Kill an already running Bluelog process |
| `-l` | Start "Bluelog Live" mode |

### Logging Options

| Flag | Description |
|------|-------------|
| `-n` | Write device names to log |
| `-m` | Write device manufacturer to log |
| `-c` | Write device class to log |
| `-f` | Use "friendly" device class descriptions |
| `-t` | Write timestamps to log |
| `-x` | Obfuscate discovered MAC addresses |
| `-e` | Encode discovered MACs with CRC32 |
| `-b` | Enable BlueProPro log format |

### Advanced Options

| Flag | Description |
|------|-------------|
| `-r <retries>` | Number of name resolution retries (default: 3) |
| `-a <minutes>` | Amnesia; Bluelog will forget a device after the specified time |
| `-w <seconds>` | Scanning window in seconds |
| `-s` | Syslog only mode; no log file is created |

## Notes
- **Permissions**: Bluetooth scanning typically requires root privileges. Always run with `sudo` if not already root.
- **PID File**: When running, Bluelog creates a PID file at `/tmp/bluelog.pid`.
- **Hardware**: Ensure your Bluetooth interface is up and not blocked (`rfkill unblock bluetooth`).
- **Bluelog Live**: This mode creates a dynamic webpage. You must point an HTTP daemon (like Apache or Nginx) to the Bluelog output directory to view the results in a browser.