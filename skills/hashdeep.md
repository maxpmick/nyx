---
name: hashdeep
description: Compute, compare, and audit multiple message digests recursively using MD5, SHA1, SHA256, Tiger, and Whirlpool. Use when performing digital forensics, verifying file integrity, identifying known malicious files via hash matching, or auditing large directory structures for changes.
---

# hashdeep

## Overview
hashdeep is a suite of tools (including md5deep, sha1deep, etc.) designed to compute and compare message digests for any number of files recursively. It supports piecewise hashing, audit modes to validate files against a known set, and matching/negative matching modes. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume hashdeep is already installed. If not:
```bash
sudo apt install hashdeep
```

## Common Workflows

### Audit a directory against a known hash list
```bash
hashdeep -r -a -k known_hashes.txt /path/to/examine
```
Recursively checks all files in the target directory against the hashes in `known_hashes.txt`.

### Generate MD5 and SHA256 hashes for a directory
```bash
hashdeep -c md5,sha256 -r /home/user/documents > manifest.txt
```

### Find files matching a specific list (Matching Mode)
```bash
md5deep -m known_md5s.txt -r /media/usb_drive
```
Displays only the files on the USB drive that match the MD5 hashes listed in the text file.

### Piecewise hashing of a large disk image
```bash
hashdeep -p 1024m evidence.img
```
Hashes the file in 1GB blocks, useful for identifying data within large blobs.

## Complete Command Reference

### hashdeep Options
The primary tool for multi-algorithm hashing and auditing.

| Flag | Description |
|------|-------------|
| `-c <alg1,alg2>` | Compute specified hashes. Values: `md5`, `sha1`, `sha256`, `tiger`, `whirlpool`. Default: md5,sha256 |
| `-p <size>` | Piecewise mode. Break files into blocks of `size` for hashing |
| `-r` | Recursive mode. Traverse all subdirectories |
| `-d` | Output in DFXML (Digital Forensics XML) |
| `-k <file>` | Add a file of known hashes for comparison |
| `-a` | Audit mode. Validates FILES against known hashes (requires `-k`) |
| `-m` | Matching mode. Displays files that match the known list (requires `-k`) |
| `-x` | Negative matching mode. Displays files that do NOT match the known list (requires `-k`) |
| `-w` | In `-m` mode, displays which known file was matched |
| `-M` | Like `-m`, but displays hashes of matching files |
| `-X` | Like `-x`, but display hashes of non-matching files |
| `-e` | Compute estimated time remaining for each file |
| `-s` | Silent mode. Suppress all error messages |
| `-b` | Bare name mode. Omit path information from output |
| `-l` | Print relative paths for filenames |
| `-i <size>` | Only process files smaller than the given threshold |
| `-I <size>` | Only process files larger than the given threshold |
| `-o` | Only process certain types of files (see manpage) |
| `-v` | Verbose mode. Use multiple times for increased verbosity |
| `-W <file>` | Write output to specified FILE |
| `-j <num>` | Use `num` threads (default: 6) |

### md5deep / sha1deep / sha256deep / tigerdeep / whirlpooldeep Options
Specialized tools for single-algorithm operations.

| Flag | Description |
|------|-------------|
| `-p <size>` | Piecewise mode. Break files into blocks of `size` for hashing |
| `-r` | Recursive mode. Traverse all subdirectories |
| `-e` | Show estimated time remaining for each file |
| `-s` | Silent mode. Suppress all error messages |
| `-z` | Display file size before hash |
| `-m <file>` | Matching mode. Use hashes in `file` as the "known" set |
| `-x <file>` | Negative matching mode. Use hashes in `file` as the "known" set |
| `-M` | Same as `-m` but also print hashes of each file |
| `-X` | Same as `-x` but also print hashes of each file |
| `-w` | Displays which known file generated a match |
| `-n` | Displays known hashes that did NOT match any input files |
| `-a` | Add a single hash to the positive matching set |
| `-A` | Add a single hash to the negative matching set |
| `-b` | Bare name mode. Omit path information from output |
| `-l` | Print relative paths for filenames |
| `-t` | Print GMT timestamp (ctime) |
| `-i <size>` | Only process files smaller than SIZE |
| `-I <size>` | Only process files larger than SIZE |
| `-v` | Display version number and exit |
| `-d` | Output in DFXML |
| `-u` | Escape Unicode characters |
| `-W <file>` | Write output to specified FILE |
| `-j <num>` | Use `num` threads (default: 6) |
| `-Z` | Triage mode |
| `-h` | Display help |
| `-hh` | Display full help list |

## Notes
- **Audit Mode**: When using `-a`, hashdeep returns a success/failure report for the entire set of files, making it ideal for verifying system integrity against a baseline.
- **Thread Tuning**: The `-j` flag defaults to 6 threads. On high-performance storage (SSDs/NVMe), increasing this can significantly speed up processing of many small files.
- **DFXML**: Use the `-d` flag if you intend to ingest the results into other forensic processing tools.