---
name: sickle-tool
description: A payload development framework used to craft, format, and examine shellcode and exploit payloads. Use when developing custom shellcode, identifying bad characters, converting raw bytes into various programming language formats (C, Python, Bash, etc.), or disassembling binary payloads during exploitation and vulnerability research.
---

# sickle-tool

## Overview
Sickle is a payload development tool designed to aid in crafting shellcode and payloads for various exploit types. While primarily focused on assembly and binary exploitation, it functions as a versatile converter and analyzer for raw shellcode. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume sickle-tool is already installed. If you get a "command not found" error:

```bash
sudo apt install sickle-tool
```

Dependencies: python3, python3-capstone, python3-keystone-engine.

## Common Workflows

### Convert raw shellcode to a C-style string
```bash
sickle-tool -r shellcode.bin -f c
```

### Identify bad characters in a payload
```bash
sickle-tool -p "\x31\xc0\x48\xbb\xd1\x9d\x96\x91\xd0\x8c\x97\xff" -b "\x00\x0a\x0d"
```

### Disassemble a binary file for a specific architecture
```bash
sickle-tool -r shellcode.bin -a x86 -m disassemble
```

### Pipe shellcode from another tool and format for Python
```bash
cat payload.bin | sickle-tool -r - -f python -v stage1_payload
```

## Complete Command Reference

```
usage: sickle-tool [-h] [-r READ] [-p PAYLOAD] [-f FORMAT] [-m MODULE]
                   [-a ARCH] [-b BADCHARS] [-v VARNAME] [-i] [-l]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-r`, `--read READ` | Read bytes from a binary file (use `-` for stdin) |
| `-p`, `--payload PAYLOAD` | Provide shellcode string directly to use |
| `-f`, `--format FORMAT` | Specify the output format (e.g., c, python, bash, perl, ruby) |
| `-m`, `--module MODULE` | Select a development module (e.g., disassemble) |
| `-a`, `--arch ARCH` | Select architecture for disassembly (e.g., x86, x64, arm) |
| `-b`, `--badchars BADCHARS` | Define bad characters to check for in the shellcode |
| `-v`, `--varname VARNAME` | Define an alternative variable name for the output format |
| `-i`, `--info` | Print detailed information for a specific module or payload |
| `-l`, `--list` | List all available formats, payloads, or modules |

## Notes
- Use the `-l` flag frequently to see the supported output formats, as these can vary based on the version installed.
- When using `-r -`, ensure the input is raw binary data.
- The tool is particularly useful for verifying that a payload does not contain null bytes (`\x00`) or other characters that might break a specific exploit string.