---
name: metacam
description: Extract EXIF (Exchangeable Image File Format) information from digital camera files, including JPEG images. Supports standard EXIF fields and vendor-specific extensions for Nikon, Olympus, Canon, and Casio. Use during digital forensics, image analysis, or incident response to identify camera metadata, timestamps, and device settings.
---

# metacam

## Overview
MetaCam is a command-line utility designed to extract EXIF information from digital camera files. It supports the DCF standard and provides detailed vendor-specific metadata for major camera brands. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume metacam is already installed. If the command is missing:

```bash
sudo apt install metacam
```

## Common Workflows

### Basic metadata extraction
```bash
metacam image.jpg
```
Displays standard EXIF information such as aperture, shutter speed, and timestamp.

### Comprehensive extraction including unknown tags
```bash
metacam -v image.jpg
```
Useful when looking for non-standard or undocumented metadata fields.

### Forensic export to XML
```bash
metacam -x image.jpg > metadata.xml
```
Outputs all identified metadata in XML format for automated processing or reporting.

### Batch processing multiple images
```bash
metacam -a *.jpg
```
Displays every available tag for all JPEG files in the current directory.

## Complete Command Reference

```
metacam <options> [filename(s)...]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help message and exit |
| `-v`, `--verbose` | Display unknown tags in addition to standard tags |
| `-a`, `--all` | Display ALL tags (implies `-v`) |
| `-x`, `--xml` | Output the metadata in XML format |

## Notes
- MetaCam is particularly effective for older digital camera formats and specific vendor extensions (Nikon, Olympus, Canon, Casio).
- For modern smartphone images or complex file types, consider cross-referencing results with `exiftool` if specific tags appear missing.
- The tool handles multiple filenames passed as trailing arguments.