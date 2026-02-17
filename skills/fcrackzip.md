---
name: fcrackzip
description: Crack password-protected ZIP archives using brute-force or dictionary-based attacks. Use when performing password recovery, forensic analysis of encrypted archives, or security testing of compressed files. It supports multiple cracking methods and can validate results using the unzip utility.
---

# fcrackzip

## Overview
fcrackzip is a fast password cracker for ZIP archives, partly written in assembler for high performance. It supports brute-force attacks with customizable charsets and lengths, as well as dictionary-based attacks. Category: Password Attacks / Digital Forensics.

## Installation (if not already installed)
Assume fcrackzip is already installed. If the command is missing:

```bash
sudo apt install fcrackzip
```

## Common Workflows

### Brute-force attack with specific length
```bash
fcrackzip -b -l 4-6 -c aA1 -u protected.zip
```
Attempts brute-force (`-b`) for passwords length 4 to 6 (`-l`), using lowercase, uppercase, and numbers (`-c`), and validates hits using unzip (`-u`).

### Dictionary attack
```bash
fcrackzip -D -p /usr/share/wordlists/rockyou.txt -u protected.zip
```
Uses a dictionary file (`-D`) with the specified path (`-p`) and verifies the password against the archive.

### Benchmark performance
```bash
fcrackzip -B
```
Executes a small benchmark to test the cracking speed on the current system.

### Get ZIP file information
```bash
fcrackzipinfo protected.zip
```
Displays metadata and technical information about the ZIP archive to help determine the best cracking approach.

## Complete Command Reference

### fcrackzip
The main password cracking utility.

```
fcrackzip [Options] file...
```

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-b` | `--brute-force` | Use brute-force algorithm |
| `-D` | `--dictionary` | Use a dictionary attack |
| `-B` | `--benchmark` | Execute a small benchmark |
| `-c` | `--charset <set>` | Use characters from charset (e.g., `a` for lowercase, `A` for uppercase, `1` for digits, `!` for symbols) |
| `-h` | `--help` | Show help message |
| `--version` | | Show program version |
| `-V` | `--validate` | Sanity-check the algorithm |
| `-v` | `--verbose` | Be more verbose; output progress |
| `-p` | `--init-password <str>` | Use string as initial password (brute-force) or specify dictionary file path (dictionary) |
| `-l` | `--length <min-max>` | Check password with length from min to max (e.g., `4-8`) |
| `-u` | `--use-unzip` | Use the `unzip` command to weed out false positives (highly recommended) |
| `-m` | `--method <num>` | Use method number "num" (see Methods below) |
| `-2` | `--modulo <r/m>` | Only calculate 1/m of the password space (useful for distributed cracking) |

#### Compiled Methods
*   **0**: cpmask
*   **1**: zip1
*   **2**: zip2, USE_MULT_TAB (Default)

### fcrackzipinfo
A utility to display technical information about a ZIP file.

```
fcrackzipinfo file...
```

## Notes
- **False Positives**: ZIP encryption is weak and can lead to false positives where a password appears to work but is incorrect. Always use the `-u` (`--use-unzip`) flag to verify the password actually extracts the file correctly.
- **Performance**: Method 2 (`zip2`) is the default and generally the fastest for standard ZIP encryption.
- **Charset Shortcuts**: Common charset strings include `a` (abcdefghijklmnopqrstuvwxyz), `A` (ABCDEFGHIJKLMNOPQRSTUVWXYZ), `1` (0123456789), and `!` (special characters). These can be combined, e.g., `-c a1`.