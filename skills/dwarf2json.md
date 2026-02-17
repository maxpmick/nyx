---
name: dwarf2json
description: Generate Volatility 3 Intermediate Symbol File (ISF) JSON from files containing symbol and type information. Use when creating custom symbols for Linux or macOS memory forensics, specifically when preparing profiles for Volatility 3 analysis of specific kernel versions or drivers.
---

# dwarf2json

## Overview
A Go-based utility that processes DWARF (Debugging With Attributed Record Formats) information to generate Volatility 3 Intermediate Symbol File (ISF) JSON output. This is essential for performing memory forensics on Linux and macOS systems where pre-built symbols are unavailable. Category: Digital Forensics.

## Installation (if not already installed)
Assume dwarf2json is already installed. If the command is not found:

```bash
sudo apt update && sudo apt install dwarf2json
```

## Common Workflows

### Generate ISF for a Linux Kernel
Process a Linux kernel image (vmlinux) with DWARF info to create a Volatility 3 symbol file.
```bash
dwarf2json linux --elf /path/to/vmlinux > linux-kernel.json
```

### Generate ISF for macOS
Process a macOS kernel or driver to create symbols for Volatility 3.
```bash
dwarf2json mac --macho /path/to/kernel --symbols /path/to/System.map > macos-symbols.json
```

### Generate ISF from a System.map (Linux)
If only the System.map and kernel are available:
```bash
dwarf2json linux --elf /boot/vmlinuz-$(uname -r) --system-map /boot/System.map-$(uname -r) > symbols.json
```

## Complete Command Reference

```
dwarf2json COMMAND [Options]
```

### Global Commands

| Command | Description |
|---------|-------------|
| `linux` | Generate ISF for Linux analysis |
| `mac`   | Generate ISF for macOS analysis |

### Linux Subcommand Options

| Flag | Description |
|------|-------------|
| `--elf <path>` | Path to the ELF file containing DWARF information (typically vmlinux) |
| `--system-map <path>` | Path to the System.map file (optional, used for symbol resolution) |
| `--output <path>` | Path to write the JSON output (defaults to stdout if not specified) |

### macOS Subcommand Options

| Flag | Description |
|------|-------------|
| `--macho <path>` | Path to the Mach-O file containing DWARF information |
| `--symbols <path>` | Path to the symbol file or System.map equivalent for macOS |
| `--output <path>` | Path to write the JSON output (defaults to stdout if not specified) |

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help information for the tool or a specific subcommand |

## Notes
- The generated JSON file should be placed in the appropriate Volatility 3 symbols directory (usually `volatility3/symbols/linux` or `volatility3/symbols/mac`) to be recognized by the framework.
- Ensure the input files (vmlinux/Mach-O) contain DWARF debug symbols; stripped binaries will not produce useful ISF files.
- For Linux, the `vmlinux` file is often found in debug packages (e.g., `linux-image-*-dbg`).