---
name: radare2-cutter
description: A Qt-based GUI for the radare2 reverse engineering framework. Use when performing static or dynamic analysis of binaries, malware analysis, or firmware reversing where a graphical interface for radare2 is preferred over the CLI. Trigger scenarios include binary exploitation research, reverse engineering tasks, and digital forensics.
---

# radare2-cutter

## Overview
Cutter is a free and open-source reverse engineering platform powered by radare2. It provides a modern and customizable GUI for users who want to perform binary analysis without the steep learning curve of radare2's command-line interface. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume Cutter is already installed. If the command is not found:

```bash
sudo apt update
sudo apt install radare2-cutter
```

## Common Workflows

### Open a binary for basic analysis
```bash
cutter -A 1 /path/to/binary
```
Opens the file and automatically runs `aaa` (standard analysis).

### Open a binary for experimental deep analysis
```bash
cutter -A 2 /path/to/binary
```
Opens the file and runs `aaaa` (experimental extended analysis).

### Open a binary without initial analysis
```bash
cutter -A 0 /path/to/binary
```
Useful for very large binaries where you want to manually trigger analysis on specific functions later.

## Complete Command Reference

```
Cutter [options] <filename>
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help information. |
| `-v`, `--version` | Displays version information. |
| `-A`, `--anal=level` | Automatically open file and optionally start analysis. Requires a filename. |
| | `0` = No analysis |
| | `1` = Standard analysis (`aaa`) |
| | `2` = Experimental analysis (`aaaa`) |
| `--pythonhome=PYTHONHOME` | Specify the `PYTHONHOME` directory to use for the integrated Jupyter notebook. |

## Notes
- Cutter is designed to be a user-friendly wrapper for radare2; however, advanced users may find more power in the radare2 CLI tools.
- The tool integrates with Jupyter for Python scripting and automation within the GUI.
- Ensure the `filename` argument is provided when using the `--anal` flag.