---
name: aeskeyfind
description: Locate 128-bit and 256-bit AES keys in captured memory images. Use when performing digital forensics, memory analysis, or cryptographic recovery to find AES key schedules that may have been left in RAM, even if bits are corrupted due to memory decay.
---

# aeskeyfind

## Overview
aeskeyfind is a tool designed to locate 128-bit and 256-bit AES keys in a captured memory image. It uses automatic techniques and entropy tests to identify scheduled keys, filtering out blocks with too many repeated bytes. The tool is robust enough to function even if several bits of the key schedule have been corrupted. Category: Digital Forensics / Cryptography.

## Installation (if not already installed)
Assume aeskeyfind is already installed. If the command is missing:

```bash
sudo apt install aeskeyfind
```

## Common Workflows

### Basic key search
Search a memory dump for AES keys using default settings and a progress bar.
```bash
aeskeyfind memory.img
```

### Verbose search with error tolerance
Search for keys while allowing up to 15 bit errors (useful for decaying memory) and displaying extended key information.
```bash
aeskeyfind -v -t 15 memory.img
```

### Quiet mode for scripting
Run the search without displaying the progress bar, ideal for piping output to other tools.
```bash
aeskeyfind -q memory.img > discovered_keys.txt
```

## Complete Command Reference

```
aeskeyfind [OPTION]... MEMORY-IMAGE
```

### Options

| Flag | Description |
|------|-------------|
| `-v` | Verbose output. Prints the extended keys and the constraints on the rows of the key schedule. |
| `-q` | Quiet mode. Does not display the progress bar. |
| `-t THRESHOLD` | Sets the maximum number of bit errors allowed in a candidate key schedule (default = 10). |
| `-h` | Displays the help message. |

## Notes
- This tool is specifically designed to find "scheduled" keys (the expanded key material used during AES encryption/decryption), not just the raw master key.
- The entropy test helps reduce false positives by skipping blocks with high byte repetition.
- It is highly effective on cold-boot attack images or standard RAM dumps (e.g., from `LiME` or `memdump`).