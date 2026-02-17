---
name: parted
description: Create, destroy, resize, move, and copy disk partitions and partition tables. Use when performing disk forensics, preparing storage media, resizing volumes, or managing partition layouts on various disk label types (GPT, MS-DOS, etc.) during incident response or system setup.
---

# parted

## Overview
GNU Parted is a comprehensive disk partition manipulation tool. It supports multiple partitioning formats including DOS, Mac, Sun, BSD, GPT, MIPS, and PC98, as well as "loop" (raw disk) types for RAID/LVM. It can detect a wide variety of filesystems including ext2/3/4, FAT16/32, HFS, Btrfs, and XFS. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Parted is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install parted
```

## Common Workflows

### List all partition layouts
```bash
parted -l
```

### Create a new GPT partition table
```bash
parted /dev/sdb mklabel gpt
```

### Create a new primary partition
```bash
parted /dev/sdb mkpart primary ext4 1MiB 100%
```
Note: Using `1MiB` as a start point ensures proper alignment on most modern disks.

### Resize an existing partition
```bash
parted /dev/sdb resizepart 1 2GB
```
Changes the end point of partition 1 to the 2GB mark.

### Inform OS of partition changes
```bash
partprobe /dev/sdb
```

## Complete Command Reference

### parted Options
```
parted [OPTION]... [DEVICE [COMMAND [PARAMETERS]...]...]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help message |
| `-l`, `--list` | Lists partition layout on all block devices |
| `-m`, `--machine` | Displays machine parseable output |
| `-j`, `--json` | Displays JSON output |
| `-s`, `--script` | Never prompts for user intervention |
| `-f`, `--fix` | In script mode, fix instead of abort when asked |
| `-v`, `--version` | Displays the version |
| `-a, --align=[none\|cyl\|min\|opt]` | Alignment for new partitions |

### parted Commands

| Command | Description |
|---------|-------------|
| `align-check TYPE N` | Check partition N for TYPE (min\|opt) alignment |
| `help [COMMAND]` | Print general help, or help on COMMAND |
| `mklabel, mktable LABEL-TYPE` | Create a new disklabel (partition table) |
| `mkpart PART-TYPE [FS-TYPE] START END` | Make a partition |
| `name NUMBER NAME` | Name partition NUMBER as NAME (GPT/Mac/PC98 only) |
| `print [devices\|free\|list,all]` | Display partition table, available devices, free space, or all partitions |
| `quit` | Exit program |
| `rescue START END` | Rescue a lost partition near START and END |
| `resizepart NUMBER END` | Resize partition NUMBER by moving its END point |
| `rm NUMBER` | Delete partition NUMBER |
| `select DEVICE` | Choose the device to edit |
| `disk_set FLAG STATE` | Change the FLAG on selected device |
| `disk_toggle [FLAG]` | Toggle the state of FLAG on selected device |
| `set NUMBER FLAG STATE` | Change the FLAG on partition NUMBER |
| `toggle [NUMBER [FLAG]]` | Toggle the state of FLAG on partition NUMBER |
| `type NUMBER TYPE-ID or TYPE-UUID` | Set TYPE-ID or TYPE-UUID of partition NUMBER |
| `unit UNIT` | Set the default unit to UNIT (e.g., KB, MB, GB, TB, s, byte, %, cyl, chs, compact) |
| `version` | Display version and copyright information |

### partprobe Options
Informs the operating system of partition table changes without rebooting.
```
partprobe [OPTION] [DEVICE]...
```

| Flag | Description |
|------|-------------|
| `-d`, `--dry-run` | Do not actually inform the operating system |
| `-s`, `--summary` | Print a summary of contents |
| `-h`, `--help` | Display help and exit |
| `-v`, `--version` | Output version information and exit |

## Notes
- **Data Safety**: Partition manipulation is inherently dangerous. Always back up data before modifying partition tables.
- **Scripting**: Use the `-s` or `--script` flag when calling `parted` from scripts to avoid interactive prompts.
- **Alignment**: For optimal performance on SSDs and Advanced Format drives, use `--align opt`.
- **Filesystem Operations**: While `parted` can detect many filesystems, using it to perform filesystem-level operations (like creating filesystems) is deprecated; use `mkfs` tools instead.