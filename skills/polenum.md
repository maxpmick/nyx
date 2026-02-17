---
name: polenum
description: Extract password policy information from a remote Windows system using the Impacket library. Use when performing reconnaissance, vulnerability analysis, or password auditing to identify security settings such as minimum password length, complexity requirements, and lockout thresholds.
---

# polenum

## Overview
polenum is a Python script that utilizes the Impacket library to query and extract password policy details from remote Windows machines. It allows security professionals to audit Windows security settings from non-Windows platforms (Linux, macOS, BSD) via SMB. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)

Assume polenum is already installed. If you get a "command not found" error:

```bash
sudo apt install polenum
```

Dependencies: python3, python3-impacket.

## Common Workflows

### Standard extraction using inline credentials
```bash
polenum username:password@192.168.1.200
```

### Extraction specifying a specific protocol/port
```bash
polenum victim:s3cr3t@192.168.1.200 '445/SMB'
```

### Using explicit flags for credentials and domain
```bash
polenum -u administrator -p 'P@ssword123' -d WORKGROUP 192.168.1.200
```

## Complete Command Reference

```
usage: polenum [-h] [--username USERNAME] [--password PASSWORD]
               [--domain DOMAIN] [--protocols [PROTOCOLS ...]]
               [enum4linux]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `enum4linux` | Target string in the format `username:password@IPaddress` |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--username`, `-u <USERNAME>` | The specified username for authentication |
| `--password`, `-p <PASSWORD>` | The password of the user |
| `--domain`, `-d <DOMAIN>` | The domain name or IP address |
| `--protocols [PROTOCOLS ...]` | Specify protocols to use (e.g., `139/SMB`, `445/SMB`) |

## Notes
- The tool provides detailed output including:
    - Minimum/Maximum password age
    - Minimum password length
    - Password history length
    - Password complexity flags (Cleartext storage, Lockout Admins, etc.)
    - Account lockout thresholds and durations
- This tool requires valid credentials (or a valid null session if configured on the target) to query the SAM/LSARPC interfaces.
- It is particularly useful for determining if a target is susceptible to password spraying by checking the `Account Lockout Threshold`.