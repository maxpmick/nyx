---
name: apktool
description: Reverse engineer Android APK files by decoding resources to nearly original form and rebuilding them after modifications. Use for Android application analysis, malware analysis, smali code debugging, and modifying APK behavior during penetration testing or digital forensics.
---

# apktool

## Overview
Apktool is a tool for reverse engineering 3rd party, closed, binary Android apps. It can decode resources (including `AndroidManifest.xml` and `resources.arsc`) and disassemble Java bytecode into smali code. It also allows for rebuilding the modified files back into a functional APK. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume apktool is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install apktool
```

## Common Workflows

### Decompile an APK
Decodes the APK into a directory for analysis or modification.
```bash
apktool d app_name.apk -o output_directory
```

### Build an APK from a directory
Reassembles the decoded directory back into a signed/unsigned APK.
```bash
apktool b modified_app_dir -o new_app.apk
```

### Install a custom framework
Used for apps that depend on manufacturer-specific frameworks (e.g., Samsung or HTC).
```bash
apktool if framework-res.apk
```

### Decompile without resources or sources
Useful if you only want to look at the manifest/assets or only the smali code.
```bash
# Only decode sources (smali), skip resources
apktool d app.apk -r

# Only decode resources, skip sources (no smali)
apktool d app.apk -s
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-advance`, `--advanced` | Prints advanced information and options |
| `-version`, `--version` | Prints the version then exits |

### Subcommand: `d[ecode]`
Decodes an APK file into a project directory.
```bash
apktool d [options] <file_apk>
```
| Flag | Description |
|------|-------------|
| `-f`, `--force` | Force delete destination directory if it exists |
| `-o`, `--output <dir>` | The name of folder that gets written (Default: apk.out) |
| `-p`, `--frame-path <dir>` | Uses framework files located in `<dir>` |
| `-r`, `--no-res` | Do not decode resources (prevents decompiling `resources.arsc`) |
| `-s`, `--no-src` | Do not decode sources (prevents disassembling `classes.dex`) |
| `-t`, `--frame-tag <tag>` | Uses framework files tagged by `<tag>` |

### Subcommand: `b[uild]`
Builds an APK from a previously decoded directory.
```bash
apktool b [options] <app_path>
```
| Flag | Description |
|------|-------------|
| `-f`, `--force-all` | Skip changes detection and build all files |
| `-o`, `--output <dir>` | The name of the APK file to be written (Default: `dist/name.apk`) |
| `-p`, `--frame-path <dir>` | Uses framework files located in `<dir>` |

### Subcommand: `if` | `install-framework`
Installs framework files to the system for handling vendor-specific dependencies.
```bash
apktool if [options] <framework.apk>
```
| Flag | Description |
|------|-------------|
| `-p`, `--frame-path <dir>` | Stores framework files into `<dir>` |
| `-t`, `--tag <tag>` | Tag frameworks using `<tag>` |

## Notes
- **Signing**: Rebuilt APKs using `apktool b` are unsigned. You must sign them (using `jarsigner` or `apksigner`) and `zipalign` them before they can be installed on a device.
- **Frameworks**: If you encounter errors regarding missing resources during decoding, you likely need to pull the framework APK from the device (usually in `/system/framework/`) and install it using `apktool if`.
- **Smali**: The source code is decoded into Smali, an intermediate assembly language for the Dex format. Use a Smali-capable editor for modifications.