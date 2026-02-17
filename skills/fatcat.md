---
name: fatcat
description: Explore, extract, repair, and perform forensic analysis on FAT12, FAT16, and FAT32 filesystems. Use when analyzing disk images, recovering deleted files, searching for orphaned directories, or manually hacking FAT tables and directory entries during digital forensics or data recovery tasks.
---

# fatcat

## Overview
fatcat is a specialized tool for interacting with FAT filesystems. It supports information gathering, file extraction (including deleted items), FAT table manipulation, and forensic recovery of orphaned data. Category: Digital Forensics.

## Installation (if not already installed)
Assume fatcat is already installed. If the command is missing:

```bash
sudo apt install fatcat
```

## Common Workflows

### Display Filesystem Information
```bash
fatcat disk.img -i
```

### List Files and Include Deleted Items
```bash
fatcat disk.img -l / -d
```

### Extract Entire Filesystem to a Local Directory
```bash
mkdir output_dir
fatcat disk.img -x output_dir/
```

### Recover a Specific Deleted File by Cluster
```bash
fatcat disk.img -R 123 -s 2048 > recovered_file.bin
```

### Search for Orphaned Files (Forensics)
```bash
fatcat disk.img -o
```

## Complete Command Reference

```bash
fatcat disk.img [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-i` | Display information about the disk/filesystem |
| `-O [offset]` | Global offset in bytes (useful for pointing to a specific partition within a full disk image) |
| `-F [format]` | Output format: `default` or `json` |

### Browsing & Extracting

| Flag | Description |
|------|-------------|
| `-l [dir]` | List files and directories in the given path |
| `-L [cluster]` | List files and directories contained in the given cluster |
| `-r [path]` | Read/output the content of the file at the given path |
| `-R [cluster]` | Read/output the raw data from the given cluster |
| `-s [size]` | Specify the size of data to read (used with `-R` or for entry hacking) |
| `-d` | Enable listing and extraction of deleted files |
| `-x [directory]` | Extract all files to the specified local directory. Includes deleted files if `-d` is used. Starts at root unless `-c` is provided |
| `-S`* | Write scramble data in unallocated sectors (Destructive) |
| `-z`* | Write scramble data in unallocated sectors (Destructive) |

### FAT Hacking

| Flag | Description |
|------|-------------|
| `-@ [cluster]` | Get the physical address and information for a specific cluster |
| `-2` | Analyze and compare the two FAT tables |
| `-b [file]` | Backup the FATs to a file (use with `-t`) |
| `-p [file]`* | Restore (patch) the FATs from a file (use with `-t`) |
| `-w [cluster]`* | Write the "next cluster" pointer for a given cluster (requires `-v`) |
| `-v [value]` | The value to write when using `-w` |
| `-t [table]` | Specify which FAT table to operate on (0: both, 1: first, 2: second) |
| `-m`* | Merge the two FAT tables |
| `-o` | Search for orphaned files and directories (entries with no parent) |
| `-f`* | Attempt to fix reachable directories |

### Entries Hacking

| Flag | Description |
|------|-------------|
| `-e [path]` | Select a specific file/directory entry to modify. Must be combined with `-c`, `-s`, or `-a` |
| `-c [cluster]`* | Set the starting cluster for the entry selected by `-e` |
| `-s [size]`* | Set the file size for the entry selected by `-e` |
| `-a [attributes]`* | Set the attributes for the entry selected by `-e` |
| `-k [cluster]` | Search for any directory entry that points to the specified cluster |

## Notes
- **Warning**: Flags marked with an asterisk (`*`) perform write operations on the disk image. Always work on a copy of the evidence, never the original.
- Supports FAT12, FAT16, and FAT32 formats.
- When using `-x` to extract, fatcat will attempt to recreate the directory structure locally.