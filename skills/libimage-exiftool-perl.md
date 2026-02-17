---
name: exiftool
description: Read, write, and edit meta information in a wide variety of files including images, audio, video, and documents. Use when performing digital forensics, analyzing file metadata for geolocation or timestamps, stripping privacy-sensitive information, or identifying file types and camera-specific maker notes.
---

# exiftool

## Overview
ExifTool is a customizable set of Perl modules and a full-featured command-line application for reading and writing meta information in numerous file formats. It supports EXIF, GPS, IPTC, XMP, JFIF, GeoTIFF, ICC Profile, Photoshop IRB, FlashPix, AFCP, and ID3, as well as the maker notes of many digital cameras. Category: Digital Forensics / Information Gathering.

## Installation (if not already installed)
Assume exiftool is already installed. If you get a "command not found" error:

```bash
sudo apt install libimage-exiftool-perl
```

Recommended dependencies for extended format support: `libarchive-zip-perl` (ZIP/Office), `libcompress-raw-lzma-perl` (7z), `libio-compress-brotli-perl` (JXL).

## Common Workflows

### Read all metadata from a file
```bash
exiftool image.jpg
```

### Extract common metadata (GPS, Date, Camera)
```bash
exiftool -common image.jpg
```

### Strip all metadata from a file (Privacy Scrubbing)
```bash
exiftool -all= image.jpg
```
*Note: This creates a backup file `image.jpg_original` unless `-overwrite_original` is used.*

### Extract GPS coordinates as decimal
```bash
exiftool -gpslatitude -gpslongitude -c "%.6f" image.jpg
```

### Rename files based on creation date
```bash
exiftool '-filename<CreateDate' -d %Y%m%d_%H%M%S%%-c.%%e *.jpg
```

## Complete Command Reference

### Basic Options
| Flag | Description |
|------|-------------|
| `-a`, `--allowDuplicates` | Allow duplicate tags to be extracted |
| `-e`, `--composite` | Do not calculate composite tags |
| `-ee`, `--extractEmbedded` | Extract information from embedded files |
| `-f`, `--forcePrint` | Force printing of tags even if they have no value |
| `-g[NUM...]`, `--groupNames` | Organize output by tag group (0=General, 1=Specific, 2=Category) |
| `-h`, `--htmlFormat` | Use HTML formatting for output |
| `-j`, `--json` | Use JSON formatting for output |
| `-l`, `--long` | Use long 2-line fixed-width output format |
| `-L`, `--latin` | Use Windows Latin1 encoding |
| `-n`, `--printConv` | Disable print conversion (output raw values) |
| `-p <fmt>`, `--printFormat` | Print output in specified format |
| `-s[NUM]`, `--short` | Short output format (tag names instead of descriptions) |
| `-t`, `--tab` | Output in tab-delimited list format |
| `-v[NUM]`, `--verbose` | Print verbose messages |
| `-x <tag>`, `--exclude` | Exclude specified tag |

### Processing Options
| Flag | Description |
|------|-------------|
| `-ext <extension>` | Process files with specified extension |
| `-F`, `--fixBase` | Fix base for maker notes offsets |
| `-fast[NUM]` | Increase speed for slow devices (skips some checks) |
| `-i <dir>`, `--ignore` | Ignore specified directory name |
| `-if <expr>` | Process files conditionally based on Perl expression |
| `-m`, `--ignoreMinorErrors` | Ignore minor errors and warnings |
| `-o <out>`, `--out` | Set output file or directory name |
| `-overwrite_original` | Overwrite original file (no backup) |
| `-overwrite_original_in_place` | Overwrite original by copying (preserves Mac metadata) |
| `-P`, `--preserve` | Preserve date/time of original file |
| `-password <pwd>` | Password for encrypted files |
| `-q`, `--quiet` | Quiet processing |
| `-r`, `--recurse` | Recursively process subdirectories |
| `-scanW` | Scan for Windows executable signatures |
| `-u`, `--unknown` | Extract unknown tags |
| `-U`, `--unknown2` | Extract unknown binary tags |
| `-z`, `--zip` | Read/write compressed information |

### Writing Options
| Flag | Description |
|------|-------------|
| `-all=` | Delete all metadata |
| `-<tag>=<val>` | Write new value to tag |
| `-<tag>+<val>` | Add value to tag (or increment number) |
| `-<tag>-<val>` | Delete tag or subtract value |
| `-tagsFromFile <src>` | Copy tags from source file to destination |
| `-wm <mode>` | Write mode (k=keep, c=create, x=extending) |

### Special Options
| Flag | Description |
|------|-------------|
| `-list`, `-listw`, `-listf` | List all supported tags, writable tags, or file extensions |
| `-ver` | Print version number |
| `-execute` | Execute multiple commands in one line |

## Notes
- **Backups**: By default, ExifTool preserves the original file by adding `_original` to the filename when writing.
- **Security**: Be cautious when processing untrusted files; while ExifTool is robust, it parses complex binary formats.
- **Performance**: Use `-fast` when only basic metadata is needed from large files or slow storage.