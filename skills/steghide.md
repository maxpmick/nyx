---
name: steghide
description: Hide data within BMP, JPEG, WAV, and AU files using steganography. It features encryption, compression, and checksums to ensure data integrity and secrecy. Use when performing steganographic analysis, hiding sensitive files within media, or extracting hidden payloads from carrier files during digital forensics and CTF challenges.
---

# steghide

## Overview
Steghide is a steganography program that hides data in various types of image and audio files (BMP, JPEG, WAV, AU). It uses the least significant bits of the carrier file to hide data in a way that is difficult to detect. It supports Blowfish encryption, MD5 hashing of passphrases, and data compression. Category: Digital Forensics / Steganography.

## Installation (if not already installed)
Assume steghide is already installed. If you get a "command not found" error:

```bash
sudo apt install steghide
```

## Common Workflows

### Embedding data into an image
```bash
steghide embed -cf cover.jpg -ef secret.txt -p "my-strong-password"
```
Hides `secret.txt` inside `cover.jpg`.

### Extracting data from a stego-file
```bash
steghide extract -sf cover.jpg -p "my-strong-password"
```
Extracts the hidden content from the file.

### Viewing information about a file
```bash
steghide info image.jpg
```
Displays whether a file contains hidden data (requires passphrase for detailed info).

### Embedding with specific encryption and no compression
```bash
steghide embed -cf audio.wav -ef data.zip -e blowfish cbc -Z
```

## Complete Command Reference

The first argument must be one of the following commands:

| Command | Description |
|---------|-------------|
| `embed`, `--embed` | Embed data into a cover file |
| `extract`, `--extract` | Extract data from a stego file |
| `info`, `--info` | Display information about a cover- or stego-file |
| `encinfo`, `--encinfo` | Display a list of supported encryption algorithms and modes |
| `version`, `--version` | Display version information |
| `license`, `--license` | Display steghide's license |
| `help`, `--help` | Display usage information |

### Embedding Options (`embed`)

| Flag | Description |
|------|-------------|
| `-ef`, `--embedfile <file>` | Select the file to be embedded |
| `-cf`, `--coverfile <file>` | Select the cover-file (carrier) |
| `-p`, `--passphrase <pass>` | Use `<passphrase>` to embed data |
| `-sf`, `--stegofile <file>` | Write result to `<filename>` instead of overwriting cover-file |
| `-e`, `--encryption <params>` | Specify encryption algorithm and/or mode (e.g., `blowfish cbc`). Use `-e none` for no encryption |
| `-z`, `--compress` | Compress data before embedding (default) |
| `-z <l>` | Specify compression level `l` (1 best speed...9 best compression) |
| `-Z`, `--dontcompress` | Do not compress data before embedding |
| `-K`, `--nochecksum` | Do not embed crc32 checksum of embedded data |
| `-N`, `--dontembedname` | Do not embed the name of the original file |
| `-f`, `--force` | Overwrite existing files |
| `-q`, `--quiet` | Suppress information messages |
| `-v`, `--verbose` | Display detailed information |

### Extracting Options (`extract`)

| Flag | Description |
|------|-------------|
| `-sf`, `--stegofile <file>` | Select the stego file to extract data from |
| `-p`, `--passphrase <pass>` | Use `<passphrase>` to extract data |
| `-xf`, `--extractfile <file>` | Write the extracted data to `<filename>` |
| `-f`, `--force` | Overwrite existing files |
| `-q`, `--quiet` | Suppress information messages |
| `-v`, `--verbose` | Display detailed information |

### Info Options (`info`)

| Flag | Description |
|------|-------------|
| `<filename>` | The file to query |
| `-p`, `--passphrase <pass>` | Use `<passphrase>` to get detailed info about embedded data |

## Notes
- Supported formats: **Images** (JPEG, BMP) and **Audio** (WAV, AU).
- If no `-sf` is specified during embedding, the original cover file will be overwritten with the stego-version.
- Steghide uses a pseudo-random distribution of bits, making the hidden data harder to detect via simple statistical analysis.