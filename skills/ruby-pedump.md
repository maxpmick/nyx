---
name: ruby-pedump
description: Dump headers, sections, and extract resources from Win32 PE executable files (EXE, DLL, etc.) using a pure Ruby implementation. Use when performing static analysis of Windows malware, reverse engineering PE files, detecting packers/compilers, or extracting embedded resources like icons and strings.
---

# ruby-pedump

## Overview
A pure Ruby tool for dumping and analyzing Win32 PE (Portable Executable) files. It can parse MZ headers, DOS stubs, Rich headers, PE/NE/TE headers, data directories, sections, imports, exports, and version information. It also includes packer detection and resource extraction capabilities. Category: Reverse Engineering.

## Installation (if not already installed)
Assume ruby-pedump is already installed. If the `pedump-ruby` command is missing:

```bash
sudo apt update
sudo apt install ruby-pedump
```

## Common Workflows

### Basic File Analysis
Display a summary table of the PE file structure, including headers and sections:
```bash
pedump-ruby malware.exe
```

### Packer and Compiler Detection
Identify if a file is packed or what compiler was used (similar to the `file` command):
```bash
pedump-ruby -P suspicious.dll
```

### Extracting a Specific Section
Extract the `.text` section of a binary to a file:
```bash
pedump-ruby --extract section:.text sample.exe > section_text.bin
```

### Exporting Data to JSON
Dump all PE information into a JSON format for automated processing:
```bash
pedump-ruby --all --format json sample.exe > report.json
```

### Interactive Analysis
Open the PE file in an interactive Ruby (IRB) console for manual inspection:
```bash
pedump-ruby --console sample.exe
```

## Complete Command Reference

```
pedump-ruby [options] <file>
```

### General Options

| Flag | Description |
|------|-------------|
| `--version` | Print version information and exit |
| `-v`, `--verbose` | Run verbosely (can be used multiple times) |
| `-q`, `--quiet` | Silent any warnings (can be used multiple times) |
| `-F`, `--force` | Try to dump by all means (can cause exceptions) |
| `-f`, `--format FORMAT` | Output format: `bin`, `c`, `dump`, `hex`, `inspect`, `json`, `table`, `yaml` (default: table) |
| `--all` | Dump all information except resource-directory (default behavior) |
| `-C`, `--console` | Opens IRB console with specified file loaded |
| `-W`, `--web` | Uploads files to https://pedump.me for HTML report and previews |

### Component Selection

| Flag | Description |
|------|-------------|
| `--mz` | Dump MZ header |
| `--dos-stub` | Dump DOS stub |
| `--rich` | Dump Rich header |
| `--pe` | Dump PE header |
| `--ne` | Dump NE (New Executable) header |
| `--te` | Dump TE (Terse Executable) header |
| `--data-directory` | Dump Data Directory |
| `-S`, `--sections` | Dump Sections |
| `--tls` | Dump Thread Local Storage (TLS) |
| `--security` | Dump Security directory |
| `-s`, `--strings` | Extract strings from the file |
| `-R`, `--resources` | Dump Resources |
| `--resource-directory` | Dump Resource Directory tree |
| `-I`, `--imports` | Dump Import Table |
| `-E`, `--exports` | Dump Export Table |
| `-V`, `--version-info` | Dump Version Information |

### Packer Detection

| Flag | Description |
|------|-------------|
| `--packer` | Detect packers/compilers |
| `--deep` | Packer deep scan (significantly slower) |
| `-P`, `--packer-only` | Packer/compiler detect only (mimics 'file' command) |
| `-r`, `--recursive` | Recurse directories during packer detection |

### Extraction and Conversion

| Flag | Description |
|------|-------------|
| `--extract ID` | Extract a resource/section/data_dir (see ID formats below) |
| `--va2file VA` | Convert Relative Virtual Address (RVA) to file offset |

**Extraction ID Formats:**
- `datadir:EXPORT` - Extract data directory by type
- `resource:0x98478` - Extract resource by file offset
- `resource:ICON/#1` - Extract resource by type and name
- `section:.text` - Extract section by name
- `section:rva/0x1000` - Extract section by RVA
- `section:raw/0x400` - Extract section by RAW_PTR

## Notes
- The tool is invoked as `pedump-ruby` in Kali Linux to avoid conflicts with other packages.
- The `--force` flag is useful for analyzing malformed or obfuscated PE files that might crash standard parsers.
- Web upload (`-W`) sends the binary to a third-party service; use with caution when handling sensitive or classified files.