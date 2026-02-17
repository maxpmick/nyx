---
name: shellter
description: Inject shellcode into native 32-bit Windows executable (PE) files using dynamic analysis. Use when performing post-exploitation, bypassing antivirus (AV) software, or creating custom malicious payloads by infecting legitimate Windows binaries during penetration testing.
---

# shellter

## Overview
Shellter is a dynamic shellcode injection tool and dynamic PE infector. It injects shellcode into native 32-bit Windows applications by taking advantage of the original structure of the PE file. It avoids common red flags like adding new sections or changing memory permissions to RWE, making it effective for AV evasion. Category: Post-Exploitation / Windows Resources.

## Installation (if not already installed)

Shellter requires Wine and the 32-bit Wine architecture to run on Kali Linux.

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine32 shellter
```

## Common Workflows

### Basic Interactive Injection
Run the tool and follow the interactive prompts to select a target PE (Auto Mode) and a payload.
```bash
shellter
```

### Automated Injection (Command Line)
While Shellter is primarily interactive, it can be automated using piped input or specific flags if supported by the version's CLI wrapper. Typically, users run it and follow these steps:
1. Choose Operation Mode: `A` (Auto) or `M` (Manual).
2. Provide path to target PE: `vlc.exe`.
3. Enable Stealth Mode: `Y/N`.
4. Select Payload: `L` (Listed) or `C` (Custom).
5. Select Payload Index: e.g., `1` for Meterpreter Reverse TCP.

## Complete Command Reference

Shellter is an interactive console application. The following options and modes are available within the interface:

### Operation Modes
- **Auto Mode (A)**: Automatically traces the execution of the target binary to find suitable injection locations (caves) that are actually executed during runtime.
- **Manual Mode (M)**: Allows the user to have more control over the injection process and the tracing of the executable.

### Configuration Options
- **Stealth Mode**: Preserves the original functionality of the infected PE file. After the shellcode executes, the application continues its normal execution.
- **Payload Selection**:
    - **Listed Payloads**: Choose from built-in payloads (mostly Metasploit-compatible).
    - **Custom Payloads**: Provide a raw `.bin` file containing your own shellcode.
- **Encoded Payloads**: Option to use encoded payloads to further evade detection.
- **User Defined Encoding**: Allows the user to specify custom encoding schemes.

### Target Requirements
- **Architecture**: 32-bit Windows Applications (x86) only.
- **Format**: Portable Executable (PE).
- **Compatibility**: Must be a native Windows application (not .NET).

## Notes
- **Wine Dependency**: Since Shellter is a Windows application, it runs via Wine. Ensure `wine32` is properly configured.
- **AV Evasion**: Shellter's strength lies in its "Dynamic" nature; it only injects into code paths that are actually executed, making it harder for emulators to detect.
- **Backup**: Always work on a copy of the target executable, as the injection process modifies the file.
- **Obfuscation**: While Shellter handles injection, the choice of shellcode (e.g., staged vs stageless) and additional encoding significantly impacts detection rates.