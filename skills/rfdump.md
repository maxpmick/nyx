---
name: rfdump
description: Decode and modify RFID tag data including tag ID, type, manufacturer, and user memory. Use when performing RFID reconnaissance, auditing tag security, modifying tag data, or demonstrating RFID privacy risks (cookie feature) with supported hardware like ACG multi-tag readers.
---

# rfdump

## Overview
RFDump is a tool designed to detect RFID tags and display their meta-information (Tag ID, Tag Type, manufacturer, etc.). It allows for the inspection and modification of a tag's user data memory via Hex or ASCII editors. It also includes features to demonstrate how RFID tags can be used for tracking (cookies). Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume rfdump is already installed. If you get a "command not found" error:

```bash
sudo apt install rfdump
```

## Common Workflows

### Launching the GUI with a specific reader port
```bash
rfdump -p /dev/ttyUSB0
```

### Initializing the card reader hardware
```bash
rfdump --setupreader
```

### Loading a saved tag data file
```bash
rfdump saved_tag_data.xml
```

## Complete Command Reference

```bash
rfdump [options] [file.xml]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show summary of options and help message. |
| `-p <port>` | Specify the serial port to use for the RFID reader (e.g., `/dev/ttyS0`, `/dev/ttyUSB0`). |
| `--setupreader` | Run the setup routine for the card reader hardware. |

### Arguments

| Argument | Description |
|----------|-------------|
| `file.xml` | Optional XML file containing previously dumped or saved RFID tag data to be viewed or edited. |

## Files
- `~/.config/rfdump.ini`: The configuration file where user preferences and reader settings are stored.

## Notes
- **Hardware Requirement**: RFDump requires specific hardware to function, such as the ACG Multi-Tag Reader or compatible card reader hardware.
- **Data Modification**: The tool allows direct editing of tag memory; ensure you have backups (XML dumps) before writing modified data to a physical tag.
- **Documentation**: Additional documentation and examples may be found locally at `/usr/share/doc/rfdump`.