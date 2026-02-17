---
name: unblob
description: Extract files from any kind of binary blob, including over 30 archive, compression, and file-system formats. It recursively extracts content and carves out unknown chunks. Use when performing firmware analysis, reverse engineering binary payloads, forensic data recovery, or identifying embedded files within unknown binary structures.
---

# unblob

## Overview
unblob is an accurate, fast, and easy-to-use extraction suite. It parses unknown binary blobs for more than 30 different formats (archive, compression, file-system), extracts their content recursively, and carves out unknown chunks that have not been accounted for. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume unblob is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install unblob
```

To check if all required external extractors (like `sasquatch`, `jefferson`, `7z`) are available:
```bash
unblob --show-external-dependencies
```

## Common Workflows

### Basic recursive extraction
Extract a firmware blob or unknown binary into the default directory (`filename_extract`):
```bash
unblob firmware.bin
```

### Extract to a specific directory with force overwrite
```bash
unblob -e ./output_dir -f firmware.bin
```

### Carve chunks without full extraction
Useful for identifying structures without running potentially slow external extractors:
```bash
unblob --skip-extraction firmware.bin
```

### High-verbosity analysis with JSON reporting
```bash
unblob -vvv --report analysis.json firmware.bin
```

## Complete Command Reference

```
unblob [OPTIONS] FILE
```

### Options

| Flag | Description |
|------|-------------|
| `-e, --extract-dir DIRECTORY` | Extract the files to this directory. Will be created if it doesn't exist. |
| `-f, --force` | Force extraction even if outputs already exist (existing outputs are removed). |
| `-d, --depth INTEGER` | Recursion depth. How deep to extract nested containers. [default: 10; min: 1] |
| `-n, --randomness-depth INTEGER` | Entropy calculation depth. How deep to calculate randomness for unknown files? 1 means input files only, 0 turns it off. [default: 1; min: 0] |
| `-P, --plugins-path PATH` | Load plugins from the provided path. |
| `-S, --skip-magic TEXT` | Skip processing files with given magic prefix. Appended to default list unless `--clear-skip-magics` is used. |
| `--skip-extension TEXT` | Skip processing files with given extension. [default: .rlib] |
| `--clear-skip-magics` | Clear unblob's own internal skip magic list. |
| `-p, --process-num INTEGER` | Number of worker processes to process files in parallel. [default: 6; min: 1] |
| `--report PATH` | File to store metadata generated during extraction (JSON format). |
| `--log PATH` | File to save logs (text format). Defaults to `unblob.log`. |
| `-s, --skip-extraction` | Only carve chunks and skip further extraction. |
| `-k, --keep-extracted-chunks` | Keep extracted chunks on disk. |
| `--carve-suffix TEXT` | Carve directory name is source file + this suffix. Carving is skipped if the whole file is a known type. [default: _extract] |
| `--extract-suffix TEXT` | Extraction directory name is source file + this suffix. [default: _extract] |
| `-v, --verbose` | Verbosity level (use -v, -vv, or -vvv for maximum). |
| `--show-external-dependencies` | Shows commands that need to be available for unblob to work properly. |
| `--version` | Shows unblob version. |
| `-h, --help` | Show help message and exit. |

## Notes
- **External Dependencies**: unblob relies on several external tools for specific formats (e.g., `7z`, `debugfs`, `jefferson`, `sasquatch`, `ubireader`). If an extraction fails, run `--show-external-dependencies` to ensure your environment is complete.
- **Default Skip List**: By default, unblob skips many common non-container formats like JPEG, PDF, SQLite, and PNG to increase speed. Use `--clear-skip-magics` if you suspect data is hidden inside these file types.
- **Performance**: Use the `-p` flag to adjust parallel processing based on your CPU core count for faster extraction of large blobs.