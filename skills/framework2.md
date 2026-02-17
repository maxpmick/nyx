---
name: framework2
description: Access the legacy Metasploit Framework Version 2 for exploit development, shellcode generation, and historical exploit execution. Use when modern Metasploit modules are unavailable, or specifically for legacy shellcode encoding and payload generation during the exploitation phase of a penetration test.
---

# framework2

## Overview
Metasploit Framework 2 is a legacy version of the famous exploitation framework. While no longer updated, it remains a valuable resource for specific shellcode generation, historical exploits, and binary analysis tools (PE/ELF scanners). Category: Exploitation.

## Installation (if not already installed)
Assume framework2 is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install framework2
```

## Common Workflows

### Launching the Interactive Console
```bash
msfconsole2
```
Note: In Kali Linux, legacy framework components are often suffixed with '2' or located in `/usr/share/framework2/`.

### Generating Encoded Shellcode
```bash
/usr/share/framework2/msfpayload win32_bind_rc4 LPORT=4444 R | /usr/share/framework2/msfencode -e PexFnstenvMov -t c
```

### Scanning a Windows PE Binary for JMP ESP instructions
```bash
/usr/share/framework2/msfpescan -j esp /path/to/target.exe
```

### Quick Command Line Exploitation
```bash
/usr/share/framework2/msfcli <exploit_name> PAYLOAD=<payload_name> RHOST=<target_ip> E
```

## Complete Command Reference

The framework consists of several specialized scripts located in `/usr/share/framework2/`.

### Core Interfaces
| Script | Description |
|--------|-------------|
| `msfconsole` | The primary interactive command-line interface for the framework. |
| `msfcli` | A scriptable command-line interface for launching exploits without entering the console. |
| `msfweb` | A legacy web-based interface for the framework. |

### Payload & Encoding Tools
| Script | Description |
|--------|-------------|
| `msfpayload` | Tool to generate various types of shellcode/payloads. |
| `msfencode` | Tool to encode shellcode to bypass IDS or remove "bad characters" (e.g., null bytes). |
| `nops` | NOP generator for padding exploit buffers. |

### Binary Analysis & Debugging
| Script | Description |
|--------|-------------|
| `msfpescan` | Scans Windows PE files for useful opcodes (JMP, CALL, etc.) for exploit development. |
| `msfelfscan` | Scans Linux ELF files for useful opcodes and return addresses. |
| `msfdldebug` | A utility for debugging and downloading components. |
| `msflogdump` | Dumps and parses framework log files. |

### Maintenance & Development
| Script | Description |
|--------|-------------|
| `msfupdate` | Legacy update script (functionality limited due to age). |
| `sdk` | Contains resources for developing new modules for Framework 2. |
| `tools` | Miscellaneous helper scripts for exploit development. |

### Directory Structure
- `exploits/`: Contains the exploit modules.
- `payloads/`: Contains the shellcode modules.
- `encoders/`: Contains the encoding algorithms.
- `nops/`: Contains NOP sled generators.
- `lib/`: Core framework libraries.

## Notes
- **Legacy Status**: This tool is unmaintained. Use `msfconsole` (Metasploit v6+) for modern engagements unless you have a specific requirement for v2 shellcode.
- **Pathing**: On Kali, these tools are located in `/usr/share/framework2/`. You may need to provide the full path or add the directory to your PATH.
- **Compatibility**: Many exploits in this version target older operating systems (Windows NT, 2000, XP, and older Linux kernels).