---
name: ifenslave
description: Attach and detach slave network interfaces to a bonding device for parallel routing, load balancing, and fault tolerance. Use when configuring network bonding (channel bonding/trunking), setting up redundant network links, or increasing bandwidth via link aggregation on Linux systems.
---

# ifenslave

## Overview
ifenslave is a tool used to attach and detach slave network interfaces to a bonding device. A bonding device acts like a single Ethernet interface to the kernel but distributes traffic across multiple slave interfaces (e.g., eth0, eth1) using various schedulers like round-robin. This provides load balancing and high availability. Category: Sniffing & Spoofing / Network Configuration.

## Installation (if not already installed)
Assume ifenslave is already installed. If the command is missing:

```bash
sudo apt install ifenslave
```

Dependencies: `ifupdown`, `iproute2`. The kernel must have bonding support enabled (`modprobe bonding`).

## Common Workflows

### Create a bond and add interfaces
```bash
# Load the bonding module
sudo modprobe bonding
# Bring up the bond interface
sudo ip link set bond0 up
# Attach physical interfaces to the bond
sudo ifenslave bond0 eth0 eth1
```

### Detach an interface from a bond
```bash
sudo ifenslave -d bond0 eth1
```

### Change the active slave (for active-backup mode)
```bash
sudo ifenslave -c bond0 eth1
```

### View bonding status
```bash
cat /proc/net/bonding/bond0
```

## Complete Command Reference

```
ifenslave [-afv] bond-device [slave-device ...]
ifenslave -d [-fv] bond-device [slave-device ...]
ifenslave -c [-fv] bond-device slave-device
```

### Options

| Flag | Description |
|------|-------------|
| `-a`, `--all-interfaces` | Show information about all interfaces. |
| `-d`, `--detach` | Detach slave interfaces from the bonding device. |
| `-c`, `--change-active` | Change the active slave interface. The bond must be in active-backup mode. |
| `-f`, `--force` | Force the operation. Use with caution. |
| `-v`, `--verbose` | Print detailed progress and debug information. |
| `-u`, `--usage` | Show a brief usage message. |
| `-V`, `--version` | Show version information. |
| `-h`, `--help` | Show help message. |

## Notes
- **Kernel Support**: The Linux kernel must have the `bonding` module loaded for this tool to function.
- **Modern Usage**: While `ifenslave` is still functional, many modern distributions prefer configuring bonding via `iproute2` (`ip link`) or NetworkManager/systemd-networkd configuration files.
- **Configuration**: For persistent bonding across reboots, interfaces should be configured in `/etc/network/interfaces` (on Debian-based systems) using `bond-slaves`, `bond-mode`, and `bond-miimon` parameters.
- **Switch Support**: Some bonding modes (like LACP/802.3ad) require specific configuration on the physical switch connected to the slave interfaces.