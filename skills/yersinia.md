---
name: yersinia
description: A powerful framework for performing layer 2 network attacks against protocols like STP, CDP, DTP, DHCP, and HSRP. Use when performing network infrastructure penetration testing, VLAN hopping, spanning tree manipulation, or man-in-the-middle attacks at the data link layer.
---

# yersinia

## Overview
Yersinia is a low-level networking tool designed to take advantage of weaknesses in different Layer 2 protocols. It allows for the analysis and testing of deployed networks by simulating various protocol-specific attacks. Category: Sniffing & Spoofing / Vulnerability Analysis.

## Installation (if not already installed)
Assume yersinia is already installed. If the command is missing:

```bash
sudo apt install yersinia
```

## Common Workflows

### Interactive Mode (Recommended)
The most common way to use Yersinia is via its ncurses interface, which allows for real-time packet capture and attack launching.
```bash
sudo yersinia -I
```

### DHCP Rogue Server / Starvation
Launch a DHCP starvation attack to exhaust the IP pool or prepare for a rogue DHCP server attack.
```bash
sudo yersinia dhcp -attack 1
```

### STP Root Bridge Election
Attempt to become the Root Bridge in a Spanning Tree topology.
```bash
sudo yersinia stp -attack 1
```

### CDP Table Flooding
Flood a Cisco switch with CDP neighbor information to exhaust device memory.
```bash
sudo yersinia cdp -attack 1
```

## Complete Command Reference

### Global Options
```
yersinia [-hVGIDd] [-l logfile] [-c conffile] protocol [protocol_options]
```

| Flag | Description |
|------|-------------|
| `-V` | Display program version |
| `-h` | Display the global help screen |
| `-G` | Launch in Graphical mode (GTK) |
| `-I` | Launch in Interactive mode (ncurses) |
| `-D` | Launch in Daemon mode |
| `-d` | Enable Debugging |
| `-l <logfile>` | Select a specific logfile |
| `-c <conffile>` | Select a specific configuration file |

### Supported Protocols
Yersinia requires a protocol to be specified when not running in Interactive or Graphical mode:
- `cdp`: Cisco Discovery Protocol
- `dhcp`: Dynamic Host Configuration Protocol
- `dot1q`: IEEE 802.1Q
- `dot1x`: IEEE 802.1X
- `dtp`: Dynamic Trunking Protocol
- `hsrp`: Hot Standby Router Protocol
- `isl`: Inter-Switch Link Protocol
- `mpls`: Multi-Protocol Label Switching
- `stp`: Spanning Tree Protocol
- `vtp`: VLAN Trunking Protocol

### Protocol-Specific Options
To see specific attack IDs and options for a protocol, use:
```bash
yersinia <protocol> -h
```

#### Common Protocol Flags (General Pattern)
| Flag | Description |
|------|-------------|
| `-attack <id>` | Launch a specific attack (IDs vary by protocol) |
| `-interface <iface>` | Specify the network interface to use |

#### STP (Spanning Tree Protocol) Attacks
- `0`: NOP
- `1`: Sending RAW Configuration BPDU
- `2`: Sending RAW TCN BPDU
- `3`: Claiming Root Role
- `4`: Claiming Other Role
- `5`: Claiming Root Role with MiTM
- `6`: Sending Dual-Homed attack

#### CDP (Cisco Discovery Protocol) Attacks
- `0`: NOP
- `1`: Sending RAW CDP packet
- `2`: Flooding CDP table
- `3`: Setting up a virtual device

#### DHCP Attacks
- `1`: Sending RAW DHCP packet
- `2`: Discovering DHCP servers
- `3`: DHCP Starvation attack
- `4`: Rogue DHCP server

#### DTP (Dynamic Trunking Protocol) Attacks
- `1`: Sending RAW DTP packet
- `2`: Enabling Trunking

#### HSRP (Hot Standby Router Protocol) Attacks
- `1`: Sending RAW HSRP packet
- `2`: Becoming Active Router
- `3`: Becoming Active Router (MITM)

## Notes
- **Root Privileges**: Yersinia requires root privileges to craft and inject raw Layer 2 frames.
- **Network Impact**: Layer 2 attacks (especially STP and DHCP starvation) can be extremely disruptive to production networks. Use with caution.
- **Interface Selection**: In interactive mode, use `i` to select the correct network interface before starting an attack.