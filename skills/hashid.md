---
name: hashid
description: Identify the different types of hashes used to encrypt data and passwords. Supports over 175 unique hash types using regular expression matching. Use when encountering an unknown hash during penetration testing, password cracking, or digital forensics to determine the correct algorithm for tools like Hashcat or John the Ripper.
---

# hashid

## Overview
hashID is a Python 3 tool designed to identify the encryption algorithms used to create hashes. It can identify a single hash string or parse a file containing multiple hashes. It maps identified hashes to their corresponding formats in popular cracking tools. Category: Password Attacks.

## Installation (if not already installed)
Assume hashid is already installed. If you get a "command not found" error:

```bash
sudo apt install hashid
```

## Common Workflows

### Identify a single hash
```bash
hashid '$pbkdf2-sha256$20000$7S90/SbaW91S$66.V.S.6.S.6.S.6.S.6.S.6.S.6.S.6.S.6.S.6.S.6'
```

### Identify hash and show Hashcat modes
```bash
hashid -m 5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8
```

### Identify hashes from a file and show JohnTheRipper formats
```bash
hashid -j hashes.txt
```

### Extended identification including salted algorithms
```bash
hashid -e 48bb6e862e54f2a795ffc4e541caed4d
```

## Complete Command Reference

```
hashid [-h] [-e] [-m] [-j] [-o FILE] [--version] INPUT
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `INPUT` | The hash string or file containing hashes to analyze. Defaults to STDIN if not provided. |

### Options

| Flag | Description |
|------|-------------|
| `-e`, `--extended` | List all possible hash algorithms, including those that use salted passwords. |
| `-m`, `--mode` | Show the corresponding **Hashcat** mode number in the output. |
| `-j`, `--john` | Show the corresponding **JohnTheRipper** format name in the output. |
| `-o`, `--outfile FILE` | Write the identification results to the specified file instead of stdout. |
| `-h`, `--help` | Show the help message and exit. |
| `--version` | Show the program's version number and exit. |

## Notes
- hashID uses regular expressions for identification; some hashes may match multiple algorithms (e.g., MD5, MD4, and NTLM all share the same length and character set).
- When using `-m` or `-j`, the tool provides the specific strings/numbers needed to pass to those tools (e.g., `-m 0` for MD5 in Hashcat).
- If identifying a single hash that contains special characters (like `$`), wrap the hash in single quotes to prevent shell expansion.