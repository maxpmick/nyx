---
name: exiflooter
description: Extract geolocation metadata from images via URLs, files, or directories and optionally integrate with OpenStreetMap. Use when performing digital forensics, OSINT, or information gathering to identify the physical location where a photo was taken or to sanitize images by removing metadata.
---

# exiflooter

## Overview
ExifLooter is a tool designed to find and display GeoLocation metadata from images. It supports analyzing individual images, entire directories, or piped input from other tools. It can also generate OpenStreetMap links based on discovered coordinates and remove metadata for privacy. Category: Digital Forensics / Information Gathering.

## Installation (if not already installed)
Assume exiflooter is already installed. If you get a "command not found" error:

```bash
sudo apt install exiflooter
```

Dependencies: `libc6`, `libimage-exiftool-perl`.

## Common Workflows

### Analyze a single image for location data
```bash
exiflooter -i photo.jpg
```

### Scan a directory and generate OpenStreetMap links
```bash
exiflooter -d ./images/ -m
```

### Remove metadata from an image
```bash
exiflooter -i private.png --remove
```

### Pipe URLs from another tool
```bash
cat image_urls.txt | exiflooter -p
```

## Complete Command Reference

```
exifLooter [flags]
```

### Flags

| Flag | Description |
|------|-------------|
| `-d`, `--directory string` | Specify a directory for analyzing all images within |
| `-h`, `--help` | Help for exifLooter |
| `-i`, `--image string` | Specify a specific image file for analyzing |
| `-m`, `--open-street-map` | Get an Open Street Map link based on the extracted coordinates |
| `-p`, `--pipe` | Enable piping mode to work with other scripts/input |
| `-r`, `--remove` | Remove all metadata from the specified image |

## Notes
- This tool relies on `exiftool` (libimage-exiftool-perl) for the underlying metadata extraction.
- When using the `-p` (pipe) flag, ensure the input consists of valid paths or URLs that the tool can resolve.
- Removing metadata with `-r` is destructive; ensure you have backups if you need to preserve the original file's information.