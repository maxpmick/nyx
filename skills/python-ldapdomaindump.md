---
name: python-ldapdomaindump
description: Enumerate Active Directory information via LDAP, including users, computers, groups, memberships, and domain policies. Use during the reconnaissance or internal penetration testing phases to gather actionable intelligence from an AD environment using authenticated or anonymous access, and export it to HTML, JSON, or CSV formats.
---

# python-ldapdomaindump

## Overview
Active Directory information dumper via LDAP. It collects and parses data available via LDAP and outputs it in human-readable HTML format, as well as machine-readable JSON and greppable files. It is highly effective for internal network reconnaissance. Category: Reconnaissance / Information Gathering, Exploitation, Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is already installed. If you encounter a "command not found" error:

```bash
sudo apt install python3-ldapdomaindump
```

## Common Workflows

### Basic Enumeration with NTLM Authentication
```bash
ldapdomaindump -u 'DOMAIN\username' -p 'password123' 192.168.1.10
```

### Anonymous Enumeration (if permitted by DC)
```bash
ldapdomaindump 192.168.1.10
```

### Enumeration with Hostname Resolution and Custom DNS
```bash
ldapdomaindump -u 'DOMAIN\user' -p 'pass' -r -n 192.168.1.10 192.168.1.10
```

### Convert JSON output to BloodHound CSVs
```bash
ldd2bloodhound domain_users.json domain_groups.json domain_computers.json
```

### Display "Pretty" Summary (enum4linux style)
```bash
ldd2pretty -d ./output_directory/
```

## Complete Command Reference

### ldapdomaindump
Main tool for dumping domain information.

```
ldapdomaindump [-h] [-u USERNAME] [-p PASSWORD] [-at {NTLM,SIMPLE}] [-o DIRECTORY] [--no-html] [--no-json] [--no-grep] [--grouped-json] [-d DELIMITER] [-r] [-n DNS_SERVER] [-m] HOSTNAME
```

| Flag | Description |
|------|-------------|
| `HOSTNAME` | **Required.** Hostname/IP or `ldap://host:port` (use `ldaps://` for SSL) |
| `-h`, `--help` | Show help message and exit |
| `-u`, `--user USERNAME` | `DOMAIN\username` for authentication; leave empty for anonymous |
| `-p`, `--password PASSWORD` | Password or `LM:NTLM` hash (prompts if not specified) |
| `-at`, `--authtype {NTLM,SIMPLE}` | Authentication type (default: NTLM) |
| `-o`, `--outdir DIRECTORY` | Directory to save the dump (default: current) |
| `--no-html` | Disable HTML output |
| `--no-json` | Disable JSON output |
| `--no-grep` | Disable Greppable output |
| `--grouped-json` | Also write JSON files for grouped files (default: disabled) |
| `-d`, `--delimiter DELIMITER` | Field delimiter for greppable output (default: tab) |
| `-r`, `--resolve` | Resolve computer hostnames (may cause high traffic) |
| `-n`, `--dns-server DNS_SERVER` | Use custom DNS resolver instead of system DNS (e.g., DC IP) |
| `-m`, `--minimal` | Query minimal set of attributes to limit memory usage |

### ldd2bloodhound
Converter utility for BloodHound.

```
ldd2bloodhound [-h] [-d] FILENAME [FILENAME ...]
```

| Flag | Description |
|------|-------------|
| `FILENAME` | **Required.** The JSON files to load (requires `domain_users.json` and `domain_groups.json`) |
| `-h`, `--help` | Show help message and exit |
| `-d`, `--debug` | Enable debug logger |

### ldd2pretty
Summary utility for human-readable console output.

```
ldd2pretty [-h] [-d DIRECTORY]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--directory DIRECTORY` | Directory containing `domain_users.json`, `domain_groups.json`, and `domain_policy.json` |

## Notes
- LDAP often contains sensitive information accessible to any authenticated user, including service account descriptions that may contain passwords.
- Using the `-r` (resolve) flag can be noisy on the network as it triggers many DNS queries.
- If the Domain Controller requires SSL, ensure you use the `ldaps://` prefix in the hostname.