---
name: smali
description: Assemble and disassemble Android Dalvik Executable (DEX) files. Use when performing Android application analysis, reverse engineering APKs, modifying Dalvik bytecode, or conducting digital forensics on Android binaries.
---

# smali / baksmali

## Overview
smali and baksmali are an assembler and disassembler, respectively, for the DEX format used by Dalvik, Android's Java VM implementation. The syntax is based on Jasmin's/dedexer's syntax and supports the full functionality of the DEX format, including annotations and debug info. Category: Digital Forensics / Reverse Engineering.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install smali
```
Dependencies: default-jre, java-wrappers.

## Common Workflows

### Disassemble a DEX file
```bash
baksmali disassemble classes.dex -o out_directory
```

### Assemble smali files into a DEX file
```bash
smali assemble out_directory -o classes.dex
```

### Deodex an Android OAT/ODEX file
```bash
baksmali deodex framework.oat -b boot.art -o out_dir
```

### List methods in a DEX file
```bash
baksmali list methods classes.dex
```

## Complete Command Reference

### baksmali (Disassembler)
Usage: `baksmali [options] <command> [<args>]`

#### Global Options
| Flag | Description |
|------|-------------|
| `--help`, `-h`, `-?` | Show usage information |
| `--version`, `-v` | Print the version of baksmali and exit |

#### Commands
| Command | Aliases | Description |
|---------|---------|-------------|
| `deodex` | `de`, `x` | Deodexes an odex/oat file |
| `disassemble` | `dis`, `d` | Disassembles a dex file |
| `dump` | `du` | Prints an annotated hex dump for the given dex file |
| `help` | `h` | Shows usage information for a specific command |
| `list` | `l` | Lists various objects (classes, methods, fields) in a dex file |

---

### smali (Assembler)
Usage: `smali [options] <command> [<args>]`

#### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `-?`, `--help` | Show usage information |
| `-v`, `--version` | Print the version of smali and exit |

#### Commands
| Command | Aliases | Description |
|---------|---------|-------------|
| `assemble` | `ass`, `as`, `a` | Assembles smali files into a dex file |
| `help` | `h` | Shows usage information for a specific command |

## Notes
- When disassembling, the output is a set of `.smali` files which are human-readable representations of Dalvik bytecode.
- When assembling, the input is typically a directory containing `.smali` files.
- Use `baksmali help <command>` or `smali help <command>` to see specific arguments for subcommands like `disassemble` or `assemble` (e.g., setting API levels or classpath directories).