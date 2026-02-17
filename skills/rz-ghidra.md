---
name: rz-ghidra
description: Decompile and disassemble binary code using the Ghidra decompiler and Sleigh engine integrated into rizin. Use when performing reverse engineering, malware analysis, or vulnerability research within the rizin framework to obtain C-like pseudocode from machine code.
---

# rz-ghidra

## Overview
rz-ghidra is a deep integration of the Ghidra decompiler and Sleigh disassembler for the rizin reverse engineering framework. It uses the C++ implementation of the Ghidra decompiler, meaning it does not require a Java runtime or a full Ghidra installation. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume rz-ghidra is already installed as part of the rizin environment. If the `pdg` command is missing in rizin:

```bash
sudo apt update
sudo apt install rz-ghidra
```

## Common Workflows

### Decompile a function
Open a binary in rizin and use the `pdg` command to decompile the current function:
```bash
rizin /bin/ls
[0x00005850]> aa
[0x00005850]> s main
[0x00005850]> pdg
```

### View Sleigh disassembly
To see the Sleigh-based disassembly for the current block:
```bash
[0x00005850]> pds
```

### List available Ghidra settings
Check or modify the decompiler behavior within the rizin shell:
```bash
[0x00005850]> e rz_ghidra.
```

## Complete Command Reference

The following commands are added to the rizin environment when the plugin is loaded:

### Decompiler Commands

| Command | Description |
|---------|-------------|
| `pdg` | Decompile the current function using Ghidra and output C-like pseudocode |
| `pdg <addr>` | Decompile the function at the specified address |
| `pdgj` | Decompile the current function and output results in JSON format |
| `pdgo` | Decompile the current function and output the Ghidra P-Code (raw decompiler operations) |

### Disassembler Commands

| Command | Description |
|---------|-------------|
| `pds` | Disassemble the current block using the Sleigh engine |
| `pdsj` | Disassemble the current block using Sleigh and output in JSON format |

### Configuration Options (eval vars)
These can be toggled using the `e` command in rizin (e.g., `e rz_ghidra.indent=4`).

| Option | Description |
|--------|-------------|
| `rz_ghidra.indent` | Set the number of spaces for indentation in decompiled output |
| `rz_ghidra.comments` | Toggle whether to show comments in the decompiled code |
| `rz_ghidra.syntax` | Enable or disable syntax highlighting in decompiled output |
| `rz_ghidra.use_rizin_colors` | Use rizin's theme colors for the decompiler output |
| `rz_ghidra.max_unroll` | Set the maximum loop unrolling limit for the decompiler |

## Notes
- **Analysis Requirement**: You must run `aa` (analyze all) or at least `af` (analyze function) in rizin before decompiling, as the decompiler relies on rizin's function metadata.
- **Self-Contained**: This plugin does not require the Ghidra GUI or Java; it is a native C++ implementation.
- **Architecture Support**: Supports all architectures handled by Ghidra's Sleigh engine (x86, ARM, MIPS, PowerPC, etc.).