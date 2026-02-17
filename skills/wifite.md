---
name: wifite
description: Automate wireless network auditing to crack WEP, WPA, and WPS encryption. It streamlines the process of putting interfaces into monitor mode, scanning for targets, and launching attacks like PMKID capture, WPS Pixie-Dust, and WPA handshake sniffing. Use when performing wireless penetration testing, auditing Wi-Fi security, or automating bulk wireless attacks.
---

# wifite

## Overview
A Python-based wrapper for the `aircrack-ng` suite, `reaver`, `bully`, and `tshark`. It automates the discovery and exploitation of wireless networks, supporting WEP cracking, WPA/WPA2 handshake capture, PMKID attacks, and WPS PIN/Pixie-Dust attacks. Category: Wireless Attacks.

## Installation (if not already installed)
Assume wifite is already installed. If missing:

```bash
sudo apt install wifite
```

## Common Workflows

### Automated scan and attack
```bash
sudo wifite
```
Starts the interactive menu: puts the card in monitor mode, scans for all networks, and lets you select targets.

### Attack WPS-enabled networks with high signal strength
```bash
sudo wifite --wps -pow 50
```
Filters for WPS-enabled access points with a power level of at least 50dB.

### Headless "Pillage" mode
```bash
sudo wifite --all --dict /usr/share/wordlists/rockyou.txt -p 60
```
Scans for 60 seconds, then automatically attacks every discovered target using the specified wordlist.

### PMKID-only attack (Clientless WPA)
```bash
sudo wifite --pmkid --pmkid-timeout 120
```
Attempts to capture PMKID hashes from access points, which does not require an active client to be connected.

## Complete Command Reference

### Settings

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--verbose` | Shows more options (-h -v). Prints commands and outputs (default: quiet) |
| `-i [interface]` | Wireless interface to use, e.g., wlan0mon (default: ask) |
| `-c [channel]` | Wireless channel to scan e.g., 1,3-6 (default: all 2Ghz channels) |
| `-inf`, `--infinite` | Enable infinite attack mode. Modify scanning time with -p (default: off) |
| `-mac`, `--random-mac` | Randomize wireless card MAC address (default: off) |
| `-p [scan_time]` | Pillage: Attack all targets after scan_time (seconds) |
| `--kill` | Kill processes that conflict with Airmon/Airodump (default: off) |
| `-pow`, `--power [min_power]` | Attacks any targets with at least min_power signal strength |
| `--skip-crack` | Skip cracking captured handshakes/pmkid (default: off) |
| `-first`, `--first [attack_max]` | Attacks the first attack_max targets |
| `-ic`, `--ignore-cracked` | Hides previously-cracked targets (default: off) |
| `--clients-only` | Only show targets that have associated clients (default: off) |
| `--nodeauths` | Passive mode: Never deauthenticates clients (default: deauth targets) |
| `--daemon` | Puts device back in managed mode after quitting (default: off) |

### WEP Options

| Flag | Description |
|------|-------------|
| `--wep` | Show only WEP-encrypted networks |
| `--require-fakeauth` | Fails attacks if fake-auth fails (default: off) |
| `--keep-ivs` | Retain .IVS files and reuse when cracking (default: off) |

### WPA Options

| Flag | Description |
|------|-------------|
| `--wpa` | Show only WPA-encrypted networks (includes WPS) |
| `--new-hs` | Captures new handshakes, ignores existing handshakes in hs/ folder (default: off) |
| `--dict [file]` | File containing passwords for cracking (default: /usr/share/dict/wordlist-probable.txt) |

### WPS Options

| Flag | Description |
|------|-------------|
| `--wps` | Show only WPS-enabled networks |
| `--wps-only` | Only use WPS PIN & Pixie-Dust attacks (default: off) |
| `--bully` | Use bully program for WPS PIN & Pixie-Dust attacks (default: reaver) |
| `--reaver` | Use reaver program for WPS PIN & Pixie-Dust attacks (default: reaver) |
| `--ignore-locks` | Do not stop WPS PIN attack if AP becomes locked (default: stop) |

### PMKID Options

| Flag | Description |
|------|-------------|
| `--pmkid` | Only use PMKID capture, avoids other WPS & WPA attacks (default: off) |
| `--no-pmkid` | Don't use PMKID capture (default: off) |
| `--pmkid-timeout [sec]` | Time to wait for PMKID capture (default: 300 seconds) |

### Commands

| Flag | Description |
|------|-------------|
| `--cracked` | Print previously-cracked access points |
| `--check [file]` | Check a .cap file (or all hs/*.cap files) for WPA handshakes |
| `--crack` | Show commands to crack a captured handshake |

## Notes
- **Root Required**: Must be run with `sudo` or as root to manipulate network interfaces.
- **Monitor Mode**: Wifite will attempt to enable monitor mode automatically, but it is often more reliable to use `airmon-ng start <interface>` beforehand.
- **Dependencies**: Ensure `hcxtools` and `hcxdumptool` are installed for optimal PMKID attack performance.
- **Storage**: Captured handshakes are typically stored in the `hs/` directory relative to where the command is run.