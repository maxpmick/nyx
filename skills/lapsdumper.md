---
name: lapsdumper
description: Dump Microsoft Local Administrator Password Solution (LAPS) passwords from Active Directory using LDAP. Use when performing internal penetration testing, lateral movement, or credential harvesting after gaining domain user credentials to check for misconfigured permissions that allow reading the ms-LAPS-Password attribute.
---

# lapsdumper

## Overview
A Python-based tool designed to dump every LAPS password that a provided domain account has the permissions to read. It queries Active Directory via LDAP to retrieve clear-text local administrator passwords stored in the `ms-LAPS-Password` attribute. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume lapsdumper is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install lapsdumper
```

Dependencies: `python3-ldap3`.

## Common Workflows

### Dump all accessible LAPS passwords
```bash
lapsdumper -u "jdoe" -p "P@ssword123" -d "corp.local" -l "dc01.corp.local"
```

### Dump password for a specific computer
```bash
lapsdumper -u "jdoe" -p "P@ssword123" -d "corp.local" -c "WKSTN-01"
```

### Authenticate using NTLM hash and export to CSV
```bash
lapsdumper -u "jdoe" -p "aad3b435b51404eeaad3b435b51404ee:58446466e105b05f0758cf033fb5966e" -d "corp.local" -o results.csv
```

## Complete Command Reference

```
lapsdumper [-h] -u USERNAME -p PASSWORD [-l LDAPSERVER] -d DOMAIN [-c COMPUTER] [-o OUTPUT]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-u`, `--username USERNAME` | Username for LDAP authentication |
| `-p`, `--password PASSWORD` | Password for LDAP authentication (accepts clear-text or LM:NT hash) |
| `-l`, `--ldapserver LDAPSERVER` | LDAP server address or Domain Controller FQDN/IP (defaults to domain if omitted) |
| `-d`, `--domain DOMAIN` | The target Active Directory domain |
| `-c`, `--computer COMPUTER` | Target a specific computer name to retrieve its password |
| `-o`, `--output OUTPUT` | Save the results to a specified CSV file |

## Notes
- This tool requires valid domain credentials.
- Success depends on the provided user having "Read" permissions on the `ms-LAPS-Password` attribute for the target computer objects.
- When using hashes for authentication, ensure they are in the `LM:NT` format.