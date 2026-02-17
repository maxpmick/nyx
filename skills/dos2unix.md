---
name: dos2unix
description: Convert text file line endings between CRLF (Windows/DOS), LF (Unix), and CR (Mac) formats. Use when encountering "Incomplete line" errors, script execution failures due to carriage returns (\r), or when preparing payloads and configuration files for different operating systems during exploitation and post-exploitation.
---

# dos2unix / unix2dos

## Overview
A suite of utilities (dos2unix, unix2dos, mac2unix, unix2mac) to convert line endings in text files. Windows uses CRLF, Unix/Linux uses LF, and older Mac systems used CR. Category: Information Gathering / Post-Exploitation.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install dos2unix
```

## Common Workflows

### Convert Windows script to Unix format (In-place)
```bash
dos2unix script.sh
```

### Convert Unix file to Windows format (New file)
```bash
unix2dos -n input.txt output.txt
```

### Convert and preserve original file timestamp
```bash
dos2unix -k document.txt
```

### Check file information without converting
```bash
dos2unix -i file.txt
```

## Complete Command Reference

All utilities (`dos2unix`, `unix2dos`, `mac2unix`, `unix2mac`) share the same flags.

### Basic Usage
```bash
dos2unix [options] [file ...] [-n infile outfile ...]
```

### General Options
| Flag | Description |
|------|-------------|
| `--allow-chown` | Allow file ownership change |
| `--no-allow-chown` | Don't allow file ownership change (default) |
| `-ascii` | Default conversion mode |
| `-7` | Convert 8 bit characters to 7 bit space |
| `-b, --keep-bom` | Keep Byte Order Mark |
| `-r, --remove-bom` | Remove Byte Order Mark (default for dos2unix/mac2unix) |
| `-m, --add-bom` | Add Byte Order Mark (default UTF-8) |
| `-c, --convmode` | Set conversion mode: `ascii`, `7bit`, `iso`, `mac` (default: `ascii`) |
| `-e, --add-eol` | Add a line break to the last line if there isn't one |
| `--no-add-eol` | Don't add a line break to the last line (default) |
| `-f, --force` | Force conversion of binary files |
| `-h, --help` | Display help text |
| `-i, --info[=FLAGS]` | Display file information |
| `-k, --keepdate` | Keep output file date (timestamp) |
| `-L, --license` | Display software license |
| `-l, --newline` | Add additional newline |
| `-n, --newfile` | New file mode: write to a different output file |
| `-o, --oldfile` | Old file mode: write to the original file (default) |
| `-O, --to-stdout` | Write to standard output |
| `-q, --quiet` | Quiet mode, suppress all warnings |
| `-s, --safe` | Skip binary files (default) |
| `-v, --verbose` | Verbose operation |
| `-V, --version` | Display version number |

### Character Set Options (ISO)
| Flag | Description |
|------|-------------|
| `-iso` | Conversion between DOS and ISO-8859-1 character set |
| `-1252` | Use Windows code page 1252 (Western European) |
| `-437` | Use DOS code page 437 (US) (default) |
| `-850` | Use DOS code page 850 (Western European) |
| `-860` | Use DOS code page 860 (Portuguese) |
| `-863` | Use DOS code page 863 (French Canadian) |
| `-865` | Use DOS code page 865 (Nordic) |

### UTF-16 Options
| Flag | Description |
|------|-------------|
| `-u, --keep-utf16` | Keep UTF-16 encoding |
| `-ul, --assume-utf16le` | Assume that the input format is UTF-16LE |
| `-ub, --assume-utf16be` | Assume that the input format is UTF-16BE |

### Symbolic Link Options
| Flag | Description |
|------|-------------|
| `-F, --follow-symlink` | Follow symbolic links and convert the targets |
| `-R, --replace-symlink` | Replace symbolic links with converted files (targets unchanged) |
| `-S, --skip-symlink` | Keep symbolic links and targets unchanged (default) |

## Notes
- **Binary Safety**: By default, the tool skips binary files (`-s`). Use `-f` to force conversion if necessary.
- **Permissions**: Use `--allow-chown` if you need the tool to attempt to preserve file ownership when writing new files.
- **Mac Formats**: `mac2unix` and `unix2mac` specifically handle the old Mac CR line endings. Modern macOS (OSX and later) uses Unix LF endings.