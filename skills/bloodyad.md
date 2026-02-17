---
name: bloodyad
description: Active Directory privilege escalation framework for performing LDAP calls to a domain controller. It supports cleartext, pass-the-hash, pass-the-ticket, and certificate authentication. Use when performing AD reconnaissance, privilege escalation, object manipulation (users, groups, computers), or modifying DACLs/GPOs during penetration testing.
---

# bloodyAD

## Overview
bloodyAD is an Active Directory privilege escalation "Swiss Army Knife" that interacts with LDAP/LDAPS services. It is designed to automate the exploitation of AD object permissions and can be used transparently with SOCKS proxies. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume bloodyAD is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install bloodyad
```

## Common Workflows

### Enumerate Object Information
Get all attributes for a specific user using cleartext credentials:
```bash
bloodyAD -d lab.local -u 'admin' -p 'password123' --host 192.168.1.10 get object 'targetUser'
```

### Add a User to a Group
Add a compromised or new user to the "Domain Admins" group:
```bash
bloodyAD -d lab.local -u 'admin' -p 'password123' --host 192.168.1.10 add groupMember 'Domain Admins' 'myUser'
```

### Pass-the-Hash Authentication
Perform operations using an NTLM hash instead of a password:
```bash
bloodyAD -d lab.local -u 'admin' -p '00000000000000000000000000000000:ae35473239f2c231c4ca4adcf44097d0' --host 192.168.1.10 get children 'DC=lab,DC=local'
```

### Set User Password
Reset a user's password (requires sufficient permissions):
```bash
bloodyAD -d lab.local -u 'admin' -p 'password123' --host 192.168.1.10 set password 'targetUser' 'NewPassword123!'
```

## Complete Command Reference

### Global Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--domain DOMAIN` | Domain used for NTLM authentication |
| `-u`, `--username USERNAME` | Username used for NTLM authentication |
| `-p`, `--password PASSWORD` | Password, `LMHASH:NTHASH`, AES/RC4 key, or certificate password. Leave empty for Integrated Windows Auth |
| `-k`, `--kerberos [KERBEROS ...]` | Enable Kerberos. Supports keywords: `kdc`, `kdcc`, `realmc`, and keyfile types (`ccache`, `kirbi`, `keytab`, `pem`, `pfx`) |
| `-f`, `--format {b64,hex,aes,rc4,default}` | Specify format for `--password` or `-k <keyfile>` |
| `-c`, `--certificate [CERT]` | Certificate auth: `"path/to/key:path/to/cert"`. Uses Windows Certstore if empty |
| `-s`, `--secure` | Use LDAPS (LDAP over TLS) |
| `--host HOST` | Hostname or IP of the Domain Controller |
| `--dc-ip DC_IP` | IP of the DC (use if `--host` cannot be resolved) |
| `--dns DNS` | IP of the DNS server to resolve AD names |
| `--gc` | Connect to Global Catalog (GC) |
| `-v`, `--verbose {QUIET,INFO,DEBUG}` | Adjust output verbosity |

### Subcommands

bloodyAD uses a functional category system for its operations:

#### `add`
Used to create objects or add relationships.
- `add computer`: Create a new computer object.
- `add groupMember`: Add a user/group/computer to a group.
- `add user`: Create a new user.
- `add genericAll`: Grant full control over an object.
- `add dcsync`: Grant DCSync rights to an object.

#### `get`
Used to retrieve information from the directory.
- `get object`: Retrieve all attributes of a specific object.
- `get children`: List children of a container/OU.
- `get membership`: List groups an object belongs to.
- `get search`: Perform custom LDAP searches.

#### `remove`
Used to delete objects or remove relationships.
- `remove groupMember`: Remove a member from a group.
- `remove object`: Delete an object from AD.

#### `set`
Used to modify existing object attributes.
- `set password`: Change an object's password.
- `set rbcd`: Configure Resource-Based Constrained Delegation.
- `set shadowCredentials`: Configure Shadow Credentials (msDS-KeyCredentialLink).
- `set userAccountControl`: Modify UAC flags (e.g., disable, require pre-auth).

## Notes
- **LDAPS**: Some operations (like password changes) typically require the `-s` / `--secure` flag unless the DC allows password changes over plain LDAP.
- **Kerberos**: When using `-k`, ensure your `KRB5CCNAME` environment variable is set if using a ccache file, or provide the path directly in the `-k` arguments.
- **SOCKS**: bloodyAD is proxy-aware; use `proxychains` or similar tools to route traffic through a pivot point.