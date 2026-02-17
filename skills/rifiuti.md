---
name: rifiuti
description: Analyze MS Windows Recycle Bin INFO2 files to extract metadata about deleted files. Use during digital forensics investigations to recover original file paths, deletion timestamps, and file sizes from legacy Windows systems (Windows 95 through XP/Server 2003).
---

# rifiuti

## Overview
Rifiuti is a forensics tool designed to examine INFO2 files, which contain metadata for files moved to the Recycle Bin in older versions of Microsoft Windows (95, 98, ME, NT, 2000, and XP). It extracts critical evidentiary data including the original file path, the date and time of deletion, and the file size. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install rifiuti
```

## Common Workflows

### Basic analysis of an INFO2 file
```bash
rifiuti INFO2
```
Parses the file and outputs the metadata using the default TAB delimiter.

### Analysis with custom delimiter for CSV compatibility
```bash
rifiuti -d "," INFO2 > recycle_bin_report.csv
```
Extracts the metadata using a comma as a field separator, making it easy to import into spreadsheet software.

### Processing a file from a mounted forensic image
```bash
rifiuti /mnt/evidence/RECYCLER/S-1-5-21-123456789-123456789-123456789-1001/INFO2
```

## Complete Command Reference

```
Usage: rifiuti [options] <filename>
```

| Flag | Description |
|------|-------------|
| `-d <delimiter>` | Specify the Field Delimiter to use between output columns. (Default: TAB) |
| `<filename>` | The path to the INFO2 file to be analyzed. |

## Notes
- **Compatibility**: This tool is specifically for the `INFO2` format used by Windows versions prior to Windows Vista. For Windows Vista and later (Windows 7, 8, 10, 11), which use `$I` and `$R` files in the `$Recycle.Bin` folder, different tools (like `rifiuti2`) are required.
- **Output Fields**: The tool typically outputs the Index, Original Drive Number, Deletion Time, and Original Path.
- **Permissions**: Ensure you have read permissions for the INFO2 file, especially when analyzing files directly from a mounted Windows filesystem.