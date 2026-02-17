---
name: enum4linux-ng
description: Enumerate information from Windows and Samba systems including users, groups, shares, password policies, and OS details. Use during the reconnaissance or enumeration phase of a penetration test when targeting SMB or LDAP services to identify attack surfaces, user accounts, and misconfigurations.
---

# enum4linux-ng

## Overview
A next-generation rewrite of the original enum4linux tool, designed for security professionals and CTF players. It acts as a smart wrapper around Samba tools (nmblookup, net, rpcclient, smbclient) and Impacket to enumerate Windows/Samba hosts. It features automated service detection and supports exporting results to JSON or YAML. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, install via:

```bash
sudo apt update && sudo apt install enum4linux-ng
```

## Common Workflows

### Full Enumeration (Default)
Automatically perform all simple enumeration checks against a target host.
```bash
enum4linux-ng 192.168.1.100
```

### Authenticated Enumeration with Domain User
Enumerate a domain controller using provided credentials to get detailed user and group info.
```bash
enum4linux-ng -u "jdoe" -p "Password123" -d -A 192.168.1.100
```

### RID Cycling for User Discovery
Brute-force user SIDs using a specific range to find hidden or unlisted accounts.
```bash
enum4linux-ng -R 500-600 -r 500-600 192.168.1.100
```

### Exporting Results for Documentation
Run a full scan and save the output in both JSON and YAML formats for further processing.
```bash
enum4linux-ng -A -oA enumeration_results 192.168.1.100
```

## Complete Command Reference

```bash
enum4linux-ng [options] host
```

### Enumeration Options

| Flag | Description |
|------|-------------|
| `-A` | Do all simple enumeration including nmblookup (`-U -G -S -P -O -N -I -L`). Enabled by default if no other options provided. |
| `-As` | Do all simple short enumeration without NetBIOS names lookup (`-U -G -S -P -O -I -L`). |
| `-U` | Get users via RPC. |
| `-G` | Get groups via RPC. |
| `-Gm` | Get groups with group members via RPC. |
| `-S` | Get shares via RPC. |
| `-C` | Get services via RPC. |
| `-P` | Get password policy information via RPC. |
| `-O` | Get OS information via RPC. |
| `-L` | Get additional domain info via LDAP/LDAPS (for Domain Controllers only). |
| `-I` | Get printer information via RPC. |
| `-R [BULK_SIZE]` | Enumerate users via RID cycling. Optionally, specifies lookup request size. |
| `-N` | Do a NetBIOS names lookup (similar to nbtstat) and try to retrieve workgroup from output. |
| `-d` | Get detailed information for users and groups (applies to `-U`, `-G`, and `-R`). |

### Authentication & Connection Options

| Flag | Description |
|------|-------------|
| `-w DOMAIN` | Specify workgroup/domain manually (usually found automatically). |
| `-u USER` | Specify username to use (default: ""). |
| `-p PW` | Specify password to use (default: ""). |
| `-K TICKET_FILE` | Authenticate with Kerberos (Active Directory only; requires working DNS). |
| `-H NTHASH` | Authenticate using an NT hash (Pass-the-Hash). |
| `--local-auth` | Authenticate locally to the target. |
| `-k USERS` | User(s) known to exist on remote system (default: administrator, guest, krbtgt, domain admins, root, bin, none). Used for SID lookup. |
| `-r RANGES` | RID ranges to enumerate (default: 500-550, 1000-1050). |
| `-s SHARES_FILE` | Brute force guessing for shares using a wordlist. |
| `-t TIMEOUT` | Sets connection timeout in seconds (default: 5s). |

### Output & Debug Options

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit. |
| `-v` | Verbose mode: show full samba tools commands being executed. |
| `--keep` | Do not delete the temporary Samba configuration file created during the run (useful with `-v`). |
| `-oJ FILE` | Write output to JSON file (extension added automatically). |
| `-oY FILE` | Write output to YAML file (extension added automatically). |
| `-oA FILE` | Write output to both YAML and JSON files. |

## Notes
- **Smart Enumeration**: The tool checks if SMB or LDAP is accessible first and skips irrelevant checks dynamically.
- **Session Dependency**: If SMB is accessible but no session (anonymous or authenticated) can be established, the tool will stop.
- **Interrupts**: Pressing `CTRL+C` (SIGINT) will trigger the tool to write the current state to the specified output files (`-oJ`, `-oY`) before exiting.