---
name: bytecode-viewer
description: Reverse engineer Java Jar and Android APK files using a comprehensive suite of decompilers, editors, and debuggers. Use when performing malware analysis, auditing Java/Android applications, decompiling bytecode to source code, or editing DEX/Smali files during reverse engineering or digital forensics.
---

# bytecode-viewer

## Overview
Bytecode Viewer (BCV) is an advanced lightweight Java Bytecode Viewer, GUI Java Decompiler, and APK/DEX Reverse Engineering Suite. It integrates multiple decompilers (Procyon, CFR, FernFlower, Krakatau), editors (Smali/Baksmali), and tools like DEX2Jar and Hex viewers into a single interface. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume bytecode-viewer is already installed. If you get a "command not found" error:

```bash
sudo apt install bytecode-viewer
```

Dependencies: `default-jre`, `java-wrappers`.

## Common Workflows

### Launch the GUI
```bash
bytecode-viewer
```
Opens the main graphical interface where you can drag and drop JAR, APK, CLASS, or DEX files for analysis.

### Open a specific file directly
```bash
bytecode-viewer application.jar
```

### Analyze an Android APK
```bash
bytecode-viewer mobile-app.apk
```
This will trigger the internal DEX2Jar and Smali/Baksmali integrations to allow viewing of both the Java source and the Dalvik bytecode.

### Using Plugins
Once the GUI is open, navigate to the "Plugins" menu to run pre-written Groovy scripts for string deobfuscation or malicious code searching across all loaded classfiles.

## Complete Command Reference

Bytecode Viewer is primarily a GUI-based application. The command-line interface is used to launch the environment or load specific files into the workspace.

```
bytecode-viewer [options] [files...]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help message and version information |

### Integrated Components
Bytecode Viewer provides a GUI wrapper for the following tools:
- **Java Decompilers**: Procyon, CFR, FernFlower, Krakatau.
- **Bytecode Editors**: Bytecode, Smali, Baksmali.
- **Android Tools**: DEX2Jar, Jar2DEX, APK Decompiler, DEX Decompiler.
- **Utilities**: Hex Viewer, Code Searcher, Debugger, Jar-Jar.

## Notes
- **Plugin System**: Supports Groovy scripting. Plugins receive a `ClassNode ArrayList` of every loaded class, allowing for full manipulation using the ASM library.
- **Memory**: As a Java application, if you are loading very large APKs or JARs, you may need to increase the JVM heap size if launched via `java -jar`.
- **Cross-Platform**: While packaged for Kali, it runs on any system with Java 8+.