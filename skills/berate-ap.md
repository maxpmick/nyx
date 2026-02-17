---
name: berate-ap
description: Orchestrate mana rogue Wi-Fi Access Points, regular hostapd APs, and MANA/Karma attacks. Use for wireless reconnaissance, credential harvesting (WPE), WPA handshake capture, and EAP relaying (wpa_sycophant) during wireless penetration testing.
---

# berate-ap

## Overview
A script for orchestrating mana rogue Wi-Fi Access Points. It simplifies the creation of rogue APs using `hostapd-mana` to perform MANA/Karma attacks, EAP credential harvesting, and internet sharing. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install berate-ap
```
Dependencies: `hostapd-mana`, `iproute2`, `iw`, `procps`.

## Common Workflows

### Basic Rogue AP with Internet Sharing
```bash
berate_ap wlan0 eth0 MyAccessPoint MyPassPhrase
```

### MANA Attack (Loud Mode)
Responds to all probes with all seen SSIDs to force client connections.
```bash
berate_ap --mana --mana-loud wlan0 eth0 RogueAP
```

### WPE (Wireless Pre-Shared Key) Credential Harvesting
Intercepts EAP credentials and saves them to a file.
```bash
berate_ap --mana-wpe --mana-credout /root/creds.txt wlan0 eth0 Enterprise_SSID
```

### WPA Handshake Capture (MANA WPA)
Captures handshakes in hashcat-compatible format.
```bash
berate_ap --mana-wpa --mana-wpaout /root/handshakes.hccapx wlan0 eth0 TargetSSID
```

## Complete Command Reference

```bash
berate_ap [options] <wifi-interface> [<interface-with-internet>] [<access-point-name> [<passphrase>]]
```

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help |
| `--version` | Print version number |
| `-c <channel>` | Channel number (default: 1) |
| `-w <version>` | WPA version: 1, 2, 3, 1+2 (default), or 2+3 |
| `-n` | Disable Internet sharing |
| `-m <method>` | Sharing method: `nat` (default), `bridge`, or `none` |
| `--psk` | Use 64 hex digits pre-shared-key instead of passphrase |
| `--hidden` | Do not broadcast the SSID |
| `--qrcode` | Show QR code of the AP (requires qrencode) |
| `--mac-filter` | Enable MAC address filtering |
| `--mac-filter-accept` | Path to MAC filter list (default: /etc/hostapd/hostapd.accept) |
| `--redirect-to-localhost` | If -n is set, redirect web requests to localhost |
| `--hostapd-debug <1-2>` | Pass -d or -dd to hostapd |
| `--isolate-clients` | Disable communication between clients |
| `--ieee80211n` | Enable IEEE 802.11n (HT) |
| `--ieee80211ac` | Enable IEEE 802.11ac (VHT) |
| `--ht_capab <HT>` | HT capabilities (default: [HT40+]) |
| `--vht_capab <VHT>` | VHT capabilities |
| `--country <code>` | Set two-letter country code (e.g., US) |
| `--freq-band <GHz>` | Set frequency band: 2.4 or 5 (default: 2.4) |
| `--driver` | Choose WiFi adapter driver (default: nl80211) |
| `--ieee80211w <0-2>` | Management Frame Protection: 0 (off), 1 (opt), 2 (req) |
| `--no-virt` | Do not create virtual interface |
| `--no-haveged` | Do not run 'haveged' automatically |
| `--fix-unmanaged` | Switch interface back to managed for NetworkManager |
| `--mac <MAC>` | Set MAC address |
| `--dhcp-dns <IPs>` | Set DNS returned by DHCP (comma separated) |
| `--daemon` | Run in the background |
| `--stop <id>` | Stop running instance by PID or interface |
| `--list-running` | Show running processes |
| `--list-clients <id>` | List clients connected to instance |
| `--mkconfig <file>` | Store configs in file |
| `--config <file>` | Load configs from file |
| `--owe` | Enable Opportunistic Wireless Encryption |

### Enterprise Options
| Flag | Description |
|------|-------------|
| `--eap` | Enable Enterprise (EAP) wireless settings |
| `--eap-user-file` | Path to EAP user file (default: hostapd.eap_user) |
| `--eap-cert-subj` | Set or modify certificate subject |
| `--eap-cert-path` | Path to certs (hostapd.ca/dh/cert/key.pem) |
| `--eap-key-passwd` | Password for the private key |
| `--radius-server` | Use external RADIUS server (default port 1812) |
| `--remote-radius <IP:port>` | IP and port of external RADIUS |
| `--radius-secret` | Shared RADIUS secret |

### Mana WPE Options
| Flag | Description |
|------|-------------|
| `--mana-wpe` | Enable WPE mode to intercept EAP credentials |
| `--mana-credout <file>` | Location of output creds (default: /tmp/hostapd.credout) |
| `--mana-eapsuccess` | Always return an EAP success message |
| `--mana-eaptls` | Accept any EAP-TLS client certificate |

### Mana/Karma Options
| Flag | Description |
|------|-------------|
| `--mana` | Respond to all device access point probes |
| `--mana-loud` | Respond with all seen APs to devices |
| `--mana-whitelist <list>` | List of SSIDs to respond to |
| `--mana-logging` | Enable device logging to file |
| `--mana-manaout <file>` | Location of mana logging file |

### MANA Other Options
| Flag | Description |
|------|-------------|
| `--mana-wpa` | Enable MANA WPA handshake capture (requires specific ESSID) |
| `--mana-wpaout <file>` | Output for wpa-psk handshakes (default: /tmp/hostapd.hccapx) |
| `--colour` | Colourise MANA output |
| `--vanilla` | Use vanilla hostapd instead of hostapd_mana |
| `--wpa-sycophant` | Enable relaying MSCHAP auth attempts (requires wpa_sycophant) |

### Non-Bridging Options
| Flag | Description |
|------|-------------|
| `--no-dns` | Disable dnsmasq DNS server |
| `--no-dnsmasq` | Disable dnsmasq server completely |
| `-g <gateway>` | IPv4 Gateway for the AP (default: 192.168.12.1) |
| `-d` | DNS server will use /etc/hosts |
| `-e <hosts_file>` | DNS server will use additional hosts file |

## Notes
- If not using `--no-virt`, you can create an AP on the same interface providing internet.
- The `--mana-wpa` attack currently does not work with general `--mana` enabled; a specific ESSID must be targeted.
- Use `--fix-unmanaged` if NetworkManager fails to reclaim the interface after closing the tool.