---
name: exifprobe
description: Read and analyze metadata and structure from digital camera image files, including RAW formats (CR2, NEF, DNG, etc.), TIFF, and JPEG. Use when performing digital forensics, image analysis, metadata extraction, or investigating camera-specific MakerNotes and hidden image data.
---

# exifprobe

## Overview
Exifprobe is a command-line utility that probes and reports the structure and metadata content of camera image files. It supports standard formats like JPEG and TIFF, as well as numerous "raw" formats (MRW, CIFF/CRW, JP2, RAF, X3F, DNG, ORF, CR2, NEF, K25, KDC, DCR, and PEF). It is particularly effective for deep inspection of IFD (Image File Directory) structures and MakerNotes. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install exifprobe
```

## Common Workflows

### Standard Structural Analysis
View the complete structure of an image file, including offsets and hex values.
```bash
exifprobe image.jpg
```

### Concise Metadata Report
Get a clean, indented report of tagnames and decimal values only.
```bash
exifprobe -R image.cr2
```

### List All Tags and Values
Extract a flat list of all metadata tags and their values without structural overhead.
```bash
exifprobe -L image.nef
```

### Filtering Metadata with exifgrep
Search for specific metadata fields (e.g., "Camera") across multiple files.
```bash
exifgrep "Camera" image1.jpg image2.jpg
```

## Complete Command Reference

### exifprobe
```
exifprobe [options] filenames(s)
```

#### Mode Options
| Flag | Description |
|------|-------------|
| `-h` | Print help message |
| `-V` | Print program version and copyright |
| `-R` | Report mode: only tagnames and decimal values, indented, inline |
| `-S` | Structure mode: everything, offset values not inline (default) |
| `-L` | List mode: list all tags and values (only); no structure |
| `-Z` | Zero (turn off) all output flags |

#### Display & Formatting Options
| Flag | Description |
|------|-------------|
| `-a` | Toggle print addresses in hex and decimal |
| `-D` | Toggle print enabled addresses, tag numbers and values in decimal only |
| `-X` | Toggle print enabled addresses, tag numbers and values in hex only |
| `-I` | Toggle indent (after address -> before -> none) |
| `-i` | Toggle "inline" print of IFD values |
| `-n` | Toggle printing of filename at start of each output line |
| `-c` | Toggle use of color to highlight certain sections |
| `-u` | Print all 16 bits of unicode data |

#### Item Toggle Options (`-p[items]`)
| Item | Description |
|------|-------------|
| `s` | Sections |
| `g` | Segments |
| `e` | IFD entries |
| `a` | Expand known entries in APP0...APPN segments |
| `m` | Print MakerNote scheme detection info |
| `M` | Debug MakerNote scheme detection info |
| `l` | Long tagnames (default in List mode) |

#### IFD Entry Toggle Options (`-e[items]`)
| Item | Description |
|------|-------------|
| `t` | Tagname |
| `n` | Tag number in decimal |
| `N` | Tag number in hex |
| `T` | Entry type |
| `v` | Value in decimal |
| `V` | Value in hex |
| `o` | File offset to value in decimal |
| `O` | File offset to value in hex |
| `r` | Relative (unadjusted) offset in decimal |
| `R` | Print "raw" values where expansion of values is needed |
| `a` | Print ascii strings until null, rather than by length |
| `A` | Print ALL elements of multiple-value tags |

#### Data Dump & Force Options
| Flag | Description |
|------|-------------|
| `-M[len\|a]` | Hex/ascii dump 'len' (or all) bytes of unknown MakerNotes |
| `-A[len\|a]` | Hex/ascii dump 'len' (or all) bytes of unknown APPn segments |
| `-U[len\|a]` | Hex/ascii dump 'len' (or all) bytes of UNDEFINED data of unknown format |
| `-B[len\|a]` | Hex/ascii dump 'len' (or all) bytes of binary images or invalid JPEG data |
| `-N[num]` | Force noteversion 'num' for MakerNote interpretation |
| `-m[name]` | Force use of maker 'name' to select MakerNote interpretation routines |
| `-l[model]` | Force use of 'model' to select MakerNote interpretation routines |
| `-O[offset]` | Start processing at 'offset' in file |
| `-C[make]+[model]` | Print makes matching 'make', models matching 'model' (substrings) |

### exifgrep
Select and reformat the output of exifprobe using egrep patterns.
```
exifgrep [-var|-export] [-num] [-r] [-t] [-n] [-c] [egrep-options] egrep-pattern [NOT egrep-pattern] imagefilename[s]
```

| Flag | Description |
|------|-------------|
| `-var` | Output in a format suitable for shell variables |
| `-export` | Output in a format suitable for export |
| `-num` | Show tag numbers |
| `-r` | Raw output |
| `-t` | Show tag names |
| `-n` | Show filenames |
| `-c` | Colorized output |

## Notes
- Exifprobe is highly detailed; for quick metadata viewing, `-R` or `-L` is usually preferred over the default structural output.
- MakerNote interpretation is camera-specific; if the tool fails to identify the camera, use `-m` or `-l` to force a specific manufacturer or model routine.