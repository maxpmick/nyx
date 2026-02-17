---
name: owl
description: Open implementation of the Apple Wireless Direct Link (AWDL) ad hoc protocol. Use to interact with Apple devices over AWDL, perform wireless reconnaissance on Apple-specific protocols, or enable IPv6 communication with iPhones, iPads, and Macs via a virtual network interface. Relevant for wireless security auditing and sniffing/spoofing in Apple ecosystems.
---

# owl

## Overview
OWL is an open-source implementation of the Apple Wireless Direct Link (AWDL) protocol. It runs in user space and utilizes the Netlink API to perform Wi-Fi channel switching and create a virtual network interface. This allows standard IPv6-capable applications to communicate with Apple devices over their proprietary ad hoc protocol. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume `owl` is already installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install owl
```

Dependencies include `libc6`, `libev4`, `libnl-3`, `libnl-genl-3`, `libnl-route-3`, `libpcap`, and `radiotap-library`.

## Common Workflows

### Basic AWDL Interface Initialization
Start OWL on a specific wireless interface to create the `awdl0` virtual interface:
```bash
sudo owl -i wlan0
```

### Passive Monitoring
Run OWL in the foreground to observe AWDL traffic and peer discovery without active interaction:
```bash
sudo owl -i wlan0 -v
```

### Interaction with IPv6 Tools
Once the `awdl0` interface is up, use standard tools to discover peers:
```bash
ping6 ff02::1%awdl0
```

## Complete Command Reference

```
owl [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-i, --interface <iface>` | Specify the wireless interface to use (e.g., wlan0). The interface must support monitor mode and active frame injection. |
| `-a, --active` | Enable active mode (sending probe requests/beacons). |
| `-v, --verbose` | Increase output verbosity. Can be specified multiple times for more detail. |
| `-N, --no-promisc` | Do not put the wireless interface into promiscuous mode. |
| `-n, --no-tun` | Do not create a virtual TUN/TAP network interface (awdl0). |
| `-p, --pcap <file>` | Write captured AWDL frames to a PCAP file for later analysis in Wireshark. |
| `-d, --daemon` | Run the process in the background as a daemon. |
| `-h, --help` | Display the help menu and exit. |

## Notes
- **Hardware Support**: Requires a Wi-Fi adapter that supports monitor mode and frame injection.
- **Interface Name**: By default, OWL creates a virtual interface named `awdl0`.
- **Root Privileges**: OWL requires `sudo` or root privileges to manipulate network interfaces and raw sockets.
- **Compatibility**: AWDL is the underlying protocol for AirDrop, AirPlay, and Sidecar; using OWL allows Linux systems to "see" these services at the link layer.