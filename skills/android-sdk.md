---
name: android-sdk
description: Manage Android SDK components, platforms, and Android Virtual Devices (AVD). Use when setting up Android development environments, creating emulators for mobile application security testing, managing SDK packages, or configuring Android projects for analysis and exploitation.
---

# android-sdk

## Overview
The Android SDK provides API libraries and developer tools necessary to build, test, and debug Android applications. In a security context, it is primarily used to manage the Android emulator (AVD) and SDK components required for mobile penetration testing and reverse engineering. Category: Mobile Application Testing.

## Installation (if not already installed)
Assume the SDK is installed. If the `android` command is missing:

```bash
sudo apt update
sudo apt install android-sdk
```

## Common Workflows

### List available targets and virtual devices
```bash
android list target
android list avd
```

### Create a new Android Virtual Device (AVD)
```bash
android create avd -n MyTestDevice -t android-25
```

### Update the SDK and install new platforms
```bash
android update sdk --no-ui
```

### Update an existing project
```bash
android update project --path /path/to/android/project
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-s`, `--silent` | Silent mode, shows errors only |
| `-v`, `--verbose` | Verbose mode, shows errors, warnings, and all messages |
| `--clear-cache` | Clear the SDK Manager repository manifest cache |
| `-h`, `--help` | Help on a specific command |

### Actions
Actions are composed of a verb and an optional direct object.

| Action | Description |
|--------|-------------|
| `sdk` | Displays the SDK Manager window (GUI) |
| `avd` | Displays the AVD Manager window (GUI) |
| `list` | Lists existing targets or virtual devices |
| `list avd` | Lists existing Android Virtual Devices |
| `list target` | Lists existing targets (API levels/platforms) |
| `list sdk` | Lists remote SDK repository packages |
| `create avd` | Creates a new Android Virtual Device |
| `move avd` | Moves or renames an Android Virtual Device |
| `delete avd` | Deletes an Android Virtual Device |
| `update avd` | Updates an AVD to match the folders of a new SDK |
| `create project` | Creates a new Android project |
| `update project` | Updates an existing Android project |
| `create test-project` | Creates a new Android project for a test package |
| `update test-project` | Updates the Android project for a test package |
| `create lib-project` | Creates a new Android library project |
| `update lib-project` | Updates an Android library project |
| `create uitest-project` | Creates a new UI test project |
| `update adb` | Updates adb to support USB devices declared in SDK add-ons |
| `update sdk` | Updates the SDK by suggesting new platforms to install |

## Notes
- Many `android` command functions have been superseded by `sdkmanager` and `avdmanager` in newer versions of the Android Build Tools, but the `android` wrapper remains common in many legacy Kali environments.
- GUI-based actions (`sdk`, `avd`) require an X11 forwarding session or a local desktop environment.
- When using `update project`, the directory must already contain an `AndroidManifest.xml`.