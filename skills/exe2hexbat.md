---
name: exe2hexbat
description: Convert Windows PE executable files into hex-encoded batch (.bat) or PowerShell (.ps1) scripts. Use during post-exploitation to bypass file transfer restrictions, upload binaries over restricted shells (like Telnet or WinEXE), or execute payloads on Windows targets where direct binary uploads are blocked.
---

# exe2hexbat

## Overview
A Python utility designed to convert Windows executable (EXE) files into text-based formats (Batch or PowerShell). This allows for the reconstruction of binaries on a target system using native Windows tools like `DEBUG.exe` or PowerShell. Category: Post-Exploitation.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install exe2hexbat
```

## Common Workflows

### Convert EXE to a Batch file (x86)
```bash
exe2hex -x payload.exe -b payload.bat
```
Uses the `DEBUG.exe` method to reconstruct the binary on the target.

### Convert EXE to a PowerShell script (x86/x64)
```bash
exe2hex -x payload.exe -p payload.ps1
```
Uses PowerShell's ability to handle byte arrays to reconstruct the binary.

### Compress and convert for Telnet automation
```bash
exe2hex -x payload.exe -cc -p payload.ps1 -t
```
Clones the file, applies high compression, converts to PowerShell, and generates an `.expect` script for automated Telnet deployment.

### Read from STDIN and URL encode
```bash
cat payload.exe | exe2hex -s -e -p payload.ps1
```

## Complete Command Reference

```
exe2hex [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-x EXE` | The EXE binary file to convert |
| `-s` | Read the binary input from STDIN |
| `-b BAT` | BAT output file (uses DEBUG.exe method - limited to x86) |
| `-p POSH` | PoSh output file (uses PowerShell method - supports x86/x64) |
| `-e` | URL encode the output strings |
| `-r TEXT` | pRefix - custom text to add before the command on each line |
| `-f TEXT` | suFfix - custom text to add after the command on each line |
| `-l INT` | Maximum HEX values per line (adjusts line length) |
| `-c` | Clones and compresses the file before converting |
| `-cc` | Clones and applies higher compression before converting |
| `-t` | Create an Expect file to automate the transfer to a Telnet session |
| `-w` | Create an Expect file to automate the transfer to a WinEXE session |
| `-v` | Enable verbose mode |

## Notes
- The Batch (`-b`) method relies on `DEBUG.exe`, which is typically only available on 32-bit Windows systems and has file size limitations.
- The PowerShell (`-p`) method is more robust and supports both 32-bit and 64-bit architectures.
- Using `-c` or `-cc` requires `upx` to be installed on the host machine to perform the compression.
- This tool is highly effective for "living off the land" (LotL) techniques when you have a command shell but no file transfer protocol (like FTP/SMB/HTTP) available.