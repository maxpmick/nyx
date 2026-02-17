---
name: zd1211-firmware
description: Provide the necessary binary firmware for ZyDAS ZD1211 and Atheros AR5007UG based USB wireless dongles. Use when a wireless adapter using the zd1211rw driver is detected but fails to initialize due to missing firmware, typically during wireless security auditing or network reconnaissance.
---

# zd1211-firmware

## Overview
This package contains the binary firmware images required by the `zd1211rw` Linux kernel driver. This driver supports various USB wireless network devices based on ZyDAS and Atheros chipsets. Without this firmware, the kernel driver cannot initialize the hardware for wireless operations. Category: Wireless Attacks / Hardware Support.

## Supported Chipsets
The firmware is compatible with the following chipsets:
* ZyDAS ZD1211
* ZyDAS ZD1211B
* Atheros AR5007UG (also known as AR2524 or AR5524)

## Installation (if not already installed)
The firmware is usually included in Kali Linux by default. If the device is plugged in but not appearing in `iwconfig` or `ip link`, or if `dmesg` shows "firmware: failed to load zd1211/zd1211_ub", install it manually:

```bash
sudo apt update
sudo apt install firmware-zd1211
```

After installation, you may need to reload the driver module or replug the device:
```bash
sudo modprobe -r zd1211rw
sudo modprobe zd1211rw
```

## Common Workflows

### Verifying Driver and Firmware Loading
After plugging in a compatible USB adapter, check the kernel logs to ensure the firmware was loaded successfully:
```bash
dmesg | grep zd1211
```
Look for messages indicating "firmware version" and "MAC address" to confirm the device is ready.

### Checking Interface Status
Verify that the wireless interface has been created (usually named `wlan0` or similar):
```bash
iw dev
```

### Enabling Monitor Mode
Once the firmware is loaded, you can use standard tools to put the device into monitor mode for packet injection or sniffing:
```bash
sudo ip link set wlan0 down
sudo iw wlan0 set monitor control
sudo ip link set wlan0 up
```

## Complete Command Reference
This package does not provide a command-line tool; it provides binary files located in `/lib/firmware/zd1211/`. The interaction is handled by the kernel driver.

### Firmware Files Included:
* `/lib/firmware/zd1211/zd1211_ub`
* `/lib/firmware/zd1211/zd1211_uph`
* `/lib/firmware/zd1211/zd1211_ur`
* `/lib/firmware/zd1211/zd1211b_ub`
* `/lib/firmware/zd1211/zd1211b_uph`
* `/lib/firmware/zd1211/zd1211b_ur`

## Notes
* **Hardware Compatibility**: This firmware is specifically for USB devices. PCI versions of ZyDAS chips may use different drivers/firmware.
* **Monitor Mode**: Most devices using the `zd1211rw` driver support monitor mode and packet injection, making them suitable for wireless penetration testing.
* **Troubleshooting**: If the device is not recognized, ensure the `zd1211rw` module is not blacklisted in `/etc/modprobe.d/`.