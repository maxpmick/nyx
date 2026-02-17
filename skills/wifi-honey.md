---
name: wifi-honey
description: Create a Wi-Fi honeypot by automating the setup of multiple monitor mode interfaces to broadcast a specific ESSID. It creates five virtual interfaces—four acting as Access Points (APs) and one running airodump-ng to capture handshakes. Use this for wireless reconnaissance, capturing WPA/WPA2 handshakes for cracking, and simulating rogue access points during wireless security assessments.
---

# wifi-honey

## Overview
wifi-honey is a script that automates the creation of a Wi-Fi honeypot. It sets up five monitor mode interfaces: four are used to broadcast the same ESSID as APs, and the fifth runs `airodump-ng` to capture traffic. The entire process is managed within a `screen` session, allowing the user to switch between different views of the attack. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume wifi-honey is already installed. If you encounter errors, ensure dependencies are met:

```bash
sudo apt update
sudo apt install wifi-honey aircrack-ng screen
```

## Common Workflows

### Basic Honeypot Setup
To start a honeypot broadcasting "FreeWiFi" on channel 6 using the physical interface `wlan0`:
```bash
sudo wifi-honey FreeWiFi 6 wlan0
```

### Managing the Honeypot Session
Once the script is running, it opens a `screen` session. Use the following commands to navigate:
- `Ctrl+a` then `n`: Switch to the next window.
- `Ctrl+a` then `p`: Switch to the previous window.
- `Ctrl+a` then `d`: Detach from the session (honeypot keeps running).
- `screen -r`: Reattach to the session.

### Capturing and Cracking Handshakes
While wifi-honey is running, the `airodump-ng` window will capture WPA/WPA2 handshakes. Once a handshake is captured, you can attempt to crack it:
```bash
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture_file.cap
```

## Complete Command Reference

```bash
wifi-honey <essid> <channel> <interface>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<essid>` | The name of the wireless network you want to broadcast. |
| `<channel>` | The primary channel for the honeypot (1-13). |
| `<interface>` | The physical wireless interface to use (e.g., `wlan0`). |

### Automated Actions
The script performs the following steps automatically:
1. Creates 5 monitor mode interfaces based on the provided physical interface.
2. Starts 4 AP instances broadcasting the specified `<essid>`.
3. Starts 1 `airodump-ng` instance to monitor and log traffic.
4. Wraps all processes into a labeled `screen` session for easy management.

## Notes
- **Interface Cleanup**: It is highly recommended to run `sudo airmon-ng check kill` before starting wifi-honey to prevent NetworkManager or wpa_supplicant from interfering with monitor mode.
- **Hardware Support**: Your wireless card must support monitor mode and packet injection.
- **WPA/WPA2 Handshakes**: By running `airodump-ng` alongside the APs, the tool captures the first two packets of the four-way handshake, which is sufficient for offline cracking attempts.
- **Stopping the Tool**: To stop the honeypot, enter the screen session and terminate the processes (usually `Ctrl+c` in each window) or kill the screen session.