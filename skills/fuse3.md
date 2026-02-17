---
name: fuse3
description: Interface for userspace programs to export virtual filesystems to the Linux kernel. Use when mounting specialized filesystems (like SSHFS, Rclone, or forensic images), managing user-level mounts, or unmounting FUSE-based filesystems during forensic analysis or data recovery.
---

# fuse3

## Overview
Filesystem in Userspace (FUSE) provides a secure method for non-privileged users to create and mount their own filesystem implementations. It is a critical component for many security tools that mount remote or virtual storage. Category: Digital Forensics / Information Gathering.

## Installation (if not already installed)
Assume fuse3 is already installed. If missing:

```bash
sudo apt install fuse3
```

## Common Workflows

### Unmount a FUSE filesystem
```bash
fusermount3 -u /mnt/sshfs_data
```

### Forcefully unmount a busy filesystem (Lazy unmount)
```bash
fusermount3 -uz /mnt/stuck_mount
```

### Mount using the mount helper
```bash
mount.fuse3 sshfs#user@host:/path /mnt/remote -o allow_other
```

## Complete Command Reference

### fusermount / fusermount3
Used to mount and unmount FUSE filesystems. `fusermount3` is the current version for FUSE 3.x.

**Usage:** `fusermount3 [options] mountpoint`

| Flag | Description |
|------|-------------|
| `-h` | Print help |
| `-V` | Print version |
| `-o opt[,opt...]` | Specify mount options |
| `-u` | Unmount the filesystem |
| `-q` | Quiet mode |
| `-z` | Lazy unmount (detach the filesystem now, clean up references later) |

### mount.fuse / mount.fuse3
The mount helper for FUSE filesystems, typically called by the `mount` command.

**Usage:** `mount.fuse3 type#[source] destination [-t type] [-o opt[,opts...]]`

| Argument | Description |
|----------|-------------|
| `type#` | The FUSE subtype (e.g., `sshfs`, `encfs`) |
| `source` | The source of the filesystem (optional depending on type) |
| `destination` | The mount point directory |
| `-t type` | Specify the filesystem type |
| `-o opt` | Comma-separated list of mount options (e.g., `allow_other`, `ro`, `default_permissions`) |

## Notes
- **Permissions**: By default, FUSE filesystems are only accessible to the user who mounted them. Use `-o allow_other` (if configured in `/etc/fuse.conf`) to allow other users access.
- **Version**: `fusermount3` and `mount.fuse3` are the standard binaries for modern Kali installations. The `fuse` package is a transitional package pointing to `fuse3`.
- **Forensics**: When dealing with forensic images mounted via FUSE, always use the `-u` flag to safely detach before removing the underlying image file.