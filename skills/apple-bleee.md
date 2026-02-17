---
name: apple-bleee
description: Sniff and analyze Bluetooth Low Energy (BLE) and Apple Wireless Direct Link (AWDL) traffic to extract information from Apple devices. Use when performing reconnaissance on Apple ecosystems, demonstrating AirDrop data leaks, monitoring AirPods status, or capturing hashed phone numbers and device states via BLE.
---

# apple-bleee

## Overview
A collection of experimental Proof-of-Concept (PoC) scripts designed to demonstrate what information an attacker can extract from Apple devices by sniffing Bluetooth and Wi-Fi traffic. It targets protocols like BLE and AWDL (AirDrop). Category: Sniffing & Spoofing / Reconnaissance.

## Installation (if not already installed)
Assume the tool is installed. If missing, run:

```bash
sudo apt update && sudo apt install apple-bleee
```

**Requirements:**
- A Bluetooth adapter capable of sending/receiving BLE messages.
- A Wi-Fi card supporting active monitor mode and frame injection (for AWDL/AirDrop scripts).

## Common Workflows

### Sniffing BLE Device State
To monitor nearby Apple devices and see status updates (like battery levels or setup states) sent via BLE:
```bash
sudo python3 /usr/share/apple-bleee/ble_read_state.py
```

### AirDrop Identity Leakage
To capture hashed phone numbers or email addresses from nearby devices attempting to use AirDrop:
```bash
sudo python3 /usr/share/apple-bleee/airdrop_leak.py -i wlan0mon
```

### Spoofing AirPods
To send BLE advertisements that trigger the AirPods pairing/status popup on nearby iPhones:
```bash
sudo python3 /usr/share/apple-bleee/adv_airpods.py
```

### Requesting Wi-Fi Password
To trigger a Wi-Fi password sharing request popup on nearby Apple devices:
```bash
sudo python3 /usr/share/apple-bleee/adv_wifi.py
```

## Complete Command Reference

The package consists of several standalone Python scripts located in `/usr/share/apple-bleee/`.

### ble_read_state.py
Sniffs BLE advertisements to display the state of nearby Apple devices.
- **Usage:** `sudo python3 /usr/share/apple-bleee/ble_read_state.py [options]`
- **Options:**
    - `-i, --interface` : Specify the Bluetooth interface (e.g., hci0).

### airdrop_leak.py
Captures AWDL frames to extract hashed identifiers (phone numbers/emails) from AirDrop.
- **Usage:** `sudo python3 /usr/share/apple-bleee/airdrop_leak.py -i <interface>`
- **Options:**
    - `-i, --interface` : Wi-Fi interface in monitor mode (required).

### adv_airpods.py
Sends BLE advertisements to mimic AirPods.
- **Usage:** `sudo python3 /usr/share/apple-bleee/adv_airpods.py`

### adv_wifi.py
Sends BLE advertisements to trigger Wi-Fi password sharing prompts.
- **Usage:** `sudo python3 /usr/share/apple-bleee/adv_wifi.py`

### opendrop2
A directory/module containing logic for interacting with AirDrop (OpenDrop implementation).
- **Usage:** Typically invoked via other scripts or as `python3 -m opendrop2`.

### hash2phone
A utility/directory used to assist in correlating captured hashes with known phone number formats.

### Internal Components
- `npyscreen`: Terminal user interface library used by the scripts.
- `utils`: Helper functions for cryptographic operations and packet parsing.

## Notes
- **Hardware:** These scripts are highly dependent on hardware capabilities. Not all Bluetooth dongles support the specific BLE broadcats required.
- **Monitor Mode:** For `airdrop_leak.py`, the Wi-Fi interface must be in monitor mode (e.g., `airmon-ng start wlan0`).
- **Legal:** Use only on devices you own or have explicit permission to test. Sniffing traffic in public spaces may be subject to local privacy laws.