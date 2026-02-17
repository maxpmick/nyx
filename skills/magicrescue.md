---
name: magicrescue
description: Scans block devices or disk images for file types by identifying "magic bytes" and extracting them using recipes. Use for digital forensics, data recovery from corrupted partitions, or undeleting files when the file system metadata is lost.
---

# magicrescue

## Overview
Magic Rescue is a file carving tool that scans block devices for known file patterns (magic bytes) and uses external programs (recipes) to extract them. It is effective for recovering data from corrupted drives or deleted partitions where traditional file system recovery fails. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is installed. If missing, use:

```bash
sudo apt install magicrescue
```

Dependencies include: `dcraw`, `flac`, `libjpeg-turbo-progs`, `mpg123`, `sqlite3`, `unzip`, `zip`.

## Common Workflows

### Basic File Recovery
Recover JPEG and PNG files from a disk image and save them to a recovery directory.
```bash
mkdir ./recovered_files
magicrescue -r jpeg-jfif -r png -d ./recovered_files /dev/sdb1
```

### Resuming a Scanned Session
Resume a previous scan starting from a specific byte offset (e.g., 1GB mark).
```bash
magicrescue -r avi -d ./output -O 1073741824 /dev/sdb1
```

### Deduplicating and Sorting Results
After recovery, use `dupemap` to remove duplicate files and `magicsort` to organize them.
```bash
# Create a database of hashes and delete duplicates in the output folder
dupemap -d hashes.db scan ./output
dupemap -d hashes.db delete ./output

# Sort files into subdirectories based on file type
magicsort ./output
```

## Complete Command Reference

### magicrescue
Scans a block device and extracts known file types.

```
magicrescue [-I FILE] [-M MODE] [-O [+-=][0x]OFFSET] [-b BLOCKSIZE] -d OUTPUT_DIR -r RECIPE1 [-r RECIPE2 [...]] DEVICE1 [DEVICE2 [...]]
```

| Flag | Description |
|------|-------------|
| `-b <BLOCKSIZE>` | Only consider files starting at a multiple of BLOCKSIZE. |
| `-d <OUTPUT_DIR>` | **Mandatory.** Output directory for found files. |
| `-r <RECIPE>` | **Mandatory.** Recipe name, file, or directory (e.g., `jpeg-exif`, `zip`). |
| `-I <FILE>` | Read input file names from this file ("-" for stdin). |
| `-M <MODE>` | Produce machine-readable output to stdout. |
| `-O <OFFSET>` | Resume from specified offset (hex or decimal) in the first device. |

**Available Recipes:** `avi`, `canon-cr2`, `elf`, `flac`, `gpl`, `gzip`, `jpeg-exif`, `jpeg-jfif`, `mbox`, `mbox-mozilla-inbox`, `mbox-mozilla-sent`, `mp3-id3v1`, `mp3-id3v2`, `msoffice`, `nikon-raw`, `perl`, `png`, `ppm`, `sqlite`, `zip`.

---

### dupemap
Creates a database of file checksums to eliminate duplicates.

```
dupemap [OPTIONS] OPERATION PATH...
```

| Flag | Description |
|------|-------------|
| `-d <DATABASE>` | Read/write from a database on disk. |
| `-I <FILE>` | Read input file names from this file ("-" for stdin). |
| `-m <MINSIZE>` | Exclude files below this size. |
| `-M <MAXSIZE>` | Exclude files above this size. |

**Operations:**
- `scan`: Scan a directory and add file hashes to the database.
- `delete`: Delete files that already exist in the database.

---

### magicsort
Categorizes files by their `file(1)` magic.

```
magicsort DIRECTORY
```

| Argument | Description |
|----------|-------------|
| `DIRECTORY` | The directory containing recovered files to be categorized. |

## Notes
- Magic Rescue does not care about the file system; it reads the raw bytes of the device.
- Ensure the `OUTPUT_DIR` is on a different partition than the one being scanned to avoid overwriting data you are trying to recover.
- You can find or create custom recipes in `/usr/share/magicrescue/recipes`.