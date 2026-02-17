---
name: forensics-colorize
description: Visually compare large files or filesystem images by creating color graphics that represent differences. Use during digital forensics, incident response, or malware analysis to quickly identify changes between binary files, disk images, or large text files where traditional diff tools are impractical.
---

# forensics-colorize

## Overview
A set of tools designed to visually compare large files by generating graphical representations of their differences. It provides an intuitive sense of the percentage and location of changes, making it superior to standard diff for binary data and massive datasets. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume the tool is already installed. If the commands are missing:

```bash
sudo apt update && sudo apt install forensics-colorize
```

## Common Workflows

### Visualizing differences between two disk images
First, generate the comparison data, then render the image:
```bash
filecompare image1.dd image2.dd > comparison.dat
colorize -w 200 comparison.dat
```
This creates an image (default `out.bmp`) with a width of 200 pixels representing the differences.

### Comparing files with a specific block size
To increase granularity or handle extremely large files, adjust the block size:
```bash
filecompare -b 4k original.bin modified.bin > changes.dat
colorize -o -d changes.dat
```
This uses 4KB blocks and changes the orientation and data flow of the resulting graphic.

## Complete Command Reference

The package consists of two primary utilities: `filecompare` (to generate the difference map) and `colorize` (to render the map into a graphic).

### filecompare
Used to create the auxiliary input file for the colorize command by comparing two files.

```
Usage: filecompare [-b size[bkmgpe]] [-Vh] FILE1 FILE2
```

| Flag | Description |
|------|-------------|
| `-b <size>[suffix]` | Set block size. Suffixes: `b` (bytes), `k` (KB), `m` (MB), `g` (GB), `p` (PB), `e` (EB). Note: Outputs at least one complete block. |
| `-t` | Use transitional colors instead of the default red or green. |
| `-V` | Display version number and exit. |
| `-h` | Display help message. |

### colorize
Generates the intuitive graphic from the data produced by `filecompare`.

```
Usage: colorize [-h|-V] [-w <num>] [-ovd] FILES
```

| Flag | Description |
|------|-------------|
| `-d` | Change direction data flows (defaults to down or right). |
| `-o` | Change image orientation (defaults to vertical). |
| `-v` | Enable verbose mode. |
| `-w <num>` | Set output image width (defaults to 100). |
| `-V` | Display version number and exit. |
| `-h` | Display help message and exit. |

## Notes
- `filecompare` outputs raw data to stdout; you should redirect this to a file to be consumed by `colorize`.
- Ensure you have sufficient disk space when using small block sizes on very large files, as the intermediate comparison file can grow significantly.
- The output of `colorize` is typically a BMP image named `out.bmp`.