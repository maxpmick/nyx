---
name: bulk-extractor
description: Extract digital evidence such as emails, URLs, credit card numbers, and EXIF data from disk images, files, or directories without parsing the filesystem. Use during digital forensics, incident response, or malware analysis to perform rapid data carving and feature extraction from raw data streams.
---

# bulk-extractor

## Overview
`bulk_extractor` is a high-performance C++ program that scans disk images, files, or directories to extract useful information (features) without needing to understand the underlying filesystem structures. It uses a variety of "scanners" to identify specific data types and produces histograms to highlight the most common findings. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install bulk-extractor
```

## Common Workflows

### Basic Image Analysis
Scan a disk image and output all discovered features to a directory:
```bash
bulk_extractor -o output_dir image.raw
```

### Targeted Scanning (Exclusive)
Disable all scanners and only run the email and net (network) scanners:
```bash
bulk_extractor -E email -e net -o output_emails image.raw
```

### Search for Specific Patterns
Search for a specific string or regular expression across a disk image:
```bash
bulk_extractor -f "secret-project-name" -o search_results image.raw
```

### Forensic Wordlist Generation
Extract all unique words from a drive to create a custom password cracking dictionary:
```bash
bulk_extractor -e wordlist -o wordlist_out image.raw
```

## Complete Command Reference

```bash
bulk_extractor [OPTION...] image_name
```

### General Options

| Flag | Description |
|------|-------------|
| `-A, --offset_add <arg>` | Offset added (in bytes) to feature locations (default: 0) |
| `-b, --banner_file <arg>` | Path of file whose contents are prepended to top of all feature files |
| `-C, --context_window <arg>` | Size of context window reported in bytes (default: 16) |
| `-d, --debug <arg>` | Enable debugging (default: 1) |
| `-D, --debug_help` | Help on debugging |
| `-E, --enable_exclusive <arg>` | Disable all scanners except the one specified |
| `-e, --enable <arg>` | Enable a scanner (can be repeated) |
| `-x, --disable <arg>` | Disable a scanner (can be repeated) |
| `-f, --find <arg>` | Search for a pattern (can be repeated) |
| `-F, --find_file <arg>` | Read patterns to search from a file (can be repeated) |
| `-G, --pagesize <arg>` | Page size in bytes (default: 16777216) |
| `-g, --marginsize <arg>` | Margin size in bytes (default: 4194304) |
| `-j, --threads <arg>` | Number of threads (default: 6) |
| `-J, --no_threads` | Read and process data in the primary thread |
| `-M, --max_depth <arg>` | Max recursion depth (default: 12) |
| `--max_bad_alloc_errors <arg>` | Max bad allocation errors (default: 3) |
| `--max_minute_wait <arg>` | Max minutes to wait until all data are read (default: 60) |
| `--notify_main_thread` | Display notifications in the main thread after phase 1 |
| `--notify_async` | Display notifications asynchronously (default) |
| `-o, --outdir <arg>` | Output directory [REQUIRED] |
| `-P, --scanner_dir <arg>` | Directories for scanner shared libraries |
| `-p, --path <arg>` | Print value of `<path>[:length][/h][/r]` (hex/raw output) |
| `-q, --quit` | No status or performance output |
| `-r, --alert_list <arg>` | File to read alert list from |
| `-R, --recurse` | Treat image file as a directory to recursively explore |
| `-S, --set <name=val>` | Set a name=value option (can be repeated) |
| `-s, --sampling <arg>` | Random sampling parameter `frac[:passes]` |
| `-V, --version` | Display version |
| `-w, --stop_list <arg>` | File to read stop list from |
| `-Y, --scan <arg>` | Specify `<start>[-end]` of area on disk to scan |
| `-z, --page_start <arg>` | Specify a starting page number |
| `-Z, --zap` | Wipe the output directory recursively before starting |
| `-0, --no_notify` | Disable real-time notification |
| `-1, --version1` | Version 1.0 notification (console-output) |
| `-H, --info_scanners` | Report information about each scanner |
| `-h, --help` | Print help screen |

### Global Configuration Options (`-S`)

| Option | Description |
|--------|-------------|
| `notify_rate=1` | Seconds between notification updates |
| `debug_histogram_malloc_fail_frequency=0` | Set >0 to simulate memory allocation failures |
| `hash_alg=sha1` | Hash algorithm for all calculations |
| `report_read_errors=1` | Report read errors |

### Scanner-Specific Options (`-S`)

| Scanner | Option | Description |
|---------|--------|-------------|
| **accts** | `ssn_mode` | 0=Normal; 1=No 'SSN' required; 2=No dashes required |
| | `min_phone_digits` | Min. digits required in a phone (default: 7) |
| **aes** | `scan_aes_128` | Scan for 128-bit AES keys (0=No, 1=Yes) |
| | `scan_aes_192` | Scan for 192-bit AES keys (0=No, 1=Yes) |
| | `scan_aes_256` | Scan for 256-bit AES keys (0=No, 1=Yes) |
| **exif** | `exif_debug` | Debug exif decoder |
| **gzip** | `gzip_max_uncompr_size` | Max size for decompressing GZIP objects |
| **net** | `carve_net_memory` | Carve network memory structures |
| | `min_carve_packet_bytes` | Smallest network packet to carve |
| **pdf** | `pdf_dump_hex` | Dump PDF buffers as hex |
| | `pdf_dump_text` | Dump PDF buffers as extracted text |
| **rar** | `rar_find_components` | Search for RAR components |
| | `rar_find_volumes` | Search for RAR volumes |
| **windirs** | `opt_weird_file_size` | Threshold for FAT32 scanner |
| | `opt_last_year` | Ignore FAT32 entries with a later year than this |
| **wordlist** | `word_min` | Minimum word size (default: 6) |
| | `word_max` | Maximum word size (default: 16) |
| | `strings` | Scan for strings instead of words (0=No, 1=Yes) |
| **xor** | `xor_mask` | XOR mask value in decimal (default: 255) |
| **zip** | `zip_max_uncompr_size` | Maximum size of a ZIP uncompressed object |

### Carve Mode Settings (`-S <scanner>_carve_mode=n`)
Set `n` to: **0** (do not carve), **1** (carve encoded data), **2** (carve everything).
Supported for: `evtx`, `jpeg`, `kml_carved`, `ntfsindx`, `ntfslogfile`, `ntfsmft`, `ntfsusn`, `rar`, `sqlite`, `unrar`, `utmp`, `vcard`, `winpe`, `zip`.

## Notes
- `bulk_extractor` is CPU-bound; increasing threads (`-j`) on multi-core systems significantly improves speed.
- It does not require mounting the image or understanding the filesystem, making it ideal for damaged media or unknown formats.
- Output is organized into "feature files" (e.g., `email.txt`, `url.txt`) within the specified output directory.