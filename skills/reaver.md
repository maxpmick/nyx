---
name: reaver
description: Brute force attack tool against Wi-Fi Protected Setup (WPS) PINs to recover WPA/WPA2 passphrases. Includes the wash utility for identifying WPS-enabled access points. Use during wireless security auditing to exploit vulnerable WPS implementations, perform Pixie Dust attacks, or recover wireless credentials when WPS is enabled and not properly locked.
---

# reaver

## Overview
Reaver performs a brute force attack against an Access Point's (AP) Wi-Fi Protected Setup (WPS) PIN number. Once the PIN is discovered, the AP's WPA/WPA2 PSK can be recovered. It includes `wash`, a survey tool to identify WPS-enabled networks and determine if they are locked. Category: Wireless Attacks.

## Installation (if not already installed)
Reaver is typically pre-installed on Kali Linux. If missing:
```bash
sudo apt update && sudo apt install reaver
```

## Common Workflows

### 1. Identify Targets with Wash
Before attacking, use `wash` to find APs with WPS enabled and check their lock status.
```bash
wash -i wlan0mon
```

### 2. Standard WPS Brute Force
Launch a basic attack against a specific BSSID with verbose output.
```bash
reaver -i wlan0mon -b 00:90:4C:C1:AC:21 -vv
```

### 3. Pixie Dust Attack
Perform an offline brute force of the WPS PIN (much faster than online attacks) if the AP is vulnerable.
```bash
reaver -i wlan0mon -b 00:90:4C:C1:AC:21 -K
```

### 4. Resuming a Session
Reaver saves progress automatically. To resume a specific session:
```bash
reaver -i wlan0mon -b 00:90:4C:C1:AC:21 -s sessionfile.wpc
```

## Complete Command Reference

### reaver
WPS PIN Cracking Tool.

**Required Arguments:**
| Flag | Description |
|------|-------------|
| `-i, --interface=<wlan>` | Name of the monitor-mode interface to use |
| `-b, --bssid=<mac>` | BSSID of the target AP |

**Optional Arguments:**
| Flag | Description |
|------|-------------|
| `-m, --mac=<mac>` | MAC of the host system |
| `-e, --essid=<ssid>` | ESSID of the target AP |
| `-c, --channel=<channel>` | Set the 802.11 channel for the interface (implies -f) |
| `-s, --session=<file>` | Restore a previous session file |
| `-C, --exec=<command>` | Execute the supplied command upon successful pin recovery |
| `-f, --fixed` | Disable channel hopping |
| `-5, --5ghz` | Use 5GHz 802.11 channels |
| `-v, --verbose` | Display non-critical warnings (-vv or -vvv for more) |
| `-q, --quiet` | Only display critical messages |
| `-h, --help` | Show help |

**Advanced Options:**
| Flag | Description |
|------|-------------|
| `-p, --pin=<wps pin>` | Use the specified pin (arbitrary string or 4/8 digit WPS pin) |
| `-d, --delay=<seconds>` | Set the delay between pin attempts [Default: 1] |
| `-l, --lock-delay=<seconds>` | Set time to wait if the AP locks WPS pin attempts [Default: 60] |
| `-g, --max-attempts=<num>` | Quit after num pin attempts |
| `-x, --fail-wait=<seconds>` | Set time to sleep after 10 unexpected failures [Default: 0] |
| `-r, --recurring-delay=<x:y>` | Sleep for y seconds every x pin attempts |
| `-t, --timeout=<seconds>` | Set the receive timeout period [Default: 10] |
| `-T, --m57-timeout=<seconds>` | Set the M5/M7 timeout period [Default: 0.40] |
| `-A, --no-associate` | Do not associate with the AP (must be done by another app) |
| `-N, --no-nacks` | Do not send NACK messages when out of order packets are received |
| `-S, --dh-small` | Use small DH keys to improve crack speed |
| `-L, --ignore-locks` | Ignore locked state reported by the target AP |
| `-E, --eap-terminate` | Terminate each WPS session with an EAP FAIL packet |
| `-J, --timeout-is-nack` | Treat timeout as NACK (useful for DIR-300/320) |
| `-F, --ignore-fcs` | Ignore frame checksum errors |
| `-w, --win7` | Mimic a Windows 7 registrar [Default: False] |
| `-K, --pixie-dust` | Run pixiedust attack |
| `-Z` | Run pixiedust attack (alias for -K) |
| `-O, --output-file=<file>` | Write packets of interest into pcap file |

---

### wash
WPS Identification and Survey Tool.

**Required Arguments:**
| Flag | Description |
|------|-------------|
| `-i, --interface=<iface>` | Interface to capture packets on |
| `-f, --file <files>` | Read packets from capture files (space separated list) |

**Optional Arguments:**
| Flag | Description |
|------|-------------|
| `-c, --channel=<num>` | Channel to listen on [Default: auto] |
| `-n, --probes=<num>` | Max number of probes to send to each AP in scan mode [Default: 15] |
| `-O, --output-file=<file>` | Write packets of interest into pcap file |
| `-F, --ignore-fcs` | Ignore frame checksum errors |
| `-2, --2ghz` | Use 2.4GHz 802.11 channels |
| `-5, --5ghz` | Use 5GHz 802.11 channels |
| `-s, --scan` | Use scan mode |
| `-u, --survey` | Use survey mode [Default] |
| `-a, --all` | Show all APs, even those without WPS |
| `-j, --json` | Print extended WPS info as JSON |
| `-U, --utf8` | Show UTF8 ESSID (does not sanitize ESSID, use with caution) |
| `-p, --progress` | Show progress |

## Notes
- **Monitor Mode**: Your wireless interface must be in monitor mode (e.g., using `airmon-ng start wlan0`) before running Reaver or Wash.
- **WPS Locking**: Many modern routers will "lock" WPS after a few failed attempts. Use `wash` to check the `Lck` column. If locked, you may need to use a high `--lock-delay` or wait for the owner to reboot the router.
- **Pixie Dust**: The `-K` (Pixie Dust) attack is offline and bypasses most rate-limiting/locking issues if the chipset is vulnerable. Always try this first.