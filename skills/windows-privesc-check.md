---
name: windows-privesc-check
description: Audit Windows systems for misconfigurations that allow local privilege escalation. It identifies weaknesses in file permissions, service configurations, and registry settings that could allow an unprivileged user to gain higher-level access. Use during the post-exploitation phase of a penetration test after gaining a local shell on a Windows target to identify paths to System or Administrator privileges.
---

# windows-privesc-check

## Overview
Windows-privesc-check is a standalone executable designed to run on Windows systems to identify security misconfigurations. It audits the system for vulnerabilities that could allow local unprivileged users to escalate privileges to other users or access local applications like databases. It is particularly effective when run as an Administrator (to read more configuration files), but provides valuable insights when run as a standard user. Category: Post-Exploitation.

## Installation (if not already installed)

The tool is a Windows executable located in the Kali Linux repositories. To ensure the resource is available on your Kali instance:

```bash
sudo apt update && sudo apt install windows-privesc-check
```

The executable is located at:
`/usr/share/windows-resources/windows-privesc-check/windows-privesc-check2.exe`

## Common Workflows

### Basic Audit
Upload the executable to the target Windows machine and run it to perform a standard check:
```cmd
windows-privesc-check2.exe
```

### Audit with Report Generation
Run the tool and redirect output to a text file for later analysis:
```cmd
windows-privesc-check2.exe > audit_results.txt
```

### Running from Kali via Smbclient/Impacket
If you have credentials, you can upload and execute the tool using Impacket's `psexec.py` or `smbclient`:
```bash
# From Kali
impacket-psexec administrator@192.168.1.100
# Inside the shell, run the uploaded exe
C:\Windows\Temp\windows-privesc-check2.exe
```

## Complete Command Reference

The tool is primarily distributed as a compiled Windows binary (`windows-privesc-check2.exe`).

### Execution
```cmd
windows-privesc-check2.exe [options]
```

### Options
*Note: As a standalone binary converted from Python via PyInstaller, the version 2.0 series focuses on automated scanning upon execution.*

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--dump` | Dump all gathered information to the screen |
| `--audit` | Run audit checks (default behavior) |

## Notes
- **Target OS**: Originally tested on Windows XP and Windows 7. While it may work on newer versions of Windows, some checks might be superseded by modern Windows security features.
- **Execution Context**: Running the tool as a low-privileged user limits its ability to inspect certain registry keys and sensitive file system areas. For the most comprehensive audit, run it from a medium-integrity or high-integrity process if possible.
- **Standalone Nature**: The tool is bundled with all necessary Python dependencies, meaning no Python installation is required on the target Windows host.
- **Location on Kali**: Always look for the binary in `/usr/share/windows-resources/windows-privesc-check/`.