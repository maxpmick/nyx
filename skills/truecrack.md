---
name: truecrack
description: Brute-force password cracker for TrueCrypt volumes optimized with NVIDIA CUDA technology. Use when attempting to recover passwords for encrypted TrueCrypt volumes using dictionary or alphabet-based (brute-force) attacks. It supports multiple key derivation functions (PBKDF2 with RIPEMD160, SHA512, or Whirlpool) and encryption algorithms (AES, Serpent, Twofish).
---

# truecrack

## Overview
TrueCrack is an open-source tool designed to brute-force TrueCrypt volumes. It is optimized for performance using NVIDIA CUDA technology but can also run on CPUs. It targets volumes using PBKDF2 for key derivation and XTS block cipher mode. Category: Password Attacks / Digital Forensics.

## Installation (if not already installed)
Assume truecrack is already installed. If the command is missing:

```bash
sudo apt install truecrack
```

## Common Workflows

### Dictionary Attack
Perform a dictionary attack against a standard TrueCrypt volume using default settings (RIPEMD160 and AES):
```bash
truecrack -t volume.tc -w /usr/share/wordlists/rockyou.txt
```

### Alphabet (Brute-force) Attack
Attempt to crack a volume by trying all combinations of numbers between 4 and 6 characters long:
```bash
truecrack -t volume.tc -c "1234567890" -s 4 -m 6
```

### Hidden Volume Attack with Specific Algorithms
Target a hidden TrueCrypt volume using SHA512 for key derivation and Twofish for encryption:
```bash
truecrack -t volume.tc -H -k sha512 -e twofish -w passwords.txt
```

### Restore a Session
Resume a previously interrupted computation using the restore flag:
```bash
truecrack -t volume.tc -w dictionary.txt -r 5000
```

## Complete Command Reference

### Usage Patterns
- **Dictionary Attack:** `truecrack -t <file> -w <wordlist> [options]`
- **Alphabet Attack:** `truecrack -t <file> -c <alphabet> -m <maxlength> [options]`

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display help information. |
| `-t`, `--truecrypt <file>` | Path to the TrueCrypt volume file. |
| `-k`, `--key <kdf>` | Key derivation function: `ripemd160`, `sha512`, or `whirlpool` (default: `ripemd160`). |
| `-e`, `--encryption <alg>` | Encryption algorithm: `aes`, `serpent`, or `twofish` (default: `aes`). |
| `-a`, `--aggressive <blocks>` | Number of parallel computations (board dependent). |
| `-w`, `--wordlist <file>` | File containing passwords for Dictionary attack. |
| `-c`, `--charset <alphabet>` | Alphabet string for Alphabet generator (e.g., "abcdef"). |
| `-s`, `--startlength <min>` | Starting length of passwords for Alphabet attack (default: 1). |
| `-m`, `--maxlength <max>` | Maximum length of passwords for Alphabet attack. |
| `-p`, `--prefix <string>` | Prefix the first part of the password for Alphabet attack. |
| `-r`, `--restore <number>` | Restore the computation from a specific point. |
| `-b`, `--backup` | Use the backup header instead of the volume header. |
| `-H`, `--hidden` | Target a hidden TrueCrypt volume. |
| `-v`, `--verbose` | Show computation messages and progress. |

## Notes
- **GPU Acceleration:** TrueCrack is optimized for NVIDIA CUDA. Ensure proper drivers are installed for maximum performance.
- **Hidden Volumes:** When attacking hidden volumes (`-H`), the tool looks for the header at a different offset within the file.
- **Backup Headers:** If the primary volume header is corrupted, use the `-b` flag to attempt cracking the backup header located at the end of the volume.