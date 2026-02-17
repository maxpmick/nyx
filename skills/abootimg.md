---
name: abootimg
description: Manipulate Android Boot Images including extracting, updating, and creating images containing kernels, ramdisks, and second-stage bootloaders. Use when performing Android firmware analysis, custom ROM development, kernel modification, or porting operating systems to Android hardware.
---

# abootimg

## Overview
abootimg is a tool designed to manipulate Android Boot Images. Unlike the original Android `mkbootimg`, which can only create images, `abootimg` can extract and modify existing ones. These images typically contain a kernel, ramdisk, and boot configuration. Category: Digital Forensics / Reverse Engineering.

## Installation (if not already installed)
Assume abootimg is already installed. If you get a "command not found" error:

```bash
sudo apt install abootimg
```

## Common Workflows

### Inspect a boot image
```bash
abootimg -i boot.img
```

### Extract components from a boot image
```bash
abootimg -x boot.img
```
This extracts `bootimg.cfg`, `zImage` (kernel), and `initrd.img` (ramdisk) to the current directory.

### Update an existing boot image with a new kernel
```bash
abootimg -u boot.img -k new_zImage
```

### Create a new boot image from scratch
```bash
abootimg --create custom_boot.img -f bootimg.cfg -k zImage -r initrd.img
```

## Complete Command Reference

### Primary Commands

| Flag | Description |
|------|-------------|
| `-h` | Print usage information |
| `-i <bootimg>` | Print boot image information/metadata |
| `-x <bootimg> [<cfg> [<kernel> [<ramdisk> [<stage2>]]]]` | Extract objects from boot image. Defaults: `bootimg.cfg`, `zImage`, `initrd.img`, `stage2.img` |
| `-u <bootimg> [options]` | Update an existing valid Android Boot Image |
| `--create <bootimg> [options]` | Create a new image from scratch. Kernel and ramdisk are mandatory |

### Update and Create Options

These options are used with `-u` or `--create`:

| Option | Description |
|--------|-------------|
| `-c "param=value"` | Specify header information parameters directly (can be used multiple times) |
| `-f <bootimg.cfg>` | Specify a configuration file for header information |
| `-k <kernel>` | Specify the kernel image file |
| `-r <ramdisk>` | Specify the ramdisk image file |
| `-s <secondstage>` | Specify the second stage bootloader image file |

### Helper Utilities

| Utility | Description |
|---------|-------------|
| `abootimg-pack-initrd` | Pack a directory back into a ramdisk/initrd image |
| `abootimg-unpack-initrd` | Unpack a ramdisk/initrd image into a directory structure |

## Notes
- When using `--create` on a block device, the tool performs sanity checks to prevent accidental overwriting of existing filesystems.
- The configuration file (`bootimg.cfg`) contains critical metadata such as kernel command line arguments, page size, and base addresses.
- `abootimg` is specifically useful for ARM-based Android devices when bringing alternative operating systems to the hardware.