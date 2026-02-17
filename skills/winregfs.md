---
name: winregfs
description: Mount Windows registry hive files as FUSE-based filesystems or check them for corruption. Use when performing digital forensics, incident response, or offline registry editing to access registry keys and values as ordinary files and directories using standard shell tools.
---

# winregfs

## Overview
Winregfs is a FUSE-based filesystem driver that enables accessing Windows registry hive files (like SYSTEM, SOFTWARE, SAM, etc.) as ordinary filesystems. Once mounted, registry data can be navigated and edited using standard command-line tools and scripts. It also includes a consistency checker for damaged hives. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume winregfs is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install winregfs
```

## Common Workflows

### Mounting a registry hive for inspection
```bash
mkdir /mnt/registry
mount.winregfs /path/to/SYSTEM /mnt/registry
ls -R /mnt/registry
```

### Mounting a hive in read-only mode (Forensics)
```bash
mount.winregfs -o ro /path/to/SOFTWARE /mnt/registry
```

### Checking a hive file for corruption
```bash
fsck.winregfs /path/to/SAM
```

### Unmounting the hive
```bash
fusermount -u /mnt/registry
```

## Complete Command Reference

### mount.winregfs
Mounts a Windows registry hive file to a directory.

```
Usage: mount.winregfs [-o ro] [fuse_options] hivename mountpoint
```

| Flag | Description |
|------|-------------|
| `-o ro` | Mount the filesystem in read-only mode (recommended for forensics) |
| `fuse_options` | Standard FUSE mount options (e.g., `-o allow_other`, `-o default_permissions`) |
| `hivename` | Path to the Windows registry hive file |
| `mountpoint` | Directory where the hive will be mounted |

### fsck.winregfs
Scans a Windows registry hive file for structural problems or damage.

```
Usage: fsck.winregfs [options] hivename
```

| Flag | Description |
|------|-------------|
| `-h` | Display the help message |
| `hivename` | Path to the Windows registry hive file to check |

## Notes
- **FUSE Dependency**: Requires the FUSE kernel module to be loaded.
- **Permissions**: You may need root privileges to mount filesystems or access specific hive files extracted from Windows images.
- **Editing**: While winregfs allows editing, always create a backup of the hive file before mounting in read-write mode, as registry structures are fragile.
- **Unmounting**: Use `fusermount -u <mountpoint>` to safely unmount the hive when finished.