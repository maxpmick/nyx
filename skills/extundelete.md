---
name: extundelete
description: Recover deleted files from ext3 and ext4 partitions by parsing the filesystem journal. Use when performing digital forensics, data recovery, or incident response to retrieve accidentally or maliciously deleted files from Linux partitions.
---

# extundelete

## Overview
extundelete is a utility designed to recover deleted files from ext3 or ext4 partitions. It uses the information stored in the partition's journal to attempt recovery. It is a vital tool for Digital Forensics and Data Recovery.

## Installation (if not already installed)
Assume extundelete is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install extundelete
```

## Common Workflows

### Restore a specific file
To restore a file, provide the path relative to the root of the partition (without a leading slash).
```bash
extundelete /dev/sdb1 --restore-file home/user/documents/secret.txt
```

### Restore an entire directory
```bash
extundelete /dev/sdb1 --restore-directory var/log/apache2
```

### Restore everything possible
Attempts to recover all deleted files found in the journal.
```bash
extundelete /dev/sdb1 --restore-all
```

### Restore by Inode
If you know the specific inode number from forensic analysis:
```bash
extundelete /dev/sdb1 --restore-inode 12345
```

## Complete Command Reference

```bash
extundelete [options] [--] device-file
```

### General Options

| Flag | Description |
|------|-------------|
| `--version`, `-[vV]` | Print version and exit successfully |
| `--help` | Print help message and exit |
| `--superblock` | Print contents of superblock (implied if no action is specified) |
| `--journal` | Show content of the journal |
| `--after dtime` | Only process entries deleted on or after 'dtime' (Unix timestamp) |
| `--before dtime` | Only process entries deleted before 'dtime' (Unix timestamp) |

### Actions

| Flag | Description |
|------|-------------|
| `--inode ino` | Show info on inode `ino` |
| `--block blk` | Show info on block `blk` |
| `--restore-inode ino[,ino,...]` | Restore file(s) with known inode number(s). Saved as `file.[inode]` |
| `--restore-file 'path'` | Restore specific file. Path is relative to partition root (no leading `/`) |
| `--restore-files 'path'` | Restore files listed in a text file (one relative path per line) |
| `--restore-directory 'path'` | Restore a directory. Path is relative to partition root |
| `--restore-all` | Attempts to restore all deleted files |

### Filesystem & Output Options

| Flag | Description |
|------|-------------|
| `-j journal` | Reads an external journal from the named file |
| `-b blocknumber` | Uses the backup superblock at `blocknumber` |
| `-B blocksize` | Uses `blocksize` (in bytes) when opening the filesystem |
| `-o directory` | Save recovered files to the named directory (Default: `RECOVERED_FILES/`) |
| `--log 0` | Silent mode |
| `--log filename` | Logs all messages to `filename` |
| `--log D1=0,D2=filename` | Custom logging. `Dn` must be `info`, `warn`, or `error`. `=0` turns off level; `=filename` logs to file; omission logs to console |

## Notes
- **Safety First**: Always unmount the partition before running extundelete to prevent data overwriting. If the partition is the root partition, consider booting from a Live USB.
- **Output**: By default, files are restored to a directory named `RECOVERED_FILES/` in the current working directory.
- **Limitations**: Extended attributes are not restored. There is no guarantee of recovery if the blocks have been overwritten by new data.
- **Timestamps**: The `--after` and `--before` flags use Unix timestamps (seconds since 1970-01-01).