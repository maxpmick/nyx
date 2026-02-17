---
name: rcracki-mt
description: Crack password hashes using rainbow tables with support for hybrid and indexed tables. Use when performing password recovery or offline credential cracking during penetration testing, specifically when rainbow tables are available to speed up the process compared to brute-force.
---

# rcracki-mt

## Overview
rcracki_mt is a multi-threaded version of the classic rcrack tool. It supports hybrid and indexed rainbow tables, allowing for significantly faster password cracking by utilizing multiple CPU cores and optimized table formats. Category: Password Attacks.

## Installation (if not already installed)

Assume rcracki_mt is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install rcracki-mt
```

## Common Workflows

### Crack a single MD5 hash
```bash
rcracki_mt -h 5d41402abc4b2a76b9719d911017c592 /path/to/tables/
```

### Crack multiple hashes using 4 threads
```bash
rcracki_mt -l hash_list.txt -t 4 /path/to/tables/
```

### Crack a single hash with specific thread count
```bash
rcracki_mt -h 5d41402abc4b2a76b9719d911017c592 -t 8 /path/to/tables/md5/
```

## Complete Command Reference

```
rcracki_mt [options] <rainbow_table_directory_or_file>
```

### Options

| Flag | Description |
|------|-------------|
| `-h <hash>` | Crack a single hash string |
| `-l <file>` | Crack a list of hashes from the specified file (one hash per line) |
| `-t <threads>` | Set the number of threads for pre-calculation and false alarm checking |
| `-o <file>` | Write the results (cracked passwords) to the specified output file |
| `-v` | Enable verbose output mode |
| `--help` | Display the help message and usage information |

### Table Support
rcracki_mt supports the following table formats:
- Standard Rainbow Tables (`.rt`)
- Indexed Rainbow Tables (`.rti`)
- Hybrid Rainbow Tables (`.rti2`)

## Notes
- Ensure the directory path provided contains the correct rainbow tables for the hash algorithm you are targeting (e.g., MD5, NTLM, SHA1).
- Using more threads (`-t`) generally speeds up the "false alarm checking" phase but is limited by your CPU core count and disk I/O speed.
- Rainbow tables must match the character set and length of the original password to be successful.