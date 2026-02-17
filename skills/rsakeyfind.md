---
name: rsakeyfind
description: Locate BER-encoded RSA private keys within memory images or binary dumps. Use during digital forensics, incident response, or memory analysis to recover cryptographic keys from RAM captures, especially when searching for keys associated with a specific known modulus.
---

# rsakeyfind

## Overview
rsakeyfind is a specialized forensics tool designed to scan memory images for BER-encoded RSA private keys. It can perform generic searches for any RSA keys or targeted searches if a specific hex-encoded modulus is provided. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume rsakeyfind is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install rsakeyfind
```

## Common Workflows

### Scan a memory dump for any RSA private keys
```bash
rsakeyfind memory.dmp
```
Scans the entire file for structures matching BER-encoded RSA private keys and outputs their locations and values.

### Search for keys matching a specific modulus
```bash
rsakeyfind memory.dmp known_modulus.txt
```
Locates both private and public keys in the memory image that match the hex-encoded modulus provided in the text file.

### Scan a live memory device (requires root)
```bash
sudo rsakeyfind /dev/mem
```
Attempts to find RSA keys currently residing in physical memory.

## Complete Command Reference

```
rsakeyfind MEMORY-IMAGE [MODULUS-FILE]
```

### Arguments

| Argument | Description |
|----------|-------------|
| `MEMORY-IMAGE` | The path to the binary file or memory dump to be scanned (e.g., a `.raw`, `.dmp`, or `/dev/mem`). |
| `MODULUS-FILE` | (Optional) A file containing a hex-encoded RSA modulus. When provided, the tool filters results to find keys matching this specific modulus. |

## Notes
- **BER Encoding**: The tool specifically looks for Basic Encoding Rules (BER) structures, which is the standard format for ASN.1 data used in many RSA implementations (like OpenSSL).
- **Permissions**: Scanning system memory devices like `/dev/mem` or `/dev/fmem` typically requires root privileges.
- **Complementary Tools**: Often used alongside `aeskeyfind` (for AES keys) and `aesfix` during cold-boot attack analysis or forensic memory forensics.