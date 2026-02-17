---
name: horst
description: Highly Optimized Radio Scanning Tool for IEEE802.11 WLAN analysis. It provides a lightweight text interface to monitor signal strength (RSSI), channel utilization, and mesh network statistics. Use when performing wireless reconnaissance, debugging IBSS/mesh networks, identifying channel congestion, or monitoring remote wireless nodes via client/server mode.
---

# horst

## Overview
horst is a lightweight IEEE802.11 WLAN analyzer with a text interface. Unlike deep packet inspection tools, it focuses on aggregated information such as signal values per station, channel utilization, and spectrum analysis. It is particularly effective for debugging Ad-hoc (IBSS) and mesh networks (OLSR/batman). Category: Wireless Attacks / Reconnaissance.

## Installation (if not already installed)
Assume horst is already installed. If the command is missing:

```bash
sudo apt install horst
```

## Common Workflows

### Basic Monitoring
Start monitoring on the default interface (usually wlan0) with the interactive UI:
```bash
sudo horst -i wlan0
```

### Spectrum Analyzer Mode
Launch directly into the spectrum analyzer view to visualize channel usage and signal levels:
```bash
sudo horst -i wlan0 -s
```

### Remote Monitoring (Server/Client)
Run horst as a server on a remote node with a physical wireless card:
```bash
sudo horst -i wlan0 -N
```
Connect from a local machine to view the remote data:
```bash
horst -n <REMOTE_IP>
```

### Filtering for Specific Targets
Monitor only a specific Access Point (BSSID) and filter for Management frames:
```bash
sudo horst -i wlan0 -B 00:11:22:33:44:55 -f MANAGEMENT
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-v` | Show version information |
| `-h` | Display help message |
| `-q` | Quiet mode, no output |
| `-D` | Show verbose debug output and disable the UI |
| `-a` | Always add a virtual monitor interface automatically |
| `-c <file>` | Path to configuration file (default: `/etc/horst.conf`) |
| `-C <chan>` | Set the initial channel to monitor |
| `-i <intf>` | Interface name to use (default: `wlan0`) |
| `-t <sec>` | Node timeout in seconds (default: `60`) |
| `-d <ms>` | Display update interval in milliseconds (default: `100`) |
| `-V <view>` | Set initial display view: `history`, `essid`, `statistics`, or `spectrum` |
| `-b <bytes>` | Set receive buffer size in bytes |
| `-M[file]` | MAC address to host name mapping file (default: `/tmp/dhcp.leases`) |

### Feature Options
| Flag | Description |
|------|-------------|
| `-s` | Enable "Poor man's" Spectrum analyzer mode |
| `-u` | Set upper channel limit |
| `-N` | Server mode: Allow network connections (default: off) |
| `-n <IP>` | Client mode: Connect to a horst server at the specified IP |
| `-p <port>` | Port number for server/client connection (default: `4444`) |
| `-o <file>` | Write packet information into the specified filename |
| `-X[file]` | Allow control socket on the specified filename (default: `/tmp/horst`) |
| `-x <cmd>` | Send a control command to a running horst instance |

### Filter Options
Filters are inclusive (positive); if set, only matching traffic is shown.
| Flag | Description |
|------|-------------|
| `-e <MAC>` | Filter by Source MAC address. Can be specified up to 9 times |
| `-f <TYPE>` | Filter by packet type (e.g., `DATA`, `CTRL`, `MANAGEMENT`). Can be used multiple times |
| `-m <MODE>` | Filter by operating mode: `AP`, `STA`, `ADH`, `PRB`, `WDS`, or `UNKNOWN`. Can be used multiple times |
| `-B <MAC>` | Filter by BSSID (Access Point MAC). Only one BSSID can be specified |

## Notes
- **Monitor Mode**: horst requires the wireless interface to be in monitor mode. It can automatically attempt to create a monitor interface if run with `-a`.
- **Root Privileges**: Most operations (capturing from a local interface) require `sudo` or root privileges.
- **Mesh Support**: Includes specific support for visualizing OLSR and batman-adv mesh protocols.
- **IBSS Splits**: Useful for detecting "splits" where the same ESSID exists on different BSSIDs, often indicating driver or configuration issues in Ad-hoc networks.