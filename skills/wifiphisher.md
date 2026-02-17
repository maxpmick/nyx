---
name: wifiphisher
description: Mount automated phishing attacks against Wi-Fi networks to obtain credentials or WPA/WPA2 passphrases without brute-forcing. Use when performing social engineering, rogue access point creation, captive portal testing, or Wi-Fi security auditing during penetration testing.
---

# wifiphisher

## Overview
Wifiphisher is a security tool that automates phishing attacks against Wi-Fi networks. It creates a rogue access point and uses social engineering to trick users into providing credentials (e.g., via captive portals or fake firmware upgrade pages) or WPA/WPA2 secret passphrases. It belongs to the Wireless Attacks and Social Engineering domains.

## Installation (if not already installed)
Assume wifiphisher is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt update
sudo apt install wifiphisher
```

## Common Workflows

### Automated Rogue AP with Firmware Upgrade Scenario
Create a rogue AP named "Free Wi-Fi" and present a fake firmware upgrade page to connected clients.
```bash
wifiphisher -e "Free Wi-Fi" -p firmware_upgrade
```

### Targeted Deauthentication and Phishing
Target a specific ESSID for deauthentication while spawning a rogue AP with the same name to capture credentials.
```bash
wifiphisher -e "Target_Network" -dE "Target_Network" -p oauth-login
```

### Verified Passphrase Capture
Use a handshake capture file to verify if the passphrase entered by the victim in the phishing page is correct (requires `cowpatty`).
```bash
wifiphisher -e "Home_WiFi" -p firmware_upgrade -hC handshake.pcap
```

### Advanced Interface Management
Manually specify interfaces for the Access Point and the deauthentication extensions.
```bash
wifiphisher -aI wlan0 -eI wlan1 -e "Public_WiFi"
```

## Complete Command Reference

```
wifiphisher [-h] [-i INTERFACE] [-eI EXTENSIONSINTERFACE] [-aI APINTERFACE] [-iI INTERNETINTERFACE] [-pI PROTECTINTERFACE [PROTECTINTERFACE ...]] [-mI MITMINTERFACE] [-iAM MAC_AP_INTERFACE] [-iEM MAC_EXTENSIONS_INTERFACE] [-iNM] [-kN] [-nE] [-nD] [-dC DEAUTH_CHANNELS [DEAUTH_CHANNELS ...]] [-e ESSID] [-dE DEAUTH_ESSID] [-p PHISHINGSCENARIO] [-pK PRESHAREDKEY] [-hC HANDSHAKE_CAPTURE] [-qS] [-lC] [-lE LURE10_EXPLOIT] [--logging] [-dK] [-lP LOGPATH] [-cP CREDENTIAL_LOG_PATH] [--payload-path PAYLOAD_PATH] [-cM] [-wP] [-wAI WPSPBC_ASSOC_INTERFACE] [-kB] [-fH] [-pPD PHISHING_PAGES_DIRECTORY] [--dnsmasq-conf DNSMASQ_CONF] [-pE PHISHING_ESSID]
```

### Interface Options

| Flag | Description |
|------|-------------|
| `-i`, `--interface` | Manually choose an interface that supports both AP and monitor modes |
| `-eI`, `--extensionsinterface` | Manually choose an interface for deauthenticating victims (monitor mode) |
| `-aI`, `--apinterface` | Manually choose an interface for spawning the rogue AP (AP mode) |
| `-iI`, `--internetinterface` | Choose an interface connected to the Internet |
| `-pI`, `--protectinterface` | Specify interface(s) to protect from NetworkManager control |
| `-mI`, `--mitminterface` | Choose an interface connected to Internet for MITM; others will be protected |
| `-iAM`, `--mac-ap-interface` | Specify the MAC address of the AP interface |
| `-iEM`, `--mac-extensions-interface` | Specify the MAC address of the extensions interface |
| `-iNM`, `--no-mac-randomization` | Do not change any MAC address |
| `-kN`, `--keepnetworkmanager` | Do not kill NetworkManager |

### Attack & Extension Options

| Flag | Description |
|------|-------------|
| `-nE`, `--noextensions` | Do not load any extensions |
| `-nD`, `--nodeauth` | Skip the deauthentication phase |
| `-dC`, `--deauth-channels` | Specific channels to deauth (e.g., `1,3,7`) |
| `-dE`, `--deauth-essid` | Deauth all BSSIDs in the WLAN with this ESSID |
| `-dK`, `--disable-karma` | Disables KARMA attack |
| `-cM`, `--channel-monitor` | Monitor if target access point changes the channel |
| `-kB`, `--known-beacons` | Broadcast beacon frames advertising popular WLANs |
| `-wP`, `--wps-pbc` | Monitor if the button on a WPS-PBC Registrar is pressed |
| `-wAI`, `--wpspbc-assoc-interface` | WLAN interface used for associating to the WPS AccessPoint |

### Rogue AP & Phishing Options

| Flag | Description |
|------|-------------|
| `-e`, `--essid` | ESSID of the rogue AP (skips selection phase) |
| `-pE`, `--phishing-essid` | Determine the ESSID to use for the phishing page |
| `-p`, `--phishingscenario` | Choose phishing scenario (e.g., `firmware_upgrade`, `oauth-login`) |
| `-pK`, `--presharedkey` | Add WPA/WPA2 protection (password) to the rogue AP |
| `-hC`, `--handshake-capture` | Path to pcap for verifying passphrases (requires `cowpatty`) |
| `-pPD`, `--phishing-pages-directory` | Search for phishing pages in this custom location |
| `--payload-path` | Path for scenarios serving a payload |
| `-fH`, `--force-hostapd` | Force the usage of system-installed hostapd |
| `--dnsmasq-conf` | Path to a custom `dnsmasq.conf` file |

### Lure10 (Location) Options

| Flag | Description |
|------|-------------|
| `-lC`, `--lure10-capture` | Capture BSSIDs of APs discovered during selection phase |
| `-lE`, `--lure10-exploit` | Fool Windows Location Service using previously captured data |

### Output & Logging Options

| Flag | Description |
|------|-------------|
| `-qS`, `--quitonsuccess` | Stop the script after successfully retrieving one pair of credentials |
| `--logging` | Log activity to file |
| `-lP`, `--logpath` | Full path of the logfile |
| `-cP`, `--credential-log-path` | Full path of the file to store captured credentials |
| `-h`, `--help` | Show help message and exit |

## Notes
- **Hardware Requirements**: Requires wireless cards that support Monitor Mode and AP Mode.
- **Dependencies**: Relies on `hostapd`, `dnsmasq`, and `iptables` for network management.
- **Verification**: The `-hC` flag is highly recommended when targeting WPA2 passwords to ensure the captured key is valid before ending the attack.