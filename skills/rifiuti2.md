---
name: rifiuti2
description: Analyze Windows Recycle Bin index files to extract file deletion times, original paths, and file sizes. Use when performing digital forensics on Windows systems (95 through Windows 10) to reconstruct user activity and identify deleted evidence.
---

# rifiuti2

## Overview
Rifiuti2 is a digital forensics tool designed to parse Windows Recycle Bin index files. It extracts critical metadata about deleted items, including the original file path, size, and deletion timestamp. It supports both the older `INFO2` format (Windows 95/NT/2000/XP) and the newer `$I...` index file format (Windows Vista/7/8/10). Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is already installed. If not, use:

```bash
sudo apt install rifiuti2
```

## Common Workflows

### Analyze modern Windows Recycle Bin ($Recycle.bin)
For Windows Vista and later, point the tool at the directory containing the `$I` index files:
```bash
rifiuti-vista -o results.txt /mnt/win_drive/\$Recycle.Bin/S-1-5-21-xxxx/
```

### Analyze legacy Windows Recycle Bin (INFO2)
For Windows XP or older, point the tool at the specific `INFO2` file:
```bash
rifiuti2 -o legacy_results.txt /mnt/win_drive/RECYCLER/S-1-5-21-xxxx/INFO2
```

### Analyze with local timezone
By default, timestamps are in UTC. Use `-z` to convert to the local system time:
```bash
rifiuti-vista -z -o local_time_results.csv /path/to/recyclebin/
```

## Complete Command Reference

The package provides two binaries depending on the Windows version being analyzed.

### rifiuti-vista
Used for Windows Vista, 7, 8, 8.1, and 10. Parses index files in the `C:\$Recycle.bin` style folder.

**Usage:** `rifiuti-vista [OPTION…] DIR_OR_FILE`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-format` | Show output formatting options |
| `-o, --output=FILE` | Write output to FILE |
| `-z, --localtime` | Present deletion time in time zone of local system (default is UTC) |
| `-v, --version` | Print version information and exit |
| `--live` | Inspect live system |

### rifiuti2
Used for legacy Windows (95, 98, ME, NT4, 2000, XP). Parses the `INFO2` file.

**Usage:** `rifiuti2 [OPTION…] INFO2`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-format` | Show output formatting options |
| `-o, --output=FILE` | Write output to FILE |
| `-z, --localtime` | Present deletion time in time zone of local system (default is UTC) |
| `-v, --version` | Print version information and exit |
| `-l, --legacy-filename=CODEPAGE` | Show legacy (8.3) path if available and specify its CODEPAGE |

## Notes
- **Format Support**: `rifiuti-vista` handles the individual `$I` files found in modern Windows versions, while `rifiuti2` handles the monolithic `INFO2` database found in older versions.
- **Output**: The default output is tab-delimited text, suitable for importing into spreadsheet software.
- **Live Systems**: When using `--live` on a running system, ensure you have sufficient permissions (Administrator/Root) to access the Recycle Bin directories.