---
name: pdfcrack
description: Recover owner and user passwords from PDF documents using wordlists or brute-force attacks. Use when performing password recovery, forensic investigations, or security auditing of encrypted PDF files. Supports standard security handler revisions 2, 3, and 4.
---

# pdfcrack

## Overview
PDFCrack is a specialized tool for recovering passwords from PDF documents. it supports cracking both owner and user passwords, offers benchmarking capabilities, and can save/resume sessions. It belongs to the Password Attacks domain.

## Installation (if not already installed)
Assume pdfcrack is already installed. If you get a "command not found" error:

```bash
sudo apt install pdfcrack
```

## Common Workflows

### Brute-force user password with specific length and charset
```bash
pdfcrack -f document.pdf -n 4 -m 8 -c abcdefghijklmnopqrstuvwxyz0123456789
```

### Wordlist attack on owner password
```bash
pdfcrack -f document.pdf -w /usr/share/wordlists/rockyou.txt -o
```

### Recover owner password using a known user password
```bash
pdfcrack -f document.pdf -p "known_user_pass"
```

### Save and resume a cracking session
```bash
# Start and save state
pdfcrack -f document.pdf -w list.txt -l session.state
# Resume later
pdfcrack -f document.pdf -l session.state
```

## Complete Command Reference

```bash
pdfcrack -f filename [OPTIONS]
```

### Options

| Flag | Description |
|------|-------------|
| `-f, --file=FILE` | **Required.** Specify the PDF file to crack |
| `-b, --bench` | Perform benchmark and exit |
| `-c, --charset=STRING` | Use the characters in STRING as charset for brute-force |
| `-w, --wordlist=FILE` | Use FILE as source of passwords to try |
| `-n, --minpw=INTEGER` | Skip trying passwords shorter than this length |
| `-m, --maxpw=INTEGER` | Stop when reaching this password length |
| `-l, --loadState=FILE` | Continue from the state saved in FILE |
| `-o, --owner` | Work with the owner password |
| `-u, --user` | Work with the user password (default) |
| `-p, --password=STRING` | Provide the user password to speed up breaking the owner password (implies `-o`) |
| `-q, --quiet` | Run quietly |
| `-s, --permutate` | Try permutating passwords (currently only supports switching first character to uppercase) |
| `-v, --version` | Print version and exit |
| `-h` | Show help message |

## Notes
- **Performance**: Use the `-b` (benchmark) flag to estimate how long a brute-force attack might take on your current hardware.
- **State Files**: The state file saves progress, which is critical for long-running brute-force attacks.
- **Limitations**: The PDF parsing routines are described by the author as a "quick hack"; if a PDF fails to load, the parser may not support that specific PDF version's formatting.
- **Permutations**: The `-s` flag is currently limited to toggling the case of the first character. For more complex permutations, use a dedicated tool like `hashcat` or `john` if the hash can be extracted.