---
name: cowpatty
description: Perform brute-force dictionary attacks against WPA-PSK and WPA2-PSK networks using packet captures of the 4-way handshake. Includes genpmk for precomputing Pairwise Master Keys (PMK) to accelerate the cracking process. Use when auditing wireless security, cracking WPA/WPA2 passphrases from .pcap files, or performing precomputation attacks on specific SSIDs.
---

# cowpatty

## Overview
cowpatty is a specialized tool for auditing WPA-PSK and WPA2-PSK networks. It identifies weak passphrases by comparing hashes generated from a dictionary against the 4-way handshake captured from a wireless network. It includes `genpmk` to precompute hashes for a specific SSID, significantly increasing cracking speed. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install cowpatty
```

## Common Workflows

### Verify Handshake in Capture
Check if a pcap file contains a valid 4-way handshake for a specific SSID before attempting to crack.
```bash
cowpatty -r capture.pcap -s "Target SSID" -c
```

### Standard Dictionary Attack
Perform a live hash generation and comparison using a wordlist.
```bash
cowpatty -f /usr/share/wordlists/rockyou.txt -r capture.pcap -s "Target SSID"
```

### Precomputation Attack (Faster)
First, precompute the PMK hashes for a specific SSID (this is the most time-consuming part).
```bash
genpmk -f /usr/share/wordlists/rockyou.txt -d precomputed_hashes -s "Target SSID"
```
Then, use the precomputed file to crack the handshake instantly.
```bash
cowpatty -d precomputed_hashes -r capture.pcap -s "Target SSID"
```

## Complete Command Reference

### cowpatty
The primary tool for WPA-PSK dictionary attacks.

| Flag | Description |
|------|-------------|
| `-f <file>` | Dictionary file (plain text wordlist) |
| `-d <file>` | Hash file (precomputed via `genpmk`) |
| `-r <file>` | Packet capture file (libpcap format) |
| `-s <ssid>` | Network SSID (enclose in quotes if it includes spaces) |
| `-c` | Check for valid 4-way frames only; does not attempt to crack |
| `-h` | Print help information and exit |
| `-v` | Print verbose information (use multiple times, e.g., `-vv`, for more verbosity) |
| `-V` | Print program version and exit |

### genpmk
Used to precompute PMK hashes for a specific SSID to speed up the cracking process.

| Flag | Description |
|------|-------------|
| `-f <file>` | Dictionary file (plain text wordlist) |
| `-d <file>` | Output hash file to be created |
| `-s <ssid>` | Network SSID for which the hashes will be valid |
| `-h` | Print help information and exit |
| `-v` | Print verbose information (use multiple times for more verbosity) |
| `-V` | Print program version and exit |

## Notes
- **SSID Sensitivity**: WPA-PSK hashes are salted with the SSID. A precomputed hash file generated for "Home_Network" will not work for "Office_Network".
- **Capture Requirements**: The packet capture (`-r`) must contain the full 4-way EAPOL handshake.
- **Performance**: Using `genpmk` is highly recommended for large wordlists or repeated attacks on the same SSID, as it moves the heavy PBKDF2 computation offline.