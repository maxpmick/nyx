---
name: gtkhash
description: Compute and verify message digests or checksums using a GTK+ interface or command line. Supports multiple algorithms including MD5, SHA1, SHA256, SHA512, RIPEMD, and WHIRLPOOL. Use when verifying file integrity, checking downloaded ISOs against known hashes, or generating checksums for digital forensics and data validation.
---

# gtkhash

## Overview
GtkHash is a utility for computing message digests or checksums. It supports a wide array of hash functions and can be used as a standalone GUI application, a command-line tool, or integrated into file managers like Caja, Nemo, and Thunar. Category: Digital Forensics / Information Gathering.

## Installation (if not already installed)
Assume gtkhash is already installed. If the command is missing or you need specific file manager extensions:

```bash
sudo apt update
sudo apt install gtkhash
# Optional extensions:
sudo apt install caja-gtkhash   # For Caja (MATE)
sudo apt install nemo-gtkhash   # For Nemo (Cinnamon)
sudo apt install thunar-gtkhash # For Thunar (XFCE)
```

## Common Workflows

### Hash a specific file via CLI
```bash
gtkhash -f SHA256 /path/to/file.iso
```

### Verify a file against a known checksum
```bash
gtkhash -c 5e3504882479937173308508b190830bc7074697 --function=SHA1 file.zip
```

### Hash a string of text directly
```bash
gtkhash --text "secretpassword" --function=MD5
```

### Batch check hashes from a file
```bash
gtkhash --check-file=checksums.txt
```

## Complete Command Reference

```
gtkhash [OPTION…] [FILE|URI...]
```

### Help Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help options |
| `--help-all` | Show all help options |
| `--help-gtk` | Show GTK+ Options |

### Application Options

| Flag | Description |
|------|-------------|
| `-c`, `--check=DIGEST` | Check against the specified digest or checksum |
| `-C`, `--check-file=FILE\|URI` | Check digests or checksums from the specified file |
| `-f`, `--function=FUNCTION` | Enable the specified Hash Function (e.g. MD5, SHA256) |
| `-t`, `--text=TEXT` | Hash the specified text instead of a file |
| `-v`, `--version` | Show version information |
| `--display=DISPLAY` | X display to use |

### Supported Hash Functions
The tool supports various algorithms including, but not limited to:
- MD5, MD6
- SHA1, SHA256, SHA512
- RIPEMD
- TIGER
- WHIRLPOOL

## Notes
- If run without arguments, `gtkhash` launches the graphical user interface.
- The file manager extensions (Caja, Nemo, Thunar) add a "Hash" or "Digests" tab to the file properties dialog in the respective file manager.
- When using `--function`, ensure the algorithm name matches the standard naming conventions (e.g., `SHA256` rather than `sha-256`).