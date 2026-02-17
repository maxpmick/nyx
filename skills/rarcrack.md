---
name: rarcrack
description: Brute-force password cracker for RAR, ZIP, and 7Z encrypted archives. Use when attempting to recover forgotten passwords or perform password audits on compressed archive files during penetration testing or digital forensics.
---

# rarcrack

## Overview
RarCrack is a lightweight brute-force utility designed to guess passwords for encrypted RAR, ZIP, and 7Z archives. It uses a multi-threaded approach to test combinations against the archive's encryption. Category: Password Attacks.

## Installation (if not already installed)
Assume rarcrack is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install rarcrack
```

Dependencies: libc6, libxml2.

## Common Workflows

### Basic brute-force attack
Automatically detects the archive type and begins brute-forcing with a single thread.
```bash
rarcrack archive.zip
```

### Multi-threaded attack
Speed up the cracking process by specifying multiple threads (e.g., 4 threads).
```bash
rarcrack archive.rar --threads 4
```

### Specifying archive type
Force the tool to treat a file as a specific archive type if auto-detection fails.
```bash
rarcrack backup.data --type 7z --threads 8
```

## Complete Command Reference

```
rarcrack encrypted_archive.ext [--threads NUM] [--type rar|zip|7z]
```

### Options

| Flag | Description |
|------|-------------|
| `--help` | Show the help screen and version information. |
| `--type <rar\|zip\|7z>` | Manually specify the archive program/format. Use this if the program fails to detect the proper file type automatically. |
| `--threads <NUM>` | Specify how many concurrent threads to run for the brute-force process (default: 1). |

## Notes
- **Resume Support**: When rarcrack starts, it creates an XML file (e.g., `archive.xml`) in the same directory. This file stores the current status, including the alphabet being used and the last password tested. You can edit this XML file to change the character set or the starting password.
- **Performance**: Brute-forcing archives is computationally expensive. Increasing the `--threads` count can improve speed on multi-core systems, but performance is ultimately limited by the archive's encryption algorithm (e.g., AES-256 in 7z/RAR5).
- **Limitations**: This tool only supports RAR, ZIP, and 7Z formats.