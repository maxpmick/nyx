---
name: ollydbg
description: Analyze 32-bit Windows executables at the assembler level. Use when performing reverse engineering, malware analysis, binary exploitation, or digital forensics on Windows binaries where source code is unavailable.
---

# ollydbg

## Overview
OllyDbg is a 32-bit assembler-level analyzing debugger for Microsoft Windows. It specializes in binary code analysis, making it essential for reverse engineering, vulnerability research, and debugging compiled applications when source code is missing. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)

OllyDbg runs via Wine on Kali Linux. If it is not installed or the environment is not configured for 32-bit applications, run:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine32 ollydbg
```

## Common Workflows

### Launching the Debugger
To start the OllyDbg GUI environment:
```bash
ollydbg
```
Alternatively, via wine directly:
```bash
wine /usr/share/ollydbg/OLLYDBG.EXE
```

### Debugging a specific Windows executable
```bash
ollydbg path/to/file.exe
```

### Attaching to a running process
1. Launch `ollydbg`.
2. Press `F6` or go to `File` -> `Attach`.
3. Select the target process from the list.

## Complete Command Reference

OllyDbg is primarily a graphical tool. When launched from the command line, it accepts the following syntax:

```bash
ollydbg [executable_path] [arguments]
```

### GUI Keyboard Shortcuts (Internal)

| Key | Action |
|-----|--------|
| `F2` | Set/Remove Breakpoint |
| `F7` | Step Into |
| `F8` | Step Over |
| `F9` | Run Program |
| `F12` | Pause |
| `Ctrl+F2` | Restart Program |
| `Alt+B` | View Breakpoints window |
| `Alt+C` | View CPU window |
| `Alt+M` | View Memory window |
| `Alt+E` | View Executable modules |

## Notes
- **Architecture**: OllyDbg 1.10 is strictly a **32-bit** debugger. It cannot debug 64-bit (x64) Windows binaries.
- **Wine Environment**: Since this tool runs under Wine, file paths within the debugger may follow Windows conventions (e.g., `Z:\usr\bin\`).
- **Privileges**: If debugging a process that requires elevated permissions, ensure you have the necessary rights within the Wine prefix.