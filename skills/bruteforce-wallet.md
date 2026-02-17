---
name: bruteforce-wallet
description: Attempt to recover the password of encrypted cryptocurrency wallet files (Bitcoin, Litecoin, Peercoin, etc.). Use when a wallet.dat file is recovered and the password is unknown or partially forgotten, supporting both exhaustive brute-force with custom charsets and dictionary-based attacks.
---

# bruteforce-wallet

## Overview
bruteforce-wallet is a specialized tool designed to recover passwords for encrypted cryptocurrency wallet files (specifically `wallet.dat` files used by Bitcoin-core based clients). It supports multi-threading, session saving/resuming, and can target specific password structures if parts of the password are already known. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install bruteforce-wallet
```

## Common Workflows

### Dictionary Attack
Try passwords from a wordlist against a wallet file:
```bash
bruteforce-wallet -f /usr/share/wordlists/rockyou.txt wallet.dat
```

### Exhaustive Brute-Force with Known Pattern
If you remember the password starts with "Pass" and ends with "2023", and is between 12 and 15 characters long:
```bash
bruteforce-wallet -b "Pass" -e "2023" -l 12 -m 15 -t 4 wallet.dat
```

### Brute-Force with Custom Charset and Progress Tracking
Try all 6-character numeric passwords, printing progress every 30 seconds using 8 threads:
```bash
bruteforce-wallet -s "0123456789" -l 6 -m 6 -t 8 -v 30 wallet.dat
```

### Resumable Session
Save progress to a state file to allow resuming if the process is interrupted:
```bash
bruteforce-wallet -w session.state -f big_list.txt wallet.dat
```

## Complete Command Reference

```
bruteforce-wallet [options] <wallet file>
```

| Flag | Description |
|------|-------------|
| `-b <string>` | Beginning of the password. Default: "" |
| `-e <string>` | End of the password. Default: "" |
| `-f <file>` | Read the passwords from a file (dictionary mode) instead of generating them. |
| `-h` | Show help and quit. |
| `-l <length>` | Minimum password length, including the beginning and end strings. Default: 1 |
| `-m <length>` | Maximum password length, including the beginning and end strings. Default: 8 |
| `-s <string>` | Password character set for exhaustive mode. Default: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" |
| `-t <n>` | Number of threads to use for cracking. Default: 1 |
| `-v <n>` | Print progress info to standard error every `n` seconds. |
| `-w <file>` | Restore the state of a previous session if the file exists, then write the state to the file regularly (~ every minute). |

## Notes
- **Signal Handling**: Sending a `USR1` signal to a running process (`kill -USR1 <pid>`) forces the tool to print current progress info to stderr immediately.
- **Performance**: Increasing threads (`-t`) is highly recommended for modern multi-core CPUs.
- **Scope**: This tool is specifically for Berkeley DB based `wallet.dat` files. It may not work on modern "descriptor" wallets or non-Bitcoin-core derivatives that use different encryption schemes.