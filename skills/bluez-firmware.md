---
name: bluez-firmware
description: Provide essential firmware files for Broadcom BCM203x and Raspberry Pi based Bluetooth chipsets. Use when Bluetooth hardware is detected but non-functional due to missing firmware, specifically during wireless security audits, hardware initialization, or Bluetooth device enumeration.
---

# bluez-firmware

## Overview
This package contains the necessary firmware images required for the operation of Bluetooth dongles and integrated controllers based on the Broadcom BCM203x and Raspberry Pi chipsets. It is a critical dependency for hardware initialization in the Sniffing & Spoofing and Wireless Attacks domains.

## Installation (if not already installed)
The firmware is typically pre-installed in Kali Linux. If the hardware fails to initialize or `dmesg` reports missing firmware:

```bash
sudo apt update
sudo apt install bluez-firmware
```

## Common Workflows

### Verifying Firmware Loading
After installing the firmware, reload the bluetooth modules or reboot to initialize the hardware. Check the kernel ring buffer for successful loading:
```bash
dmesg | grep -i bluetooth
```

### Checking Bluetooth Device Status
Once the firmware is present, the device should appear in the standard Bluetooth management tools:
```bash
hciconfig -a
# OR
bluetoothctl list
```

## Complete Command Reference

This package does not provide standalone executable commands or subcommands. It provides binary firmware blobs located in the system firmware directory (typically `/lib/firmware/`). These files are automatically loaded by the Linux kernel's Bluetooth subsystem when compatible hardware is detected.

### Included Firmware Files
The package typically includes firmware for:
- Broadcom BCM203x chipsets
- Raspberry Pi integrated Bluetooth controllers

## Notes
- This is a firmware-only package. It does not include the Bluetooth stack (BlueZ) itself, which is provided by the `bluez` package.
- If Bluetooth still does not work after installation, ensure the `bluetooth` service is running: `sudo systemctl start bluetooth`.
- For Raspberry Pi users, this package is often essential for the onboard Bluetooth interface to function correctly in Kali Linux environments.