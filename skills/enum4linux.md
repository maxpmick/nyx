---
name: enum4linux
description: Enumerate information from Windows and Samba systems including user lists, share lists, group memberships, password policies, and OS details. Use when performing SMB reconnaissance, identifying network shares, brute-forcing RIDs, or gathering information from domain controllers and file servers during penetration testing.
---

# enum4linux

## Overview
Enum4linux is a PERL-based wrapper around Samba tools (smbclient, rpcclient, net, and nmblookup) designed to enumerate data from Windows and Samba hosts. It is particularly effective for RID cycling and extracting information when anonymous access is partially restricted. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume enum4linux is already installed. If missing:

```bash
sudo apt install enum4linux
```
Dependencies: `samba`, `smbclient`, `polenum`, `ldap-utils`, `perl`.

## Common Workflows

### Full Enumeration
Run all simple enumeration checks (Users, Shares, Groups, Password Policy, RID cycling, OS info, nmblookup, and Printers):
```bash
enum4linux -a 192.168.1.200
```

### User Enumeration via RID Cycling
Enumerate users by cycling through Relative Identifiers (RIDs), useful when standard user listing is restricted:
```bash
enum4linux -r -R 500-600 192.168.1.200
```

### Authenticated Share Enumeration
List shares and details using specific credentials:
```bash
enum4linux -S -u "admin" -p "password123" 192.168.1.200
```

### Domain Controller Specific Info
Get OS info, password policy, and LDAP information from a DC:
```bash
enum4linux -o -P -l 192.168.1.200
```

## Complete Command Reference

```bash
enum4linux [options] ip
```

### Standard Options (Similar to enum.exe)

| Flag | Description |
|------|-------------|
| `-U` | Get userlist |
| `-M` | Get machine list |
| `-S` | Get sharelist |
| `-P` | Get password policy information |
| `-G` | Get group and member list |
| `-d` | Be detailed (applies to `-U` and `-S`) |
| `-u <user>` | Specify username to use (default "") |
| `-p <pass>` | Specify password to use (default "") |

### Additional Options

| Flag | Description |
|------|-------------|
| `-a` | Do all simple enumeration (`-U -S -G -P -r -o -n -i`). Default if no options provided |
| `-h` | Display help message and exit |
| `-r` | Enumerate users via RID cycling |
| `-R <range>` | RID ranges to enumerate (default: 500-550, 1000-1050). Implies `-r` |
| `-K <n>` | Keep searching RIDs until `n` consecutive RIDs fail. Implies RID range ends at 999999. Useful against DCs |
| `-l` | Get limited info via LDAP 389/TCP (for Domain Controllers only) |
| `-s <file>` | Brute force guessing for share names using a wordlist |
| `-k <user>` | Known user(s) to get SID (default: administrator, guest, krbtgt, domain admins, root, bin, none). Use commas for multiple |
| `-o` | Get Operating System information |
| `-i` | Get printer information |
| `-w <wrkg>` | Specify workgroup manually (usually found automatically) |
| `-n` | Do an nmblookup (similar to nbtstat) |
| `-v` | Verbose mode. Shows full commands being run (net, rpcclient, etc.) |
| `-A` | Aggressive mode. Perform write checks on shares, etc. |

## Notes
- **RID Cycling**: Effective against Windows NT/2000 with `RestrictAnonymous=1` or XP/2003 with "Allow anonymous SID/Name translation" enabled.
- **Samba RIDs**: Samba servers often use RIDs in the range 3000-3050.
- **Password Policy**: Requires `polenum` to be installed to function correctly.
- **Permissions**: Many features work best with anonymous access enabled on the target, otherwise valid credentials (`-u` and `-p`) are recommended.