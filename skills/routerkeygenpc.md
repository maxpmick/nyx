---
name: routerkeygenpc
description: Generate default WPA/WEP keys for various router models based on SSID and MAC address. Use when performing wireless security audits or penetration testing against legacy or vulnerable routers that may still be using factory-default credentials.
---

# routerkeygenpc

## Overview
Router Keygen is a tool designed to calculate the default WPA/WEP keys for a wide variety of routers. It targets specific algorithms used by manufacturers to derive initial passwords from the device's SSID or MAC address. Category: Wireless Attacks.

## Supported Routers
* Thomson based (Thomson, SpeedTouch, Orange, Infinitum, BBox, DMax, BigPond, O2Wireless, Otenet, Cyta, TN_private, Blink)
* DLink (select models)
* Pirelli Discus
* Eircom
* Verizon FiOS (select models)
* Alice AGPF
* FASTWEB Pirelli and Telsey
* Huawei (some InfinitumXXXX)
* Wlan_XXXX / Jazztel_XXXX / Wlan_XX (select models)
* Ono (P1XXXXXX0000X)
* WlanXXXXXX, YacomXXXXXX, WifiXXXXXX
* Sky V1 routers
* Clubinternet.box v1 and v2 (TECOM-AH4XXXX)
* InfostradaWifi
* CONN-X
* Megared
* EasyBox, Arcor, Vodafone
* PBS (Austria)
* MAXCOM
* PTV
* TeleTu/Tele2
* Axtel, Axtel-xtremo
* Intercable
* OTE
* Cabovisao Sagem
* Alice (Germany)
* Speedport

## Installation (if not already installed)
Assume the tool is installed. If the command is missing:

```bash
sudo apt update && sudo apt install routerkeygenpc
```

## Common Workflows

### Calculate keys using SSID and MAC
```bash
routerkeygen-cli -s "SpeedTouch123456" -m "00:11:22:33:44:55"
```

### Quiet mode for scripting
```bash
routerkeygen-cli -q -s "WLAN_1234" -m "AA:BB:CC:DD:EE:FF"
```

### Identify the specific keygen algorithm used
```bash
routerkeygen-cli -k -s "ThomsonA1B2C3"
```

## Complete Command Reference

The package provides both a GUI (`routerkeygen`) and a command-line interface (`routerkeygen-cli`).

### routerkeygen-cli

```
routerkeygen-cli [-h] [-s network_name] [-m mac_address] [-k] [-q]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-s <network_name>`, `--ssid <network_name>` | Specify the SSID (Network Name) of the target router |
| `-m <mac_address>`, `--mac <mac_address>` | Specify the MAC address (BSSID) of the target router |
| `-k`, `--kg` | Print the keygen algorithm name alongside the candidate key in the format `kgname:candidate` |
| `-q`, `--quiet` | Quiet mode: Print only the calculated keys, suppressing headers and metadata |

## Notes
- This tool relies on known vulnerabilities in default key generation algorithms. If a router's password has been changed from the factory default, these keys will not work.
- For Thomson routers, providing the SSID is often sufficient, but providing the MAC address increases accuracy for other models.
- The GUI version can be launched by simply running `routerkeygen` in a terminal or via the Kali applications menu.