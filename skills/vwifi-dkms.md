---
name: vwifi-dkms
description: Create and manage virtual Wi-Fi interfaces for testing wireless environments without physical hardware. Supports Station and Host AP modes with WPA/WPA2 security. Use when simulating wireless networks, testing hostapd/wpa_supplicant configurations, or performing wireless security research in virtualized environments.
---

# vwifi-dkms

## Overview
vwifi is a virtual Wi-Fi driver built upon the cfg80211 subsystem that collaborates with FullMAC drivers. It provides a minimal interface to scan for dummy Wi-Fi networks, establish connections, and disconnect. It is designed to work with standard tools like `iw`, `hostapd`, and `wpa_supplicant`. Category: Wireless Attacks / Wireless Simulation.

## Installation (if not already installed)
The tool consists of a kernel module (DKMS) and a userspace management tool.

```bash
sudo apt update
sudo apt install vwifi-dkms vwifi-tool
```

## Common Workflows

### Loading the Virtual Driver
After installation, the module must be loaded into the kernel to create the virtual wireless interfaces.
```bash
sudo modprobe vwifi
```

### Managing the Deny List
Use `vwifi-tool` to prevent specific interfaces from communicating or to clear existing restrictions.
```bash
# Block communication between wlan1 and wlan2
sudo vwifi-tool -s wlan1 -d wlan2

# Clear all interface restrictions
sudo vwifi-tool -c
```

### Setting up a Virtual Access Point
Combine with `hostapd` to create a virtual AP on a vwifi interface.
```bash
# Assuming vwifi has created wlan1
sudo hostapd /etc/hostapd/hostapd.conf
```

## Complete Command Reference

### vwifi-tool
A userspace tool providing flexibility and customization for the vwifi driver, specifically for status display and netlink socket communication to configure deny lists.

**Usage:**
```bash
vwifi-tool [arguments]
```

| Flag | Description |
|------|-------------|
| `-d <interface>` | Destination interface name for the deny list |
| `-s <interface>` | Source interface name for the deny list |
| `-c` | Clear the current denylist |

### Driver Capabilities
The `vwifi` driver supports the following modes and features via standard Linux wireless tools (like `iw` or `nmcli`):
- **Station Mode**: Connect to virtual access points.
- **Host AP Mode**: Act as a virtual access point.
- **Security**: Supports WPA and WPA2 protocols.
- **Subsystem**: Integrates with `cfg80211`.

## Notes
- **Dependencies**: Requires `dkms` for kernel module management and `iw` for interface configuration.
- **Integration**: Designed to be used in conjunction with `wpa_supplicant` for station mode and `hostapd` for AP mode.
- **Environment**: Ideal for CI/CD pipelines or security labs where physical Wi-Fi adapters are unavailable or impractical.