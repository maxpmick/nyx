---
name: exiv2
description: Read, write, and manipulate image metadata including Exif, IPTC, and XMP. Use when performing digital forensics, analyzing image origins, modifying timestamps, extracting thumbnails/previews, or sanitizing metadata from image files during investigations.
---

# exiv2

## Overview
Exiv2 is a command-line utility for managing image metadata. It provides fast access to Exif, IPTC, and XMP data, allowing for printing, modifying, deleting, and extracting metadata from various image formats. Category: Digital Forensics.

## Installation (if not already installed)
Assume exiv2 is already installed. If you get a "command not found" error:

```bash
sudo apt install exiv2
```

## Common Workflows

### Print metadata summary
```bash
exiv2 image.jpg
```

### Extract all metadata to a sidecar file
```bash
exiv2 -ex image.jpg
```
This creates `image.exv` containing the metadata.

### Remove all metadata from an image
```bash
exiv2 -rm image.jpg
```

### Set a specific XMP tag
```bash
exiv2 -M"set Xmp.dc.subject XmpBag Sky" image.tiff
```

### Rename files based on Exif timestamp
```bash
exiv2 -r "%Y-%m-%d_%H-%M-%S_:basename:" mv *.jpg
```

## Complete Command Reference

```
exiv2 [ option [ arg ] ]+ [ action ] file ...
```

### Actions

| Action | Alias | Description |
|--------|-------|-------------|
| `print` | `pr` | Print image metadata (default action). |
| `adjust` | `ad` | Adjust Exif timestamps. Requires `-a`, `-Y`, `-O`, or `-D`. |
| `delete` | `rm` | Delete image metadata. Use `-d` to choose type (default: all). |
| `insert` | `in` | Insert metadata from `.exv`, `.xmp`, thumbnail, or `.icc`. |
| `extract` | `ex` | Extract metadata to `.exv`, `.xmp`, preview, thumbnail, or ICC. |
| `rename` | `mv` | Rename files/set timestamps based on Exif data. |
| `modify` | `mo` | Apply commands to modify metadata. Requires `-m` or `-M`. |
| `fixiso` | `fi` | Copy ISO from Canon/Nikon makernotes to standard Exif tag. |
| `fixcom` | `fc` | Convert Unicode Exif user comment to UCS-2. |

### General Options

| Flag | Description |
|------|-------------|
| `-h` | Display help and exit |
| `-V` | Show program version |
| `-v` | Be verbose |
| `-q` | Silence warnings and errors (quiet) |
| `-Q lvl` | Set log-level: `d`(ebug), `i`(nfo), `w`(arning), `e`(rror), `m`(ute) |
| `-b` | Obsolete (test suite use) |
| `-u` | Show unknown tags |
| `-g str` | Grep output for `str`. Append `/i` for case insensitive |
| `-K key` | Only output tags exactly matching `key` |
| `-n enc` | Character set to decode Exif Unicode user comments |
| `-k` | Preserve file timestamps when updating (keep) |
| `-t` | Set file timestamp from Exif when renaming (overrides `-k`) |
| `-T` | Only set file timestamp from Exif (use with `rename` action) |
| `-f` | Do not prompt before overwriting files (force) |
| `-F` | Do not prompt before renaming files (Force) |
| `-l dir` | Location (directory) for files to be inserted from or extracted to |
| `-S suf` | Use suffix `suf` for source files for `insert` action |

### Action-Specific Options

#### Print (`-p` mode)
| Mode | Description |
|------|-------------|
| `s` | Summary of Exif metadata (default) |
| `a` | Exif, IPTC, and XMP tags |
| `e` | Exif tags |
| `t` | Interpreted (translated) Exif tags |
| `v` | Plain (untranslated) Exif tags values |
| `h` | Hex dump of Exif tags |
| `i` | IPTC tags |
| `x` | XMP tags |
| `c` | JPEG comment |
| `p` | List available image previews, sorted by size |
| `C` | Print ICC profile |
| `R` | Recursive print structure of image (debug build only) |
| `S` | Print structure of image (limited file types) |
| `X` | Extract "raw" XMP |

#### Print Flags (`-P` flgs)
Fine control for tag lists: `E` (Exif), `I` (IPTC), `X` (XMP), `x` (Hex tag number), `g` (Group), `k` (Key), `l` (Label), `d` (Description), `n` (Name), `y` (Type), `c` (Count), `s` (Size), `v` (Plain value), `V` (Value+Type+Set), `t` (Interpreted), `h` (Hex dump).

#### Delete (`-d` target)
| Target | Description |
|--------|-------------|
| `a` | All supported metadata (default) |
| `e` | Exif tags |
| `t` | Exif thumbnail only |
| `i` | IPTC tags |
| `x` | XMP tags |
| `c` | JPEG comment |
| `C` | ICC Profile |
| `-` | Input from stdin |

#### Insert/Extract (`-i` or `-e` target)
| Target | Description |
|--------|-------------|
| `a` | All supported metadata |
| `e` | Exif tags |
| `t` | Exif thumbnail (to/from `<file>-thumb.jpg`) |
| `i` | IPTC tags |
| `x` | XMP tags |
| `c` | JPEG comment |
| `pN` | Extract N'th preview image (Extract only) |
| `C` | ICC Profile (to/from `<file>.icc`) |
| `X` | XMP sidecar (to/from `<file>.xmp`) |
| `XX` | "raw" metadata (to/from `<file>.exv`) |

#### Adjust
| Flag | Description |
|------|-------------|
| `-a time` | Time adjustment: `[+|-]HH[:MM[:SS]]` |
| `-Y yrs` | Year adjustment |
| `-O mon` | Month adjustment |
| `-D day` | Day adjustment |

#### Modify
| Flag | Description |
|------|-------------|
| `-c txt` | Set JPEG comment string |
| `-m cmdf` | Apply commands from file `cmdf` |
| `-M cmd` | Command string: `set <key> [[<type>] <val>]`, `add <key> [[<type>] <val>]`, `del <key> [<type>]`, or `reg <prefix> <namespace>` |

#### Rename (`-r` format)
Supports `strftime` codes and:
- `:basename:` : Filename without extension
- `:basesuffix:` : Suffix before extension
- `:dirname:` : Directory name
- `:parentname:` : Parent directory name

## Notes
- Exiv2 supports remote URLs (http, https, ftp, sftp).
- When using `-M` for modification, ensure the key is correctly formatted (e.g., `Exif.Photo.UserComment`).
- The `rename` action is powerful for organizing large forensic image sets by capture date.