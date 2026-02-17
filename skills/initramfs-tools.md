---
name: initramfs-tools
description: Manage, create, update, and extract Linux initramfs (initial RAM filesystem) images. Use when modifying boot processes, adding kernel modules, troubleshooting boot failures, or performing forensics on boot images during system administration or post-exploitation.
---

# initramfs-tools

## Overview
A collection of tools used to build and manage a bootable initramfs for Linux kernel packages. The initramfs is responsible for mounting the root filesystem and starting the main init system. Category: System Administration / Post-Exploitation.

## Installation (if not already installed)
Assume the tools are already installed as they are core Kali components. If missing:

```bash
sudo apt install initramfs-tools initramfs-tools-core
```

## Common Workflows

### Update the initramfs for the current kernel
```bash
sudo update-initramfs -u
```

### Create a new initramfs for all installed kernels
```bash
sudo update-initramfs -c -k all
```

### List files inside an initramfs image
```bash
lsinitramfs -l /boot/initrd.img-$(uname -r)
```

### Extract an initramfs for analysis
```bash
mkdir extracted_initramfs
unmkinitramfs /boot/initrd.img-$(uname -r) extracted_initramfs/
```

## Complete Command Reference

### update-initramfs
High-level tool to manage initramfs images in `/boot`.

**Usage:** `update-initramfs {-c|-d|-u} [-k version] [-v] [-b directory]`

| Flag | Description |
|------|-------------|
| `-k <version>` | Specify kernel version or 'all' |
| `-c` | Create a new initramfs |
| `-u` | Update an existing initramfs |
| `-d` | Remove an existing initramfs |
| `-b <directory>` | Set alternate boot directory (default is /boot) |
| `-v` | Be verbose |

### mkinitramfs
Low-level tool for generating an initramfs image.

**Usage:** `mkinitramfs [option]... -o outfile [version]`

| Flag | Description |
|------|-------------|
| `-c <compress>` | Override COMPRESS setting in initramfs.conf (e.g., gzip, bzip2, lzma, xz) |
| `-d <confdir>` | Specify an alternative configuration directory |
| `-l <level>` | Override COMPRESSLEVEL setting in initramfs.conf |
| `-k` | Keep temporary directory used to make the image |
| `-o <outfile>` | Write the resulting image to outfile |
| `-r <root>` | Override ROOT setting in initramfs.conf |

### lsinitramfs
List content of an initramfs image.

**Usage:** `lsinitramfs [-l] initramfs-file...`

| Flag | Description |
|------|-------------|
| `-l` | Display long and more verbose listing of initramfs content |

### unmkinitramfs
Extract content from an initramfs image.

**Usage:** `unmkinitramfs [-v] initramfs-file directory`

| Flag | Description |
|------|-------------|
| `-v` | Display verbose messages about extraction |

## Notes
- Most operations involving `update-initramfs` require root privileges (`sudo`).
- Modifying initramfs incorrectly can lead to an unbootable system. Always keep a backup of the original image.
- `unmkinitramfs` is particularly useful for security researchers to inspect boot-time scripts and included binaries/modules.