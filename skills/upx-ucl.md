---
name: upx-ucl
description: Compress or expand executable files to reduce size or obfuscate payloads. Use when performing post-exploitation to shrink binaries for transfer, during exploitation to pack custom payloads, or in digital forensics to identify and decompress packed malware samples.
---

# upx-ucl

## Overview
UPX (Ultimate Packer for eXecutables) is an advanced executable file compressor that typically reduces the file size of programs and DLLs by 50%-70%. It supports numerous formats including ELF (Linux), PE (Windows), and Mach-O (macOS). Category: Exploitation / Digital Forensics / Social Engineering.

## Installation (if not already installed)
Assume upx-ucl is already installed. If you get a "command not found" error:

```bash
sudo apt install upx-ucl
```

## Common Workflows

### Compress a binary with default settings
```bash
upx-ucl -o compressed_app original_app
```

### Decompress a packed executable
```bash
upx-ucl -d packed_malware.exe
```

### Maximum compression (Brute force)
```bash
upx-ucl --ultra-brute -9 payload.elf
```

### List information about a compressed file
```bash
upx-ucl -l suspicious_file.exe
```

## Complete Command Reference

### Main Commands
| Flag | Description |
|------|-------------|
| `-1` | Compress faster |
| `-9` | Compress better |
| `--best` | Compress best (can be slow for big files) |
| `-d` | Decompress |
| `-l` | List compressed file |
| `-t` | Test compressed file |
| `-V` | Display version number |
| `-h` | Give help |
| `-L` | Display software license |

### General Options
| Flag | Description |
|------|-------------|
| `-q` | Be quiet |
| `-v` | Be verbose |
| `-oFILE` | Write output to 'FILE' |
| `-f` | Force compression of suspicious files |
| `--no-color` | Disable color output |
| `--mono` | Force monochrome output |
| `--color` | Force color output |
| `--no-progress` | Disable progress bar |

### Compression Tuning
| Flag | Description |
|------|-------------|
| `--lzma` | Try LZMA [slower but tighter than NRV] |
| `--brute` | Try all available compression methods & filters [slow] |
| `--ultra-brute` | Try even more compression variants [very slow] |

### Backup Options
| Flag | Description |
|------|-------------|
| `-k`, `--backup` | Keep backup files |
| `--no-backup` | No backup files [default] |

### Overlay Options
| Flag | Description |
|------|-------------|
| `--overlay=copy` | Copy any extra data attached to the file [default] |
| `--overlay=strip` | Strip any extra data attached to the file [DANGEROUS] |
| `--overlay=skip` | Don't compress a file with an overlay |

### File System Options
| Flag | Description |
|------|-------------|
| `--force-overwrite` | Force overwrite of output files |
| `--link` | Preserve hard links (Unix only) [USE WITH CARE] |
| `--no-link` | Do not preserve hard links but rename files [default] |
| `--no-mode` | Do not preserve file mode (permissions) |
| `--no-owner` | Do not preserve file ownership |
| `--no-time` | Do not preserve file timestamp |

### Format Specific Options

**djgpp2/coff**
- `--coff`: Produce COFF output [default: EXE]

**dos/com, dos/exe, dos/sys**
- `--8086`: Make compressed file work on any 8086
- `--no-reloc`: (exe only) Put no relocations in the exe header

**ps1/exe**
- `--8-bit`: Uses 8 bit size compression [default: 32 bit]
- `--8mib-ram`: 8 megabyte memory limit [default: 2 MiB]
- `--boot-only`: Disables client/host transfer compatibility
- `--no-align`: Don't align to 2048 bytes [enables: --console-run]

**watcom/le**
- `--le`: Produce LE output [default: EXE]

**win32/pe, win64/pe & rtm32/pe**
- `--compress-exports=0`: Do not compress the export section
- `--compress-exports=1`: Compress the export section [default]
- `--compress-icons=0`: Do not compress any icons
- `--compress-icons=1`: Compress all but the first icon
- `--compress-icons=2`: Compress all but the first icon directory [default]
- `--compress-icons=3`: Compress all icons
- `--compress-resources=0`: Do not compress any resources at all
- `--keep-resource=list`: Do not compress resources specified by list
- `--strip-relocs=0`: Do not strip relocations
- `--strip-relocs=1`: Strip relocations [default]

**linux/elf**
- `--preserve-build-id`: Copy .gnu.note.build-id to compressed output

## Notes
- UPX is frequently used by malware authors to evade simple signature-based detection; decompressing a file with `-d` is a standard first step in static analysis.
- Some security software may flag UPX-packed binaries as suspicious regardless of the actual content.
- Using `--ultra-brute` can significantly increase compression time but is useful for minimizing payload size for restricted environments.