---
name: edb-debugger
description: A graphical cross-platform x86/x86-64 debugger and disassembler inspired by OllyDbg. Use for binary analysis, reverse engineering, and exploit development on Linux ELF files. It supports attaching to running processes, generating symbol maps, and debugging executables with arguments.
---

# edb-debugger

## Overview
edb (Evan's Debugger) is a modular graphical debugger and disassembler for x86 and x86-64 binaries. It is based on the ptrace API and the Capstone disassembly library. It is primarily used for reverse engineering, malware analysis, and vulnerability research. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume edb is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install edb-debugger edb-debugger-plugins
```

## Common Workflows

### Debugging a new executable
Start the debugger and automatically load a specific binary with optional arguments:
```bash
edb --run /bin/ls -la
```

### Attaching to a running process
Attach the debugger to an existing process using its Process ID (PID):
```bash
edb --attach 1234
```

### Generating symbol maps
Create a symbol map for a shared library to improve the disassembly context within edb:
```bash
edb --symbols /lib/x86_64-linux-gnu/libc.so.6 > libc.so.6.map
```

### Bulk symbol generation
Generate maps for all libraries in a directory to populate edb's symbols directory:
```bash
for i in /lib/x86_64-linux-gnu/*.so*; do edb --symbols "$i" > "$(basename "$i").map"; done
```

## Complete Command Reference

```
edb [OPTION]... [TARGET]
```

### Options

| Flag | Description |
|------|-------------|
| `--help` | Show usage information and exit. |
| `--symbols <file>` | Generate a symbols map for the specified `<file>`. |
| `--attach <pid>` | Attach the debugger to the process with the given `<pid>`. |
| `--run <program> [args...]` | Open `<program>` in the debugger with optional `[args...]`. |
| `--version` | Show version string and exit. |
| `--dump-version` | Show version and exit. |

## Notes
- **Plugin Support**: Most of edb's functionality (like Heap Analysis, Opcode Searcher, etc.) is provided via plugins. Ensure `edb-debugger-plugins` is installed.
- **Symbol Maps**: Generated `.map` files are most useful when placed in the symbols directory configured in edb's internal preferences (**Options -> Preferences -> Symbols**).
- **Architecture**: While cross-platform in design, it is most stable on Linux for x86 and x86-64 architectures.
- **Permissions**: Debugging processes may require elevated privileges (sudo) depending on the system's `kernel.yama.ptrace_scope` settings.