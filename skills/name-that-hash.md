---
name: name-that-hash
description: Identify over 300 hash types including MD5, SHA256, and more. Use when you encounter an unknown hash string during a penetration test, CTF, or forensic investigation and need to determine which hashing algorithm was used to select the correct cracking parameters for tools like Hashcat or John the Ripper.
---

# name-that-hash

## Overview
Name That Hash (nth) is a hash identification tool that maps unknown hash strings to their likely algorithms. It provides specific information for popular cracking tools like Hashcat and John the Ripper. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the `nth` or `name-that-hash` command is not found:

```bash
sudo apt update && sudo apt install name-that-hash
```

## Common Workflows

### Identify a single hash
```bash
nth --text '5f4dcc3b5aa765d61d8327deb882cf99'
```

### Identify hashes from a file
```bash
nth --file hashes.txt
```

### Identify Base64 encoded hashes
```bash
nth --base64 --text 'NWY0ZGNjM2I1YWE3NjVkNjFkODMyN2RlYjg4MmNmOTk='
```

### Extract and identify hashes from a dirty string
```bash
nth --extreme --text 'The hash is: ####5d41402abc4b2a76b9719d911017c592###'
```

### JSON output for automation
```bash
nth --text '5f4dcc3b5aa765d61d8327deb882cf99' --greppable
```

## Complete Command Reference

The tool can be invoked using either `nth` or `name-that-hash`.

### Options

| Flag | Description |
|------|-------------|
| `-t, --text TEXT` | Check one hash. Use single quotes `'` to avoid shell expansion issues. |
| `-f, --file FILENAME` | Checks every hash in a newline separated file. |
| `-g, --greppable` | Prints output in JSON format for easier parsing/grepping. |
| `-b64, --base64` | Decodes hashes in Base64 before identification. Attempts Base64 first, then falls back to normal identification. |
| `-a, --accessible` | Accessible mode: removes ASCII art and large text blocks for screenreaders. |
| `-e, --extreme` | Searches for hashes within a string (extraction mode). |
| `--no-banner` | Removes the ASCII banner from startup. |
| `--no-john` | Do not print John The Ripper specific information. |
| `--no-hashcat` | Do not print Hashcat specific information. |
| `-v, --verbose` | Turn on debugging logs. Use `-vvv` for maximum log detail. |
| `--help` | Show the help message and exit. |

## Notes
- **Shell Syntax**: Always use single quotes (`'`) for the `--text` argument on Linux to prevent the shell from misinterpreting special characters.
- **Cracking Integration**: By default, the tool provides the mode numbers for Hashcat and the format labels for John the Ripper, making it easy to pipe results into a cracking workflow.
- **Base64 Support**: The `--base64` flag is useful for web-related hashes that are often encoded before being stored or transmitted.