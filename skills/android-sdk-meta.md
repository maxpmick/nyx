---
name: android-sdk-meta
description: A comprehensive suite of tools for Android application development, debugging, and security analysis. Use when performing mobile application penetration testing, interacting with Android devices via ADB, analyzing APK files, signing applications, or performing forensics on Android platforms.
---

# android-sdk-meta

## Overview
The Android SDK (Software Development Kit) is a collection of tools classified into SDK Tools, Platform-tools, and Build-tools. In a security context, these tools are essential for interacting with Android devices, extracting data, installing/uninstalling applications, and analyzing application packages (APKs). Category: Exploitation / Digital Forensics / Web Application Testing (Mobile).

## Installation (if not already installed)
Assume the tools are installed. If specific commands like `adb` or `apksigner` are missing:

```bash
sudo apt update
sudo apt install android-sdk
```

## Common Workflows

### Device Interaction and Shell Access
```bash
adb devices          # List connected devices
adb shell            # Open a terminal on the device
adb pull /sdcard/data.db ./  # Extract a file from the device
```

### APK Analysis and Signing
```bash
apksigner verify --verbose sample.apk    # Verify an APK signature
zipalign -v 4 input.apk output.apk       # Optimize an APK for alignment
aapt dump badging sample.apk             # Extract package name and permissions
```

### Debugging and Tracing
```bash
dmtracedump -h tracefile                 # Generate a call stack from a trace
hprof-conv input.hprof output.hprof      # Convert heap profile for analysis
```

## Complete Command Reference

The `android-sdk-meta` package provides several critical binaries across its sub-packages.

### Platform-Tools (Interaction)
| Tool | Description |
|------|-------------|
| `adb` | Android Debug Bridge: manage device state, shell access, and file transfer |
| `fastboot` | Flash and manipulate the device's filesystem in bootloader mode |
| `dmtracedump` | Generates graphical call stack diagrams from log files |
| `etc1tool` | Command-line utility to encode/decode PNG images to ETC1 compression |
| `hprof-conv` | Converts HPROF files to a format readable by standard analysis tools |
| `sqlite3` | Used to inspect and manipulate SQLite databases on the device |

### Build-Tools (Packaging & Analysis)
| Tool | Description |
|------|-------------|
| `aapt` | Android Asset Packaging Tool: view, create, and update Zip-compatible archives (APK, jar, zip) |
| `apksigner` | Signs APKs and confirms their signatures are valid |
| `zipalign` | Archive alignment tool that provides important optimization for APK files |
| `aidl` | Android Interface Definition Language: generates Java code for IPC |
| `split-select` | Tool for selecting the best APK for a device based on its configuration |

### SDK Tools
| Tool | Description |
|------|-------------|
| `proguard-cli` | Shrinks, optimizes, and obfuscates code by removing unused code and renaming classes |

## Notes
- **Udev Rules**: On Linux, ensure `android-udev-rules` is installed if the system fails to detect connected hardware devices.
- **Permissions**: Many `adb` operations (like accessing `/data/data/`) require the device to be rooted or the application to be in a debuggable state.
- **Pathing**: These tools are typically added to the system PATH in Kali Linux automatically. If not, check `/usr/lib/android-sdk/`.