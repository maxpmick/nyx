---
name: hcxtools
description: A collection of tools for capturing, converting, and manipulating WLAN traffic for use with hashcat and John the Ripper. Use when performing wireless security audits, converting pcapng captures to WPA/WPA2 hashes (mode 22000), performing PMKID/EAPOL analysis, or generating targeted wordlists from ESSIDs.
---

# hcxtools

## Overview
hcxtools is a set of utilities designed for the conversion of wireless capture files (pcapng/pcap/cap) into hash formats compatible with hashcat and John the Ripper. It includes tools for hash manipulation, wordlist generation based on ESSIDs, and automated uploading to cracking services. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt update
sudo apt install hcxtools
```

## Common Workflows

### Convert Capture to Hashcat Format
```bash
hcxpcapngtool -o output.22000 -E wordlist.txt capture.pcapng
```
Converts a capture file to hashcat mode 22000 and extracts ESSIDs into a wordlist.

### Filter Hashes by ESSID
```bash
hcxhashtool -i input.22000 -o filtered.22000 --essid="TargetWiFi"
```

### Generate Targeted Wordlist from ESSID
```bash
hcxeiutool -i essid_list -d digitlist -x xdigitlist -s sclist
cat essid_list digitlist xdigitlist sclist > final_wordlist.txt
```

### Identify MAC Vendor
```bash
whoismac -m 00:11:22:33:44:55
```

## Complete Command Reference

### hcxpcapngtool
Converts capture files to hash formats.

| Flag | Description |
|------|-------------|
| `-o <file>` | Output WPA-PBKDF2-PMKID+EAPOL hash file (hashcat -m 22000) |
| `-E <file>` | Output wordlist from all frames containing an ESSID |
| `-R <file>` | Output wordlist from PROBEREQUEST frames only |
| `-I <file>` | Output unsorted identity list |
| `-U <file>` | Output unsorted username list |
| `-D <file>` | Output device information list |
| `-h`, `-v` | Show help / version |
| `--all` | Convert all possible hashes instead of only the best one |
| `--eapoltimeout=<ms>` | Set EAPOL TIMEOUT (default: 5000 ms) |
| `--nonce-error-corrections=<digit>` | Set nonce error correction (default: 0) |
| `--ignore-ie` | Do not use CIPHER and AKM information |
| `--max-essids=<digit>` | Maximum allowed ESSIDs (default: 1) |
| `--eapmd5=<file>` | Output EAP MD5 CHALLENGE (hashcat -m 4800) |
| `--eapmd5-john=<file>` | Output EAP MD5 CHALLENGE (john chap) |
| `--eapleap=<file>` | Output EAP LEAP and MSCHAPV2 CHALLENGE |
| `--tacacs-plus=<file>` | Output TACACS PLUS v1 |
| `--nmea=<file>` | Output GPS data in NMEA 0183 format |
| `--csv=<file>` | Output Access Point information in CSV format |
| `--log=<file>` | Output logfile |
| `--raw-out=<file>` | Output frames in HEX ASCII |
| `--raw-in=<file>` | Input frames in HEX ASCII |
| `--lts=<file>` | Output BSSID list to sync with external GPS data |
| `--pmkid-client=<file>` | Output WPA-(MESH/REPEATER)-PMKID hash file |
| `--pmkid=<file>` | Output deprecated PMKID file (delimiter *) |
| `--hccapx=<file>` | Output deprecated hccapx v4 file |
| `--hccap=<file>` | Output deprecated hccap file |
| `--john=<file>` | Output deprecated JtR wpapsk-opencl format |
| `--prefix=<file>` | Convert everything to lists using this prefix |
| `--add-timestamp` | Add date/time and EAPOL TIME gap to hash line |

### hcxhashtool
Manipulates and filters hash files.

| Flag | Description |
|------|-------------|
| `-i <file>` | Input PMKID/EAPOL hash file |
| `-o <file>` | Output PMKID/EAPOL hash file |
| `-E <file>` | Output ESSID list (autohex enabled) |
| `-L <file>` | Output ESSID list (unfiltered and unsorted) |
| `-d` | Download IEEE OUI list |
| `--essid-group` | Convert to ESSID groups in working directory |
| `--oui-group` | Convert to OUI groups |
| `--mac-group-ap` | Convert APs to MAC groups |
| `--mac-group-client` | Convert CLIENTs to MAC groups |
| `--type=<digit>` | Filter by hash type (1=PMKID, 2=EAPOL, 3=Both) |
| `--hcx-min/max` | Filter by occurrence per ESSID |
| `--essid-len/min/max` | Filter by ESSID length |
| `--essid=<ESSID>` | Filter by exact ESSID |
| `--essid-part(x)=<str>` | Filter by part of ESSID (x for case-insensitive) |
| `--essid-list=<file>` | Filter by ESSID file |
| `--essid-regex=<regex>` | Filter ESSID by regular expression |
| `--mac-ap/client=<MAC>` | Filter by AP or Client MAC |
| `--mac-list/skiplist` | Filter/Exclude by MAC file |
| `--oui-ap/client=<OUI>` | Filter by OUI |
| `--vendor(-ap/client)` | Filter by vendor name |
| `--authorized` | Filter EAPOL pairs by status authorized |
| `--challenge` | Filter EAPOL pairs by status CHALLENGE |
| `--apless` | Filter EAPOL pairs by status M1M2ROGUE |
| `--info=<file/stdout>` | Output detailed info about hash file |
| `--psk=<PSK>` | Pre-shared key to test (slow) |
| `--pmk=<PMK>` | Plain master key to test |
| `--hccapx-in/out` | Input/Output deprecated hccapx |
| `--hccap-in/out` | Input/Output ancient hccap |

### hcxpsktool
Generates potential PSK candidates based on AP metadata.

| Flag | Description |
|------|-------------|
| `-c <file>` | Input hashcat -m 22000 file |
| `-i <file>` | Input hashcat -m 2500 file |
| `-j <file>` | Input John file |
| `-z <file>` | Input hashcat -m 16800 file |
| `-e <char>` | Input ESSID |
| `-b <xdigit>` | Input MAC access point |
| `-o <file>` | Output PSK file |
| `--maconly` | Print candidates based on MAC only |
| `--netgear` | Include weak Netgear/Orbi candidates |
| `--spectrum` | Include weak Spectrum candidates |
| `--digit10` | Include weak 10 digit candidates |
| `--phome` | Include weak Pegatron/Vantiva candidates |
| `--tenda` | Include weak Tenda candidates |
| `--ee/eeupper` | Include weak EE/BrightBox candidates |
| `--alticeoptimum` | Include weak Altice/Optimum candidates |
| `--asus` | Include weak ASUS RT-AC candidates |
| `--weakpass` | Include weak password candidates |
| `--eudate/usdate` | Include European/American dates |
| `--wpskeys` | Include complete WPS keys |
| `--simple` | Include simple patterns |

### hcxeiutool
Calculates wordlist candidates from ESSID lists.

| Flag | Description |
|------|-------------|
| `-i <file>` | Input wordlist |
| `-d <file>` | Output digit wordlist |
| `-x <file>` | Output xdigit wordlist |
| `-c <file>` | Output character wordlist (A-Za-z) |
| `-s <file>` | Output character wordlist (replaced by 0x0a for rules) |

### hcxwltool
Wordlist manipulation tool.

| Flag | Description |
|------|-------------|
| `-i <file>` | Input wordlist |
| `-o <file>` | Output wordlist |
| `--straight` | Output format untouched |
| `--digit` | Output format only digits |
| `--xdigit` | Output format only xdigits |
| `--lower/upper` | Output format only lower/upper case |
| `--capital` | Output format only capital |
| `--length=<8-32>` | Filter by password length |

### Additional Tools

**hcxhash2cap**: Converts hash files back to cap files (Note: M3 messages cannot be converted back).
- `-c <file>`: Output cap file.
- `--pmkid-eapol`, `--pmkid`, `--hccapx`, `--hccap`, `--john`: Input formats.

**hcxpmktool**: Verifies if a PSK/PMK matches a specific hash line.
- `-l <line>`: Hashcat -m 22000 line.
- `-e <ESSID>`, `-p <PSK>`: Input credentials.

**whoismac**: OUI lookup tool.
- `-d`: Download OUI list.
- `-m <mac/oui>`: Lookup MAC or OUI.
- `-p <hashline>`: Input hash line for lookup.

**wlancap2wpasec**: Uploads captures to wpa-sec.stanev.org.
- `-k <key>`: User key.
- `-u <url>`: Custom URL.
- `-R`: Remove file after successful upload.

## Notes
- **Hashcat Mode**: Use `-m 22000` for the combined PMKID/EAPOL format generated by `hcxpcapngtool`.
- **Integrity**: Do not use third-party cleaning tools on pcapng files before using `hcxpcapngtool`, as it relies on optional comment fields.
- **Nonce Errors**: `hcxtools` does not perform nonce error corrections by default. If packet loss occurred during capture, the resulting PTK may be incorrect.