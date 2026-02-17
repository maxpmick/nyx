---
name: hexwalk
description: Analyze, view, and edit binary files using a graphical hex editor with integrated entropy analysis, byte mapping, and binwalk support. Use when performing malware analysis, reverse engineering, firmware analysis, or forensic investigation of binary data to identify patterns, calculate hashes, and visualize file structure.
---

# hexwalk

## Overview
HexWalk is a cross-platform graphical hex editor, viewer, and analyzer. it integrates features from projects like qhexedit2 and binwalk to provide advanced binary analysis capabilities including entropy visualization, pattern matching, and file diffing. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume hexwalk is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install hexwalk
```

## Common Workflows

### Basic Binary Inspection
Launch the GUI to open and inspect a specific binary file:
```bash
hexwalk /path/to/suspicious_file.bin
```

### Firmware Analysis
Open a firmware image to use the integrated **Binwalk** functionality for identifying embedded file systems or compressed payloads, and use the **Entropy Analysis** tab to locate encrypted or compressed sections.

### Pattern Searching
Use the advanced find feature within the GUI to search for specific signatures using **Regex**, **HEX**, **UTF8**, or **UTF16** encoding to identify hardcoded strings or magic bytes.

### Binary Diffing
Open two different versions of a file or two similar binaries to perform a **Diff file analysis** to identify modified bytes or patches.

## Complete Command Reference

HexWalk is primarily a GUI-based application.

```bash
hexwalk [filename]
```

### GUI Features and Capabilities

| Feature | Description |
|------|-------------|
| **Advanced Search** | Find patterns based on HEX, UTF8, UTF16, and Regular Expressions. |
| **Binwalk Integration** | Identify signatures and embedded files within the loaded binary. |
| **Entropy Analysis** | Visualize data density to find compressed or encrypted regions. |
| **Byte Map** | Graphical representation of the byte distribution in the file. |
| **Hash Calculator** | Calculate cryptographic hashes (MD5, SHA, etc.) of the file or selections. |
| **Converter** | Built-in Binary/Decimal/Hexadecimal base converter. |
| **Hex Editing** | Direct manipulation and editing of raw bytes. |
| **Diff Analysis** | Compare two files to highlight differences in hex data. |
| **Header Parsing** | Use Byte Patterns to parse and interpret file headers. |

## Notes
- HexWalk relies on QT5 for its interface; ensure an X11 or Wayland session is available if running from a remote server.
- The tool is particularly useful for identifying "packed" sections of code by looking for high-entropy blocks.
- It provides a more user-friendly, visual alternative to command-line tools like `hexdump` or `xxd` for deep manual inspection.