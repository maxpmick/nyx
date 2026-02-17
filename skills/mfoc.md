---
name: mfoc
description: Recover authentication keys from MIFARE Classic RFID tags using the "offline nested" attack. Use when performing RFID security assessments, cloning MIFARE Classic cards, or auditing access control systems where at least one key (default or custom) is known.
---

# mfoc

## Overview
MFOC (MIFARE Classic Offline Cracker) is an open-source implementation of the "offline nested" attack. it allows for the recovery of all keys from a MIFARE Classic card by exploiting the nested authentication vulnerability, provided that at least one key for any sector is already known (either a default key or a user-provided one). Category: Wireless Attacks / RFID.

## Installation (if not already installed)

Assume mfoc is already installed. If you get a "command not found" error:

```bash
sudo apt install mfoc
```

Dependencies: libc6, libnfc6.

## Common Workflows

### Standard attack using default keys
```bash
mfoc -O output_card_dump.mfd
```
Attempts to find one known key using internal default lists, then performs the nested attack to recover all other keys and dump the card data.

### Attack with a specific known key
```bash
mfoc -k ffffeeeedddd -O mycard.mfd
```
Useful if the card does not use standard default keys but you have discovered one key through other means.

### Using a custom key list for initial discovery
```bash
mfoc -f custom_keys.txt -O mycard.mfd
```
Reads a file containing potential keys to use as the exploit entry point.

### High-sensitivity attack for difficult tags
```bash
mfoc -P 50 -T 30 -O mycard.mfd
```
Increases the number of probes and the nonce tolerance to improve success rates on timing-sensitive or non-standard tags.

## Complete Command Reference

```
Usage: mfoc [-h] [-k key] [-f file] ... [-P probnum] [-T tolerance] [-O output]
```

| Flag | Description |
|------|-------------|
| `h` | Print the help message and exit. |
| `k` | Try the specified key (hex format) in addition to the default keys. |
| `f` | Parses a file of keys to add in addition to the default keys. |
| `P` | Number of probes per sector. (Default: 20) |
| `T` | Nonce tolerance half-range. (Default: 20, resulting in a total range of 40 in both directions) |
| `O` | **REQUIRED**: File in which the recovered card contents will be written. |
| `D` | File in which partial card info will be written in case the PRNG is not vulnerable. |

## Notes
- **Prerequisite**: This tool requires an NFC reader supported by `libnfc` (e.g., ACR122U, PN532).
- **Vulnerability**: This tool only works on MIFARE Classic cards vulnerable to the "nested" attack. It requires at least one sector key to be known to start the offline cracking process.
- If the PRNG (Pseudo-Random Number Generator) of the card is not vulnerable (e.g., MIFARE Classic EV1 or "Hardened" cards), use the `-D` flag to save progress or consider using `mfcuk` for the initial key recovery.