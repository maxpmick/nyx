---
name: shellnoob
description: A shellcode writing toolkit used to convert shellcode between different formats, resolve syscalls, and perform in-place development. Use when writing, debugging, or transforming shellcode during exploitation, binary patching, or vulnerability research.
---

# shellnoob

## Overview
ShellNoob is a comprehensive toolkit for shellcode development and conversion. It supports multiple architectures (x86, x86_64, ARM) and operating systems (Linux, FreeBSD). It allows for interactive assembly-to-opcode conversion, syscall resolution, and binary patching. Category: Exploitation.

## Installation (if not already installed)
Assume shellnoob is already installed. If missing:

```bash
sudo apt install shellnoob
```

## Common Workflows

### Interactive Assembly to Opcode
Quickly test how assembly instructions translate to hex opcodes.
```bash
shellnoob -i --to-opcode
```

### Convert Assembly File to C String
Convert a file containing assembly instructions into a C-style shellcode string.
```bash
shellnoob --from-asm payload.asm --to-c payload.c
```

### Debug Shellcode with GDB
Automatically compile shellcode into an executable and launch it in GDB with a breakpoint at the entry point.
```bash
shellnoob --from-hex shellcode.txt --to-gdb
```

### Resolve Syscall Numbers
Find the syscall number for a specific function (e.g., execve) on the current architecture.
```bash
shellnoob --get-sysnum execve
```

## Complete Command Reference

### Conversion Options
`shellnoob [--from-INPUT] (input_file | -) [--to-OUTPUT] [output_file | -]`

| Flag | Description |
|------|-------------|
| `--from-INPUT` | Specify input format: `asm`, `obj`, `bin`, `hex`, `c`, `shellstorm` |
| `--to-OUTPUT` | Specify output format: `asm`, `obj`, `exe`, `bin`, `hex`, `c`, `completec`, `python`, `bash`, `ruby`, `pretty`, `safeasm` |
| `-` | Use as filename for stdin (input) or stdout (output) |

### General Configuration

| Flag | Description |
|------|-------------|
| `--64` | Enable 64-bit mode (default: 32-bit) |
| `--intel` | Use Intel syntax (default: AT&T) |
| `-c` | Prepend a breakpoint (e.g., `int3`) to the shellcode |
| `-q` | Quiet mode |
| `-v`, `-vv`, `-vvv` | Verbose mode (shows low-level conversion steps) |

### Debugging & Execution

| Flag | Description |
|------|-------------|
| `--to-strace` | Compile the shellcode and run it under `strace` |
| `--to-gdb` | Compile the shellcode and run it under `gdb` with a breakpoint at entry |

### Standalone Plugins & Utilities

| Flag | Description |
|------|-------------|
| `-i` | Interactive mode |
| `--to-asm` | Used with `-i`: Interactive opcode-to-assembly |
| `--to-opcode` | Used with `-i`: Interactive assembly-to-opcode |
| `--get-const <const>` | Resolve a constant name to its value |
| `--get-sysnum <name>` | Resolve a syscall name to its number |
| `--get-strerror <err>` | Resolve an error number to its string description |
| `--file-patch <fp> <off> <hex>` | Patch a file at a specific offset with hex data |
| `--vm-patch <fp> <addr> <hex>` | Patch a file at a specific VM address with hex data |
| `--fork-nopper <exe_fp>` | NOP out calls to `fork()` in the specified executable |

### System Commands

| Flag | Description |
|------|-------------|
| `--install` | Copies the script to a convenient system location |
| `--uninstall` | Removes the installed script |
| `--force` | Force installation/uninstallation |

## Notes
- **Architecture Support**: Built-in support for Linux (x86, x86_64, ARM) and FreeBSD (x86, x86_64).
- **Dependencies**: Relies on `gcc`, `as`, `objdump`, and `python3`.
- **Binary Patching**: The `--file-patch`, `--vm-patch`, and `--fork-nopper` plugins are primarily tested on x86/x86_64.
- **Safeasm**: The `safeasm` output format is useful for avoiding "bad bytes" (like null bytes) in specific environments.