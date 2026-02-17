---
name: pskracker
description: Generate default WPA/WPA2 keys and WPS PINs for specific router models using known algorithms. Use when performing wireless security auditing, testing for default credential vulnerabilities, or attempting to recover WiFi passwords based on BSSID and serial numbers.
---

# pskracker

## Overview
PSKracker is a collection of WPA/WPA2/WPS default key generators and PIN generators written in C. It implements bleeding-edge algorithms to derive default security credentials from hardware identifiers like BSSIDs and serial numbers. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, install the main package and its required data files:

```bash
sudo apt update
sudo apt install pskracker pskracker-data
```

## Common Workflows

### Generate default WPA keys for a specific model
```bash
pskracker --target <model_number> --bssid 00:11:22:33:44:55
```

### Generate only WPS PINs
```bash
pskracker -t <model_number> -b 00:11:22:33:44:55 --wps
```

### Generate keys using a serial number
```bash
pskracker -t <model_number> -s SN123456789 -b 00:11:22:33:44:55
```

### Force full output of all possible keys
```bash
pskracker -t <model_number> -b 00:11:22:33:44:55 --force
```

## Complete Command Reference

```
Usage: pskracker <arguments>
```

### Required Arguments

| Flag | Description |
|------|-------------|
| `-t`, `--target` | Target model number (refer to tool documentation or help for supported list) |

### Optional Arguments

| Flag | Description |
|------|-------------|
| `-b`, `--bssid` | BSSID (MAC address) of the target access point |
| `-W`, `--wps` | Output possible WPS pin(s) only |
| `-G`, `--guest` | Output possible guest WPA key(s) only |
| `-s`, `--serial` | Serial number of the target device |
| `-f`, `--force` | Force full output (useful if the tool filters results by default) |
| `-h`, `--help` | Display help/usage information |

## Notes
- The effectiveness of this tool depends on the `pskracker-data` package which contains the necessary dictionaries and algorithm mappings.
- Target model numbers vary; if the specific model is unknown, you may need to research the OUI of the BSSID to identify the manufacturer and likely model.
- This tool is specifically for **default** keys; if the user has changed the password or PIN, these generated values will not work.