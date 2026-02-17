---
name: u-boot-tools
description: Manipulate, create, and inspect U-Boot images and bootloader components. Use when performing embedded systems analysis, firmware modification, IoT penetration testing, or preparing bootable images for ARM/MIPS/PPC devices. Includes tools for FIT images, EFI capsules, and serial booting Marvell SoCs.
---

# u-boot-tools

## Overview
A collection of utilities for working with Das U-Boot, the universal bootloader for embedded systems. These tools allow for the creation of bootable image files, extraction of components from existing images, and interaction with hardware during the boot process. Category: Exploitation / Hardware Hacking.

## Installation (if not already installed)
The tools are typically pre-installed on Kali ARM builds. On other systems:

```bash
sudo apt install u-boot-tools u-boot-qemu
```

## Common Workflows

### Inspecting a U-Boot Image
View header information, architecture, and entry points of a firmware file:
```bash
mkimage -l /path/to/uImage
```

### Extracting a Component from a Multi-File Image
Extract the second component (index 1) from a combined image:
```bash
dumpimage -T multi -p 1 -o extracted_kernel.bin firmware.img
```

### Creating a Legacy U-Boot Image
Wrap a raw binary (e.g., a Linux kernel) with a U-Boot header:
```bash
mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "MyKernel" -d zImage uImage
```

### Serial Booting a Marvell Device
Push a boot image over a serial TTY connection to a Marvell SoC:
```bash
kwboot -b u-boot.kwb -t /dev/ttyUSB0
```

## Complete Command Reference

### mkimage
Used to create or list image headers for U-Boot.

| Flag | Description |
|------|-------------|
| `-l <image>` | List image header information |
| `-T <type>` | Set image type (use `-T list` to see all) |
| `-A <arch>` | Set architecture (e.g., arm, mips, x86) |
| `-O <os>` | Set operating system (e.g., linux, freebsd) |
| `-C <comp>` | Set compression type (e.g., gzip, bzip2, none) |
| `-a <addr>` | Set load address (hex) |
| `-e <ep>` | Set entry point (hex) |
| `-n <name>` | Set image name |
| `-d <datafile>` | Use image data from file (supports multiple `:data_file`) |
| `-x` | Set XIP (Execute In Place) |
| `-f <fit-src>` | Input filename for FIT source (.its) or `auto` |
| `-F` | Re-sign an existing FIT image |
| `-i <ramdisk>` | Input filename for ramdisk file |
| `-E` | Place data outside of the FIT structure |
| `-B <size>` | Align size in hex for FIT structure and header |
| `-D <opts>` | Set options for device tree compiler |
| `-k <keydir>` | Directory containing private keys for signing |
| `-K <dtb>` | Write public keys to this .dtb file |
| `-G <key>` | Use specific signing key (instead of `-k`) |
| `-c <comment>` | Add comment in signature node |
| `-p <addr>` | Place external data at a static position |
| `-r` | Mark keys used as 'required' in dtb |
| `-N <engine>` | OpenSSL engine to use for signing |
| `-V` | Print version information |

### dumpimage
Used to extract components from U-Boot images.

| Flag | Description |
|------|-------------|
| `-l <image>` | List image header information |
| `-T <type>` | Parse image file as specific type |
| `-p <pos>` | Position (starting at 0) of the component to extract |
| `-o <outfile>` | Output filename for the extracted component |
| `-h` | Print usage information |
| `-V` | Print version information |

### kwboot
Boot Marvell SoCs (Kirkwood, Armada) over serial.

| Flag | Description |
|------|-------------|
| `-b <image>` | Boot image with preamble (Kirkwood, Armada 370/XP/38x) |
| `-D <image>` | Boot image without preamble (Dove) |
| `-b` | Enter xmodem boot mode |
| `-d` | Enter console debug mode |
| `-a` | Use timings for Armada XP |
| `-s <timeo>` | Use specific response-timeout |
| `-o <timeo>` | Use specific xmodem block timeout |
| `-t` | Open mini terminal after transfer |
| `-B <baud>` | Set baud rate |
| `<TTY>` | The serial device (e.g., `/dev/ttyUSB0`) |

### mkeficapsule
Generate EFI capsule updates.

| Flag | Description |
|------|-------------|
| `-f, --fit` | FIT image type |
| `-r, --raw` | Raw image type |
| `-g, --guid <id>` | GUID for image blob type |
| `-i, --index <idx>` | Update image index |
| `-I, --instance` | Update hardware instance |
| `-p, --private-key` | Private key file for signing |
| `-c, --certificate` | Signer's certificate file |
| `-m, --monotonic` | Monotonic count |
| `-d, --dump_sig` | Dump signature (*.p7) |

## Notes
- Use `mkimage -T list` to identify supported image types for the specific version installed.
- When using `kwboot`, ensure you have appropriate permissions for the TTY device (usually `dialout` group).
- `u-boot-qemu` provides binaries for emulating these environments: `qemu-ppce500`, `qemu-riscv64`, `qemu-x86_64`, `qemu_arm64`, etc.