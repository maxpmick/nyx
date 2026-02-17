---
name: stegcracker
description: Brute-force steganography passwords to uncover hidden data inside image and audio files. Use when performing steganography analysis, CTF challenges, or digital forensics to extract hidden payloads from JPG, BMP, WAV, or AU files using wordlists.
---

# stegcracker

## Overview
StegCracker is a steganography brute-force utility designed to uncover hidden data inside files by testing passwords from a wordlist against supported file formats. It primarily acts as a wrapper for `steghide`. Category: Digital Forensics / Steganography.

## Installation (if not already installed)
Assume stegcracker is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install stegcracker
```

Dependencies: python3, steghide.

## Common Workflows

### Basic brute-force with default wordlist
On Kali Linux, this automatically uses the `rockyou.txt` wordlist.
```bash
stegcracker hidden_data.jpg
```

### Brute-force with a specific wordlist and custom output
```bash
stegcracker image.png /usr/share/wordlists/dirb/common.txt -o extracted_secret.txt
```

### High-performance cracking with increased threads
```bash
stegcracker secret.wav --threads 32 --chunk-size 128
```

### Quiet mode for scripting/piping
```bash
stegcracker evidence.bmp wordlist.txt --quiet > cracked_pass.txt
```

## Complete Command Reference

```
usage: stegcracker <file> [<wordlist>] [options]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `file` | Input file containing hidden information. Supported types: **jpg, jpeg, bmp, wav, au**. |
| `wordlist` | File containing passwords (one per line). Defaults to `/usr/share/wordlists/rockyou.txt` on Kali. |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit. |
| `-o`, `--output <OUTPUT>` | Output file location for the decrypted data. Defaults to `<filename>.out`. |
| `-t`, `--threads <THREADS>` | Number of concurrent threads. Default: 16. |
| `-c`, `--chunk-size <SIZE>` | Number of passwords loaded into memory per thread cycle before printing a status update. Default: 64. |
| `-q`, `--quiet`, `--stfu` | Quiet mode: suppresses status updates and only outputs the cracked password. |
| `-v`, `--version` | Print the current version number and exit. |
| `-V`, `--verbose` | Verbose mode: prints additional debugging information. Cannot be used with `--quiet`. |

## Notes
- **File Support**: StegCracker only accepts `.jpg`, `.jpeg`, `.bmp`, `.wav`, and `.au` files.
- **Performance**: Increasing `--threads` can improve speed but may consume significant CPU resources.
- **Logging**: By default, all logging and error messages are printed to `stderr` to facilitate piping `stdout` to other tools.
- **Wordlist**: If using the default `rockyou.txt` on Kali, ensure it is decompressed (`gunzip /usr/share/wordlists/rockyou.txt.gz`) before use if the tool does not handle the .gz extension automatically.