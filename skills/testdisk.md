---
name: testdisk
description: Scan and repair disk partitions, recover lost partitions, and perform file carving to recover deleted or lost files from various file systems and storage media. Use when performing digital forensics, data recovery, or incident response to restore missing partitions (FAT, NTFS, Ext2/3/4, etc.) or extract deleted files (images, documents, archives) from hard drives, memory cards, or disk images.
---

# testdisk

## Overview
A powerful suite of data recovery tools. **TestDisk** focuses on partition recovery and fixing boot sectors, supporting a wide array of file systems including FAT, NTFS, Ext2/3/4, LVM, and RAID. **PhotoRec** is a file carving tool that ignores the file system and goes after the underlying data to recover lost files (images, videos, docs). **fidentify** uses the PhotoRec database to identify file types. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install testdisk
```

## Common Workflows

### Recovering Lost Partitions
```bash
sudo testdisk /dev/sdb
```
Follow the interactive menu: Select media -> Select partition table type (usually Intel or EFI GPT) -> Analyze -> Quick Search.

### Listing Partitions from a Disk Image
```bash
testdisk /list evidence.dd
```

### Recovering Deleted Files (Carving)
```bash
sudo photorec /d ./recovered_files /log /dev/sdb
```
Launches PhotoRec to scan `/dev/sdb` and output found files into the `./recovered_files` directory.

### Identifying a Mystery File
```bash
fidentify unknown_file.bin
```

## Complete Command Reference

### testdisk
Scan and repair disk partitions.

**Usage:**
`testdisk [/log] [/debug] [file.dd|file.e01|device]`
`testdisk /list [/log] [file.dd|file.e01|device]`
`testdisk /version`

| Flag | Description |
|------|-------------|
| `/log` | Create a `testdisk.log` file in the current directory |
| `/debug` | Add debug information to the log |
| `/list` | Display current partitions and exit (non-interactive) |
| `/version` | Display version information |

---

### photorec
Recover lost files from harddisk, digital camera, and CD-ROM by carving data.

**Usage:**
`photorec [/log] [/debug] [/d recup_dir] [file.dd|file.e01|device]`
`photorec /version`

| Flag | Description |
|------|-------------|
| `/log` | Create a `photorec.log` file |
| `/debug` | Add debug information |
| `/d <dir>` | Specify the directory where recovered files (`recup_dir`) will be stored |
| `/version` | Display version information |

---

### fidentify
Determine file type using the PhotoRec signature database.

**Usage:**
`fidentify [--check] [+file_format] [directory|file]`
`fidentify --version`

| Flag | Description |
|------|-------------|
| `--check` | Check the integrity of the database |
| `+file_format` | Specifically enable a file format to search for |
| `--version` | Display version information |

## Notes
- **Safety**: When recovering partitions or files, never write the recovered data or logs to the same partition you are currently analyzing.
- **Forensics**: Supports raw disk images (`.dd`) and EnCase images (`.e01`).
- **File Systems**: Supports a massive range including FAT12/16/32, NTFS, Ext2/3/4, HFS+, JFS, ReiserFS, XFS, ZFS, and more.
- **PhotoRec Carving**: PhotoRec can recover over 480 file extensions including ZIP, Office docs, PDF, HTML, and various image/video formats.