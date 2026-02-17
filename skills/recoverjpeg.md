---
name: recoverjpeg
description: Recover JFIF (JPEG) pictures and MOV movies from filesystem images or raw devices using data carving. Use when performing digital forensics, incident response, or data recovery to retrieve deleted or lost media from corrupted partitions, memory cards, or disk images.
---

# recoverjpeg

## Overview
A suite of data carving tools designed to recover JPEG images and MOV videos from raw data streams. It ignores filesystem metadata and searches for file headers and structures directly. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install recoverjpeg
```

## Common Workflows

### Recover JPEGs from a disk image
```bash
recoverjpeg -o ./recovered_images /dev/sdb1
```

### Recover MOV videos with custom naming
```bash
recovermov -n vacation_video -o ./recovered_movies /dev/sdc1
```

### Clean up and organize recovered photos
```bash
# Remove duplicate files in the current directory
remove-duplicates -f

# Sort pictures into date-based directories using EXIF data
sort-pictures
```

### Advanced JPEG recovery with specific block size
```bash
recoverjpeg -b 4096 -m 10m -s 50000 image.dd
```

## Complete Command Reference

### recoverjpeg
Recover JPEG pictures from a filesystem image or device.

| Flag | Description |
|------|-------------|
| `-b <blocksize>` | Block size in bytes (default: 512) |
| `-d <format>` | Directory format string in printf syntax |
| `-f <format>` | File format string in printf syntax |
| `-h` | Display help message |
| `-i <index>` | Initial picture index |
| `-m <maxsize>` | Max jpeg file size in bytes (default: 6m) |
| `-o <directory>` | Restore jpeg files into this directory |
| `-q` | Quiet mode |
| `-r <readsize>` | Size of disk reads in bytes (default: 128m) |
| `-s <cutoff>` | Minimal file size in bytes to restore |
| `-S <skipsize>` | Size to skip at the beginning of the file/device |
| `-v` | Verbose mode |
| `-V` | Display version and exit |

### recovermov
Recover MOV movies from a filesystem image or device.

| Flag | Description |
|------|-------------|
| `-b <blocksize>` | Block size in bytes (default: 512) |
| `-n <base_name>` | Basename of the mov files to create (default: "video_") |
| `-h` | Display help message |
| `-i <index>` | Initial movie index |
| `-o <directory>` | Restore mov files into this directory |
| `-V` | Display version and exit |

### remove-duplicates
Remove duplicate files in the current directory.

| Flag | Description |
|------|-------------|
| `-f` | Actually remove the files. If omitted, duplicates are only identified. |

### sort-pictures
Sorts recovered pictures into subdirectories based on EXIF tags. It creates hard links to organize files into:
- `invalid`: Invalid JFIF files.
- `small`: Files smaller than 100,000 bytes.
- `undated`: Files where EXIF date could not be determined.
- `YYYY-MM-DD`: Directories named by the date the picture was taken.

## Notes
- `sort-pictures` specifically looks for files matching the template `image?????*.jpg`.
- These tools are "carvers" and do not require a functional filesystem to work; they work on raw bytes.
- Ensure the output directory has enough space to hold all potentially recovered data.