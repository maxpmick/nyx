---
name: dfvfs
description: Access and navigate digital forensics storage media types, volume systems, and file systems through a unified virtual interface. Use when performing digital forensics, incident response, or data recovery to read-only access disk images (EWF, QCOW, VHD, VMDK), volume systems (LVM, VSS, LUKS, APFS), and file systems (NTFS, FAT, EXT, XFS) without mounting them directly to the host.
---

# dfvfs

## Overview
The Digital Forensics Virtual File System (dfVFS) provides a generic, read-only interface for accessing file-system objects across various storage media types and file formats. It acts as an abstraction layer over multiple back-ends (like SleuthKit, libewf, etc.), allowing tools to interact with complex forensic images as if they were a standard file system. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume dfvfs is already installed as a library. If you need to install it or its dependencies:

```bash
sudo apt update
sudo apt install python3-dfvfs
```

## Common Workflows

### Using dfVFS in Python Scripts
dfVFS is primarily a library used by other tools (like Plaso/log2timeline). To use it in a script to open a path:
```python
from dfvfs.helpers import volume_scanner
from dfvfs.resolver import resolver

scanner = volume_scanner.VolumeScanner()
# Scan a raw disk image for partitions
base_path_specs = scanner.GetBasePathSpecs("evidence.raw")
# Resolve a specific file within the image
file_entry = resolver.Resolver.OpenFileEntry(base_path_specs[0])
```

### Listing Files in a Forensic Image (via helper scripts)
If using tools built on dfVFS, you can typically access contents of various image formats:
```bash
# Example of a tool using dfVFS logic to list files in an E01 image
python3 list_files.py --source evidence.E01
```

### Accessing Encrypted Volumes
dfVFS supports back-ends for LUKS, BDE (BitLocker), and FVDE (FileVault). When used in scripts, it can handle credential passing to unlock these volumes for read-only analysis.

## Supported Back-ends and Formats

dfVFS provides a unified interface for the following technologies:

### Storage Media Types / Image Formats
| Format | Description |
|--------|-------------|
| **EWF** | Expert Witness Compression Format (EnCase images) |
| **QCOW** | QEMU Copy-On-Write |
| **RAW** | Raw disk images (dd) |
| **VHDI** | Virtual Hard Disk (VHD) |
| **VMDK** | VMware Virtual Disk |

### Volume Systems
| System | Description |
|--------|-------------|
| **APFS** | Apple File System Container |
| **BDE** | BitLocker Drive Encryption |
| **FVDE** | FileVault Drive Encryption |
| **LUKS** | Linux Unified Key Setup |
| **LVM** | Logical Volume Manager |
| **VSS** | Volume Shadow Snapshots |

### File Systems
| System | Description |
|--------|-------------|
| **EXT** | Extended File System (2, 3, 4) |
| **FAT** | File Allocation Table (12, 16, 32) |
| **HFS** | Hierarchical File System |
| **NTFS** | New Technology File System |
| **TSK** | The Sleuth Kit (Generic support) |
| **XFS** | XFS File System |

## Complete Command Reference
dfVFS is a Python library rather than a single standalone CLI tool. However, it provides several modules and classes used by forensic developers:

### Key Python Modules
- `dfvfs.helpers`: Contains `volume_scanner` for automated detection of partitions and file systems.
- `dfvfs.resolver`: The `Resolver` class is used to open file-system objects using "path specifications".
- `dfvfs.path`: Defines `PathSpec` objects which describe the chain of access (e.g., Image -> Partition -> File System -> File).
- `dfvfs.vfs`: Contains the virtual file system implementations for different back-ends.

### Path Specification (PathSpec)
dfVFS uses a recursive path specification system. To access a file in a ZIP inside a partition on a disk image, the PathSpec chain looks like:
`OS (Image File) -> TSK_PARTITION (Partition) -> TSK (File System) -> ZIP (Compressed Archive)`

## Notes
- **Read-Only**: dfVFS is strictly read-only to preserve forensic integrity.
- **Abstraction**: It allows developers to write code that works on a directory, a ZIP file, or a BitLocker-encrypted NTFS partition within an E01 image using the same API calls.
- **Dependencies**: Relies heavily on `libyal` libraries (libewf, libfsntfs, etc.) and `The Sleuth Kit`.