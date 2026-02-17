---
name: cabextract
description: Extract files from Microsoft Cabinet (.cab) archives, including executable cabinets and multi-part sets. Use when performing digital forensics, malware analysis, or incident response to unpack Windows software distributions, font packs, or installer files.
---

# cabextract

## Overview
cabextract is a utility designed to unpack Microsoft Cabinet (.cab) files. These archives are commonly used by Microsoft to distribute software, drivers, and system updates. It is essential for analyzing Windows-based installers and compressed artifacts. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume cabextract is already installed. If you encounter a "command not found" error:

```bash
sudo apt install cabextract
```

## Common Workflows

### List contents of a cabinet file
```bash
cabextract -l archive.cab
```

### Extract all files to a specific directory
```bash
cabextract -d ./output_dir setup.exe
```

### Test the integrity of a cabinet archive
```bash
cabextract -t data1.cab
```

### Extract specific files using a pattern
```bash
cabextract -F "*.dll" driver_package.cab
```

### Handle multi-part cabinets
For archives split across multiple files (e.g., disk1.cab, disk2.cab), only specify the first file:
```bash
cabextract disk1.cab
```

## Complete Command Reference

```
Usage: cabextract [options] [-d dir] <cabinet file(s)>
```

### Options

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-v` | `--version` | Print version information or list cabinet details |
| `-h` | `--help` | Show the help page |
| `-l` | `--list` | List the contents of the cabinet without extracting |
| `-t` | `--test` | Test the integrity of the cabinet file |
| `-q` | `--quiet` | Only print errors and warnings; suppress normal output |
| `-L` | `--lowercase` | Convert all extracted filenames to lowercase |
| `-f` | `--fix` | Attempt to salvage as much data as possible from corrupted cabinets |
| `-i` | `--interactive` | Prompt the user before overwriting existing files |
| `-n` | `--no-overwrite` | Do not overwrite existing files; skip them instead |
| `-k` | `--keep-symlinks` | Follow symlinked files or directories when extracting |
| `-p` | `--pipe` | Pipe the extracted file content directly to stdout |
| `-s` | `--single` | Restrict search to cabinets explicitly named on the command line |
| `-F` | `--filter` | Extract only files that match the given pattern (e.g., `*.exe`) |
| `-e` | `--encoding` | Assume non-UTF8 filenames have the specified encoding |
| `-d` | `--directory` | Extract all files into the specified directory |

## Notes
- **Multi-part Cabinets**: When dealing with a set of cabinet files, you only need to provide the filename of the first cabinet in the set to `cabextract`.
- **Self-Extracting Exes**: Many Windows `.exe` installers are actually self-extracting cabinet archives; `cabextract` can process these directly.
- **Corrupted Files**: The `-f` (fix) flag is particularly useful in forensics when dealing with partially recovered or damaged archive files.