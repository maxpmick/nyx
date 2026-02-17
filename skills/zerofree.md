---
name: zerofree
description: Zero out unallocated blocks in ext2, ext3, and ext4 filesystems to reduce disk image size or securely wipe deleted data. Use when preparing virtual machine disk images for compression/shrinkage or when performing post-exploitation cleanup and forensic sanitization of free space.
---

# zerofree

## Overview
Zerofree finds unallocated blocks with non-zero content in ext2, ext3, or ext4 filesystems and fills them with zeroes (or a custom value). It is significantly faster and more efficient than using `dd` to fill free space because it does not cause the disk image to grow to its maximum size during the process. Category: Digital Forensics / System Maintenance.

## Installation (if not already installed)
Assume zerofree is already installed. If you get a "command not found" error:

```bash
sudo apt install zerofree
```

## Common Workflows

### Prepare a VM disk for shrinking
The filesystem must be unmounted or mounted read-only. If it is the root partition, remount it read-only first.
```bash
# Remount root as read-only
mount -n -o remount,ro /dev/sda1
# Run zerofree
zerofree -v /dev/sda1
```

### Dry run to see what would be zeroed
Use the `-n` flag to perform a non-destructive test.
```bash
zerofree -n -v /dev/sdb1
```

### Fill free space with a specific byte value
Useful for specific forensic wiping patterns or testing.
```bash
zerofree -f 0xFF /dev/sdb1
```

## Complete Command Reference

```
zerofree [-n] [-v] [-f fillval] filesystem
```

### Options

| Flag | Description |
|------|-------------|
| `-n` | **Dry run**: Check the filesystem and describe what would be done without actually modifying the disk. |
| `-v` | **Verbose**: Show progress and statistics during the operation. |
| `-f <fillval>` | **Fill value**: Use a value other than zero to fill the free blocks. The value can be specified in decimal or hex (e.g., `255` or `0xFF`). |
| `filesystem` | The path to the device or partition to process (e.g., `/dev/sdb1`). |

## Notes
- **Requirement**: The target filesystem **must** be unmounted or mounted read-only. Running zerofree on a filesystem mounted read-write will likely cause filesystem corruption.
- **Virtual Machines**: This tool is primarily intended for guest OS disk images (VirtualBox, VMware, QEMU/KVM). After running zerofree, you must run the hypervisor's specific disk compaction tool (e.g., `VBoxManage modifyhd --compact` or `qemu-img convert`) to actually reduce the host file size.
- **Forensics**: While not a multi-pass wiper, it is more effective than `rm` for ensuring deleted data in unallocated blocks is overwritten.