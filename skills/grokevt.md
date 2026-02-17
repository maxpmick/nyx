---
name: grokevt
description: Read and convert Microsoft Windows NT/2000/XP/2003 event log files (.evt) into human-readable formats. Use when performing digital forensics, incident response, or analyzing Windows event logs from mounted partitions, disk images, or memory dumps to reconstruct system activity.
---

# grokevt

## Overview
GrokEVT is a collection of scripts designed to extract information from Windows event logs by processing registry entries, message templates, and raw log files. It is primarily used in forensic investigations to convert proprietary binary log formats into readable CSV output. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume grokevt is already installed. If not:
```bash
sudo apt install grokevt
```
Dependencies: python3, python3-pyregfi, reglookup.

## Common Workflows

### 1. Build a Message Database
First, create a database from a mounted Windows partition (e.g., mounted at `/mnt/windows`). You need a configuration profile (usually found in `/usr/share/grokevt/`).
```bash
grokevt-builddb /usr/share/grokevt/profiles/xp-sp2 /mnt/windows ./winevt_db
```

### 2. List Available Logs
Check which logs were successfully processed and are available in the database.
```bash
grokevt-parselog -l ./winevt_db
```

### 3. Parse a Specific Log to CSV
Convert a specific log (e.g., 'System') to a human-readable CSV format.
```bash
grokevt-parselog ./winevt_db System > system_log.csv
```

### 4. Find Log Fragments in Disk Images
Search for event log structures within a raw disk image or memory dump.
```bash
grokevt-findlogs -v evidence.img
```

## Complete Command Reference

### grokevt-builddb
Builds a database tree based on a single Windows system.
```bash
grokevt-builddb [-v] [-c CSID] <CONFIG_PROFILE> <OUTPUT_DIR>
```
| Flag | Description |
|------|-------------|
| `-v` | Verbose mode |
| `-c CSID` | Specify Control Set ID (e.g., 1 for ControlSet001) |
| `<CONFIG_PROFILE>` | Path to the configuration profile for the target OS |
| `<OUTPUT_DIR>` | Directory where the database will be created |

### grokevt-parselog
Parses a Windows event log and generates human-readable output.
```bash
grokevt-parselog [-v] [-H] [-h] <DATABASE_DIR> <LOG_TYPE>
```
| Flag | Description |
|------|-------------|
| `-l <DATABASE_DIR>` | List all log types available in the database |
| `-m <DATABASE_DIR> <LOG_TYPE>` | Show metadata for a specific log type |
| `-v` | Verbose mode |
| `-H` | Include header row in CSV output |
| `-h` | Print help message |
| `-?` | Print help message |

### grokevt-addlog
Adds a raw event log to an existing GrokEVT database.
```bash
grokevt-addlog <DATABASE_DIR> <EVT_FILE> <NEW_TYPE> <BASE_TYPE>
```
*   `<NEW_TYPE>`: The name you want to give this log in the database.
*   `<BASE_TYPE>`: The template type to use (e.g., System, Application).

### grokevt-findlogs
Attempts to find log file fragments in raw binary files.
```bash
grokevt-findlogs [-v] [-h] [-H] [-o <OFFSET>] <RAW_FILE>
```
| Flag | Description |
|------|-------------|
| `-v` | Verbose mode |
| `-h` | Print help message |
| `-H` | Print header information |
| `-o <OFFSET>` | Start searching at the specified byte offset |

### grokevt-ripdll
Extracts message resources from a PE-formatted file (DLL/EXE).
```bash
grokevt-ripdll <INPUT_DLL> <OUTPUT_DB>
```

### grokevt-dumpmsgs
Dumps the contents of message databases built by `grokevt-ripdll`.
```bash
grokevt-dumpmsgs message-db1 [message-db2 ...]
```
*   Outputs two comma-separated columns: `LanguageCode-RVA` and the `Message`.
*   Special characters are URL-encoded (e.g., `%XX`).

## Notes
*   **Profiles**: Configuration profiles define where registry hives and system files are located on different Windows versions.
*   **Encoding**: Output messages containing newlines or commas are encoded as `%XX` (hex value).
*   **Legacy Support**: This tool is specifically designed for the older `.evt` format (NT/2000/XP/2003). For newer `.evtx` files (Vista and later), other tools like `evtx-tools` are required.