---
name: iw
description: Configure and show information for Linux wireless devices using the nl80211 kernel interface. Use when performing wireless reconnaissance, setting up monitor mode, changing frequencies/channels, managing mesh networks, or troubleshooting 802.11 interfaces. It is the modern replacement for the deprecated iwconfig.
---

# iw

## Overview
`iw` is a CLI tool for configuring wireless devices based on the `nl80211` interface. It supports almost all modern wireless drivers and is used for tasks ranging from simple interface management to complex mesh and monitor mode configurations. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume `iw` is already installed. If missing:
```bash
sudo apt install iw
```

## Common Workflows

### List Wireless Interfaces and Capabilities
```bash
iw dev
iw phy
```

### Enable Monitor Mode
```bash
# Stop the interface first
sudo ip link set wlan0 down
# Change type to monitor
sudo iw wlan0 set type monitor
# Bring interface back up
sudo ip link set wlan0 up
```

### Scan for Networks
```bash
iw dev wlan0 scan
# Filter for specific SSID
iw dev wlan0 scan | grep SSID
```

### Set Channel/Frequency
```bash
# Set to channel 6 (2437 MHz)
iw dev wlan0 set channel 6
# Set to specific frequency
iw dev wlan0 set freq 2412
```

### Check Connection Link Status
```bash
iw dev wlan0 link
```

## Complete Command Reference

### Global Options
| Option | Description |
|--------|-------------|
| `--debug` | Enable netlink debugging |
| `--version` | Show version |

### Device and Interface Management
| Command | Description |
|---------|-------------|
| `dev` | List all network interfaces for wireless hardware |
| `dev <devname> info` | Show information for this interface |
| `dev <devname> del` | Remove this virtual interface |
| `dev <devname> interface add <name> type <type> [mesh_id <meshid>] [4addr on\|off] [flags <flag>*] [addr <mac-addr>]` | Add a new virtual interface. Types: managed, ibss, monitor, mesh, wds. |
| `phy` or `list` | List all wireless devices and their capabilities |
| `phy <phyname> info` | Show capabilities for the specified wireless device |
| `phy <phyname> set name <new name>` | Rename the wireless device |
| `phy <phyname> set netns { <pid> \| name <nsname> }` | Put device into a different network namespace |

### Configuration Commands
| Command | Description |
|---------|-------------|
| `dev <devname> set type <type>` | Set interface type (managed, ibss, monitor, mesh, wds) |
| `dev <devname> set 4addr <on\|off>` | Set interface 4addr (WDS) mode |
| `dev <devname> set power_save <on\|off>` | Set power save state |
| `dev <devname> set txpower <auto\|fixed\|limit> [<mBm>]` | Set transmit power |
| `dev <devname> set channel <channel> [HT/VHT/HE options] [punct <bitmap>]` | Set operating channel |
| `dev <devname> set freq <freq> [HT/VHT/HE options] [punct <bitmap>]` | Set operating frequency |
| `phy <phyname> set antenna <bitmap> \| all \| <tx> <rx>` | Set allowed antennas |
| `phy <phyname> set distance <auto\|distance>` | Set coverage class/ACK timeout (meters) |
| `phy <phyname> set retry [short <limit>] [long <limit>]` | Set retry limits |
| `phy <phyname> set rts <threshold\|off>` | Set RTS threshold |
| `phy <phyname> set frag <threshold\|off>` | Set fragmentation threshold |

### Scanning and Enumeration
| Command | Description |
|---------|-------------|
| `dev <devname> scan [-u] [freq <f>*] [duration <d>] [ies <hex>] [meshid <m>] [flags] [ssid <s\>*\|passive]` | Perform a one-shot scan |
| `dev <devname> scan dump [-u]` | Dump current scan results from kernel |
| `dev <devname> scan trigger [options]` | Trigger a scan without waiting for results |
| `dev <devname> scan abort` | Abort ongoing scan |
| `dev <devname> survey dump [--radio]` | List gathered channel survey data |
| `event [-t\|-T\|-r] [-f]` | Monitor kernel wireless events |

### Connection and Authentication
| Command | Description |
|---------|-------------|
| `dev <devname> connect [-w] <SSID> [<freq>] [<bssid>] [auth open\|shared] [key 0:abc] [mfp:req/opt/no]` | Join a network |
| `dev <devname> disconnect` | Disconnect from current network |
| `dev <devname> auth <SSID> <bssid> <type> <freq> [key]` | Authenticate with a network |
| `dev <devname> link` | Print information about current connection |
| `dev <devname> station dump [-v]` | List all known stations (e.g., connected AP) |
| `dev <devname> station get <MAC>` | Get info for a specific station |

### AP and Mesh Mode
| Command | Description |
|---------|-------------|
| `dev <devname> ap start <SSID> <freq> [options]` | Start an Access Point (requires hostapd) |
| `dev <devname> ap stop` | Stop AP functionality |
| `dev <devname> mesh join <mesh ID> [options]` | Join a mesh network |
| `dev <devname> mesh leave` | Leave a mesh |
| `dev <devname> mpath dump` | List known mesh paths |
| `dev <devname> ibss join <SSID> <freq> [options]` | Join/Create an IBSS (Ad-hoc) cell |

### Advanced / Regulatory
| Command | Description |
|---------|-------------|
| `reg get` | Print current regulatory domain |
| `reg set <ISO>` | Set regulatory domain (e.g., US, DE, JP) |
| `phy <phyname> channels` | Show available channels for the hardware |
| `phy <phyname> wowlan enable [triggers]` | Enable Wake-on-Wireless-LAN |
| `phy <phyname> coalesce enable <config-file>` | Enable packet coalescing |

## Notes
- **Monitor Mode Flags**: When adding a monitor interface, flags like `fcsfail`, `control`, and `otherbss` are useful for deep packet inspection.
- **Scripting**: Always use explicit `dev` or `phy` identifiers in scripts.
- **Power**: Power levels are often set in `mBm` (millibel-milliwatts). 100 mBm = 1 dBm.
- **Regulatory**: If you cannot set a specific channel or TX power, check `iw reg get` to see if your current regulatory domain restricts those settings.