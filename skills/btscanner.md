---
name: btscanner
description: Extract detailed information from Bluetooth devices without pairing using an ncurses-based interface. It gathers HCI and SDP information, monitors RSSI, and link quality. Use when performing Bluetooth reconnaissance, device discovery, signal strength monitoring, or identifying device types via OUI and class lookups during wireless security assessments.
---

# btscanner

## Overview
btscanner is an ncurses-based tool designed to extract maximum information from Bluetooth devices without requiring pairing. It utilizes the BlueZ stack to gather HCI and SDP data, maintains open connections to monitor signal metrics (RSSI/Link Quality), and uses IEEE OUI lookups to identify device manufacturers and types. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume btscanner is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install btscanner
```

Dependencies: ieee-data, libbluetooth3, libc6, libncurses6, libtinfo6, libxml2, perl.

## Common Workflows

### Launching the Interactive Interface
The most common way to use btscanner is to launch the interactive ncurses UI.
```bash
sudo btscanner
```
Once inside, you can use the menu to scan for devices, select a target to view detailed SDP records, and monitor signal strength in real-time.

### Using a Custom Configuration
If you have a specific configuration file (e.g., to define specific interface behaviors or logging):
```bash
sudo btscanner --cfg=/path/to/btscanner.cfg
```

### Scanning without Resetting the Adapter
By default, btscanner resets the Bluetooth adapter to ensure a clean state. To skip this (e.g., if another tool is using the interface):
```bash
sudo btscanner --no-reset
```

## Complete Command Reference

```bash
btscanner [options]
```

### Options

| Flag | Description |
|------|-------------|
| `--help` | Display the help message and exit. |
| `--cfg=<file>` | Use the specified `<file>` as the configuration file instead of the default. |
| `--no-reset` | Do not reset the Bluetooth adapter before starting the scan. |

## Notes
- **Root Privileges**: btscanner requires root privileges to access the Bluetooth hardware via the BlueZ stack.
- **Interface State**: If the tool fails to find devices, ensure your Bluetooth interface (e.g., `hci0`) is up using `hciconfig hci0 up`.
- **Information Gathering**: Unlike standard discovery, btscanner attempts to connect to the device to query SDP (Service Discovery Protocol) records, providing a much deeper look into the services offered by the target.
- **Signal Monitoring**: The tool provides real-time updates for RSSI (Received Signal Strength Indication) and Link Quality, which is useful for physically locating a hidden Bluetooth device.