---
name: nasty
description: Recover lost or forgotten GPG/PGP passphrases using incremental, random, or dictionary-based guessing. Use during digital forensics investigations or password recovery scenarios when a private key is accessible but the passphrase is unknown.
---

# nasty

## Overview
Nasty is a specialized tool designed to recover GPG/PGP passphrases. It supports multiple recovery modes including brute-force (incremental), random guessing, and dictionary attacks. It is primarily used in digital forensics and security auditing. Category: Digital Forensics / Password Attacks.

## Installation (if not already installed)
Assume nasty is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install nasty
```

## Common Workflows

### Dictionary Attack
Use a specific wordlist to attempt to unlock a GPG key:
```bash
nasty -m file -i /usr/share/wordlists/rockyou.txt -k "user@example.com"
```

### Incremental Brute-Force
Attempt all possible combinations of lowercase letters and numbers with a length of 4 to 6 characters:
```bash
nasty -m incremental -a 4 -b 6 -c a0 -k "KeyID"
```

### Random Guessing with Output
Try random combinations of all ASCII characters and save the successful passphrase to a file:
```bash
nasty -m random -c . -f found_pass.txt -k "target-email@domain.com"
```

## Complete Command Reference

```
nasty [Options] -k <key_filter>
```

### Options

| Flag | Description |
|------|-------------|
| `-a <x>` | Set minimum length of the passphrase |
| `-b <x>` | Set maximum length of the passphrase |
| `-m <mode>` | Set guessing mode: `incremental` (try all), `random` (try at random), or `file` (read from file) |
| `-i <file>` | Input file to read passphrases from (required for `-m file`) |
| `-f <file>` | File to write the found passphrase to |
| `-c <charset>` | Define charset (one or more): `a` (a-z), `A` (A-Z), `0` (0-9), `.` (ASCII 32-126), `+` (ASCII 32-255, default) |
| `-k <string>` | Filter string to select the specific GPG key to attack (e.g., Email, Name, or Key ID) |
| `-v` | Enable verbose mode |

## Notes
- The `-k` flag is essential to identify which key in your GPG keyring the tool should attempt to decrypt.
- Brute-forcing GPG passphrases can be extremely slow due to the key derivation functions used by GPG; dictionary attacks (`-m file`) are generally preferred if a likely pattern is known.
- Ensure the target GPG key is already imported into the local GPG keyring before running the tool.