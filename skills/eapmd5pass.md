---
name: eapmd5pass
description: Extract and crack EAP-MD5 authentication exchanges from live traffic or pcap files using offline dictionary attacks. Use when performing wireless security audits, attacking legacy 802.1X implementations, or recovering credentials from captured EAP-MD5 handshakes.
---

# eapmd5pass

## Overview
eapmd5pass is a specialized tool designed to exploit the inherent vulnerabilities in the legacy EAP-MD5 authentication mechanism. It extracts the challenge and response portions of an EAP-MD5 exchange from a live interface or a capture file and performs an offline dictionary attack to recover the user's password. Category: Wireless Attacks / Password Attacks.

## Installation (if not already installed)
Assume eapmd5pass is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install eapmd5pass
```

## Common Workflows

### Cracking from a PCAP file
```bash
eapmd5pass -r capture.pcap -w /usr/share/wordlists/rockyou.txt
```

### Live capture and crack from a specific BSSID
```bash
eapmd5pass -i wlan0mon -b 00:11:22:33:44:55 -w /usr/share/john/password.lst
```

### Manual entry of captured parameters
If you have already extracted the EAP-MD5 values using another tool:
```bash
eapmd5pass -U "victim_user" -C "challenge_hex" -R "response_hex" -E "id_hex" -w wordlist.txt
```

## Complete Command Reference

```
eapmd5pass [ -i <int> | -r <pcapfile> ] [ -w wordfile ] [options]
```

### Input Options

| Flag | Description |
|------|-------------|
| `-i <iface>` | Interface name (must be in monitor mode for wireless capture) |
| `-r <pcapfile>` | Read from a named libpcap file |

### Cracking Options

| Flag | Description |
|------|-------------|
| `-w <wordfile>` | Use wordfile for possible passwords (dictionary file) |
| `-b <bssid>` | BSSID of target network (default: all) |

### Manual Parameter Options
*Note: These options and `-r` are mutually exclusive.*

| Flag | Description |
|------|-------------|
| `-U <username>` | Username of the EAP-MD5 user |
| `-C <chal>` | EAP-MD5 challenge value (hex) |
| `-R <response>` | EAP-MD5 response value (hex) |
| `-E <eapid>` | EAP-MD5 response EAP ID value (hex) |

### General Options

| Flag | Description |
|------|-------------|
| `-v` | Increase verbosity level (can be used up to 3 times, e.g., `-vvv`) |
| `-V` | Display version information |
| `-h` | Display usage information |

## Notes
- EAP-MD5 does not provide mutual authentication or key derivation, making it highly susceptible to offline dictionary attacks if the exchange is captured.
- When using `-i`, ensure the wireless interface is in monitor mode and tuned to the correct channel.
- The `-r` option and the manual parameter options (`-U`, `-C`, `-R`, `-E`) are not meant to be used together. Use `-r` when a packet capture is available, and manual flags when values were obtained through other means.