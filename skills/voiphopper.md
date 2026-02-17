---
name: voiphopper
description: Run VLAN hop security tests to bypass NAC and gain access to Voice VLANs. Use when performing VoIP infrastructure security testing, VLAN segmentation bypass, or network reconnaissance to discover and jump into hidden voice networks using CDP, DHCP, or LLDP-MED.
---

# voiphopper

## Overview
VoIP Hopper is a security tool written in C that automates VLAN hopping attacks. It mimics the behavior of IP phones to discover Voice VLAN IDs via protocols like CDP, LLDP-MED, or DHCP, and then automatically creates a tagged VLAN interface to gain unauthorized network access. Category: Vulnerability Analysis / Sniffing & Spoofing.

## Installation (if not already installed)
Assume voiphopper is already installed. If the command is missing:

```bash
sudo apt install voiphopper
```

## Common Workflows

### CDP Sniffing and Auto-VLAN Hopping
Automatically sniff for Cisco Discovery Protocol packets to find the Voice VLAN ID and create a new interface.
```bash
voiphopper -i eth0 -c 0
```

### Manual VLAN Hopping
If the VLAN ID is already known (e.g., 200), manually create the tagged interface.
```bash
voiphopper -i eth0 -v 200
```

### Cisco Phone Emulation (CDP Spoofing)
Spoof a Cisco IP Phone to trigger the switch to assign the port to the Voice VLAN.
```bash
voiphopper -i eth0 -c 1 -E 'SEP00070EEA5086' -P 'Port 1' -C Host -L 'Cisco IP Phone 7940' -S 'P003-08-8-00' -U 1
```

### Avaya Discovery via DHCP
Discover the Voice VLAN using Avaya-specific DHCP options.
```bash
voiphopper -i eth0 -a
```

### Interactive Assessment Mode
Launch an interactive sniffer to learn hosts and analyze traffic on the interface.
```bash
voiphopper -i eth0 -z
```

## Complete Command Reference

### General & Miscellaneous Options
| Flag | Description |
|------|-------------|
| `-i <interface>` | Specify the network interface to use (e.g., eth0) |
| `-l` | List available interfaces for CDP sniffing, then exit |
| `-m <MAC>` | Spoof the MAC Address of the existing and new interface |
| `-D -m <MAC>` | Spoof the MAC Address of ONLY the new Voice Interface |
| `-d <interface>` | Delete a specific VLAN interface (e.g., eth0.200) and exit |
| `-z` | Start interactive assessment mode (ARP sniffing/host discovery) |
| `-V` | Print version information and exit |
| `-h` | Print help/usage information |

### CDP Spoof Mode (-c 1) Options
Used to emulate a Cisco IP Phone.
| Flag | Description |
|------|-------------|
| `-E <string>` | Device ID (e.g., SEP00070EEA5086) |
| `-P <string>` | Port ID (e.g., 'Port 1') |
| `-C <string>` | Capabilities (e.g., Host) |
| `-L <string>` | Platform (e.g., 'Cisco IP Phone 7940') |
| `-S <string>` | Software Version (e.g., 'P003-08-8-00') |
| `-U <string>` | Duplex (e.g., 1 for Full) |

### Discovery Modes
| Flag | Mode | Description |
|------|------|-------------|
| `-c 0` | CDP Sniff | Sniff for CDP packets to discover Voice VLAN ID |
| `-c 1` | CDP Spoof | Send spoofed CDP packets to trigger VLAN assignment |
| `-a` | Avaya DHCP | Use Avaya DHCP Option 176/242 to discover VLAN ID |
| `-v <ID>` | VLAN Hop | Manually specify the VLAN ID to jump into |
| `-t <0\|1\|2>` | Alcatel | Alcatel VLAN discovery (0: Sniff, 1: Spoof, 2: Manual) |

## Notes
- **Root Privileges**: This tool requires root privileges to create network interfaces and capture raw packets.
- **Interface Cleanup**: Use the `-d` flag to clean up virtual interfaces created during testing to avoid network configuration clutter.
- **MAC Spoofing**: When using `-m`, ensure the MAC address format is `XX:XX:XX:XX:XX:XX`. Spoofing the MAC to match a known valid IP phone is often necessary to bypass port security.