---
name: libsmali-java
description: Assemble and disassemble Android's DEX (Dalvik Executable) format files. Use when performing Android application reverse engineering, malware analysis, or modifying APK functionality by converting DEX files to human-readable smali code and back.
---

# libsmali-java (smali/baksmali)

## Overview
smali and baksmali are an assembler and disassembler, respectively, for the DEX format used by Dalvik, Android's Java VM implementation. The syntax is loosely based on Jasmin's/dedexer's syntax and supports the full functionality of the DEX format, including annotations, debug info, and line info. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume the tools are already installed. If missing:

```bash
sudo apt install libsmali-java
```

## Common Workflows

### Disassemble an APK's DEX file
```bash
baksmali disassemble classes.dex -o out_directory
```

### Assemble smali files into a DEX file
```bash
smali assemble out_directory -o classes.dex
```

### Deodex an Android boot OAT/ODEX file
```bash
baksmali deodex framework.oat -b boot.oat -o deodexed_out
```

### List methods in a DEX file
```bash
baksmali list methods classes.dex
```

## Complete Command Reference

### baksmali (Disassembler)

```
baksmali [--version] [--help] [<command> [<args>]]
```

#### Global Options
| Flag | Description |
|------|-------------|
| `--help`, `-h`, `-?` | Show usage information |
| `--version`, `-v` | Print the version of baksmali and then exit |

#### Commands

**deodex (de, x)**
Deodexes an odex/oat file.
- `-b`, `--boot-classpath <file>`: The boot classpath to use for deodexing.
- `-d`, `--classpath-dir <dir>`: The directory to look for classpath files in.
- `-o`, `--output <dir>`: The directory to write the disassembled files to.

**disassemble (dis, d)**
Disassembles a dex file.
- `-o`, `--output <dir>`: The directory to write the disassembled files to (default: `out`).
- `-p`, `--parameter-registers`: Use parameter registers (p0, p1, ...) instead of local registers (v0, v1, ...).
- `-l`, `--line-numbers`: Include line number information in the output.
- `-s`, `--source-file`: Include source file information in the output.

**dump (du)**
Prints an annotated hex dump for the given dex file.

**list (l)**
Lists various objects in a dex file.
- `classes`: List classes.
- `methods`: List methods.
- `fields`: List fields.
- `types`: List types.

**help (h)**
Shows usage information for baksmali or a specific command.

---

### smali (Assembler)

```
smali [-v] [-h] [<command> [<args>]]
```

#### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `-?`, `--help` | Show usage information |
| `-v`, `--version` | Print the version of smali and then exit |

#### Commands

**assemble (ass, as, a)**
Assembles smali files into a dex file.
- `-o`, `--output <file>`: The name of the dex file to write (default: `out.dex`).
- `-j`, `--jobs <n>`: The number of threads to use.
- `-a`, `--api <n>`: The numeric API level to use for the generated dex file.

**help (h)**
Shows usage information for smali or a specific command.

## Notes
- Smali code is the standard human-readable representation of Dalvik bytecode.
- When deodexing, you often need the `boot.oat` or `boot-framework.oat` from the original device to resolve dependencies.
- Use `smali help <command>` or `baksmali help <command>` to see detailed flags for specific sub-operations not listed in the top-level help.