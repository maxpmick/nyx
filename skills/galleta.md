---
name: galleta
description: Analyze and parse Microsoft Internet Explorer (MSIE) cookie files for forensic investigation. Use when performing digital forensics, incident response, or user activity analysis to extract cookie data into a spreadsheet-compatible format.
---

# galleta

## Overview
Galleta is a digital forensics tool designed to examine the content of cookie files produced by Microsoft Internet Explorer (MSIE). It parses the binary/structured cookie files and outputs field-separated data that can be easily loaded into spreadsheets for analysis. Category: Digital Forensics.

## Installation (if not already installed)
Assume galleta is already installed. If you get a "command not found" error:

```bash
sudo apt install galleta
```

## Common Workflows

### Standard cookie parsing
Parse a cookie file using the default TAB delimiter:
```bash
galleta cookie_file.txt
```

### Parsing with custom delimiter
Parse a cookie file and use a semicolon as the field separator for CSV/spreadsheet compatibility:
```bash
galleta -d ";" cookie_file.txt
```

### Exporting results to a file
Redirect the parsed output to a text file for further processing:
```bash
galleta -d "," cookie_file.txt > cookie_analysis.csv
```

## Complete Command Reference

```
Usage: galleta [options] <filename>
```

### Options

| Flag | Description |
|------|-------------|
| `-d <delimiter>` | Set the Field Delimiter (Default is TAB) |
| `<filename>` | The path to the MSIE cookie file to be parsed |

## Notes
- Galleta is specifically designed for older Microsoft Internet Explorer cookie formats.
- The tool outputs data in a raw field-separated format; if no delimiter is specified, ensure your viewer supports TAB characters.
- If the tool returns an error "The cookie file cannot be opened!", verify the file path and ensure you have read permissions for the target file.