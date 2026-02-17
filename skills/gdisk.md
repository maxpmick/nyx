---
name: gdisk
description: A family of text-mode tools (gdisk, cgdisk, sgdisk, fixparts) for creating and manipulating GUID Partition Table (GPT) and Master Boot Record (MBR) disks. Use when performing disk partitioning, converting MBR to GPT, repairing damaged partition tables, or creating hybrid MBR layouts during system imaging, forensics, or OS installation.
---

# gdisk

## Overview
GPT fdisk (gdisk) is a suite of utilities for managing Globally Unique Identifier (GUID) Partition Tables. It includes `gdisk` (interactive), `cgdisk` (curses-based), `sgdisk` (command-line/scriptable), and `fixparts` (MBR repair). It supports in-place conversion between MBR and GPT, partition table backups, and repair of damaged structures. Category: Digital Forensics / System Administration.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install gdisk
```

## Common Workflows

### Interactive Partitioning (Curses)
```bash
sudo cgdisk /dev/sdb
```
Provides a visual menu to create, delete, and manage GPT partitions.

### Scripted Partition Creation
```bash
sudo sgdisk -n 1:2048:4096 -t 1:8300 -c 1:"LinuxData" /dev/sdb
```
Creates partition 1 starting at sector 2048, ending at 4096, type 8300 (Linux), named "LinuxData".

### MBR to GPT Conversion
```bash
sudo sgdisk -g /dev/sdc
```
Converts an MBR disk to GPT format non-interactively.

### Wipe Partition Data (Zap)
```bash
sudo sgdisk -Z /dev/sdb
```
Destroys both GPT and MBR data structures (use with extreme caution).

## Complete Command Reference

### cgdisk (Curses-based)
`cgdisk [ -a ] device`

| Option | Description |
|--------|-------------|
| `-a` | Use ">" symbol instead of ncurses highlighting for limited displays. |

**Interactive Options:**
- **Align**: Change sector alignment (default 1 MiB/2048 sectors).
- **Backup**: Save in-memory partition table to a binary file.
- **Delete**: Remove a partition entry.
- **Info**: Show detailed GUIDs and sector-exact start/end points.
- **Load**: Restore partition data from a backup file.
- **naMe**: Change the UTF-16 GPT partition name.
- **New**: Create partition (supports `+size{K,M,G,T,P}` notation).
- **Quit**: Exit without saving changes.
- **Type**: Change type code (Hex or GUID). Press `L` for list.
- **Verify**: Check for CRCs and mismatched headers.
- **Write**: Commit changes to disk.

### sgdisk (Command-line)
`sgdisk [OPTION...] <device>`

| Flag | Description |
|------|-------------|
| `-A, --attributes=...` | Operate on partition attributes (show\|or\|nand\|xor\|=\|set\|clear\|toggle\|get). |
| `-a, --set-alignment=val` | Set sector alignment. |
| `-b, --backup=file` | Backup GPT to file. |
| `-B, --byte-swap-name=num` | Byte-swap partition's name. |
| `-c, --change-name=n:name` | Change partition's name. |
| `-C, --recompute-chs` | Recompute CHS values in protective/hybrid MBR. |
| `-d, --delete=partnum` | Delete a partition. |
| `-D, --display-alignment` | Show number of sectors per allocation block. |
| `-e, --move-second-header` | Move backup header to end of disk. |
| `-E, --end-of-largest` | Show end of largest free block. |
| `-f, --first-in-largest` | Show start of the largest free block. |
| `-F, --first-aligned...` | Show start of the largest free block, aligned. |
| `-g, --mbrtogpt` | Convert MBR to GPT. |
| `-G, --randomize-guids` | Randomize disk and partition GUIDs. |
| `-h, --hybrid=...` | Create hybrid MBR. |
| `-i, --info=partnum` | Show detailed information on partition. |
| `-I, --align-end` | Align partition end points. |
| `-j, --move-main-table=s` | Change start sector of main partition table. |
| `-k, --move-backup-table=s`| Change start sector of backup partition table. |
| `-l, --load-backup=file` | Load GPT backup from file. |
| `-L, --list-types` | List known partition types. |
| `-m, --gpttombr=...` | Convert GPT to MBR. |
| `-n, --new=num:start:end` | Create new partition. |
| `-N, --largest-new=num` | Create largest possible new partition. |
| `-o, --clear` | Clear partition table. |
| `-O, --print-mbr` | Print MBR partition table. |
| `-p, --print` | Print partition table. |
| `-P, --pretend` | Make changes in memory only. |
| `-r, --transpose=n1:n2` | Transpose two partitions. |
| `-R, --replicate=dev` | Replicate partition table from another device. |
| `-s, --sort` | Sort partition table entries. |
| `-S, --resize-table=num` | Resize partition table (number of partitions). |
| `-t, --typecode=n:code` | Change partition type code. |
| `-T, --transform-bsd=n` | Transform BSD disklabel partition to GPT. |
| `-u, --partition-guid=n:g`| Set partition GUID. |
| `-U, --disk-guid=guid` | Set disk GUID. |
| `-v, --verify` | Check partition table integrity. |
| `-z, --zap` | Destroy GPT data structures. |
| `-Z, --zap-all` | Destroy GPT and MBR data structures. |

### fixparts (MBR Repair)
`fixparts device`

**Interactive Commands:**
- `a`: Toggle active/boot flag.
- `c`: Recompute CHS values.
- `l`: Change partition status to logical.
- `o`: Omit a partition (removes it upon writing).
- `p`: Display basic partition summary.
- `q`: Quit without saving.
- `r`: Change partition status to primary.
- `s`: Sort partition entries.
- `t`: Change MBR type code (1-byte hex).
- `w`: Write changes and exit.
- `?`: Print help menu.

## Notes
- **Data Safety**: Changes are kept in memory until the `w` (Write) command is issued (except for `fixparts`' initial offer to wipe stray GPT data).
- **Bootability**: Converting MBR to GPT may make a system unbootable if the OS or BIOS does not support UEFI/GPT.
- **FreeBSD**: If writing fails, use `sysctl kern.geom.debugflags=16`.
- **Hybrid MBR**: Use `gdisk` or `sgdisk -h` to create hybrid layouts for compatibility with GPT-unaware OSes (e.g., older Windows).