---
name: stegosuite
description: Hide and extract encrypted information within image files (BMP, GIF, JPG, PNG) using steganography. Use when performing steganographic analysis, hiding sensitive data in images, or extracting hidden payloads during digital forensics and CTF challenges.
---

# stegosuite

## Overview
Stegosuite is a Java-based steganography tool used to embed text messages and multiple files into images. It supports AES encryption for the embedded data and works with BMP, GIF, JPG, and PNG formats. Category: Digital Forensics / Steganography.

## Installation (if not already installed)
Assume stegosuite is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install stegosuite
```

## Common Workflows

### Launching the Graphical Interface
```bash
stegosuite gui
```

### Embedding a file into an image
```bash
stegosuite embed -f secret.txt -p "yourpassword" original_image.jpg
```
This creates a new image file containing the encrypted secret.

### Extracting data from a stego-image
```bash
stegosuite extract -p "yourpassword" stego_image.jpg
```

### Checking available space in an image
```bash
stegosuite capacity image.png
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show this help message and exit |
| `-V`, `--version` | Print version information and exit |

### Subcommands

#### `gui`
Starts the graphical user interface.

#### `embed`
Embeds data into an image.
**Usage:** `stegosuite embed [OPTIONS] <IMAGE>`

| Flag | Description |
|------|-------------|
| `-f`, `--file <FILE>` | File to embed into the image |
| `-m`, `--message <TEXT>` | Text message to embed |
| `-p`, `--password <PASS>` | Password for AES encryption |
| `-o`, `--output <FILE>` | Path for the resulting image |

#### `extract`
Extracts data from an image.
**Usage:** `stegosuite extract [OPTIONS] <IMAGE>`

| Flag | Description |
|------|-------------|
| `-p`, `--password <PASS>` | Password used during embedding |
| `-d`, `--destination <DIR>` | Directory to save extracted files |

#### `capacity`
Shows the maximum amount of data (in bytes) that can be embedded in the specified image.
**Usage:** `stegosuite capacity <IMAGE>`

#### `help`
Displays help information about the specified command.
**Usage:** `stegosuite help [COMMAND]`

## Notes
- Supported formats: BMP, GIF, JPG, PNG.
- Security: All embedded data is automatically encrypted using AES.
- Dependencies: Requires Java Runtime Environment (JRE) and SWT toolkit.
- When embedding, the tool typically creates a new file (e.g., `original_embed.jpg`) to avoid overwriting the source unless specified.