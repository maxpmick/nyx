---
name: rubeus
description: Perform raw Kerberos interaction and abuses including ticket requests, renewals, constrained delegation attacks, AS-REP roasting, Kerberoasting, and ticket manipulation. Use when performing Active Directory exploitation, lateral movement, privilege escalation, or credential harvesting within a Windows domain environment.
---

# rubeus

## Overview
Rubeus is a C# toolset for raw Kerberos interaction and abuses, heavily adapted from the Kekeo and MakeMeEnterpriseAdmin projects. It allows for a wide range of Kerberos-based attacks and ticket management tasks. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Rubeus is a Windows executable typically used via a wrapper or executed on a target. In Kali, the binary is located in the Windows resources directory.

```bash
sudo apt install rubeus
```

The executable is located at: `/usr/share/windows-resources/rubeus/Rubeus.exe`

## Common Workflows

### Kerberoasting
Harvest supported service tickets and output hashes for offline cracking:
```bash
rubeus kerberoast /outfile:hashes.txt
```

### AS-REP Roasting
Harvest AS-REP hashes for users with "Do not require Kerberos preauthentication" enabled:
```bash
rubeus asreproast /format:hashcat /outfile:asrep.txt
```

### Monitor for New Tickets
Continuously monitor for new TGTs being cached on a compromised system (requires elevated privileges):
```bash
rubeus monitor /interval:10 /nowrap
```

### Request a TGT and Inject
Request a TGT using a hash and inject it into the current session:
```bash
rubeus asktgt /user:USER /rc4:HASH /ptt
```

## Complete Command Reference

Rubeus is executed as a command-line tool with various subcommands.

### Subcommands

| Subcommand | Description |
|------------|-------------|
| `asktgt` | Requests a TGT based on a user password, hash, or AES key. |
| `asktgs` | Requests a TGS for one or more service principal names (SPNs). |
| `asreproast` | Performs AS-REP roasting for users without pre-authentication required. |
| `kerberoast` | Performs Kerberoasting against SPNs to harvest crackable service tickets. |
| `renew` | Renews an existing TGT. |
| `brute` | Performs password brute-forcing or spraying against Kerberos. |
| `changepw` | Changes a user's password via the Kerberos change password (kpasswd) protocol. |
| `s4u` | Performs S4U2self and S4U2proxy constrained delegation attacks. |
| `tgtdeleg` | Uses the GSS-API to request a delegation TGT (for unconstrained delegation). |
| `monitor` | Monitors the local machine for new Kerberos ticket events. |
| `harvest` | Monitors for and harvests tickets to a remote server or local file. |
| `triage` | Lists Kerberos tickets in the current logon session (similar to `klist`). |
| `dump` | Dumps Kerberos tickets from the current or specified logon session. |
| `ptt` | Pass-the-Ticket: Imports a ticket (.kirbi) into the current session. |
| `purge` | Purges all Kerberos tickets from the current session. |
| `describe` | Parses and describes a Kerberos ticket (.kirbi) file. |
| `createnetonly` | Creates a hidden "netonly" process for use with `/ptt`. |

### Global and Common Flags

| Flag | Description |
|------|-------------|
| `/user:USER` | Username to impersonate/target. |
| `/domain:DOMAIN` | Target FQDN domain. |
| `/dc:DC` | Specific Domain Controller to target. |
| `/ticket:BASE64\|FILE` | Provide a ticket for use in a command. |
| `/outfile:FILE` | Save output (hashes or tickets) to a file. |
| `/ptt` | Inject the resulting ticket into the current session. |
| `/rc4:HASH` | Provide an NTLM/RC4 hash for authentication. |
| `/aes256:HASH` | Provide an AES256 key for authentication. |
| `/format:FORMAT` | Output format for hashes (e.g., `hashcat` or `john`). |
| `/nowrap` | Prevent long lines (like Base64 tickets) from wrapping in the console. |
| `/debug` | Enable verbose/debug output. |

## Notes
- Rubeus is a Windows-centric tool. On Kali, it is provided as a `.exe` to be transferred to a target or executed via `wine` (though `wine` support for raw Kerberos is limited).
- Many commands (like `monitor`, `dump`, and `triage` for other sessions) require local administrator or SYSTEM privileges.
- When using `/ptt`, the ticket is injected into the memory of the current logon session. Use `createnetonly` to avoid overwriting your primary session's tickets.