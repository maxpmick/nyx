---
name: pixiewps
description: Bruteforce the WPS PIN offline by exploiting the low or non-existing entropy of certain Access Points (Pixie Dust attack). Use when performing wireless security audits, attacking WPS-enabled networks, or when M1-M3 messages have been captured via tools like Reaver or Bully.
---

# pixiewps

## Overview
Pixiewps is an offline Wi-Fi Protected Setup (WPS) bruteforce tool written in C. It exploits the "Pixie Dust" vulnerability where certain Access Points use predictable or weak random number generators for their nonces and session keys. Category: Wireless Attacks.

## Installation (if not already installed)
Assume pixiewps is already installed. If you get a "command not found" error:

```bash
sudo apt install pixiewps
```

## Common Workflows

### Standard Pixie Dust Attack
Perform an offline attack using the Enrollee's public key, hashes, and nonces captured from a WPS exchange.
```bash
pixiewps -e <pke> -s <e-hash1> -z <e-hash2> -n <e-nonce> -m <r-nonce> -b <e-bssid>
```

### Mode 3 (RTL819x) Attack with M7/M5 Data
Recover the WPA-PSK and secret nonces from encrypted M7 (and optionally M5) settings.
```bash
pixiewps -e <pke> -r <pkr> -n <e-nonce> -m <r-nonce> -b <e-bssid> -7 <enc7> -5 <enc5> --mode 3
```

### Brute-forcing with specific modes
Attempt multiple attack modes (e.g., RT/MT/CL and eCos simple) simultaneously.
```bash
pixiewps -e <pke> -s <e-hash1> -z <e-hash2> -n <e-nonce> -m <r-nonce> -b <e-bssid> --mode 1,2
```

## Complete Command Reference

### Required and Optional Arguments

| Flag | Description |
|------|-------------|
| `-e`, `--pke` | Enrollee's DH public key, found in M1. |
| `-r`, `--pkr` | Registrar's DH public key, found in M2. |
| `-s`, `--e-hash1` | Enrollee hash-1, found in M3. Hash of the first half of the PIN. |
| `-z`, `--e-hash2` | Enrollee hash-2, found in M3. Hash of the second half of the PIN. |
| `-a`, `--authkey` | Authentication session key. Can be avoided by supplying `--e-nonce`, `--r-nonce`, and `--e-bssid`. |
| `-n`, `--e-nonce` | Enrollee's nonce, found in M1. |
| `-m`, `--r-nonce` | Registrar's nonce, found in M2. Used to compute session keys. |
| `-b`, `--e-bssid` | Enrollee's BSSID. Used to compute session keys. |
| `-S`, `--dh-small` | **Deprecated.** Small Diffie-Hellman keys. Must match Reaver option. |
| `--mode N[,... N]` | Select modes (1: RT/MT/CL, 2: eCos simple, 3: RTL819x, 4: eCos simplest [Exp], 5: eCos Knuth [Exp]). |
| `--start [mm/]yyyy` | Starting date for mode 3 (Unix epoch range). |
| `--end [mm/]yyyy` | Ending date for mode 3 (Unix epoch range). |
| `-7`, `--m7-enc` | Encrypted settings from M7. Recovers WPA-PSK and secret nonce 2 (Mode 3). |
| `-5`, `--m5-enc` | Encrypted settings from M5. Recovers secret nonce 1. Use with `--m7-enc`. |

## Notes
- Pixiewps is an **offline** tool. You must first capture the required values (PKE, PKR, E-Hash1/2, E-Nonce, R-Nonce) using a tool like `reaver` or `bully`.
- Mode 3 is specifically effective against Realtek (RTL819x) chipsets.
- If using `--mode 3`, you can use `--force` to make pixiewps start from the current time and go back to the Unix epoch (1970).
- This tool is intended for security auditing and educational purposes on networks you have permission to test.