---
name: vlan
description: Configure and manage 802.1q VLAN interfaces on Linux systems. Use when performing network segmentation testing, bypassing VLAN tagging, or setting up virtual interfaces for sniffing and spoofing in environments using 802.1q trunking.
---

# vlan (vconfig)

## Overview
The `vlan` package provides tools and legacy integration scripts for configuring 802.1q VLAN interfaces. It includes the `vconfig` utility, which acts as a wrapper for `iproute2` commands to create, remove, and modify VLAN-tagged interfaces. Category: Sniffing & Spoofing / Network Configuration.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing:

```bash
sudo apt update && sudo apt install vlan
```

## Common Workflows

### Create a VLAN interface
Create a new VLAN interface with ID 10 on the physical interface eth0:
```bash
sudo vconfig add eth0 10
```
This usually creates an interface named `eth0.10` or `vlan0010` depending on the name type setting.

### Remove a VLAN interface
```bash
sudo vconfig rem eth0.10
```

### Set VLAN naming convention
Change how the system names new VLAN interfaces (e.g., to use `vlan5` instead of `eth0.5`):
```bash
sudo vconfig set_name_type VLAN_PLUS_VID_NO_PAD
```

### Configure QoS Mapping
Map socket buffer priority 0 to VLAN priority 7 for outgoing packets:
```bash
sudo vconfig set_egress_map eth0.10 0 7
```

## Complete Command Reference

The `vconfig` utility uses subcommands to manage VLAN configurations.

### Subcommands

| Command | Arguments | Description |
|---------|-----------|-------------|
| `add` | `[interface-name] [vlan_id]` | Create a VLAN interface on the specified physical device with the given ID (0-4095). |
| `rem` | `[vlan-name]` | Remove the specified VLAN interface. |
| `set_flag` | `[interface-name] [flag-num] [0 \| 1]` | Set specific operational flags (0 for OFF, 1 for ON). |
| `set_egress_map` | `[vlan-name] [skb_priority] [vlan_qos]` | Map internal socket buffer priority to VLAN header QoS priority for outgoing traffic. |
| `set_ingress_map` | `[vlan-name] [skb_priority] [vlan_qos]` | Map incoming VLAN header QoS priority to internal socket buffer priority. |
| `set_name_type` | `[name-type]` | Set the global naming convention for new VLAN interfaces. |

### Name Types
Used with the `set_name_type` command:
* `VLAN_PLUS_VID`: Results in `vlan0005`
* `VLAN_PLUS_VID_NO_PAD`: Results in `vlan5`
* `DEV_PLUS_VID`: Results in `eth0.0005`
* `DEV_PLUS_VID_NO_PAD`: Results in `eth0.5`

### Flags
Used with the `set_flag` command:
* `1` (**REORDER_HDR**): When ON, the VLAN device moves the ethernet header to mimic a physical ethernet device. Useful for programs like `dhcpd` that read raw packets. Default is OFF.

## Notes
- **Deprecation Warning**: `vconfig` is a legacy compatibility shim. For modern Linux systems, it is recommended to use `ip link` commands directly (e.g., `ip link add link eth0 name eth0.10 type vlan id 10`).
- **Interface State**: After adding a VLAN interface with `vconfig`, you must still bring the interface up using `ip link set <interface> up` or `ifconfig <interface> up`.
- **Persistence**: Changes made with `vconfig` are not persistent across reboots unless added to `/etc/network/interfaces`.