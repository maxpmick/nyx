---
name: rephrase
description: Specialized passphrase recovery tool for GnuPG and LUKS. Use when a user remembers parts of a passphrase but is unsure of specific segments, allowing for the testing of multiple permutations and combinations to recover access to GPG keys, symmetrically encrypted files, or LUKS encrypted block devices.
---

# rephrase

## Overview
Rephrase is a specialized tool designed to recover forgotten passphrases for GnuPG and LUKS. It allows users to input known parts of a passphrase and provide alternatives for uncertain sections. The tool then iterates through all possible combinations to identify the correct one. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume the tool is already installed. If not, use:

```bash
sudo apt install rephrase
```

## Common Workflows

### Recovering a GPG Private Key Passphrase
If you remember your passphrase starts with "P@ss" and ends with "2023", but aren't sure if the middle is "word" or "W0rd":
```bash
rephrase <key_id>
# When prompted for parts:
# Part 1: P@ss
# Part 2: word, W0rd
# Part 3: 2023
# Part 4: (leave empty to finish)
```

### Recovering a GPG Symmetrically Encrypted File
```bash
rephrase --gpg-symmetric secret.gpg
```

### Recovering a LUKS Partition Passphrase
```bash
sudo rephrase --luks /dev/sdb1
```

## Complete Command Reference

The tool operates by prompting the user for "parts" of the passphrase. For each part, you can enter a single string (if certain) or multiple comma-separated strings (if uncertain). Rephrase will then test every possible combination.

### Usage Modes

| Command / Flag | Description |
|----------------|-------------|
| `rephrase <key>` | Attempt to recover the passphrase for a specific GPG key ID or UID |
| `rephrase --gpg-key <key>` | Explicitly specify a GPG key for passphrase recovery |
| `rephrase --gpg-symmetric <file>` | Attempt to recover the passphrase for a GPG symmetrically encrypted file |
| `rephrase --luks <device>` | Attempt to recover the passphrase for a LUKS encrypted block device (requires root) |
| `rephrase -h` | Display help and version information |

### Input Syntax
When the tool runs, it prompts for `Part 1`, `Part 2`, etc.
- **Single possibility**: Type the string and press Enter.
- **Multiple possibilities**: Type strings separated by commas (e.g., `word,W0rd,w0rd`).
- **Finish**: Press Enter on an empty part to begin the brute-force process.

## Notes
- **Performance**: The number of combinations grows exponentially with the number of alternatives provided. Keep the search space focused.
- **Permissions**: Recovering LUKS passphrases typically requires `sudo` or root privileges to access the block device.
- **Dependencies**: Requires `gnupg` to be installed on the system for GPG-related recovery.