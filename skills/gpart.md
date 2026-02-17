---
name: gpart
description: Guess PC-type hard disk partitions and find lost or deleted partition tables. Use when the primary partition table (MBR) is damaged, incorrect, or deleted, or when performing digital forensics to recover inadvertently deleted primary and logical partitions.
---

# gpart

## Overview
Gpart (Guess PC-part) is a tool that scans a disk device and attempts to guess the primary partition table if it is damaged or missing. It identifies the types, locations, and sizes of partitions (including primary and logical) for various filesystems including Ext2, FAT, NTFS, BeOS, FreeBSD/NetBSD disklabels, LVM, and more. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume gpart is already installed. If the command is missing:

```bash
sudo apt install gpart
```

## Common Workflows

### Standard scan to identify lost partitions
```bash
gpart /dev/sdb
```
Scans the device and prints the guessed partition table to stdout.

### Interactive recovery and backup
```bash
gpart -i -b mbr_backup.bin -W /dev/sdb /dev/sdb
```
Saves a backup of the current MBR, scans the disk, and asks for confirmation before writing the guessed table back to the device.

### Full scan with high verbosity for forensic analysis
```bash
gpart -v -v -f -l scan_results.log /dev/sda
```
Performs a full scan (checking every sector), increases verbosity, and logs all findings to a file.

### Scan a specific range of a disk
```bash
gpart -k 1024 -K 2048000 /dev/sdb
```
Skips the first 1024 sectors and stops scanning at sector 2,048,000.

## Complete Command Reference

```
gpart [options] device
```

### Options

| Flag | Description |
|------|-------------|
| `-b <file>` | Save a backup of the original MBR to the specified file. |
| `-C c,h,s` | Manually set the cylinders, heads, and sectors (C/H/S) to be used in the scan. |
| `-c` | Check/compare mode. |
| `-d` | Dry run: Do not start the guessing loop. |
| `-E` | Do not try to identify extended partition tables. |
| `-e` | Do not skip disk read errors; attempt to process them. |
| `-f` | Full scan. Check every sector rather than incrementing by heads or cylinders. |
| `-g` | Do not try to get the disk geometry from the OS. |
| `-h` | Show the help message. |
| `-i` | Run interactively. Ask for confirmation before taking actions. |
| `-K <sector>` | Scan only up to the given last sector. |
| `-k <#>` | Skip the specified number of sectors before starting the scan. |
| `-L` | List all available filesystem modules and their default weights, then exit. |
| `-l <file>` | Write output to the specified log file. |
| `-n <inc>` | Scan increment: number followed by 's' (sector), 'h' (head), or 'c' (cylinder). |
| `-q` | Quiet mode. Suppress output to stdout (log file is still written if specified). |
| `-s <size>` | Manually set the sector size (disables sector size probing). |
| `-V` | Show version information. |
| `-v` | Verbose mode. Can be specified multiple times (e.g., `-vv`) for more detail. |
| `-W <device>` | Write the guessed primary partition table to the specified device or file. |
| `-w <mod,wt>` | Set the weight factor for a specific module (e.g., `ext2,1.5`). |

### Supported Filesystems/Types
* BeOS
* BtrFS
* FreeBSD/NetBSD/386BSD disklabels
* Linux Ext2
* MS-DOS FAT12, FAT16, FAT32
* IBM OS/2 HPFS
* Linux LVM and LVM2
* Linux Swap (v0 and v1)
* Minix
* MS Windows NT/2000 (NTFS)
* QNX 4.x
* ReiserFS (v3.5.X)
* Sun Solaris (Intel)
* SGI XFS

## Notes
- **Safety**: Writing a guessed partition table (`-W`) is dangerous. Always use the `-b` flag to back up the existing MBR before attempting a write.
- **Manual Recovery**: If you do not want to write the table directly, use the output of gpart to manually recreate partitions using `fdisk` or `sfdisk`.
- **Geometry**: Gpart relies on disk geometry. If the disk was moved from a controller with different geometry settings, use the `-C` flag to override.