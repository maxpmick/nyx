---
name: scalpel
description: Fast filesystem-independent file carver that recovers files by reading a database of header and footer definitions. Use when performing digital forensics, data recovery, or incident response to extract files from disk images or raw device files across various filesystems (FAT, NTFS, Ext, etc.).
---

# scalpel

## Overview
Scalpel is a high-performance file carver based on Foremost 0.69. It is filesystem-independent, meaning it can recover files from FAT16, FAT32, exFAT, NTFS, Ext2/3/4, JFS, XFS, ReiserFS, and raw partitions. It works by matching file headers and footers defined in a configuration file against the raw data of an image or device. Category: Digital Forensics.

## Installation (if not already installed)
Assume scalpel is already installed. If the command is missing:

```bash
sudo apt install scalpel
```

## Common Workflows

### Basic file recovery
Carve files from a disk image using the default configuration and saving to an output directory:
```bash
scalpel -o output_dir evidence.img
```

### Preview mode (Dry run)
Audit the image to see what files *would* be carved without actually writing them to disk:
```bash
scalpel -p evidence.img
```

### Using a specific configuration file
By default, all lines in `/etc/scalpel/scalpel.conf` are commented out. You must uncomment the file types you want to recover or provide a custom config:
```bash
scalpel -c my_custom_rules.conf -o recovered_files evidence.img
```

### Carving directly from a device
```bash
sudo scalpel -o recovered_jpgs /dev/sdb1
```

## Complete Command Reference

```
scalpel [-b] [-c <config file>] [-d] [-h|V] [-i <file>]
        [-m blocksize] [-n] [-o <outputdir>] [-O num] [-q clustersize]
        [-r] [-s num] [-t <blockmap file>] [-u] [-v]
        <imgfile> [<imgfile>] ...
```

| Flag | Description |
|------|-------------|
| `-b` | Carve files even if defined footers aren't discovered within maximum carve size for file type (Foremost 0.69 compatibility mode). |
| `-c <file>` | Choose a specific configuration file (e.g., `/etc/scalpel/scalpel.conf`). |
| `-d` | **EXPERIMENTAL**: Generate header/footer database; bypasses certain optimizations to discover all footers. Performance will suffer; does not affect the set of files carved. |
| `-h` | Print help message and exit. |
| `-i <file>` | Read names of disk images from the specified file instead of the command line. |
| `-m <size>` | **EXPERIMENTAL**: Generate/update carve coverage blockmap file. The first 32-bit unsigned int identifies the block size. Each subsequent entry counts how many carved files contain that block. |
| `-n` | Don't add extensions to extracted files. |
| `-o <dir>` | Set output directory for carved files. This directory must not exist before running. |
| `-O` | Don't organize carved files by type. Default behavior is to organize files into subdirectories. |
| `-p` | Perform image file preview; the audit log indicates what would be carved, but no files are written. |
| `-q <size>` | Carve only when the header is cluster-aligned to the specified cluster size. |
| `-r` | Find only the first of overlapping headers/footers (Foremost 0.69 compatibility mode). |
| `-s <num>` | Skip `n` bytes in each disk image before starting the carving process. |
| `-t <dir>` | **EXPERIMENTAL**: Set directory for coverage blockmap. |
| `-u` | **EXPERIMENTAL**: Use carve coverage blockmap. Carve only sections of the image whose entries in the blockmap are 0. |
| `-V` | Print copyright information and exit. |
| `-v` | Verbose mode; provides more detailed output during the carving process. |

## Notes
- **Configuration Required**: Before running, you must edit `/etc/scalpel/scalpel.conf` (or a local copy) to uncomment the specific file headers (e.g., jpg, pdf, doc) you wish to recover.
- **Output Directory**: Scalpel requires that the output directory specified with `-o` does **not** already exist; it will create it for you.
- **Permissions**: When carving raw devices (e.g., `/dev/sda`), you typically need root privileges (`sudo`).