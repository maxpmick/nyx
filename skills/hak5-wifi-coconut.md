---
name: hak5-wifi-coconut
description: Userspace driver and capture utility for the Hak5 Wi-Fi Coconut. It allows for simultaneous multi-channel Wi-Fi monitoring by capturing traffic across all 2.4 GHz channels. Use when performing wide-spectrum wireless reconnaissance, sniffing 802.11 traffic, or monitoring multiple Wi-Fi channels simultaneously during wireless security audits.
---

# hak5-wifi-coconut

## Overview
Userspace driver and interface for the Hak5 Wi-Fi Coconut hardware. It enables the capture of raw 802.11 frames across the entire 2.4 GHz spectrum simultaneously. Captured data can be viewed in an interactive UI or piped to other tools like Wireshark and Kismet. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, install via:

```bash
sudo apt update && sudo apt install hak5-wifi-coconut
```

## Common Workflows

### Interactive Monitoring
Launch the interactive channel UI to monitor traffic across all radios:
```bash
wifi_coconut
```

### Capture to PCAP file
Save all captured traffic from all channels into a single PCAP file for later analysis:
```bash
wifi_coconut --pcap=capture.pcap --no-display
```

### Live Analysis with Wireshark
Pipe the live multi-channel capture directly into Wireshark:
```bash
wifi_coconut --pcap=- | wireshark -k -i -
```

### Stealth Mode
Operate the device without any LED activity:
```bash
wifi_coconut --disable-leds --disable-blinking
```

## Complete Command Reference

```
wifi_coconut [options]
```

By default, the `wifi_coconut` tool opens in interactive mode.

### Universal Options

| Flag | Description |
|------|-------------|
| `--disable-leds` | Go fully dark; don't enable any LEDs |
| `--invert-leds` | Normally LEDs are on and blink during traffic; this flag keeps them off and only lights them during traffic |
| `--disable-blinking` | Disable blinking the LEDs on traffic |

### Non-interactive Modes & Device Control

| Flag | Description |
|------|-------------|
| `--no-display` | Don't display the channel UI while logging |
| `--wait` | Wait for a Wi-Fi Coconut to be found before starting |
| `--pcap=[fname]` | Log packets to a pcap file. If file is `-`, the pcap stream is echoed to stdout for piping |
| `--wait-for-coconut` | Wait for a coconut to be connected and identified |
| `--list-coconuts` | List detected Wi-Fi Coconut devices and exit |
| `--coconut-device=X` | If multiple devices are connected, specify which one to use (X = device index/ID) |
| `--enable-partial` | Enable the device even if not all radios have been identified |
| `--plain-dot11` | Log plain 802.11 packets instead of radiotap formatted packets (removes signal/channel metadata) |
| `--quiet` | Disable most console output |

## Notes
- The Wi-Fi Coconut requires significant USB bus bandwidth; ensure it is plugged into a high-speed USB 3.0 port.
- When using `--pcap=-`, ensure you use the `--quiet` or `--no-display` flags to prevent UI characters from corrupting the binary PCAP stream.
- Radiotap headers (default) are recommended for analysis as they preserve signal strength and channel information for each packet.