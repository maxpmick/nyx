---
name: bluez
description: Official Linux Bluetooth protocol stack providing a suite of tools for Bluetooth device management, scanning, pairing, and protocol testing. Use when performing Bluetooth reconnaissance, device enumeration, GATT attribute manipulation, RFCOMM/L2CAP testing, or monitoring HCI traffic during wireless security assessments.
---

# bluez

## Overview
BlueZ is the official Linux Bluetooth protocol stack. It provides a comprehensive set of utilities for managing Bluetooth controllers, interacting with Low Energy (BLE) and Classic devices, and analyzing Bluetooth traffic. Category: Wireless Attacks / Bluetooth.

## Installation (if not already installed)
Assume bluez is already installed. If tools are missing:
```bash
sudo apt install bluez bluez-hcidump bluez-test-tools bluez-meshd
```

## Common Workflows

### Interactive Device Discovery and Pairing
```bash
bluetoothctl
[bluetooth]# scan on
[bluetooth]# devices
[bluetooth]# pair <MAC_ADDR>
[bluetooth]# trust <MAC_ADDR>
[bluetooth]# connect <MAC_ADDR>
```

### Quick Scan for Remote Devices
```bash
hcitool scan
```

### Enumerate BLE Services and Characteristics
```bash
gatttool -b <MAC_ADDR> --interactive
[<MAC_ADDR>][LE]> connect
[<MAC_ADDR>][LE]> primary
[<MAC_ADDR>][LE]> characteristics
```

### Monitor and Save HCI Traffic
```bash
hcidump -i hci0 -w capture.pcap
```

## Complete Command Reference

### bluetoothctl
Main CLI for managing Bluetooth.
- **Options**: `--agent <cap>`, `--endpoints`, `--monitor`, `--timeout <sec>`, `--init-script <file>`.
- **Primary Commands**: `list`, `show`, `select`, `devices`, `power <on/off>`, `pairable <on/off>`, `discoverable <on/off>`, `scan <on/off>`, `pair <mac>`, `trust <mac>`, `block <mac>`, `remove <mac>`, `connect <mac>`, `disconnect <mac>`, `info <mac>`.
- **Sub-menus**:
    - `gatt.`: `list-attributes`, `read`, `write`, `select-attribute`, `attribute-info`.
    - `advertise.`: `uuids`, `service`, `manufacturer`, `data`, `name`, `clear`.
    - `monitor.`: `set-rssi-threshold`, `add-or-pattern`.

### hcitool
Configure Bluetooth connections and send HCI commands.
- **Options**: `-i <dev>` (HCI device).
- **Commands**: `dev`, `inq`, `scan`, `name <mac>`, `info <mac>`, `con`, `cc <mac>`, `dc <mac>`, `rssi <mac>`, `lq <mac>`, `tpl <mac>`, `lescan` (BLE scan), `leinfo <mac>`.

### hciconfig
Configure local Bluetooth devices.
- **Commands**: `up`, `down`, `reset`, `auth`, `noauth`, `encrypt`, `noencrypt`, `piscan`, `noscan`, `name [name]`, `class [class]`, `leadv [type]`, `noleadv`.

### gatttool
Tool for Bluetooth Low Energy (BLE) interaction.
- **Options**: `-i <adapter>`, `-b <device>`, `-t [public|random]`, `-m <mtu>`, `-p <psm>`, `-l [low|medium|high]`, `-I` (Interactive mode).

### hcidump
Parse and display HCI data.
- **Options**: `-i <dev>`, `-w <file>` (save), `-r <file>` (read), `-t` (timestamp), `-a` (ascii), `-x` (hex), `-X` (ext), `-R` (raw).

### sdptool
Search and browse SDP services.
- **Commands**: `search <service>`, `browse [mac]`, `records [mac]`, `add <service>`, `del <handle>`.

### l2ping
L2CAP echo request.
- **Usage**: `l2ping [-i device] [-s size] [-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>`
- **Flags**: `-f` (flood), `-r` (reverse), `-v` (verify payload).

### rfcomm
RFCOMM configuration utility.
- **Commands**: `bind <dev> <mac> [channel]`, `release <dev>`, `show <dev>`, `connect <dev> <mac> [channel]`, `listen <dev> [channel]`.

### btmgmt / mgmt-tester
Kernel management interface tool.
- **Commands**: `info`, `power <on/off>`, `discov <on/off>`, `connectable <on/off>`, `find`, `pair <mac>`, `unpair <mac>`, `block <mac>`.

### btmon
Bluetooth monitor for btsnoop traces.
- **Options**: `-r <file>` (read), `-w <file>` (write), `-a <file>` (analyze), `-s <socket>`, `-i <index>`, `-t` (time), `-S` (SCO traffic), `-A` (A2DP).

### meshctl / mesh-cfgclient
Bluetooth Mesh configuration and control.
- **meshctl Options**: `--config <dir>`, `--monitor`, `--timeout <sec>`.
- **mesh-cfgclient Commands**: `create`, `discover-unprovisioned`, `provision`, `list-nodes`.

### Testing & Hardware Tools
- **bluemoon**: Configuration utility for specific controllers. Flags: `-A` (set bdaddr), `-F` (load firmware), `-R` (reset).
- **btattach**: Attach serial devices. Flags: `-B` (BR/EDR), `-P <proto>`, `-S <baudrate>`.
- **btvirt**: Bluetooth emulator. Flags: `-l [num]` (local controllers), `-L` (LE only), `-B` (BR/EDR only).
- **l2test / rctest / isotest**: Protocol-specific stress and functional testing tools.
- **hex2hcd**: Broadcom firmware converter.

## Notes
- Most tools require `sudo` or `root` privileges to access HCI interfaces.
- `hcitool lescan` may require `hciconfig hci0 up` first.
- If a device is not showing up, check the physical status with `rfkill list bluetooth`.