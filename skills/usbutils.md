---
name: usbutils
description: Enumerate and inspect USB devices, buses, and topologies. Use when performing hardware reconnaissance, identifying connected peripherals, debugging USB-based exploits (like BadUSB), or sniffing HID device descriptors and data streams during physical security assessments or forensics.
---

# usbutils

## Overview
A collection of utilities for inspecting and manipulating USB devices connected to the system. It includes tools for listing devices, viewing bus topology, dumping HID descriptors, and resetting USB ports. Category: Sniffing & Spoofing / Social Engineering / Wireless Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If a command is missing:

```bash
sudo apt install usbutils
```

## Common Workflows

### List all USB devices with basic info
```bash
lsusb
```

### View USB hierarchy and speed as a tree
```bash
lsusb -t
```

### Get detailed descriptors for a specific device
```bash
lsusb -v -d 1d6b:0002
```

### Dump HID report descriptors for a specific device
```bash
usbhid-dump -d 80ee:0021 -e descriptor
```

### Monitor HID data stream (e.g., keystrokes/mouse movement)
```bash
usbhid-dump -d 80ee:0021 -e stream
```

## Complete Command Reference

### lsusb
List USB devices and their properties.

| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | Increase verbosity (show detailed descriptors) |
| `-s [[bus]:][devnum]` | Show only devices with specified device and/or bus numbers (decimal) |
| `-d vendor:[product]` | Show only devices with specified vendor and product ID (hexadecimal) |
| `-D device` | Selects which device file lsusb will examine (e.g., /dev/bus/usb/001/001) |
| `-t`, `--tree` | Dump the physical USB device hierarchy as a tree |
| `-V`, `--version` | Show version of program |
| `-h`, `--help` | Show usage and help |

### usb-devices
A shell script that prints details about USB buses and connected devices in a format similar to `/proc/bus/usb/devices`. No specific flags are documented beyond standard help.

### usbhid-dump
Dump USB device HID report descriptors and/or streams.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Output help message |
| `-v`, `--version` | Output version information |
| `-s`, `-a`, `--address=bus[:dev]` | Limit interfaces by bus (1-255) and device address (1-255) |
| `-d`, `-m`, `--model=vid[:pid]` | Limit interfaces by vendor and product IDs (hexadecimal) |
| `-i`, `--interface=NUMBER` | Limit interfaces by number (0-254); 255 matches any |
| `-e`, `--entity=STRING` | What to dump: `descriptor`, `stream`, or `all` (can be abbreviated) |
| `-t`, `--stream-timeout=MS` | Stream interrupt transfer timeout in ms; 0 is infinity (Default: 60000) |
| `-p`, `--stream-paused` | Start with the stream dump output paused |
| `-f`, `--stream-feedback` | Print a dot to stderr for every transfer dumped |

**Signals:**
- `USR1`: Pause the stream dump output.
- `USR2`: Resume the stream dump output.

### usbreset
Resets a USB device to its initial state. Usually requires a device path (e.g., `/dev/bus/usb/001/002`).

## Notes
- `lsusb -v` often requires root privileges to display all descriptors (like serial numbers).
- `usbhid-dump` is highly useful for reverse engineering custom USB HID devices or analyzing potential malicious hardware.
- If a device is "stuck," `usbreset` can sometimes restore functionality without unplugging the hardware.