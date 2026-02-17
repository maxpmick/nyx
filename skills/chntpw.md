---
name: chntpw
description: View and modify Windows NT/2000/XP/Vista/7/8/8.1 user databases (SAM files). Use when performing offline password resets, unlocking locked Windows accounts, promoting users to the Administrators group, or editing the Windows registry from a Linux environment during penetration testing or digital forensics.
---

# chntpw

## Overview
A suite of utilities designed to overwrite Windows passwords, unlock accounts, and edit registry hives by modifying the SAM and registry files directly. It supports both 32 and 64-bit Windows versions. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install chntpw
```

## Common Workflows

### Interactive Password Reset
```bash
chntpw -i /mnt/windows/Windows/System32/config/SAM
```
Provides a menu to list users, change passwords (clear/blank), promote users to admin, or unlock accounts.

### List Users in SAM Hive
```bash
chntpw -l /mnt/windows/Windows/System32/config/SAM
```

### Reset Password for Specific User (Non-interactive)
```bash
sampasswd -r -u Administrator /mnt/windows/Windows/System32/config/SAM
```

### Add User to Administrators Group
```bash
samusrgrp -a -u "Guest" -g 0x220 /mnt/windows/Windows/System32/config/SAM
```
Note: `0x220` is the standard RID for the Administrators group.

### Export Registry Key
```bash
reged -x /mnt/windows/Windows/System32/config/SOFTWARE HKEY_LOCAL_MACHINE\SOFTWARE Microsoft out.reg
```

## Complete Command Reference

### chntpw
Main utility for password manipulation and registry editing.
`chntpw [OPTIONS] <samfile> [systemfile] [securityfile] [otherreghive] [...]`

| Flag | Description |
|------|-------------|
| `-h` | Show help message |
| `-u <user>` | Username or RID (e.g., 0x3e9) to interactively edit |
| `-l` | List all users in SAM file and exit |
| `-i` | Interactive Menu system |
| `-e` | Registry editor with full write support |
| `-d` | Enter buffer debugger (hex editor) |
| `-v` | Verbose output for debugging |
| `-L` | For scripts, write names of changed files to `/tmp/changed` |
| `-N` | No allocation mode (only same length overwrites, very safe) |
| `-E` | No expand mode (do not expand hive file, safe mode) |

### reged
Utility to export, import, and edit Windows registry hives.
`reged [MODES] [OPTIONS]`

**Modes:**
- `-x <hive> <prefix> <key> <output.reg>`: Export registry key to `.reg` file.
- `-I <hive> <prefix> <input.reg>`: Import from `.reg` file into hive.
- `-e <hive> ...`: Interactive edit one or more registry files.

**Options:**
- `-L`: Log changed filenames to `/tmp/changed` and auto-save.
- `-C`: Auto-save (commit) changed hives without asking.
- `-N`: No allocate mode (same size edits only).
- `-E`: No expand mode.
- `-t`: Debug trace of allocated blocks.
- `-v`: Verbose messages.

### sampasswd
Reset passwords of users in the SAM database.
`sampasswd [-r|-l] [-H] -u <user> <samhive>`

**Modes:**
- `-r`: Reset user's password.
- `-l`: List users in SAM.

**Parameters:**
- `-u <user>`: Username or RID (hex with 0x).
- `-a`: Reset password of all users in administrators group (0x220).
- `-f`: Reset password of admin user with lowest RID (excluding 0x1f4 unless only admin).

**Options:**
- `-H`: Human readable listing (for `-l`) or confirmation message (for `-r`).
- `-N`: No allocate mode.
- `-E`: No expand mode.
- `-t`: Debug trace.
- `-v`: Verbose/debug messages.

### samunlock
Unlock locked-out users in the SAM database.
`samunlock [-U|-l] [-H] -u <user> <samhive>`

**Modes:**
- `-U`: Unlock user.
- `-l`: List users in SAM.

**Parameters:**
- `-u <user>`: Username or RID (hex with 0x).
- `-f`: Unlock admin user with lowest RID (excluding 0x1f4 unless only admin).

**Options:**
- `-H`: Human readable listing (for `-l`) or confirmation message (for `-U`).
- `-N`: No allocate mode.
- `-E`: No expand mode.
- `-t`: Debug trace.
- `-v`: Verbose/debug messages.

### samusrgrp
Add or remove users from groups in SAM database files.
`samusrgrp [-a|-r|-l|-L|-s] -u <user> -g <groupid> <samhive>`

**Modes:**
- `-a`: Add user to group.
- `-r`: Remove user from group.
- `-l`: List groups.
- `-L`: List groups and their members.
- `-s`: Print machine SID.

**Parameters:**
- `-u <user>`: Username or RID (hex with 0x).
- `-g <groupid>`: Group RID in hex (e.g., 0x220 for Administrators).

**Options:**
- `-H`: Human readable output.
- `-N`: No allocate mode.
- `-E`: No expand mode.
- `-t`: Debug trace.
- `-v`: Verbose/debug messages.

## Notes
- **Safety**: Use `-N` or `-E` flags if you are concerned about corrupting the registry hive.
- **RIDs**: If a username contains international characters or spaces, use the RID (e.g., `0x1f4`) instead of the name.
- **Pathing**: Windows registry files are typically located in `Windows/System32/config/`.
- **Write Access**: Ensure the target partition is mounted with write permissions (e.g., `ntfs-3g`).