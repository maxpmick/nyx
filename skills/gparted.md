---
name: gparted
description: Create, reorganize, and delete disk partitions using the GNOME Partition Editor. Use when performing digital forensics, disk imaging preparation, incident response, or managing storage devices to resize, move, or label partitions while preserving data.
---

# gparted

## Overview
GParted (GNOME Partition Editor) is a graphical utility for manipulating disk partitions. It uses libparted to detect and manipulate devices and partition tables, supporting tasks like creating partition tables, enabling flags (boot/hidden), and performing partition operations (create, delete, resize, move, check, label, copy, and paste). Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume GParted is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install gparted
```

## Common Workflows

### Launch GParted for all detected devices
```bash
sudo gparted
```

### Open GParted for specific disk devices
```bash
sudo gparted /dev/sda /dev/sdb
```

### Prepare a drive for forensics imaging
Use GParted to identify partition boundaries, check for unallocated space, or label partitions before creating bit-stream images.

## Complete Command Reference

```
gparted [device]...
```

### Arguments

| Argument | Description |
|----------|-------------|
| `[device]...` | Optional path to one or more disk devices (e.g., `/dev/sda`, `/dev/nvme0n1`) to open specifically within the editor. |

### Supported Operations (GUI-based)
While the command line is used to launch the tool, the following operations are performed within the application:
- **Partition Table**: Create new partition tables (MS-DOS, GPT, etc.).
- **Flags**: Enable/disable partition flags such as `boot`, `hidden`, `raid`, `lvm`, and `esp`.
- **Partition Actions**: 
    - Create and Delete partitions.
    - Resize and Move partitions.
    - Check and Repair filesystems.
    - Label partitions (change Volume Label).
    - Copy and Paste partitions (cloning data to different sectors or drives).

## Notes
- **Data Safety**: Editing partitions has the potential to cause **LOSS OF DATA**. Always backup data before use.
- **Root Privileges**: GParted requires root privileges to access block devices. It is typically invoked via `pkexec` or `sudo`.
- **Avoid External Mounting**: To reduce the risk of data loss, do not mount or unmount partitions using other tools or the command line while GParted is running.
- **Dependencies**: GParted relies on various filesystem-specific tools (e.g., `ntfsprogs`, `e2fsprogs`) to support different formats. If a specific filesystem option is greyed out, the corresponding CLI utility may be missing.