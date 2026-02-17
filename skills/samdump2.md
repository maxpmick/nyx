---
name: samdump2
description: Extract Windows 2k/NT/XP/Vista password hashes from SAM and SYSTEM registry hives. Use when performing offline password cracking, digital forensics, or credential harvesting from Windows backup files or mounted disk images.
---

# samdump2

## Overview
samdump2 is a utility designed to retrieve the syskey bootkey from a Windows SYSTEM hive and use it to decrypt and dump password hashes (LM and NTLM) from the SAM database. It incorporates the functionality of the legacy `bkhive` tool. Category: Digital Forensics / Password Attacks.

## Installation (if not already installed)

Assume samdump2 is already installed. If you get a "command not found" error:

```bash
sudo apt install samdump2
```

## Common Workflows

### Basic hash extraction
Extract hashes from local or mounted registry hives and display them in the terminal:
```bash
samdump2 SYSTEM SAM
```

### Save hashes to a file for cracking
Extract hashes and save them to a file compatible with John the Ripper or Hashcat:
```bash
samdump2 -o hashes.txt /path/to/SYSTEM /path/to/SAM
```

### Debugging extraction issues
If the tool fails to parse the hives, use debug mode to identify where the process is failing:
```bash
samdump2 -d SYSTEM SAM
```

## Complete Command Reference

```
samdump2 [OPTION]... SYSTEM_FILE SAM_FILE
```

| Flag | Description |
|------|-------------|
| `-d` | Enable debugging output to troubleshoot parsing errors |
| `-h` | Display help information and usage |
| `-o file` | Write the extracted hashes to the specified file instead of stdout |

## Notes
- This tool requires both the **SYSTEM** and **SAM** registry hives from the target Windows machine.
- These files are typically located at `%SystemRoot%\System32\config\`.
- Because these files are locked while Windows is running, they must be acquired via offline access (e.g., booting from a Live USB), from a backup/Volume Shadow Copy, or by using a tool like `reg save` on a live system with administrative privileges.
- Supports Windows NT, 2000, XP, and Vista. For newer versions of Windows (7, 10, 11), specialized tools like `secretsdump.py` from the Impacket suite are often preferred, though `samdump2` may still function for basic SAM/SYSTEM extraction.