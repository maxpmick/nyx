---
name: spooftooph
description: Automate the spoofing or cloning of Bluetooth device Name, Class, and Address (BD_ADDR). Use when performing Bluetooth reconnaissance, device impersonation, or hiding a device in plain sight by mimicking existing Bluetooth profiles during wireless security assessments.
---

# spooftooph

## Overview
Spooftooph is a tool designed to automate the process of spoofing or cloning Bluetooth device information, including the Name, Class, and Address. By mimicking an existing device, it allows a Bluetooth interface to effectively hide or impersonate other hardware. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume spooftooph is already installed. If you get a "command not found" error:

```bash
sudo apt install spooftooph
```

## Common Workflows

### Manual Address Spoofing
Assign a specific Bluetooth address to a local interface:
```bash
spooftooph -i hci0 -a 00:80:37:89:EE:76
```

### Randomize Device Profile
Assign a random Name, Class, and Address to the interface:
```bash
spooftooph -i hci0 -R
```

### Scan and Clone
Scan for nearby devices and select one to clone:
```bash
spooftooph -i hci0 -s
```

### Automated Cloning at Intervals
Continuously scan and clone devices in range at a specific time interval (e.g., every 10 seconds):
```bash
spooftooph -i hci0 -t 10
```

### Log and Replay Profiles
Scan devices and save their profiles to a CSV file, then later use that file to spoof:
```bash
# Save profiles
spooftooph -i hci0 -s -w bluetooth_log.csv
# Load and spoof from log
spooftooph -i hci0 -r bluetooth_log.csv
```

## Complete Command Reference

```
spooftooph -i dev [-mstu] [-nac]|[-R]|[-r file] [-w file]
```

| Flag | Description |
|------|-------------|
| `-a <address>` | Specify new BD_ADDR (Bluetooth Device Address) |
| `-b <num_lines>` | Number of Bluetooth profiles to display per page |
| `-B` | Disable banner for smaller screens (like phones) |
| `-c <class>` | Specify new CLASS |
| `-h` | Display help message |
| `-i <dev>` | Specify interface (e.g., hci0, hci1) |
| `-m` | Specify multiple interfaces during selection |
| `-n <name>` | Specify new NAME |
| `-r <file>` | Read in CSV logfile |
| `-R` | Assign random NAME, CLASS, and ADDR |
| `-s` | Scan for devices in local area |
| `-t <time>` | Time interval to clone device in range |
| `-u` | USB delay. Interactive delay for reinitializing interface (Useful in Virtualized environments when USB must be passed through) |
| `-w <file>` | Write discovered profiles to CSV logfile |

## Notes
- **Hardware Requirements**: Requires a Bluetooth adapter supported by the BlueZ stack.
- **Virtualization**: If running in a VM, use the `-u` flag to allow the host and guest enough time to hand over the USB Bluetooth controller during the reinitialization process.
- **Stealth**: If two devices in range share the same Address, most scanning software will only list one of them, effectively hiding the spoofed device.