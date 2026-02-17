---
name: wordlistraider
description: Prepare and optimize existing wordlists by filtering words based on specific criteria like length, numbers, and special characters. Use when performing password attacks, brute-force preparation, or wordlist management to reduce file size and save time during exploitation.
---

# wordlistraider

## Overview
WordlistRaider is a Python-based tool designed to refine large wordlists into smaller, more targeted lists. It filters entries based on minimum/maximum length and the presence of numbers or special characters, which is essential for optimizing password cracking attempts and reducing unnecessary requests. Category: Password Attacks.

## Installation (if not already installed)

Assume wordlistraider is already installed. If you get a "command not found" error:

```bash
sudo apt install wordlistraider
```

Dependencies: figlet, python3, python3-colorama, python3-more-termcolor, python3-pyfiglet.

## Common Workflows

### Filter for standard policy (8+ chars)
```bash
wordlistraider -w /usr/share/wordlists/rockyou.txt -t filtered_rockyou.txt --min 8
```

### Filter for complex passwords (8-12 chars, numbers, and special chars)
```bash
wordlistraider -w source.txt -t complex.txt --min 8 --max 12 -n true -s true
```

### Extract short numeric-only style passwords
```bash
wordlistraider -w biglist.txt -t short_numeric.txt --min 4 --max 6 -n true
```

## Complete Command Reference

```bash
wordlistraider [-h] -w <source_path> -t <target_path> [options]
```

### Required Arguments

| Flag | Description |
|------|-------------|
| `-w`, `--wordlist` | Path to the source wordlist file to be processed |
| `-t`, `--target` | Path where the filtered target wordlist will be saved |

### Filtering Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--min`, `--minlength` | Minimum length of password (default: 8) |
| `--max`, `--maxlength` | Maximum length of password |
| `-n`, `--numbers` | Filter for passwords that must include numbers (default: false) |
| `-s`, `--specialcharacters` | Filter for passwords that include special characters (default: false) |

## Notes
- Using this tool on multi-gigabyte wordlists can significantly improve the efficiency of tools like Hashcat or John the Ripper by removing candidates that do not meet the target's known password policy.
- The `-n` and `-s` flags typically expect a boolean-style input (e.g., `true`) to activate the filter.