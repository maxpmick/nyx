---
name: binwalk
description: Analyze, reverse engineer, and extract data from binary blobs and firmware images. Use to identify embedded files, executable code, file signatures, and calculate entropy. Essential for firmware analysis, hardware security audits, and digital forensics to uncover hidden filesystems, kernels, or compressed data within a single binary file.
---

# binwalk

## Overview
Binwalk is a tool for searching binary images for embedded files and executable code. It is specifically designed for identifying files and code embedded inside of firmware images using the libmagic library and a custom signature file optimized for firmware headers, Linux kernels, bootloaders, and filesystems. Category: Digital Forensics / Hardware / Exploitation.

## Installation (if not already installed)
Assume binwalk is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install binwalk
```

## Common Workflows

### Signature Scan
Scan a firmware image to identify embedded components and their offsets:
```bash
binwalk -B firmware.bin
```

### Automatic Extraction
Scan and automatically extract all known file types found in the image:
```bash
binwalk -e firmware.bin
```

### Recursive Extraction (Matryoshka)
Extract files and then automatically scan/extract the contents of those extracted files (up to 8 levels deep):
```bash
binwalk -Me firmware.bin
```

### Entropy Analysis
Analyze the file's entropy to identify encrypted or compressed sections (high entropy usually indicates encryption/compression):
```bash
binwalk -E firmware.bin
```

## Complete Command Reference

### Disassembly Scan Options
| Flag | Description |
|------|-------------|
| `-Y, --disasm` | Identify the CPU architecture of a file using the capstone disassembler |
| `-T, --minsn=<int>` | Minimum number of consecutive instructions to be considered valid (default: 500) |
| `-k, --continue` | Don't stop at the first match |

### Signature Scan Options
| Flag | Description |
|------|-------------|
| `-B, --signature` | Scan target file(s) for common file signatures |
| `-R, --raw=<str>` | Scan target file(s) for the specified sequence of bytes |
| `-A, --opcodes` | Scan target file(s) for common executable opcode signatures |
| `-m, --magic=<file>` | Specify a custom magic file to use |
| `-b, --dumb` | Disable smart signature keywords |
| `-I, --invalid` | Show results marked as invalid |
| `-x, --exclude=<str>` | Exclude results that match `<str>` |
| `-y, --include=<str>` | Only show results that match `<str>` |

### Extraction Options
| Flag | Description |
|------|-------------|
| `-e, --extract` | Automatically extract known file types |
| `-D, --dd=<t[:e[:c]]>` | Extract `<type>` signatures (regex), give extension `<ext>`, and execute `<cmd>` |
| `-M, --matryoshka` | Recursively scan extracted files |
| `-d, --depth=<int>` | Limit matryoshka recursion depth (default: 8 levels deep) |
| `-C, --directory=<str>` | Extract files/folders to a custom directory (default: CWD) |
| `-j, --size=<int>` | Limit the size of each extracted file |
| `-n, --count=<int>` | Limit the number of extracted files |
| `-0, --run-as=<str>` | Execute external extraction utilities with the specified user's privileges |
| `-1, --preserve-symlinks` | Do not sanitize extracted symlinks pointing outside extraction dir (dangerous) |
| `-r, --rm` | Delete carved files after extraction |
| `-z, --carve` | Carve data from files, but don't execute extraction utilities |
| `-V, --subdirs` | Extract into sub-directories named by the offset |

### Entropy Options
| Flag | Description |
|------|-------------|
| `-E, --entropy` | Calculate file entropy |
| `-F, --fast` | Use faster, but less detailed, entropy analysis |
| `-J, --save` | Save plot as a PNG |
| `-Q, --nlegend` | Omit the legend from the entropy plot graph |
| `-N, --nplot` | Do not generate an entropy plot graph |
| `-H, --high=<float>` | Set the rising edge entropy trigger threshold (default: 0.95) |
| `-L, --low=<float>` | Set the falling edge entropy trigger threshold (default: 0.85) |

### Binary Diffing Options
| Flag | Description |
|------|-------------|
| `-W, --hexdump` | Perform a hexdump / diff of a file or files |
| `-G, --green` | Only show lines containing bytes that are the same among all files |
| `-i, --red` | Only show lines containing bytes that are different among all files |
| `-U, --blue` | Only show lines containing bytes that are different among some files |
| `-u, --similar` | Only display lines that are the same between all files |
| `-w, --terse` | Diff all files, but only display a hex dump of the first file |

### Raw Compression Options
| Flag | Description |
|------|-------------|
| `-X, --deflate` | Scan for raw deflate compression streams |
| `-Z, --lzma` | Scan for raw LZMA compression streams |
| `-P, --partial` | Perform a superficial, but faster, scan |
| `-S, --stop` | Stop after the first result |

### General Options
| Flag | Description |
|------|-------------|
| `-l, --length=<int>` | Number of bytes to scan |
| `-o, --offset=<int>` | Start scan at this file offset |
| `-O, --base=<int>` | Add a base address to all printed offsets |
| `-K, --block=<int>` | Set file block size |
| `-g, --swap=<int>` | Reverse every n bytes before scanning |
| `-f, --log=<file>` | Log results to file |
| `-c, --csv` | Log results to file in CSV format |
| `-t, --term` | Format output to fit the terminal window |
| `-q, --quiet` | Suppress output to stdout |
| `-v, --verbose` | Enable verbose output |
| `-h, --help` | Show help output |
| `-a, --finclude=<str>` | Only scan files whose names match this regex |
| `-p, --fexclude=<str>` | Do not scan files whose names match this regex |
| `-s, --status=<int>` | Enable the status server on the specified port |

## Notes
- **Security Warning**: Using `-1, --preserve-symlinks` is dangerous as it allows extracted files to create symlinks anywhere on your filesystem.
- **Extraction**: Extraction relies on external utilities (like `tar`, `gzip`, `unsquashfs`). If extraction fails, ensure the relevant filesystem tools are installed.
- **EOL Notice**: Binwalk v2.x is approaching End of Life (12/12/2025). Consider migrating to v3.x when available.