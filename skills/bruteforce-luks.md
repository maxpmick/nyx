---
name: bruteforce-luks
description: Attempt to recover the password of a LUKS encrypted volume by testing passwords against key slots. Use during digital forensics or incident response when a LUKS container's password is unknown or partially remembered.
---

# bruteforce-luks

## Overview
bruteforce-luks is a specialized tool designed to find the password of a LUKS (Linux Unified Key Setup) encrypted volume. It attempts to decrypt at least one of the key slots by iterating through possible passwords. It is primarily used in forensics when some information about the password is known, as blind brute-forcing of strong LUKS passwords is computationally expensive. Category: Digital Forensics / Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install bruteforce-luks
```

## Common Workflows

### Brute-force with a known prefix and suffix
If you remember the password starts with "Pass" and ends with "2023", but forgot the 3 characters in the middle:
```bash
bruteforce-luks -b "Pass" -e "2023" -l 11 -m 11 /dev/sdb1
```

### Dictionary attack using a wordlist
To test passwords from a specific file against a LUKS partition:
```bash
bruteforce-luks -f /usr/share/wordlists/rockyou.txt /dev/sda2
```

### Multi-threaded brute-force with progress updates
Use 8 threads and print progress every 30 seconds for a volume image file:
```bash
bruteforce-luks -t 8 -v 30 -s "abcdefghijklmnopqrstuvwxyz0123456789" /path/to/volume.img
```

### Resuming a session
Save the state to a file to allow resuming if the process is interrupted:
```bash
bruteforce-luks -w session.state -t 4 /dev/nvme0n1p3
```

## Complete Command Reference

```
bruteforce-luks [options] <path to LUKS volume>
```

### Options

| Flag | Description |
|------|-------------|
| `-b <string>` | Beginning of the password (prefix). Default: "" |
| `-e <string>` | End of the password (suffix). Default: "" |
| `-f <file>` | Read passwords from a file (wordlist mode) instead of generating them. |
| `-h` | Show help and quit. |
| `-l <length>` | Minimum password length, including prefix and suffix. Default: 1 |
| `-m <length>` | Maximum password length, including prefix and suffix. Default: 8 |
| `-s <string>` | Password character set for generation. Default: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" |
| `-t <n>` | Number of threads to use. Default: 1 |
| `-v <n>` | Print progress info to standard error every `n` seconds. |
| `-w <file>` | Restore state from file if it exists; otherwise, save state to this file regularly (~every minute). |

## Notes
- **Performance**: LUKS uses heavy key derivation functions (like Argon2 or PBKDF2), making brute-force attempts significantly slower than simple hash cracking.
- **Signals**: Sending a `USR1` signal to a running `bruteforce-luks` process (e.g., `kill -USR1 <pid>`) forces it to print current progress info to stderr immediately.
- **Scope**: This tool is most effective when the search space is narrowed down by length (`-l`, `-m`), character set (`-s`), or known fragments (`-b`, `-e`).