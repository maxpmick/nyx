---
name: jd-gui
description: Decompile and analyze Java bytecode using a graphical interface. Use when performing reverse engineering of Java applications, analyzing .class or .jar files, or recovering source code from compiled Java binaries during security assessments.
---

# jd-gui

## Overview
JD-GUI is a standalone graphical utility that displays Java source codes of ".class" files. It allows for browsing reconstructed source code with instant access to methods and fields. Category: Reverse Engineering.

## Installation (if not already installed)
Assume jd-gui is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install jd-gui
```

Dependencies: default-jre, java-wrappers.

## Common Workflows

### Launch the GUI
Simply run the command to open the graphical interface:
```bash
jd-gui
```

### Open a specific JAR or Class file
Launch the tool and immediately load a target file for analysis:
```bash
jd-gui target_application.jar
```

### Analyze multiple files
Open several files simultaneously in the GUI tabs:
```bash
jd-gui file1.class file2.jar file3.war
```

## Complete Command Reference

```
jd-gui [FILES]
```

| Argument | Description |
|----------|-------------|
| `FILES`  | Optional list of paths to `.class`, `.jar`, `.war`, or `.ear` files to open upon startup. |

### GUI Features
Once the application is launched, the following functionality is available via the interface:
- **File Navigation**: Tree view of packages and classes within archives.
- **Syntax Highlighting**: Color-coded Java source code reconstruction.
- **Search**: Search for strings, types, methods, and fields across loaded files.
- **Save Source**: Export the decompiled source code into a ZIP archive (`File` -> `Save All Sources`).
- **Drag and Drop**: Support for dragging files directly into the window for decompilation.

## Notes
- JD-GUI is a wrapper around the JD-Core library.
- While highly effective, decompilation may not always produce 100% accurate source code, especially if the bytecode was obfuscated (e.g., using ProGuard or DexGuard).
- For Android applications, you must first convert `.dex` files to `.jar` (using tools like `dex2jar`) before opening them in JD-GUI.