---
name: ophcrack
description: Crack Windows passwords using rainbow tables based on a time-memory trade-off. Recovers 99.9% of alphanumeric passwords for Windows NT/2000/XP/Vista/7. Use when performing password cracking, auditing Windows credentials from pwdump files or SAM hives, or during post-exploitation to escalate privileges.
---

# ophcrack

## Overview
Ophcrack is a Windows password cracker based on rainbow tables. It implements a variant of Hellman's original trade-off to achieve high performance, often recovering passwords in seconds. It supports both a Qt-based graphical interface and a command-line interface. Category: Password Attacks.

## Installation (if not already installed)
Assume ophcrack is already installed. If the command is missing:

```bash
sudo apt install ophcrack      # For GUI and CLI
sudo apt install ophcrack-cli  # For CLI only
```

## Common Workflows

### Crack hashes from a pwdump file (CLI mode)
```bash
ophcrack -g -d /usr/share/rainbowtables -f hashes.txt
```
The `-g` flag disables the GUI, and `-d` specifies the directory containing your rainbow tables.

### Crack hashes from an encrypted SAM directory
```bash
ophcrack -g -d /path/to/tables -w /mnt/windows/system32/config
```

### Specific table selection and output to CSV
```bash
ophcrack -g -d /tables -t xp_free_fast,0,3:vista_free -f in.txt -x results.csv
```
Uses tables 0 and 3 from the `xp_free_fast` directory and all tables from the `vista_free` directory.

### Audit mode with threading
```bash
ophcrack -g -A -n 4 -d /tables -f hashes.txt
```
Enables audit mode and uses 4 threads for processing.

## Complete Command Reference

```
ophcrack [OPTIONS]
```

### General Options

| Flag | Description |
|------|-------------|
| `-a` | Disable audit mode (default) |
| `-A` | Enable audit mode |
| `-b` | Disable bruteforce |
| `-B` | Enable bruteforce (default) |
| `-c <file>` | Specify the config file to use |
| `-D` | Display (lots of!) debugging information |
| `-d <dir>` | Specify tables base directory |
| `-e` | Do not display empty passwords |
| `-f <file>` | Load hashes from the specified file (pwdump or session) |
| `-g` | Disable GUI |
| `-h` | Display help information |
| `-i` | Hide usernames |
| `-I` | Show usernames (default) |
| `-l <file>` | Log all output to the specified file |
| `-n <num>` | Specify the number of threads to use |
| `-o <file>` | Write cracking output to file in pwdump format |
| `-p <num>` | Preload (0: none, 1: index, 2: index+end, 3: all [default]) |
| `-q` | Quiet mode |
| `-r` | Launch the cracking when ophcrack starts (GUI only) |
| `-s` | Disable session auto-saving |
| `-S <file>` | Specify the file to use to automatically save search progress |
| `-u` | Display statistics when cracking ends |
| `-t <table>` | Specify which table to use in the directory given by `-d` (Format: `table1[,a[,b,...]][:table2[,a[,b,...]]]`) |
| `-v` | Verbose mode |
| `-w <dir>` | Load hashes from encrypted SAM file in directory `dir` |
| `-x <file>` | Export data in CSV format to file |

## Notes
- **Rainbow Tables**: Ophcrack requires rainbow tables to function effectively. These are often large and may need to be downloaded or mounted separately (e.g., from `/usr/share/rainbowtables` or external storage).
- **Windows Versions**: While highly effective for LM and NTLM hashes (XP/Vista/7), modern Windows versions (10/11) use stronger protections, though NTLM hashes may still be vulnerable if extracted.
- **Audit Mode**: Use `-A` to check for password strength without necessarily attempting to crack every single hash to completion.