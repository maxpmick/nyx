---
name: netexec
description: Automate the assessment and exploitation of network services across large environments. Use when performing lateral movement, credential spraying, vulnerability scanning, or post-exploitation tasks across protocols like SMB, LDAP, SSH, WinRM, and MSSQL. It is the successor to CrackMapExec.
---

# netexec

## Overview
NetExec (nxc) is a multi-protocol network exploitation tool designed to automate security assessments of large networks. It facilitates credential harvesting, command execution, and service enumeration across various protocols. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume NetExec is already installed. If the `nxc` or `netexec` command is missing:

```bash
sudo apt update && sudo apt install netexec
```

## Common Workflows

### SMB Credential Spraying
```bash
nxc smb 192.168.1.0/24 -u user.txt -p pass.txt
```
Checks provided credentials against an entire subnet via SMB.

### LDAP Domain Enumeration
```bash
nxc ldap 192.168.1.10 -u 'username' -p 'password' --users --groups
```
Enumerates domain users and groups using valid credentials.

### Execute Command via WinRM
```bash
nxc winrm 192.168.1.50 -u 'admin' -p 'password' -x 'whoami /all'
```
Runs a system command on a target host where WinRM is enabled.

### Database Management
```bash
nxcdb -cw internal_audit
nxcdb -sw internal_audit
```
Creates and switches to a specific workspace to organize scan results.

## Complete Command Reference

### Global Options
These options apply to the main `nxc` / `netexec` binary.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--version` | Display nxc version |
| `-t`, `--threads <THREADS>` | Set how many concurrent threads to use |
| `--timeout <TIMEOUT>` | Max timeout in seconds of each thread |
| `--jitter <INTERVAL>` | Sets a random delay between each authentication |
| `--verbose` | Enable verbose output |
| `--debug` | Enable debug level information |
| `--no-progress` | Do not display progress bar during scan |
| `--log <LOG>` | Export result into a custom file |
| `-6` | Enable force IPv6 |
| `--dns-server <DNS_SERVER>` | Specify DNS server (default: System DNS) |
| `--dns-tcp` | Use TCP instead of UDP for DNS queries |
| `--dns-timeout <DNS_TIMEOUT>` | DNS query timeout in seconds |

### Available Protocols
NetExec supports subcommands for specific protocols. Use `nxc <protocol> -h` for protocol-specific flags.

| Protocol | Description |
|----------|-------------|
| `smb` | Enumerate and exploit SMB (Server Message Block) |
| `ssh` | Enumerate and exploit SSH (Secure Shell) |
| `ldap` | Enumerate and exploit LDAP (Lightweight Directory Access Protocol) |
| `winrm` | Enumerate and exploit WinRM (Windows Remote Management) |
| `mssql` | Enumerate and exploit MSSQL (Microsoft SQL Server) |
| `ftp` | Enumerate and exploit FTP (File Transfer Protocol) |
| `vnc` | Enumerate and exploit VNC (Virtual Network Computing) |
| `nfs` | Enumerate and exploit NFS (Network File System) |
| `rdp` | Enumerate and exploit RDP (Remote Desktop Protocol) |
| `wmi` | Enumerate and exploit WMI (Windows Management Instrumentation) |

### nxcdb (Database Navigator)
Utility for managing the NetExec backend database.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-gw`, `--get-workspace` | Get the current workspace name |
| `-cw`, `--create-workspace <NAME>` | Create a new workspace |
| `-sw`, `--set-workspace <NAME>` | Set the current active workspace |

## Notes
- NetExec is the direct continuation of the **CrackMapExec** project.
- It maintains a local database of discovered hosts and credentials, which can be queried or cleared.
- When targeting Windows environments, ensure you specify the domain or use `local-auth` if testing local accounts.