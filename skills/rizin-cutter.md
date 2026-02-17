---
name: rizin-cutter
description: Perform GUI-based reverse engineering and binary analysis powered by the Rizin framework. Use when analyzing malware, decompiling binaries, debugging executables, or performing hardware firmware analysis and digital forensics. It provides a comprehensive visual interface for disassembly, graphing, and hex editing.
---

# rizin-cutter

## Overview
Cutter is a free and open-source reverse engineering platform powered by Rizin. It serves as an advanced, customizable GUI for binary analysis, aiming to provide a modern user experience for tasks involving disassembly, decompilation, and debugging. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume rizin-cutter is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install rizin-cutter
```

## Common Workflows

### Opening a binary for analysis
```bash
cutter /path/to/executable
```
Launches the GUI and prompts for analysis options (e.g., simple, advanced, or experimental analysis).

### Opening a file with a specific Rizin project
```bash
cutter -p my_project.rizin
```
Loads a previously saved Rizin project directly into the Cutter interface.

### Running a script on startup
```bash
cutter -python my_script.py /bin/ls
```
Opens the target binary and executes the specified Python script automatically.

### Debugging a local process
```bash
cutter debug://<pid>
```
Attaches the Cutter debugger to a running process by its Process ID.

## Complete Command Reference

```
cutter [options] [filename]
```

### Arguments
| Argument | Description |
|----------|-------------|
| `filename` | Path to the binary file to open or a URI (e.g., `debug://`, `malloc://`) |

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help message and exits |
| `-v`, `--version` | Displays version information |
| `--no-analysis` | Open the file without performing any initial analysis |
| `--analysis <level>` | Set analysis level (0 to 2, default is 1) |
| `-p <project>` | Load a specific Rizin project file |
| `-m`, `--minimal` | Start Cutter in minimal mode (no extra widgets) |
| `-A <arch>` | Force a specific architecture (e.g., x86, arm) |
| `-b <bits>` | Force a specific register size (e.g., 32, 64) |
| `-e <k=v>` | Set a Rizin configuration variable (e.g., `-e asm.bits=32`) |
| `-i <file>` | Run a Rizin script file on startup |
| `-python <file>` | Run a Python script file on startup |
| `--plugins-path <path>` | Set a custom path to search for plugins |

### Debugging Options
| Flag | Description |
|------|-------------|
| `-d`, `--debug` | Open the file in debug mode |

## Notes
- Cutter is the official GUI for **Rizin**. Most configuration variables (`-e`) compatible with Rizin/Radare2 will work within Cutter.
- For plugin development, the `librizin-cutter-dev` package is required to build C++ plugins.
- Python scripting is supported via the integrated Jupyter notebook and script execution flags, provided `python3-pyside6` and related dependencies are present.