---
name: foremost
description: Recover lost files based on headers, footers, and internal data structures from disk images or physical drives. Use when performing digital forensics, data recovery, or incident response to extract deleted files (carving) from raw images, dd files, or unallocated space.
---

# foremost

## Overview
Foremost is a forensic data carving tool that recovers files by scanning headers, footers, and internal data structures. It can process image files (dd, Safeback, Encase, etc.) or direct drive devices. It supports built-in file types and custom configurations for specific data structures. Category: Digital Forensics.

## Installation (if not already installed)
Assume foremost is already installed. If you get a "command not found" error:

```bash
sudo apt install foremost
```

## Common Workflows

### Recover specific file types from a disk image
```bash
foremost -t jpeg,pdf,exe -i evidence.dd -o recovery_results
```

### Quick scan for all supported file types
```bash
foremost -q -i /dev/sdb -o /home/user/recovered
```
Searches on 512-byte boundaries for faster processing on large drives.

### Audit mode (Dry run)
```bash
foremost -w -i image.dd
```
Only writes the `audit.txt` file to the output directory without actually extracting the files to disk.

### Recover corrupted files
```bash
foremost -a -i image.dd -o corrupted_recovery
```
Writes all detected headers without performing error detection, useful for fragmented or damaged files.

## Complete Command Reference

```bash
foremost [-v|-V|-h|-T|-Q|-q|-a|-w-d] [-t <type>] [-s <blocks>] [-k <size>] [-b <size>] [-c <file>] [-o <dir>] [-i <file>]
```

### Options

| Flag | Description |
|------|-------------|
| `-i <file>` | Specify input file (default is stdin). Can be a raw image or a device path like `/dev/sda`. |
| `-o <dir>` | Set output directory for recovered files (defaults to `output`). |
| `-t <type>` | Specify file types to extract (e.g., `jpeg,pdf,exe,doc,zip`). Use `all` for all built-in types. |
| `-c <file>` | Set configuration file to use (defaults to `foremost.conf`). |
| `-q` | Enable quick mode. Searches are performed only on 512-byte sector boundaries. |
| `-Q` | Enable quiet mode. Suppresses error messages and standard output. |
| `-v` | Verbose mode. Logs all messages to the screen; useful for tracking progress. |
| `-a` | Write all headers. Performs no error detection (useful for recovering corrupted files). |
| `-w` | Write audit file only. Do not write any detected files to the disk. |
| `-d` | Turn on indirect block detection (optimized for UNIX file-systems). |
| `-s <num>` | Skip the specified number of blocks in the input file before starting the search. |
| `-k <size>` | Set the chunk size (in bytes) for the internal buffer. |
| `-b <size>` | Set the block size for the file system (default is 512). |
| `-T` | Time stamp the output directory so you don't have to delete the old one. |
| `-V` | Display copyright information and version number, then exit. |
| `-h` | Display the help message and exit. |

## Notes
- **Output Directory**: Foremost requires the output directory to be empty or non-existent. If the directory exists and is not empty, the tool will refuse to run unless the `-T` flag is used or the directory is cleared.
- **Configuration**: Advanced users can define custom file headers and footers in `/etc/foremost.conf` to recover non-standard file types.
- **Permissions**: When running foremost against a physical device (e.g., `/dev/sdb`), you typically need root privileges (`sudo`).