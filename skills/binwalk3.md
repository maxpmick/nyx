---
name: binwalk3
description: Analyze binary blobs and firmware images to identify and extract embedded files, data, and filesystems. Use when performing firmware analysis, reverse engineering, digital forensics, or identifying unknown compression and encryption through entropy analysis.
---

# binwalk3

## Overview
Binwalk3 is a high-performance tool rewritten in Rust for identifying and optionally extracting files and data embedded inside other files. While primarily focused on firmware analysis, it supports a wide variety of file types and includes entropy analysis to detect hidden or encrypted data. Category: Digital Forensics / Hardware / Incident Response.

## Installation (if not already installed)
Assume binwalk3 is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install binwalk3
```

## Common Workflows

### Standard Signature Scan
Scan a firmware image to identify embedded files and their offsets:
```bash
binwalk3 firmware.bin
```

### Automatic Extraction
Scan and automatically extract all recognized file types into the default `extractions` directory:
```bash
binwalk3 -e firmware.bin
```

### Recursive Extraction (Matryoshka)
Extract files and then recursively scan and extract files found within the extracted data:
```bash
binwalk3 -eM firmware.bin
```

### Entropy Analysis
Analyze the file's entropy to identify compressed or encrypted sections (outputs a plot):
```bash
binwalk3 -E firmware.bin
```

### Filtered Scan
Only search for specific signatures (e.g., squashfs and lzma):
```bash
binwalk3 -y squashfs -y lzma firmware.bin
```

## Complete Command Reference

```
Usage: binwalk3 [OPTIONS] [FILE_NAME]
```

### Arguments
| Argument | Description |
|----------|-------------|
| `FILE_NAME` | Path to the file to analyze |

### Options
| Flag | Description |
|------|-------------|
| `-L, --list` | List supported signatures and extractors |
| `-q, --quiet` | Suppress output to stdout |
| `-v, --verbose` | During recursive extraction display *all* results |
| `-e, --extract` | Automatically extract known file types |
| `-M, --matryoshka` | Recursively scan extracted files |
| `-a, --search-all` | Search for all signatures at all offsets |
| `-E, --entropy` | Plot the entropy of the specified file |
| `-l, --log <LOG>` | Log JSON results to a file |
| `-t, --threads <THREADS>` | Manually specify the number of threads to use |
| `-x, --exclude <EXCLUDE>...` | Do not scan for these signatures |
| `-y, --include <INCLUDE>...` | Only scan for these signatures |
| `-C, --directory <DIR>` | Extract files/folders to a custom directory [default: extractions] |
| `-h, --help` | Print help |
| `-V, --version` | Print version |

## Notes
- **Performance**: binwalk3 is a Rust rewrite of the original Python binwalk, offering significantly faster scanning and extraction.
- **Dependencies**: For certain extraction types, external tools like `sasquatch` (for non-standard SquashFS) are required.
- **Recursive Scans**: Using `-M` (Matryoshka) can lead to deep directory structures and high disk usage if the firmware contains many nested layers.
- **Custom Signatures**: Use `-L` to see what signatures are currently supported by the Rust implementation.