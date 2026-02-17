---
name: ldeep
description: Perform in-depth LDAP enumeration against Active Directory environments or local cache files. Use to gather information about users, groups, computers, trust relationships, and security descriptors during the reconnaissance and internal enumeration phases of a penetration test.
---

# ldeep

## Overview
ldeep is an in-depth LDAP enumeration utility designed to query Active Directory LDAP servers or process locally saved LDAP data. It helps identify misconfigurations, group memberships, and sensitive AD objects. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume ldeep is already installed. If the command is missing:

```bash
sudo apt install ldeep
```

## Common Workflows

### Enumerate all users from a domain controller
```bash
ldeep ldap -u 'username' -p 'password' -d 'domain.local' -s 'ldaps://10.10.10.10' users
```

### List all computers and save to a file
```bash
ldeep -o computers_list.json ldap -u 'user' -p 'pass' -d 'domain.com' -s 'ldap://dc01.domain.com' computers
```

### Check for Kerberoastable accounts
```bash
ldeep ldap -u 'user' -p 'pass' -d 'domain.local' -s 'ldap://10.10.10.10' users --spn
```

### Enumerate domain trusts
```bash
ldeep ldap -u 'user' -p 'pass' -d 'domain.local' -s 'ldap://10.10.10.10' trusts
```

## Complete Command Reference

### Global Options
```
ldeep [-h] [-o OUTFILE] [--security_desc] {ldap,cache,protections} ...
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-o`, `--outfile OUTFILE` | Store the results in a file |
| `--security_desc` | Enable the retrieval of security descriptors in ldeep results |

### Modes (Backend Engines)

#### 1. ldap
Query a live Active Directory LDAP server.

**Usage:** `ldeep ldap [options] <command>`

**LDAP Connection Options:**
- `-u`, `--username` : Username for authentication
- `-p`, `--password` : Password for authentication
- `-H`, `--hashes` : NTLM hashes, format is `LMHASH:NTHASH`
- `-k`, `--kerberos` : Use Kerberos authentication (requires KRB5CCNAME environment variable)
- `-d`, `--domain` : Domain name (e.g., corp.local)
- `-s`, `--server` : Target LDAP server URL (e.g., `ldap://10.10.10.10` or `ldaps://dc01.corp.local`)
- `-b`, `--base` : Base DN to start the search (e.g., `dc=corp,dc=local`)

#### 2. cache
Query locally saved LDAP data files.

**Usage:** `ldeep cache [options] <command>`

#### 3. protections
Analyze Active Directory protections and security settings.

### Available Commands (Sub-actions)
These commands are typically used after the mode (e.g., `ldeep ldap ... users`):

| Command | Description |
|---------|-------------|
| `all` | Retrieve all objects |
| `users` | Enumerate domain users |
| `computers` | Enumerate domain computers |
| `groups` | Enumerate domain groups |
| `memberships` | Show group memberships for users/groups |
| `trusts` | Enumerate domain trust relationships |
| `pso` | Password Settings Objects (Password Policies) |
| `gpo` | Group Policy Objects |
| `ou` | Organizational Units |
| `zones` | DNS Zones stored in AD |
| `query` | Perform a custom LDAP query |

## Notes
- When using `--security_desc`, be aware that this increases the volume of data returned and may require higher privileges to read certain object descriptors.
- For Kerberos authentication, ensure your `KRB5CCNAME` is set and you have a valid TGT.
- The tool is particularly effective for finding "Shadow Admins" and identifying accounts with SPNs (Service Principal Names).