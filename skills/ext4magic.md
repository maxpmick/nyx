---
name: ext4magic
description: Recover deleted files from ext3 or ext4 partitions by extracting information from the filesystem journal. Use during digital forensics, incident response, or data recovery scenarios to restore file attributes like original filenames, ownership, and timestamps.
---

# ext4magic

## Overview
ext4magic is a specialized file recovery and carving tool for ext3 and ext4 filesystems. It leverages the filesystem journal to reconstruct deleted files and directory trees, often preserving metadata that traditional carvers lose. Category: Digital Forensics.

## Installation (if not already installed)
Assume ext4magic is already installed. If the command is missing:

```bash
sudo apt install ext4magic
```

## Common Workflows

### Recover all recently deleted files (Magic Mode)
Attempts a high-probability recovery of all deleted files to a specific directory.
```bash
ext4magic /dev/sdb1 -M -d /recovery/output
```

### Recover a specific file by name
Search the journal for a specific deleted file and attempt recovery.
```bash
ext4magic /dev/sdb1 -f "important_document.pdf" -r -d /recovery/output
```

### List deleted files within a time range
List files deleted between two Unix timestamps to identify candidates for recovery.
```bash
ext4magic /dev/sdb1 -a 1672531200 -b 1672617600 -l
```

### Recover files from a specific inode
If the inode number is known from forensic analysis, recover the data associated with it.
```bash
ext4magic /dev/sdb1 -I 12345 -r -d /recovery/output
```

## Complete Command Reference

### Usage Syntax
```
ext4magic -M [-j <journal_file>] [-d <target_dir>] <filesystem> 
ext4magic -m [-j <journal_file>] [-d <target_dir>] <filesystem> 
ext4magic [-S|-J|-H|-V|-T] [-x] [-j <journal_file>] [-B n|-I n|-f <file_name>|-i <input_list>] [-t n|[[-a n][-b n]]] [-d <target_dir>] [-R|-r|-L|-l] [-Q] <filesystem> 
```

### Primary Modes

| Flag | Description |
|------|-------------|
| `-M` | "Magic" recovery. Attempts to recover all deleted files with a high success probability. |
| `-m` | Similar to Magic mode but attempts to recover more files (higher false positive risk). |

### Selection Options

| Flag | Description |
|------|-------------|
| `-B <n>` | Specify a block number for recovery/analysis. |
| `-I <n>` | Specify an inode number for recovery/analysis. |
| `-f <file_name>` | Search for and recover a specific file name or path. |
| `-i <input_list>` | Read a list of files/inodes to process from a file. |
| `-j <journal_file>` | Use an external journal file (useful if the internal journal is overwritten). |
| `-d <target_dir>` | Directory where recovered files will be written. |

### Time Control Options

| Flag | Description |
|------|-------------|
| `-a <n>` | "After" - Only process files deleted after this Unix timestamp. |
| `-b <n>` | "Before" - Only process files deleted before this Unix timestamp. |
| `-t <n>` | "Time" - Use a specific timestamp for journal lookups. |

### Action Options

| Flag | Description |
|------|-------------|
| `-R` | Restore all files and directories (recursive). |
| `-r` | Restore only the specified files/directories. |
| `-L` | List all files and directories found in the journal. |
| `-l` | List only deleted files found in the journal. |
| `-S` | Show filesystem superblock information. |
| `-J` | Show journal superblock information. |
| `-H` | Show a histogram of inode timestamps. |
| `-V` | Print version information. |
| `-T` | Display the entire transaction list from the journal. |
| `-x` | Expert mode: allows more detailed output and control. |
| `-Q` | Quiet mode: suppress non-essential output. |

## Notes
- **Unmount First**: Always run ext4magic on an unmounted filesystem or a read-only image to prevent data overwriting.
- **Journal Dependency**: Success depends heavily on the state of the filesystem journal. If the journal has wrapped around, recovery of older deleted files may be impossible.
- **Root Privileges**: This tool requires root privileges to access block devices directly.
- **Timestamps**: Use `date -d "YYYY-MM-DD HH:MM:SS" +%s` to convert human-readable dates to Unix timestamps for the `-a` and `-b` flags.