---
name: cmospwd
description: Decrypt BIOS passwords from CMOS and perform CMOS backup, restoration, or clearing. Use when performing physical security assessments, password recovery for BIOS/UEFI settings, or when needing to bypass BIOS-level protections on legacy or modern systems.
---

# cmospwd

## Overview
CmosPwd is a cross-platform tool designed to decrypt passwords stored in CMOS used to access a computer's BIOS setup. It can also dump CMOS contents, backup/restore CMOS settings to a file, or "kill" (clear) the CMOS memory. Category: Password Attacks.

## Installation (if not already installed)
Assume cmospwd is already installed. If you get a "command not found" error:

```bash
sudo apt install cmospwd
```

## Common Workflows

### Decrypt BIOS password from live CMOS
```bash
sudo cmospwd
```
Attempts to identify the BIOS type and decrypt the password currently stored in the system's CMOS.

### Dump CMOS memory to screen
```bash
sudo cmospwd /d
```
Displays the raw hex dump of the CMOS memory.

### Backup CMOS to a file
```bash
sudo cmospwd /w cmos_backup.bin
```
Saves the current CMOS state to a file named `cmos_backup.bin`.

### Clear (Kill) CMOS settings
```bash
sudo cmospwd /k
```
Wipes the CMOS settings (use with caution as this resets BIOS to factory defaults).

### Decrypt password from a backup file
```bash
cmospwd /l cmos_backup.bin
```

## Complete Command Reference

```
cmospwd [Options]
```

### General Options

| Flag | Description |
|------|-------------|
| `/d` | Dump CMOS memory to the console in hex format |
| `/k` | Kill CMOS (clears settings/passwords by invalidating checksum) |
| `/kde` | Use German QWERTZ keyboard mapping for password decryption |
| `/kfr` | Use French AZERTY keyboard mapping for password decryption |
| `/m[01]*` | Execute selected modules (e.g., `/m0010011` executes modules 3, 6, and 7) |

### File Operations

| Flag | Description |
|------|-------------|
| `/w <file>` | **Write**: Save current CMOS content to a backup file |
| `/l <file>` | **Load**: Read a CMOS backup file and attempt to decrypt passwords from it |
| `/r <file>` | **Restore**: Restore CMOS settings from a previously saved backup file |

## Notes
- **Privileges**: Most operations (except loading a local backup file) require root/administrator privileges to access hardware ports (`/dev/nvram` or direct I/O).
- **Award BIOS**: For Award BIOS, the decrypted passwords displayed may differ from the original characters but are functional equivalents that will be accepted by the BIOS.
- **Compatibility**: While it works on most modern systems, some proprietary or highly secure UEFI implementations may store passwords in encrypted flash memory rather than standard CMOS, rendering them unrecoverable by this tool.
- **Risk**: Using the `/k` (kill) or `/r` (restore) options can render a system unbootable if the BIOS settings are corrupted or incompatible. Use with caution.