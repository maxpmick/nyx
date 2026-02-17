---
name: pyinstxtractor
description: Extract the contents of a PyInstaller generated executable file to recover original Python bytecode (pyc files) and embedded resources. Use when performing reverse engineering, malware analysis, or security auditing of compiled Python Windows (EXE) or Linux binaries.
---

# pyinstxtractor

## Overview
PyInstaller Extractor (pyinstxtractor) is a specialized tool designed to unpack and extract the internal contents of executables created with PyInstaller. It recovers the original compiled Python bytecode (.pyc files) and other bundled assets, which is a critical first step in reverse engineering Python-based applications. Category: Reverse Engineering.

## Installation (if not already installed)
Assume pyinstxtractor is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install pyinstxtractor
```

Dependencies: python3.

## Common Workflows

### Basic Extraction
Extract the contents of a PyInstaller executable into a new directory.
```bash
pyinstxtractor target_app.exe
```

### Extracting Linux Binaries
The tool works on ELF binaries created by PyInstaller on Linux as well.
```bash
pyinstxtractor ./target_binary
```

### Post-Extraction Analysis
After extraction, the tool creates a folder named `[filename]_extracted`. You can then use a decompiler like `uncompyle6` or `pycdc` on the resulting `.pyc` files to recover the source code.

## Complete Command Reference

The tool is typically invoked as a standalone script or via the `pyinstxtractor` wrapper. It takes the target executable as its primary argument.

```bash
pyinstxtractor <filename>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<filename>` | The path to the PyInstaller generated executable (EXE or ELF) to be extracted. |

*Note: As of the current version, the tool does not use standard flags like `-h` or `--help`. Running the command without arguments or with an invalid filename will result in an error message.*

## Notes
- **Bytecode Versioning**: The extracted `.pyc` files will correspond to the Python version used to compile the original executable. You may need to fix the `.pyc` headers (adding the magic number) before decompiling; however, recent versions of `pyinstxtractor` attempt to automate this by providing a template header in the extracted folder.
- **Entry Point**: Look for a file named `pyiboot01-hosts` or a file with the same name as the original executable within the extracted directory to find the main entry point of the application.
- **Safety**: Always perform extraction and analysis of unknown or suspicious binaries within a sandbox or isolated virtual machine.