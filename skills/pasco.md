---
name: pasco
description: Examine and parse Microsoft Internet Explorer index.dat cache files for forensic analysis. Use when performing digital forensics, investigating web browsing history on Windows systems, or recovering deleted activity records from IE cache files.
---

# pasco

## Overview
Pasco is a forensic tool designed to examine the content of `index.dat` files produced by Microsoft Internet Explorer. It parses the proprietary file format and outputs field-separated data that can be easily loaded into spreadsheets for analysis. Category: Digital Forensics.

## Installation (if not already installed)
Assume pasco is already installed. If you get a "command not found" error:

```bash
sudo apt install pasco
```

## Common Workflows

### Basic cache parsing
Parse an `index.dat` file and output the results to a text file using the default TAB delimiter:
```bash
pasco index.dat > forensic_report.txt
```

### Parsing with CSV-style delimiter
Parse the cache file using a comma as a field delimiter for easy import into spreadsheet software:
```bash
pasco -t , index.dat > history.csv
```

### Recovering deleted records
Attempt to extract and undelete activity records from the cache file:
```bash
pasco -d index.dat
```

## Complete Command Reference

```
pasco [options] <filename>
```

### Options

| Flag | Description |
|------|-------------|
| `-d` | Undelete Activity Records: Attempts to recover deleted entries from the index.dat file |
| `-t <delimiter>` | Field Delimiter: Sets the character used to separate output fields (Default: TAB) |
| `<filename>` | Path to the Microsoft Internet Explorer `index.dat` file to be analyzed |

## Notes
- The tool outputs data in a raw field-separated format. It is highly recommended to redirect the output to a file (e.g., `> output.txt`) for analysis.
- `index.dat` files are typically found in user profile directories on Windows systems (e.g., Temporary Internet Files, History, and Cookies folders).
- If the tool returns an error stating the file cannot be opened, ensure you have the correct permissions or that the file path is accurate.