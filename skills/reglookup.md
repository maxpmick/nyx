---
name: reglookup
description: Analyze Windows NT-based registry files (hives) to extract keys, values, and security descriptors. Use when performing digital forensics, incident response, or malware analysis to enumerate registry entries, recover deleted data structures, or generate activity timelines from registry MTIMEs.
---

# reglookup

## Overview
RegLookup is a forensic utility for direct analysis of Windows NT-based registry files. It provides tools to read registry hives, filter by path or data type, recover deleted registry structures, and generate timelines. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume reglookup is already installed. If you get a "command not found" error:

```bash
sudo apt install reglookup
```

## Common Workflows

### Full Hive Enumeration
Read an entire system registry hive and output to CSV format:
```bash
reglookup /mnt/win/c/Windows/System32/config/SYSTEM
```

### Targeted Key Discovery
Filter for specific services or configurations using a path prefix:
```bash
reglookup -p /ControlSet001/Services/Tcpip /path/to/SYSTEM
```

### Forensic Recovery
Attempt to recover deleted registry keys and values from unallocated hive space:
```bash
reglookup-recover -r -l /path/to/NTUSER.DAT
```

### Timeline Generation
Generate a timeline based on registry key Modification Times (MTIME):
```bash
reglookup-timeline /path/to/SOFTWARE > software_timeline.csv
```

## Complete Command Reference

### reglookup
Windows NT+ registry reader and lookup tool.

```
reglookup [options] registry-file
```

| Flag | Description |
|------|-------------|
| `-p <prefix>` | Specify a path prefix filter. Only keys/values under this path are output. |
| `-t <type>` | Filter by data type (NONE, SZ, EXPAND_SZ, BINARY, DWORD, DWORD_BE, LINK, MULTI_SZ, RSRC_LIST, RSRC_DESC, RSRC_REQ_LIST, QWORD, KEY). |
| `-h` | Enable printing of column header row (default). |
| `-H` | Disable printing of column header row. |
| `-i` | Values inherit the timestamp of their parent key. |
| `-s` | Add 5 columns for security descriptors: owner, group, sacl, dacl, class. |
| `-S` | Disable security descriptor information (default). |
| `-v` | Verbose output. |

### reglookup-recover
Tool for recovering deleted data structures from registry hives.

```
reglookup-recover [options] registry-file
```

| Flag | Description |
|------|-------------|
| `-v` | Verbose output. |
| `-h` | Enable printing of column header row (default). |
| `-H` | Disable printing of column header row. |
| `-l` | Display cells that couldn't be interpreted as valid structures at the end. |
| `-L` | Do not display uninterpretable cells (default). |
| `-r` | Display raw cell contents alongside interpreted data. |
| `-R` | Do not display raw cell contents (default). |

### reglookup-timeline
Generates a CSV timeline of registry MTIMEs.

```
reglookup-timeline registry-file
```

## Notes
- **Output Encoding**: Special characters or non-ASCII bytes are hex-encoded as `%XX`.
- **Delimiters**: CSV is the primary format. Sub-delimiters used for complex fields (like ACLs) are `|` (secondary), `:` (third), and ` ` (fourth).
- **Timestamps**: Registry timestamps are stored at the Key level. Individual values do not have their own timestamps; using `-i` applies the parent key's MTIME to the values.
- **Accuracy**: MTIME conversions are generally UTC but may have slight drift (seconds) due to how Windows writes to the registry.
- **Security Descriptors**: The `-s` output includes abbreviations for access rights (e.g., `QRY_VAL`, `SET_VAL`) and inheritance flags (e.g., `OI`, `CI`).