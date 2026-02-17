---
name: macchanger
description: View and manipulate the MAC (Media Access Control) addresses of network interfaces. Use when performing network reconnaissance, bypassing MAC filtering, anonymizing device identity, or testing network security controls. It belongs to the Sniffing & Spoofing and Wireless Attacks domains.
---

# macchanger

## Overview
GNU MAC Changer is a utility that simplifies the manipulation of MAC addresses for network interfaces. Since MAC addresses are often used to track devices across networks, changing them can thwart tracking and assist in security testing. Category: Sniffing & Spoofing / Wireless Attacks.

## Installation (if not already installed)
Assume macchanger is already installed. If you get a "command not found" error:

```bash
sudo apt install macchanger
```

## Common Workflows

### Show current MAC address
```bash
macchanger -s eth0
```

### Set a fully random MAC address
Note: Interfaces usually need to be down before changing the MAC.
```bash
sudo ip link set dev wlan0 down
sudo macchanger -r wlan0
sudo ip link set dev wlan0 up
```

### Reset to the permanent hardware MAC
```bash
sudo macchanger -p eth0
```

### Set a specific MAC address
```bash
sudo macchanger --mac=00:11:22:33:44:55 eth0
```

### Set a random MAC of the same vendor
```bash
sudo macchanger -a eth0
```

## Complete Command Reference

```
macchanger [options] device
```

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-h` | `--help` | Print help message and exit |
| `-V` | `--version` | Print version and exit |
| `-s` | `--show` | Print the current and permanent MAC address and exit |
| `-e` | `--ending` | Change only the device-specific bytes (don't change the vendor/OUI bytes) |
| `-a` | `--another` | Set a random vendor MAC of the same kind/vendor |
| `-A` | | Set a random vendor MAC of any kind |
| `-p` | `--permanent` | Reset the interface to its original, permanent hardware MAC |
| `-r` | `--random` | Set a fully random MAC address |
| `-l` | `--list[=keyword]` | Print known vendors. If a keyword is provided, filter the list |
| `-b` | `--bia` | Pretend to be a burned-in-address (BIA) |
| `-m` | `--mac=XX:XX:XX:XX:XX:XX` | Set the MAC address to the specific value provided |

## Notes
- **Interface State**: You must typically take the network interface down (`ip link set <iface> down` or `ifconfig <iface> down`) before changing the MAC address, and bring it back up afterward.
- **Persistence**: Changes made by macchanger are not persistent across reboots unless configured via system scripts (like NetworkManager or udev rules).
- **Privacy**: Regularly changing MAC addresses helps prevent device tracking by marketing firms or network monitoring systems.