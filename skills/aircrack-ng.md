---
name: aircrack-ng
description: A comprehensive suite of tools for 802.11 wireless network auditing, including monitoring, attacking, testing, and cracking WEP and WPA-PSK keys. Use for wireless reconnaissance, packet injection, deauthentication attacks, and recovering wireless passwords during penetration testing.
---

# aircrack-ng

## Overview
Aircrack-ng is the industry-standard suite for wireless security auditing. It focuses on different areas of WiFi security: monitoring (airodump-ng), attacking (aireplay-ng), testing (airmon-ng), and cracking (aircrack-ng). Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume aircrack-ng is already installed. If missing:
```bash
sudo apt install aircrack-ng
```

## Common Workflows

### WPA2-PSK Crack (Handshake required)
```bash
# 1. Put interface in monitor mode
airmon-ng start wlan0
# 2. Capture handshake
airodump-ng -c <channel> --bssid <BSSID> -w capture_file wlan0mon
# 3. Deauth client to force handshake
aireplay-ng -0 5 -a <BSSID> -c <CLIENT_MAC> wlan0mon
# 4. Crack with wordlist
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture_file-01.cap
```

### Automated WEP/WPA Attack
```bash
besside-ng -W wlan0mon
```

### Decrypt Capture File
```bash
airdecap-ng -e 'NetworkName' -p 'password123' capture.cap
```

## Complete Command Reference

### airmon-ng
Manage monitor mode on wireless interfaces.
`usage: airmon-ng <start|stop|check> <interface> [channel or frequency]`

### airodump-ng
Wireless packet capture.
`usage: airodump-ng <options> <interface>`

| Option | Description |
|--------|-------------|
| `--ivs` | Save only captured IVs |
| `--gpsd` | Use GPSd |
| `--write <prefix>` | Dump file prefix |
| `--beacons` | Record all beacons in dump file |
| `--update <secs>` | Display update delay in seconds |
| `--showack` | Prints ack/cts/rts statistics |
| `-h` | Hides known stations for --showack |
| `-f <msecs>` | Time in ms between hopping channels |
| `--berlin <secs>` | Time before removing inactive AP/client (Default: 120s) |
| `-r <file>` | Read packets from file |
| `--real-time` | Simulate live arrival rate when reading file |
| `-x <msecs>` | Active Scanning Simulation |
| `--manufacturer` | Display manufacturer from IEEE OUI list |
| `--uptime` | Display AP Uptime from Beacon Timestamp |
| `--wps` | Display WPS information |
| `--output-format <formats>` | pcap, ivs, csv, gps, kismet, netxml, logcsv |
| `--write-interval <sec>` | Output file write interval |
| `--encrypt <suite>` | Filter by cipher suite |
| `--bssid <bssid>` | Filter by BSSID |
| `--essid <essid>` | Filter by ESSID |
| `--essid-regex <regex>` | Filter by ESSID regex |
| `-a` | Filter out unassociated stations |
| `--channel <chans>` | Capture on specific channels |
| `--band <abg>` | Band on which to hop |

### aireplay-ng
Packet injection and traffic generation.
`usage: aireplay-ng <options> <replay interface>`

**Attack Modes:**
- `--deauth <count>` (-0): Deauthenticate stations
- `--fakeauth <delay>` (-1): Fake authentication with AP
- `--interactive` (-2): Interactive frame selection
- `--arpreplay` (-3): Standard ARP-request replay
- `--chopchop` (-4): Decrypt/chopchop WEP packet
- `--fragment` (-5): Generates valid keystream
- `--caffe-latte` (-6): Query client for new IVs
- `--cfrag` (-7): Fragments against a client
- `--test` (-9): Tests injection and quality

### aircrack-ng
802.11 WEP / WPA-PSK key cracker.
`usage: aircrack-ng [options] <input file(s)>`

| Option | Description |
|--------|-------------|
| `-a <mode>` | Force mode (1/WEP, 2/WPA-PSK) |
| `-e <essid>` | Target ESSID |
| `-b <bssid>` | Target BSSID |
| `-w <words>` | Path to wordlist(s) |
| `-p <nbcpu>` | Number of CPUs to use |
| `-n <nbits>` | WEP key length (64/128/152/256/512) |
| `-K` | Use only old KoreK attacks (pre-PTW) |
| `-r <DB>` | Path to airolib-ng database |
| `-I <str>` | PMKID string (hashcat -m 16800) |
| `--simd=<type>` | Use specific SIMD (avx2, sse2, neon, etc.) |

### airbase-ng
Attacking clients (Fake AP).
`usage: airbase-ng <options> <replay interface>`
- `-a <bssid>`: Set AP MAC
- `-e <essid>`: Set ESSID
- `-c <channel>`: Set channel
- `-W 0|1`: Set WEP flag in beacons
- `-L`: Caffe-Latte WEP attack
- `-N`: cfrag WEP attack

### airdecap-ng
Decrypt pcap files.
- `-l`: Don't remove 802.11 header
- `-e <essid>`: Target SSID
- `-p <pass>`: WPA passphrase
- `-w <key>`: WEP key (hex)

### airolib-ng
Manage WPA pre-computed hashes.
- `--import [essid|passwd] <file>`: Import text file
- `--batch`: Start batch-processing PMKs
- `--stats`: Database information

### airgraph-ng
Visualization utility for airodump-ng CSV files.
- `-i <input.csv>`: Input CSV file
- `-o <output.png>`: Output image
- `-g <CAPR|CPG>`: Graph type (Client-to-AP or Common Probe)

## Notes
- **Monitor Mode**: Always use `airmon-ng check kill` before starting to prevent interference from NetworkManager or wpa_supplicant.
- **WPA Cracking**: Requires a 4-way handshake. Use `wpaclean` to strip unnecessary packets from large captures before cracking.
- **Legal**: Only perform wireless testing on networks you have explicit permission to audit.