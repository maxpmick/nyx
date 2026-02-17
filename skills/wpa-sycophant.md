---
name: wpa-sycophant
description: Relay Phase 2 authentication attempts (EAP-PEAP, EAP-TTLS) from a rogue access point to a legitimate corporate wireless infrastructure. Use this tool during wireless penetration testing to gain unauthorized network access by proxying authentication requests in real-time without needing to crack passwords.
---

# wpa-sycophant

## Overview
wpa-sycophant is a specialized tool designed to relay Phase 2 authentication attempts from a client connecting to a rogue access point directly to a target corporate wireless network. This allows an attacker to authenticate to a secure network by leveraging a legitimate user's credentials in real-time. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, use:

```bash
sudo apt update && sudo apt install wpa-sycophant
```

Dependencies: `libc6`, `libnl-3-200`, `libnl-genl-3-200`, `libssl3t64`.

## Common Workflows

### Basic Relay Operation
To start the relay, you must provide a configuration file (defining the target SSID and parameters) and the wireless interface to use for the upstream connection.

```bash
sudo wpa_sycophant -c /etc/wpa-sycophant/wpa_sycophant_example.conf -i wlan0
```

### Typical Attack Scenario
1. Set up a rogue Access Point (e.g., using `hostapd-mana`) configured to forward EAP requests to a local socket.
2. Configure `wpa_sycophant.conf` to point to the target corporate network.
3. Run `wpa_sycophant` to listen for incoming relayed authentication attempts from the rogue AP and proxy them to the real network.

## Complete Command Reference

```
Usage: sudo wpa_sycophant -c <config_file> -i <interface> [Options]
```

### Required Arguments

| Flag | Description |
|------|-------------|
| `-c <file>` | Path to the configuration file (e.g., `/etc/wpa-sycophant/wpa_sycophant.conf`) |
| `-i <iface>` | The wireless interface to use for connecting to the target network |

### General Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help/usage message |

## Notes
- **Rogue AP Requirement**: This tool does not work in isolation. It requires a modified Access Point (like `hostapd-mana`) that is capable of communicating with the Sycophant relay via a Unix domain socket.
- **Phase 2 Support**: Primarily targets EAP methods that use a tunneled Phase 2, such as PEAP or TTLS.
- **Configuration**: The configuration file follows a syntax similar to `wpa_supplicant.conf` but is tailored for the relaying mechanism. Ensure the `ssid` and `key_mgmt` fields match the target corporate network.
- **Permissions**: Must be run with `sudo` or as root to manage wireless interfaces and sockets.