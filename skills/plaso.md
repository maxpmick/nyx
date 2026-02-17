---
name: plaso
description: A Python-based engine for automatic creation of super timelines from various log files and forensic artifacts. Use when performing digital forensics, incident response, or deep-dive artifact analysis to correlate events across a system. It supports multiple tools like log2timeline for extraction, psort for filtering/formatting, and psteal for end-to-end processing.
---

# Plaso

## Overview
Plaso (Super Timeline All The Things) is a framework used to parse various log files and forensic artifacts from computers and network equipment to produce a single correlated timeline. It is a critical tool for forensic investigators to analyze vast amounts of information in a chronological context. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume Plaso is already installed. If not, use:
```bash
sudo apt install plaso
```

## Common Workflows

### Full Timeline Extraction (log2timeline)
Extract events from a disk image into a Plaso storage file:
```bash
log2timeline.py /cases/mycase/storage.plaso image.dd
```

### End-to-End Processing (psteal)
Extract events from a source and immediately output to a CSV file:
```bash
psteal.py --source image.dd -w timeline.csv
```

### Filtering and Exporting (psort)
Filter a storage file for specific events and export to a dynamic output format:
```bash
psort.py -o dynamic -w filtered_timeline.txt storage.plaso "event_identifier == 'some_id'"
```

### Image File Export (image_export)
Export specific files from a disk image based on extensions:
```bash
plaso-image_export -x "docx,pdf,xlsx" -w ./extracted_files/ image.raw
```

## Complete Command Reference

### plaso-log2timeline
Extracts events from files, directories, or storage media.

| Flag | Description |
|------|-------------|
| `SOURCE` | Path to source device, file, or directory |
| `-h, --help` | Show help message |
| `--artifact_definitions PATH` | Path to artifact definitions (.yaml) |
| `--archives TYPES` | Comma separated list of archive types to process (or "all", "none", "list") |
| `--artifact_filters FILTERS` | Comma separated names of forensic artifact definitions |
| `--extract_winreg_binary` | Extract binary Windows Registry values (Slower) |
| `--preferred_year YEAR` | Initial year for formats without year (e.g., syslog) |
| `--skip_compressed_streams` | Skip content in .gz or .bz2 streams |
| `-f, --file-filter FILE` | List of files to include for targeted collection |
| `--hasher_file_size_limit SIZE` | Max file size for hashers (0 = no limit) |
| `--hashers LIST` | List of hashers to use (e.g., "md5,sha256") |
| `--parsers EXPRESSION` | Define presets, parsers, or plugins (e.g., "linux,!bash_history") |
| `--yara_rules PATH` | Path to Yara rules definitions |
| `--partitions PARTITIONS` | Partitions to process (e.g., "1,3..5" or "all") |
| `--volumes VOLUMES` | Volumes to process (e.g., "1,3..5" or "all") |
| `--codepage CODEPAGE` | Preferred codepage for decoding strings |
| `--language TAG` | Language for Windows EventLog strings (e.g., "en-US") |
| `-z, --timezone ZONE` | Preferred time zone (default: UTC) |
| `--vss_stores STORES` | VSS stores to process (e.g., "1,2" or "all", "none") |
| `--credential TYPE:DATA` | Credentials for encrypted volumes (e.g., "password:test") |
| `--storage_file PATH` | Path of the output storage file |
| `--workers WORKERS` | Number of worker processes |

### plaso-psort
Reads, filters, and processes Plaso storage files.

| Flag | Description |
|------|-------------|
| `PATH` | Path to a storage file |
| `FILTER` | Event filter expression |
| `--analysis PLUGIN_LIST` | Comma separated list of analysis plugins |
| `--slice DATE_TIME` | Create a time slice around ISO 8601 date |
| `--slice_size SIZE` | Minutes (for time slice) or events (for slicer) |
| `--slicer` | Create a slice around every filter match |
| `-a, --include-all` | Include duplicate entries |
| `-o, --output-format FORMAT` | Output format (use "-o list" to see available) |
| `-w, --write FILE` | Output filename |
| `--fields FIELDS` | Fields to include in output |
| `--output_time_zone ZONE` | Time zone for output values |

### plaso-psteal
Combined tool for extraction and output.

| Flag | Description |
|------|-------------|
| `--source SOURCE` | The source to process |
| `-o FORMAT` | The output format |
| `-w OUTPUT_FILE` | Output filename |
| `--parsers EXPRESSION` | Parser filter expression |
| `--storage_file PATH` | Intermediate storage file path |
| *Note* | Supports most extraction flags from log2timeline and output flags from psort |

### plaso-image_export
Collector for exporting files from images/VSS.

| Flag | Description |
|------|-------------|
| `IMAGE` | Path to the image file |
| `-x, --extensions EXT` | Filter by file extensions (comma separated) |
| `--names NAMES` | Filter by file names |
| `--signatures IDS` | Filter by file format signatures |
| `-w, --write PATH` | Directory to store extracted files |
| `--date-filter FILTER` | Filter by date range (e.g., "atime, 2023-01-01, 2023-01-02") |
| `--no_hashes` | Do not generate hashes.json file |

### plaso-pinfo
Shows metadata about a Plaso storage file.

| Flag | Description |
|------|-------------|
| `PATH` | Path to storage file |
| `--compare FILE` | Compare against another storage file |
| `--output_format FORMAT` | text, json, or markdown |
| `--report TYPE` | Specific report (e.g., "windows_services", "file_hashes") |
| `--sections LIST` | Specific sections to output |

## Notes
- **Performance**: Processing large images with `--extract_winreg_binary` or `--archives all` can be significantly slower.
- **VSS**: Use `--vss_stores all` to ensure Volume Shadow Copies are parsed during Windows investigations.
- **Storage**: Plaso uses SQLite as the default storage format for `.plaso` files.
- **Memory**: Use `--process_memory_limit` if running on systems with constrained RAM.