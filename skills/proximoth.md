---
name: proximoth
description: Detect Wi-Fi devices vulnerable to Control Frame Attacks by injecting RTS (Request to Send) frames and monitoring for CTS (Clear to Send) responses. Use during wireless security audits, proximity detection, and vulnerability assessment of Wi-Fi client devices and access points.
---

# proximoth

## Overview
Proximoth is a command-line tool designed to detect Wi-Fi devices in proximity using Control Frame Attacks. It specifically tests for vulnerabilities related to how devices handle RTS/CTS (Request to Send / Clear to Send) mechanisms, which can be used for device tracking or denial-of-service research. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install proximoth
```

Dependencies: `libc6`, `libpcap0.8t64`.

## Common Workflows

### Basic Vulnerability Detection
Scan a specific target MAC address using a monitor mode interface:
```bash
proximoth -i wlan0mon AA:BB:CC:DD:EE:FF
```

### Stealthy Proximity Detection with Custom BSSID
Inject frames using a specific BSSID to mimic a known Access Point while saving results to a file:
```bash
proximoth -i wlan0mon -b 00:11:22:33:44:55 -o stats.txt AA:BB:CC:DD:EE:FF
```

### Capture Evidence to PCAP
Perform the attack and save all captured CTS responses to a PCAP file for later analysis in Wireshark:
```bash
proximoth -i wlan0mon -d captures.pcap AA:BB:CC:DD:EE:FF
```

### High-Frequency Testing
Reduce the interval between RTS injections (use with caution as low values may cause device malfunction):
```bash
proximoth -i wlan0mon -r 100000 AA:BB:CC:DD:EE:FF
```

## Complete Command Reference

```
proximoth [options] <target>
```

### Arguments
| Argument | Description |
|----------|-------------|
| `<target>` | MAC address of the target device to test. |

### Options
| Flag | Description |
|------|-------------|
| `-h, --help` | Prints the help screen. |
| `-o <file>, --out-file <file>` | File to write statistics after the tool is shut down. |
| `-b <bssid>, --bssid <bssid>` | Custom BSSID to be injected as the sender MAC address. Address is fixed automatically to be global and unicast unless `-a` is used. |
| `-a, --no-mac-autofix` | Disables the unicast/global auto-fix for BSSID MAC addresses. |
| `-i <iface>, --interface <iface>` | **Obligatory.** Wireless interface to use for packet injection and sniffing. Must be in monitor mode. |
| `-d <file>, --dump-file <file>` | Write all CTS captures to a PCAP file. |
| `-r <us>, --rts-interval <us>` | Microseconds to wait between RTS injections. Default: `500000`. |
| `-t, --text-mode` | Enables text-only mode (disables visual UI elements). |
| `--version` | Prints version number and author information. |

## Notes
- **Interface Requirements**: The wireless interface must support packet injection and be placed in monitor mode (e.g., using `airmon-ng start <iface>`) before running Proximoth.
- **Safety**: Setting the `-r` (RTS interval) too low can overwhelm the target device's wireless stack, potentially causing a temporary Denial of Service or hardware malfunction.
- **MAC Auto-fix**: By default, Proximoth ensures the BSSID used for injection is a valid global unicast address to ensure the target processes the frame correctly. Use `-a` only for specific research scenarios where malformed MACs are required.