---
name: airgeddon
description: Multi-use bash script for auditing wireless networks. It acts as a menu-driven wrapper for various 3rd party tools to perform WEP/WPA/WPA2/WPA3 attacks, WPS exploitation, Evil Twin attacks, and enterprise network auditing. Use when performing wireless reconnaissance, capturing handshakes, launching deauthentication attacks, or conducting rogue access point simulations during wireless penetration testing.
---

# airgeddon

## Overview
airgeddon is a comprehensive, menu-driven wireless auditing framework. It integrates multiple tools (like aircrack-ng, mdk4, hostapd) into a unified interface to simplify complex wireless attacks. Category: Wireless Attacks.

## Installation (if not already installed)
Assume airgeddon is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install airgeddon
```

### Dependencies
The script relies on several external tools. It will perform a check upon startup and notify you if any are missing:
`aircrack-ng`, `bash`, `gawk`, `iproute2`, `iw`, `pciutils`, `procps`, `tmux`, `xterm`.

## Common Workflows

### Launching the Interactive Menu
Most users should run the tool without flags to access the full menu-driven interface:
```bash
sudo airgeddon
```

### Checking Dependencies and Environment
Run the script to trigger the initial auto-check for required tools and interface status:
```bash
sudo airgeddon
```
*Follow the on-screen prompts to install missing dependencies or set interfaces to monitor mode.*

### Capturing a WPA/WPA2 Handshake
1. Launch `airgeddon`.
2. Select the interface and switch to **Monitor Mode** via the menu.
3. Navigate to the **WPA/WPA2 attacks menu**.
4. Select **Explore for targets** to find an AP.
5. Choose a **Deauthentication attack** to force a client reconnect and capture the handshake file.

### Evil Twin Attack (Captive Portal)
1. Launch `airgeddon`.
2. Navigate to the **Evil Twin attacks menu**.
3. Select **Evil Twin AP attack with captive portal**.
4. Follow prompts to select the target, configure the DNS spoofing, and choose a portal template (e.g., generic login or firmware update).

## Complete Command Reference

airgeddon is primarily designed as an interactive tool. While it lacks a complex CLI argument structure for specific attacks (which are handled inside the TUI), it supports the following execution flags:

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help message and version information. |
| (No flags) | Launches the interactive, menu-driven bash script. |

### Internal Menu Modules
Once launched, the tool provides access to the following functional domains:
*   **Interface Management**: Switch between Managed and Monitor modes.
*   **DoS Attacks**: Various deauthentication and disassociation methods (mdk4, aireplay-ng).
*   **WPA/WPA2/WPA3 Attacks**: Handshake/PMKID capture and offline cracking.
*   **WPS Attacks**: Pixie Dust, PIN brute-force, and Null PIN attacks.
*   **Evil Twin Attacks**: Rogue AP creation with captive portals, DNS spoofing, and sniffing.
*   **Enterprise Attacks**: Auditing 802.1x enterprise networks.
*   **WPS/WPA/WPA2 Decryption**: Decrypting captured traffic using known keys/passwords.

## Notes
- **Root Privileges**: This tool must be run with `sudo` or as the `root` user to manipulate network interfaces.
- **Hardware Requirements**: Requires a wireless adapter that supports **Monitor Mode** and **Packet Injection**.
- **Screen Resolution**: airgeddon often opens multiple `xterm` windows; ensure you are running in a graphical environment (X11) or have an X-server configured if running remotely.
- **Safety**: Ensure you have explicit permission to audit the target wireless network. Deauthentication attacks can disrupt legitimate services.