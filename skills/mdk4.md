---
name: mdk4
description: Exploit common IEEE 802.11 protocol weaknesses and perform wireless Denial-of-Service (DoS) attacks. Use for beacon flooding, deauthentication, hidden SSID brute-forcing, authentication DoS, and testing WIDS/WIPS resilience during wireless security audits.
---

# mdk4

## Overview
MDK4 is a multithreaded proof-of-concept tool used to exploit IEEE 802.11 protocol vulnerabilities. It is the successor to MDK3 and uses the `osdep` library from the aircrack-ng project to inject frames. It is primarily used for stress testing access points and simulating various Wi-Fi attacks. Category: Wireless Attacks.

## Installation (if not already installed)
Assume mdk4 is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install mdk4
```

## Common Workflows

### Deauthenticate all clients from a specific AP
```bash
mdk4 wlan0mon d -B 00:11:22:33:44:55
```

### Beacon Flooding (Fake APs) from a file
```bash
mdk4 wlan0mon b -f /usr/share/wordlists/ssids.txt -c 11
```

### Brute-force a hidden SSID
```bash
mdk4 wlan0mon p -t 00:11:22:33:44:55 -f /usr/share/wordlists/rockyou.txt
```

### Authentication DoS (Flood all APs in range)
```bash
mdk4 wlan0mon a -a 00:11:22:33:44:55
```

## Complete Command Reference

### Global Usage
```bash
mdk4 <interface> <attack_mode> [attack_options]
mdk4 <interface_in> <interface_out> <attack_mode> [attack_options]
```

### IDS Evasion Options
These can be appended after any attack mode identifier.

| Option | Description |
|--------|-------------|
| `--ghost <period>,<max_rate>,<min_txpower>` | Enable Ghosting (switch rate/power every X ms) |
| `--frag <min_frags>,<max_frags>,<percent>` | Enable Fragmenting of outgoing packets |

---

### ATTACK MODE b: Beacon Flooding
Sends beacon frames to show fake APs at clients.

| Flag | Description |
|------|-------------|
| `-n <ssid>` | Use SSID <ssid> instead of randomly generated ones |
| `-f <file>` | Read SSIDs from file |
| `-v <file>` | Read MACs and SSIDs from file |
| `-t <adhoc>` | Create Ad-Hoc network (1) or Managed (0, default) |
| `-w <enc>` | Set encryption: WEP (n), WPA (a), WPA2 (2) (default: open) |
| `-g` | Show AP as 54Mbps |
| `-m` | Use valid MAC address from OUI database |
| `-h` | Hop to the channel where the AP is (requires `-t 1`) |
| `-c <chan>` | Create AP on channel <chan> |
| `-s <pps>` | Set speed in packets per second (default: 50) |

### ATTACK MODE a: Authentication Denial-Of-Service
Sends authentication frames to all APs found in range.

| Flag | Description |
|------|-------------|
| `-a <ap_mac>` | Only test the specified AP |
| `-i <ap_mac>` | Ignore the specified AP |
| `-s <pps>` | Set speed in packets per second (default: unlimited) |
| `-m` | Use valid MAC address from OUI database |

### ATTACK MODE p: SSID Probing and Bruteforcing
Probes APs and checks for answer; useful for decloaking hidden SSIDs.

| Flag | Description |
|------|-------------|
| `-e <ssid>` | SSID to probe for |
| `-f <file>` | Read SSIDs from file for brute force |
| `-t <ap_mac>` | Target AP MAC address |
| `-s <pps>` | Set speed (default: 400) |
| `-b <char>` | Brute force mode (Character sets: `n` digits, `u` upper, `l` lower, `s` symbols) |

### ATTACK MODE d: Deauthentication and Disassociation
Disconnects clients from an AP based on data traffic.

| Flag | Description |
|------|-------------|
| `-w <file>` | Read MACs from whitelist |
| `-b <file>` | Read MACs from blacklist |
| `-s <pps>` | Set speed (default: unlimited) |
| `-c [chan,chan,...]` | Enable channel hopping |
| `-E <ssid>` | Target a specific SSID |
| `-B <ap_mac>` | Target a specific AP MAC |
| `-S <sta_mac>` | Target a specific Station MAC |

### ATTACK MODE m: Michael Countermeasures Exploitation
Provokes Michael Countermeasures on TKIP APs to shut them down for 60 seconds.

| Flag | Description |
|------|-------------|
| `-t <ap_mac>` | Target AP MAC address |
| `-j` | Use the new QoS exploit (re-injects packets) |
| `-s <pps>` | Set speed (default: 400) |
| `-w <seconds>` | Wait between bursts (default: 10) |

### ATTACK MODE e: EAPOL Start and Logoff Injection
Floods AP with EAPOL Start frames or injects fake Logoff messages.

| Flag | Description |
|------|-------------|
| `-t <ap_mac>` | Target AP MAC address |
| `-s <pps>` | Set speed (default: 400) |
| `-l` | Use Logoff messages to kick clients |

### ATTACK MODE s: IEEE 802.11s Mesh Networks
Attacks on link management and routing in mesh networks.

| Flag | Description |
|------|-------------|
| `-f <type>` | Flood type (1: Auth, 2: Peer Link, 3: Path Request) |
| `-t <ap_mac>` | Target AP MAC address |
| `-s <pps>` | Set speed (default: 100) |

### ATTACK MODE w: WIDS Confusion
Confuse Intrusion Detection Systems by cross-connecting clients.

| Flag | Description |
|------|-------------|
| `-e <ssid>` | SSID of target WDS network |
| `-c [chan,chan,...]` | Enable channel hopping |
| `-z` | Activate Zero_Knowledge mode (fools more WIDS) |

### ATTACK MODE f: Packet Fuzzer
A simple packet fuzzer with multiple sources and modifiers.

| Flag | Description |
|------|-------------|
| `-s <source>` | Source: 1: Beacon, 2: Data, 3: Auth, 4: ProbeReq |
| `-m <modifier>` | Modifier: 1: Random, 2: Flip, 3: Overwrite |

### ATTACK MODE x: Protocol Vulnerability Testing
Proof-of-concept for specific WiFi protocol implementation vulnerabilities.

| Flag | Description |
|------|-------------|
| `-t <ap_mac>` | Target AP MAC address |
| `-c <chan>` | Set channel |
| `-n <num>` | Test case number (1-10) |

## Notes
- **Interface**: Ensure your wireless interface is in **Monitor Mode** before running MDK4 (`airmon-ng start <interface>`).
- **Driver Support**: IDS evasion features (Ghosting/Fragmenting) are highly dependent on the wireless driver and hardware.
- **Legal**: Only use MDK4 on networks you have explicit permission to test. It is a powerful DoS tool that can disrupt legitimate communications.