---
name: scrounge-ntfs
description: Recover data from corrupted NTFS filesystems by reading disk blocks and rebuilding the original directory tree. Use when performing digital forensics, data recovery, or incident response to retrieve files from damaged or inaccessible NTFS partitions.
---

# scrounge-ntfs

## Overview
Scrounge NTFS is a data recovery tool designed to retrieve files from corrupted NTFS partitions. It works by scanning the raw disk blocks and attempting to reconstruct the original filesystem structure into a specified output directory. Category: Digital Forensics / Data Recovery.

## Installation (if not already installed)
Assume scrounge-ntfs is already installed. If the command is missing:

```bash
sudo apt install scrounge-ntfs
```

## Common Workflows

### List partition information
Identify the layout of the drive to find potential NTFS partitions.
```bash
scrounge-ntfs -l /dev/sdb
```

### Search for NTFS partitions
Scan the drive for signatures of NTFS partitions to determine start and end sectors.
```bash
scrounge-ntfs -s /dev/sdb
```

### Recover data from a specific range
Extract files from a partition starting at sector 63 and ending at sector 204800, saving results to a recovery folder.
```bash
mkdir ./recovery
scrounge-ntfs -o ./recovery /dev/sdb 63 204800
```

### Advanced recovery with MFT offset
Specify a known Master File Table (MFT) offset and custom cluster size (e.g., 4 sectors) for a more precise recovery.
```bash
scrounge-ntfs -m 16384 -c 4 -o ./recovery /dev/sdb 2048 409600
```

## Complete Command Reference

### List Partitions
```bash
scrounge-ntfs -l disk
```
*   `-l`: List all drive partition information.
*   `disk`: The raw disk device (e.g., `/dev/sda`).

### Search for Partitions
```bash
scrounge-ntfs -s disk
```
*   `-s`: Search drive for NTFS partitions. Useful when the partition table is wiped or corrupted.

### Scrounge/Recover Data
```bash
scrounge-ntfs [-m mftoffset] [-c clustersize] [-o outdir] disk start end
```

| Flag | Description |
|------|-------------|
| `-m mftoffset` | Offset to the Master File Table (MFT) in sectors. |
| `-c clustersize` | Cluster size in sectors (default is 8). |
| `-o outdir` | Directory where the recovered files and directory tree will be placed. |
| `disk` | The raw disk device or partition image (e.g., `/dev/hda`, `/dev/sdb`). |
| `start` | The first sector of the NTFS partition. |
| `end` | The last sector of the NTFS partition. |

## Notes
- This tool requires raw access to the disk device; typically requires `root` or `sudo` privileges.
- The output directory (`-o`) should be on a different physical disk or partition than the one being recovered to prevent data overwriting.
- If the cluster size is unknown, the default of 8 is a common standard for many NTFS volumes, but it may vary based on the volume size.