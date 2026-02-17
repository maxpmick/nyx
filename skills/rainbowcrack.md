---
name: rainbowcrack
description: Crack password hashes using the time-memory trade-off technique with rainbow tables. Use when performing password recovery or offline hash cracking for LM, NTLM, MD5, SHA1, or SHA256 hashes during penetration testing or security audits.
---

# rainbowcrack

## Overview
RainbowCrack is a general-purpose implementation of Philippe Oechslin's faster time-memory trade-off technique. Unlike brute-force crackers, it uses precomputed rainbow tables to significantly accelerate the cracking process. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not found, use:

```bash
sudo apt install rainbowcrack
```

## Common Workflows

### Generate a Rainbow Table
Generate an MD5 rainbow table for lowercase alphanumeric passwords of length 1-7.
```bash
rtgen md5 loweralpha 1 7 0 1000 1000 0
```

### Sort and Merge Tables
Before using a generated table, it must be sorted to enable fast searching.
```bash
rtsort .
```

### Crack a Single Hash
Crack a specific MD5 hash using tables located in the current directory.
```bash
rcrack . -h 5d41402abc4b2a76b9719d911017c592
```

### Crack Hashes from a PWDUMP File
Crack NTLM hashes extracted from a Windows SAM/Active Directory dump.
```bash
rcrack /path/to/tables/ -ntlm hashes.pwdump
```

## Complete Command Reference

### rcrack
The main tool used to search rainbow tables for a hash match.

**Usage:** `rcrack path [path] [...] [options]`

| Option | Description |
|------|-------------|
| `path` | Directory where rainbow tables (`*.rt`, `*.rtc`) are stored |
| `-h <hash>` | Load and crack a single hash |
| `-l <hash_list_file>` | Load hashes from a file (one hash per line) |
| `-lm <pwdump_file>` | Load LM hashes from a pwdump formatted file |
| `-ntlm <pwdump_file>` | Load NTLM hashes from a pwdump formatted file |

**Supported Algorithms:**
- `lm` (HashLen=8, PlaintextLen=0-7)
- `ntlm` (HashLen=16, PlaintextLen=0-15)
- `md5` (HashLen=16, PlaintextLen=0-15)
- `sha1` (HashLen=20, PlaintextLen=0-20)
- `sha256` (HashLen=32, PlaintextLen=0-20)

---

### rtgen
Used to generate new rainbow tables.

**Usage:** 
- `rtgen hash_algorithm charset min_len max_len table_index chain_len chain_num part_index`
- `rtgen hash_algorithm charset min_len max_len table_index -bench`

| Parameter | Description |
|-----------|-------------|
| `hash_algorithm` | Algorithm to use (md5, sha1, sha256, lm, ntlm) |
| `charset` | Character set (e.g., loweralpha, numeric, alpha-numeric) |
| `plaintext_len_min` | Minimum length of the plaintext |
| `plaintext_len_max` | Maximum length of the plaintext |
| `table_index` | Index of the rainbow table |
| `chain_len` | Length of the rainbow chain |
| `chain_num` | Number of chains to generate |
| `part_index` | Index of the part |
| `-bench` | Benchmark the generation speed |

---

### rtsort
Sorts the rainbow tables (`*.rt`) to enable the `rcrack` tool to perform binary searches. This must be run on every `.rt` file before cracking.

**Usage:** `rtsort path`

---

### rtmerge
Used to merge multiple rainbow tables into a single file.

**Usage:** `rtmerge path`

---

### rt2rtc / rtc2rt
Utilities to convert rainbow tables between the `.rt` (Rainbow Table) and `.rtc` (Rainbow Table Compressed) formats.

**Usage:** 
- `rt2rtc path` (Convert to compressed)
- `rtc2rt path` (Convert to standard)

## Notes
- Rainbow tables can occupy significant disk space (often many gigabytes or terabytes for complex charsets).
- Ensure you have the correct charset and length parameters when generating tables, or `rcrack` will fail to find the plaintext.
- Tables must be sorted with `rtsort` before they can be used by `rcrack`.