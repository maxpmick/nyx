---
name: bully
description: Implementation of the WPS brute force attack written in C. It exploits design flaws in the Wi-Fi Protected Setup (WPS) specification to recover WPA/WPA2 passphrases. Use when performing wireless security assessments, testing for WPS vulnerabilities, or attempting to recover Wi-Fi credentials from access points with WPS enabled.
---

# bully

## Overview
Bully is a high-performance C implementation of the WPS brute force attack. It is conceptually similar to Reaver but designed for better memory/CPU performance, correct endianness handling, and fewer dependencies. It automates the process of testing WPS pins to retrieve the network's plaintext password. Category: Wireless Attacks.

## Installation (if not already installed)
Bully is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install bully
```
Dependencies: `aircrack-ng`, `libpcap`, `pixiewps`.

## Common Workflows

### Basic Attack by ESSID
Target an access point by its name using a monitor mode interface:
```bash
bully -e "Target_Network" wlan0mon
```

### Attack by BSSID on a Specific Channel
Target a specific MAC address and lock the frequency to avoid channel hopping:
```bash
bully -b 00:11:22:33:44:55 -c 6 wlan0mon
```

### Pixie Dust Attack
Attempt to use the `pixiewps` offline brute force method for much faster results on supported chipsets:
```bash
bully -d -b 00:11:22:33:44:55 wlan0mon
```

### Sequential Pin Testing (Non-Randomized)
By default, bully randomizes pins. Use this for a linear 0000000-9999999 attack:
```bash
bully -S -b 00:11:22:33:44:55 wlan0mon
```

## Complete Command Reference

```bash
bully <options> interface
```

### Required Arguments
| Argument | Description |
|----------|-------------|
| `interface` | Wireless interface in monitor mode (requires root) |
| `-b, --bssid <mac>` | MAC address of the target access point |
| `-e, --essid <string>` | Extended SSID for the access point |

### Optional Arguments
| Flag | Description | Default |
|------|-------------|---------|
| `-c, --channel N[,N...]` | Channel number of AP, or list to hop [b/g] | Auto |
| `-i, --index N` | Starting pin index (7 or 8 digits) | Auto |
| `-l, --lockwait N` | Seconds to wait if the AP locks WPS | 43 |
| `-o, --outfile <file>` | Output file for messages | stdout |
| `-p, --pin N` | Starting pin number (7 or 8 digits) | Auto |
| `-s, --source <mac>` | Source (hardware) MAC address | Probe |
| `-u, --lua <file>` | Lua script file | - |
| `-v, --verbosity N` | Verbosity level 1-4 (1 is quietest) | 3 |
| `-w, --workdir <path>` | Location of pin/session files | `~/.bully/` |
| `-5, --5ghz` | Hop on 5GHz a/n default channel list | No |
| `-B, --bruteforce` | Bruteforce the WPS pin checksum digit | No |
| `-F, --force` | Force continue in spite of warnings | No |
| `-S, --sequential` | Sequential pins (do not randomize) | No |
| `-T, --test` | Test mode (do not inject any packets) | No |

### Advanced Arguments
| Flag | Description | Default |
|------|-------------|---------|
| `-d, --pixiewps` | Attempt to use pixiewps | No |
| `-a, --acktime N` | Deprecated/ignored | Auto |
| `-r, --retries N` | Resend packets N times when not acked | 2 |
| `-m, --m13time N` | Deprecated/ignored | Auto |
| `-t, --timeout N` | Deprecated/ignored | Auto |
| `-1, --pin1delay M,N` | Delay M seconds every Nth nack at M5 | 0,1 |
| `-2, --pin2delay M,N` | Delay M seconds every Nth nack at M7 | 5,1 |
| `-A, --noacks` | Disable ACK check for sent packets | No |
| `-C, --nocheck` | Skip CRC/FCS validation (performance) | No |
| `-D, --detectlock` | Detect WPS lockouts unreported by AP | No |
| `-E, --eapfail` | EAP Failure terminate every exchange | No |
| `-L, --lockignore` | Ignore WPS locks reported by the AP | No |
| `-M, --m57nack` | M5/M7 timeouts treated as WSC_NACK's | No |
| `-N, --nofcs` | Packets don't contain the FCS field | Auto |
| `-P, --probe` | Use probe request for non-beaconing AP | No |
| `-Q, --wpsinfo` | Use probe request to gather WPS info | No |
| `-R, --radiotap` | Assume radiotap headers are present | Auto |
| `-W, --windows7` | Masquerade as a Windows 7 registrar | No |
| `-Z, --suppress` | Suppress packet throttling algorithm | No |
| `-V, --version` | Print version info and exit | - |
| `-h, --help` | Display help information | - |

## Notes
- **WPS Locking**: Many modern routers will "lock" WPS after a few failed attempts. Use `-l` or `-D` to manage how Bully handles these locks.
- **Interface**: Ensure your wireless card is in monitor mode (e.g., via `airmon-ng start wlan0`) before running Bully.
- **Session Recovery**: Bully saves progress in `~/.bully/`. If an attack is interrupted, running the same command again will typically resume from the last saved state.