---
name: fern-wifi-cracker
description: Automated wireless security auditing and attack tool used to crack WEP, WPA, and WPS keys. It provides a graphical interface for capturing packets, performing deauthentication attacks, and brute-forcing PINs or passphrases. Use when performing wireless penetration testing, auditing Wi-Fi security, or recovering network keys.
---

# fern-wifi-cracker

## Overview
Fern Wi-Fi Cracker is a Wireless security auditing and attack software program written in Python using the Qt GUI library. It automates the process of recovering WEP/WPA/WPS keys and can also perform other network-based attacks on wireless or ethernet-based networks. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install fern-wifi-cracker
```

**Dependencies:**
- aircrack-ng
- macchanger
- python3-pyqt5
- python3-scapy
- reaver
- xterm

## Common Workflows

### Launching the Graphical Interface
Fern is primarily a GUI-based tool. Launch it from a terminal with root privileges to ensure the wireless card can be put into monitor mode:
```bash
sudo fern-wifi-cracker
```

### Typical Auditing Workflow
1. **Select Interface**: Choose your wireless interface (e.g., `wlan0`) from the dropdown.
2. **Scan for Access Points**: Click the scan button to identify nearby WEP, WPA, or WPS-enabled networks.
3. **Select Target**: Click on the "WiFi WEP" or "WiFi WPA" buttons to see discovered networks.
4. **Configure Attack**:
   - For **WEP**: Choose between ARP Request Replay, Caffe-Latte, or Chop-Chop attacks.
   - For **WPA**: Browse for a wordlist and initiate a deauthentication attack to capture the 4-way handshake.
   - For **WPS**: Use the "WPS Attack" tab to brute-force the PIN using Reaver.
5. **Attack**: Press the "Attack" button to begin the automated cracking process.

## Complete Command Reference

The tool is designed to be run as a standalone GUI application. It does not typically utilize command-line arguments for its primary functions, as all configurations (interface selection, attack type, and wordlist paths) are handled within the Python Qt interface.

```bash
# Start the application
fern-wifi-cracker
```

### Core Features & Capabilities
- **WEP Cracking**: Supports ARP Request Replay, Caffe-Latte, P0841, and Chop-Chop attacks.
- **WPA/WPA2 Cracking**: Dictionary-based attacks against captured handshakes.
- **WPS Cracking**: Integrated Reaver functionality for brute-forcing WPS PINs.
- **Automatic Access Point Probing**: Scans and categorizes targets by encryption type.
- **Session Saving**: Ability to save and resume cracking sessions.
- **Internal Database**: Stores successfully cracked keys for future reference.
- **MAC Address Cloning**: Integrated macchanger support to mask the hardware address of the attacking interface.
- **Attack Automation**: Automatically handles the transition of the wireless card into monitor mode.

## Notes
- **Root Privileges**: This tool must be run with `sudo` or as the root user to interact with network hardware and toggle monitor mode.
- **Monitor Mode**: Fern will attempt to enable monitor mode automatically on the selected interface. If it fails, manually enable it using `airmon-ng start <interface>` before launching the tool.
- **Hardware Compatibility**: Requires a wireless adapter that supports packet injection and monitor mode.