---
name: xmount
description: Convert on-the-fly between multiple disk image formats using FUSE to create a virtual representation. Use when performing digital forensics, incident response, or malware analysis to mount EWF (E01), AFF, or RAW images as virtual VDI, VMDK, or VHD files for booting in virtual machines or analysis without altering the original evidence.
---

# xmount

## Overview
xmount creates a virtual file system using FUSE that contains a virtual representation of an input disk image. It supports on-the-fly conversion between formats and provides virtual write access via cache files, allowing forensic images to be booted in hypervisors like VirtualBox, VMware, or QEMU without modifying the source. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume xmount is already installed. If not:
```bash
sudo apt install xmount
```

## Common Workflows

### Mount an E01 image as a virtual RAW (DD) image
```bash
mkdir /mnt/vimage
xmount --in ewf /path/to/image.E01 /mnt/vimage
```
The virtual RAW image will be available at `/mnt/vimage/xmount.dd`.

### Mount an E01 for booting in VirtualBox (VDI format) with write cache
```bash
xmount --cache /tmp/image.cache --in ewf /path/to/image.E01 --out vdi /mnt/vbox_image
```
This creates a `.vdi` file in the mount point. Changes made by the VM are stored in `image.cache`.

### Combine multiple RAW split images into one virtual VMDK
```bash
xmount --in raw image.dd.001 --in raw image.dd.002 --out vmdk /mnt/vmdk_mount
```

### Extract unallocated space from a FAT image
```bash
xmount --in raw image.dd --morph unallocated --morphopts unallocated_fs=fat /mnt/unallocated_space
```

## Complete Command Reference

```bash
xmount [fopts] <xopts> <mntp>
```

### FUSE Options (fopts)
| Flag | Description |
|------|-------------|
| `-d` | Enable FUSE's and xmount's debug mode |
| `-h` | Display help message |
| `-s` | Run single threaded |
| `-o no_allow_other` | Disable automatic addition of FUSE's `allow_other` option |
| `-o <fopts>` | Specify custom FUSE mount options (disables `allow_other` automatically) |

### xmount Options (xopts)
| Flag | Description |
|------|-------------|
| `--cache <cfile>` | Enable virtual write support using `<cfile>` as the cache |
| `--owcache <cfile>` | Same as `--cache` but overwrites existing cache file |
| `--rocache <cfile>` | Same as `--cache` but does **not** allow further writes (read-only cache) |
| `--in <itype> <ifile>` | Input format and source file. Can be specified multiple times for morphing |
| `--inopts <iopts>` | Comma separated list of `key=value` input library options |
| `--info` / `--version` | Print info about compiler, libraries, and version |
| `--morph <mtype>` | Morphing function: `combine` (default), `raid0`, `unallocated` |
| `--morphopts <mopts>` | Comma separated list of `key=value` morphing library options |
| `--offset <off>` | Move output image data start `<off>` bytes into the input |
| `--out <otype>` | Output format: `raw` (default), `dmg`, `vdi`, `vhd`, `vmdk`, `vmdks` |
| `--sizelimit <size>` | Limit output data to `<size>` bytes after the data start |

### Supported Input Types (`itype`)
`aewf`, `vdi`, `aaff`, `ewf`, `qcow`, `qcow2`, `qemu`, `aff`, `aff3`, `raw`, `dd`.

### Library Specific Options

#### libxmount_input_aewf.so (EWF/E01)
- `aewfmaxmem`: Max RAM cache (MiB) for offset tables. Default: 10.
- `aewfmaxfiles`: Max concurrently opened segment files. Default: 10.
- `aewfstats`: Directory path to output statistics.
- `aewfrefresh`: Stats update interval in seconds. Default: 10.
- `aewflog`: Path for writing log file.
- `aewfthreads`: Max threads for decompression. Default: System CPUs.

#### libxmount_input_vdi.so
- `vdilog`: Path for writing log file.

#### libxmount_input_aaff.so (AFF - Deprecated)
- `aaffmaxmem`: Max RAM cache (MiB) for seek offsets. Default: 10.
- `aafflog`: Full path for log file.

#### libxmount_morphing_raid.so
- `raid_chunksize`: Chunk size in bytes. Default: 524288 (512k).

#### libxmount_morphing_unallocated.so
- `unallocated_fs`: Filesystem to extract blocks from (`hfs`, `fat`). Default: autodetect.

## Notes
- **Permissions**: For VMDK emulation, you must uncomment `user_allow_other` in `/etc/fuse.conf` or run xmount as root.
- **Split Images**: If an image is split (e.g., .E01, .E02), you must specify every file using multiple `--in` flags.
- **Mount Point**: The mount point must exist before running the command.