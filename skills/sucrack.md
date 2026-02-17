---
name: sucrack
description: Multithreaded local password cracking tool for su. Use when you have gained low-privilege access to a Linux/UNIX system and need to escalate privileges by brute-forcing the password of another user (typically root) via the su command. It handles the pseudo-terminal requirements that make simple shell scripts ineffective for su brute-forcing.
---

# sucrack

## Overview
sucrack is a multithreaded C-based tool designed to brute-force local user accounts via the `su` binary. It is specifically useful because `su` usually requires a TTY/pseudo-terminal for password entry, which sucrack provides. It allows for high-efficiency concurrent login attempts. Category: Password Attacks.

## Installation (if not already installed)
Assume sucrack is already installed. If the command is missing:

```bash
sudo apt install sucrack
```

## Common Workflows

### Basic brute-force against root
```bash
sucrack -u root /usr/share/wordlists/rockyou.txt
```

### Brute-force with specific number of threads and timeout
```bash
sucrack -n 10 -t 5 -u admin /usr/share/metasploit-framework/data/wordlists/unix_passwords.txt
```

### Use a custom su path and display statistics
```bash
sucrack -s /bin/su -u root -w 20 wordlist.txt
```

## Complete Command Reference

```
sucrack [options] wordlist
```

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display help message |
| `-u <user>` | The user account to crack (default: root) |
| `-l <rules>` | Specify the password rules (e.g., 'as' for alphanumeric/symbols) |
| `-n <threads>` | Number of concurrent threads to use for brute-forcing |
| `-w <count>` | Number of attempts to perform before a small wait/delay |
| `-t <seconds>` | Timeout in seconds for each su process |
| `-s <path>` | Path to the su binary (default: /bin/su) |
| `-r` | Enable rewriting of the wordlist (e.g., for specific mutations) |
| `-v` | Enable verbose output (show attempts) |

## Notes
- **Performance**: Increasing the number of threads (`-n`) can speed up the process but may cause system instability or trigger security alerts/logging.
- **Account Locking**: Be aware of local security policies (like `pam_tally2` or `faillock`) that may lock the target account after a certain number of failed attempts.
- **Environment**: This tool is intended for local privilege escalation scenarios where you already have shell access as a low-privileged user.