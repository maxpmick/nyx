---
name: unar
description: List and extract contents from a wide variety of archive formats including Zip, RAR, 7z, Tar, ISO, and many legacy formats. Use when performing digital forensics to inspect compressed artifacts, extracting malware samples, or handling archives with unknown encodings or complex structures during incident response.
---

# unar

## Overview
`unar` and its companion `lsar` are versatile command-line utilities for handling nearly any archive format, including modern (7z, RARv5), legacy (Stuffit, ARJ), and system-specific (MSI, EXE, ISO) files. It is particularly useful in forensics for its ability to handle various filename encodings and recursive extraction. Category: Digital Forensics / Sniffing & Spoofing (Respond).

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install unar
```

## Common Workflows

### List archive contents with metadata
```bash
lsar -l evidence.zip
```

### Extract an archive to a specific directory
```bash
unar -o ./extracted_data/ suspicious.rar
```

### Extract a password-protected archive
```bash
unar -p "infected2024" malware.7z
```

### Extract specific files by index (found via lsar)
```bash
lsar -i archive.tar.gz
unar -i archive.tar.gz 3 5 8
```

### Handle archives with specific character encodings
```bash
unar -e "GBK" chinese_archive.zip
```

## Complete Command Reference

### lsar (List Archive Contents)
`lsar [options] archive [files ...]`

| Flag | Alias | Description |
|------|-------|-------------|
| `-long` | `-l` | Print more information about each file. |
| `-verylong` | `-L` | Print all available information about each file. |
| `-test` | `-t` | Test the integrity of the files in the archive. |
| `-password` | `-p <str>` | The password for decrypting protected archives. |
| `-encoding` | `-e <name>` | Encoding for filenames (use "help" or "list" to see all). |
| `-password-encoding` | `-E <name>` | Encoding to use for the password. |
| `-print-encoding` | `-pe` | Print auto-detected encoding and confidence factor. |
| `-indexes` | `-i` | Specify files to list as indexes instead of names. |
| `-json` | `-j` | Print the listing in JSON format. |
| `-json-skip-solid-information` | `-jss` | Do not print solid object info in JSON output. |
| `-json-ascii` | `-ja` | Print JSON output encoded as pure ASCII. |
| `-no-recursion` | `-nr` | Do not list archives contained within other archives. |
| `-help` | `-h` | Display help information. |
| `-version` | `-v` | Print version and exit. |

### unar (Extract Archive Contents)
`unar [options] archive [files ...]`

| Flag | Alias | Description |
|------|-------|-------------|
| `-output-directory` | `-o <dir>` | Directory to write contents. Use `-` for stdout. |
| `-force-overwrite` | `-f` | Always overwrite existing files. |
| `-force-rename` | `-r` | Always rename files if they already exist. |
| `-force-skip` | `-s` | Always skip files if they already exist. |
| `-force-directory` | `-d` | Always create a containing directory. |
| `-no-directory` | `-D` | Never create a containing directory. |
| `-password` | `-p <str>` | The password for decrypting protected archives. |
| `-encoding` | `-e <name>` | Encoding for filenames (use "help" or "list" to see all). |
| `-password-encoding` | `-E <name>` | Encoding to use for the password. |
| `-indexes` | `-i` | Specify files to unpack as indexes (from `lsar`). |
| `-no-recursion` | `-nr` | Do not extract archives contained within other archives. |
| `-copy-time` | `-t` | Copy modification time from archive to the directory. |
| `-forks` | `-k <val>` | Handle Mac resource forks: `visible` (default), `hidden`, `skip`. |
| `-quiet` | `-q` | Run in quiet mode. |
| `-version` | `-v` | Print version and exit. |
| `-help` | `-h` | Display help information. |

## Notes
- **Forensics Tip**: Use `lsar -L` to see detailed metadata like timestamps and compression methods before extracting.
- **Encoding**: If filenames appear as gibberish, use `lsar -pe` to detect the likely encoding, then re-run with `-e`.
- **Recursive Extraction**: By default, `unar` will attempt to extract nested archives (e.g., a `.tar` inside a `.gz`). Use `-nr` to prevent this.