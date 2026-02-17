---
name: rfcat
description: Swiss army knife for sub-GHz radio analysis, reverse-engineering, and exploitation. Use to interact with CC1111 based dongles (like Yard Stick One) for sniffing, transmitting, and analyzing wireless protocols in the sub-GHz spectrum. Essential for wireless security audits, IoT device testing, and spectrum analysis.
---

# rfcat

## Overview
Rfcat is a sub-GHz radio analysis tool designed to reduce the time required for security researchers to create tools for analyzing unknown wireless targets. It provides an interactive Python environment to control CC1111-based hardware. Category: Wireless Attacks.

## Installation (if not already installed)
Assume rfcat is already installed. If you encounter errors, install via:

```bash
sudo apt install rfcat
```

## Common Workflows

### Interactive Research Mode
Start an interactive IPython shell to manually control the radio dongle (the most common usage):
```bash
rfcat -r
```
Inside the shell, you can use the `d` object (e.g., `d.setFreq(433000000)`).

### Spectrum Analyzer
Launch the graphical spectrum analyzer to visualize radio activity:
```bash
rfcat -s -f 433000000
```

### Relay for Metasploit
Start a relay server to allow remote tools or Metasploit to interact with the radio hardware:
```bash
rfcat_msfrelay --localonly -P 8080
```

### Flashing Firmware
Trigger the bootloader mode to prepare the device for a firmware update:
```bash
rfcat --bootloader --force
```

## Complete Command Reference

### rfcat
Main entry point for research and spectrum analysis.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-r`, `--research` | Interactive Python and the "d" instance to talk to your dongle |
| `-i INDEX`, `--index INDEX` | Specify the index of the dongle to use |
| `-s`, `--specan` | Start spectrum analyzer |
| `-f CENTFREQ`, `--centfreq CENTFREQ` | Set center frequency for spectrum analyzer |
| `-c INC`, `--inc INC` | Set increment for spectrum analyzer |
| `-n SPECCHANS` | Set number of channels for spectrum analyzer |
| `--bootloader` | Trigger the bootloader (use in order to flash the dongle) |
| `--force` | Confirm setting bootloader mode (must flash after setting) |
| `-S`, `--safemode` | Troubleshooting only, used with `-r` |

### rfcat_bootloader
Utility for interacting with the CC Bootloader.

**Usage:** `rfcat_bootloader <serial_port> <command>`

| Command | Description |
|---------|-------------|
| `download <hex_file>` | Download hex_file to the device |
| `run` | Run the user code |
| `reset` | Reset the bootloader's record of written pages (allows overwriting without power cycle) |
| `erase_all` | Erases the entire user flash area |
| `erase <n>` | Erases page `n` of the flash memory (1024 byte pages) |
| `read <start_addr> <len> [hex_file]` | Reads `len` bytes from `start_addr` and optionally writes to `hex_file` (hex format) |
| `verify <hex_file>` | Verify hex_file matches device flash memory |

### rfcat_msfrelay
Relay service for remote interaction.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-i INDEX`, `--index INDEX` | Specify dongle index |
| `-u USER`, `--user USER` | HTTP Username for authentication |
| `-p PASSWORD`, `--password PASSWORD` | HTTP Password for authentication |
| `-P PORT`, `--Port PORT` | Port to listen on |
| `--noauth` | Do not require authentication |
| `--localonly` | Listen on localhost only |

## Notes
- **Hardware Requirement**: Requires compatible hardware such as the Yard Stick One or PandwaRF.
- **Root Privileges**: Often requires root or specific udev rules to access USB radio peripherals.
- **Bootloader Warning**: Using `--bootloader --force` requires you to flash the device immediately after, or it may remain in an unusable state until flashed.