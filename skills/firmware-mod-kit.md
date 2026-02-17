---
name: firmware-mod-kit
description: Deconstruct and reconstruct firmware images for embedded devices, primarily Linux-based routers. Use when performing firmware analysis, reverse engineering IoT devices, modifying filesystem contents, or repacking firmware images during digital forensics and incident response.
---

# firmware-mod-kit

## Overview
The Firmware Mod Kit (FMK) is a collection of scripts and binaries designed to automate the process of extracting and rebuilding firmware images. It supports common embedded formats like TRX, uImage, and filesystems such as SquashFS and CramFS. Category: Digital Forensics / Reverse Engineering.

## Installation (if not already installed)
Assume the tool is installed. If commands are missing, install via:

```bash
sudo apt update
sudo apt install firmware-mod-kit
```

## Common Workflows

### Extracting a firmware image
To automatically detect the format and extract the filesystem and kernel:
```bash
extract-firmware.sh firmware.bin
```
This creates a directory (usually `fmk/`) containing the extracted parts.

### Modifying and rebuilding firmware
After extracting and making changes to the files in `fmk/rootfs/`:
```bash
build-firmware.sh fmk/
```
The new firmware image will be located in `fmk/new-firmware.bin`.

### Identifying firmware details
To identify the header types and offsets without full extraction:
```bash
/usr/share/firmware-mod-kit/src/binwalk/binwalk firmware.bin
```

## Complete Command Reference

The toolkit consists of several scripts located in `/usr/share/firmware-mod-kit/`.

### Primary Scripts

| Script | Description |
|--------|-------------|
| `extract-firmware.sh` | The main extraction script. Automatically identifies the firmware type and extracts the kernel and filesystem. |
| `build-firmware.sh` | The reconstruction script. Rebuilds a firmware image from a directory previously created by `extract-firmware.sh`. |

### Extraction Utilities (Internal/Manual)

| Utility | Description |
|---------|-------------|
| `unsquashfs_all.sh` | Attempts to extract SquashFS filesystems using various versions of unsquashfs to ensure compatibility. |
| `uncramfs_all.sh` | Attempts to extract CramFS filesystems. |
| `un-trx.sh` | Extracts the components of a TRX firmware image. |
| `un-tar.sh` | Extracts firmware packaged in TAR archives. |

### Rebuilding Utilities (Internal/Manual)

| Utility | Description |
|---------|-------------|
| `mksquashfs` | Creates SquashFS images (multiple versions included for compatibility). |
| `mkcramfs` | Creates CramFS images. |
| `asustrx` | Tool for creating ASUS-specific TRX headers. |
| `addpattern` | Adds specific hardware patterns/headers required by some manufacturers (e.g., Linksys). |

### Helper Tools

| Tool | Description |
|------|-------------|
| `binwalk` | Included tool for analyzing and searching binary images for known signatures. |
| `dev-info.sh` | Displays information about the device/firmware if metadata is available. |

## Notes
- **Working Directory**: By default, `extract-firmware.sh` creates a folder named `fmk` in the current working directory. If you run it multiple times, ensure you move or rename previous `fmk` directories to avoid overwriting.
- **Root Privileges**: Some filesystem extraction/repacking operations (like creating device nodes in `rootfs`) may require `sudo` to preserve correct permissions and ownership.
- **Compatibility**: While FMK is powerful, some modern encrypted or signed firmwares cannot be rebuilt into a working state without the appropriate keys.