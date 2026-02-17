---
name: stegsnow
description: Conceal messages in ASCII text by appending whitespace (spaces and tabs) to the end of lines. Use when performing steganography, hiding data within text files, or extracting hidden messages from suspicious documents during digital forensics or CTF challenges.
---

# stegsnow

## Overview
stegsnow (also known as SNOW) is a steganography tool that hides messages in ASCII text by appending trailing whitespace. Because spaces and tabs are invisible in most text viewers, the message remains hidden from casual observation. It includes built-in encryption using the ICE algorithm to protect the hidden content even if its presence is detected. Category: Digital Forensics / Steganography.

## Installation (if not already installed)
Assume stegsnow is already installed. If you get a "command not found" error:

```bash
sudo apt install stegsnow
```

## Common Workflows

### Hide a message in a text file with encryption
```bash
stegsnow -C -p "mysecretpassword" -m "This is a hidden message" input.txt output.txt
```

### Extract a hidden message from a file
```bash
stegsnow -C -p "mysecretpassword" output.txt
```

### Hide the contents of a file within another file
```bash
stegsnow -f secret_data.txt cover_letter.txt final_document.txt
```

### Check the storage capacity of a text file
```bash
stegsnow -S cover_letter.txt
```

## Complete Command Reference

```
stegsnow [-C] [-Q] [-S] [-V | --version] [-h | --help] [-p passwd] [-l line-len] [-f file | -m message] [infile [outfile]]
```

### Options

| Flag | Description |
|------|-------------|
| `-C` | Compress the data if concealing, or uncompress it if extracting. |
| `-Q` | Quiet mode. Suppresses non-essential output. |
| `-S` | Report on the approximate storage capacity of the input file (how many bits can be hidden). |
| `-V`, `--version` | Display version information and exit. |
| `-h`, `--help` | Display the help message and usage summary. |
| `-p passwd` | Encrypt the data with the specified password using the ICE algorithm. If a password is provided during extraction, the data is decrypted. |
| `-l line-len` | Set the maximum line length for the output text. stegsnow will attempt to keep lines under this length (default is 80). |
| `-f file` | Hide the contents of the specified file within the text. |
| `-m message` | Hide the specified string message within the text. |
| `infile` | The input ASCII file to be used as the cover text or the file to extract from. |
| `outfile` | The output file where the text with the hidden message will be saved. |

## Notes
- If no `infile` is specified, stegsnow reads from standard input.
- If no `outfile` is specified, stegsnow writes to standard output.
- The tool uses the ICE encryption algorithm when the `-p` flag is used.
- Trailing whitespace is often stripped by email servers or certain text editors; ensure the transport medium preserves trailing spaces and tabs.