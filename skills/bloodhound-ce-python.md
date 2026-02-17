---
name: bloodhound-ce-python
description: Python-based ingestor for BloodHound Community Edition (CE) used to collect Active Directory data including users, groups, trusts, and ACLs. Use during the reconnaissance or exploitation phases of a penetration test to map attack paths, identify privilege escalation opportunities, and analyze domain relationships from a non-domain-joined Linux host.
---

# bloodhound-ce-python

## Overview
`bloodhound-ce-python` is a Python-based ingestor for BloodHound Community Edition, built on the Impacket library. It allows attackers or auditors to enumerate Active Directory environments and generate JSON files compatible with the BloodHound CE interface. It is specifically designed for BloodHound CE; for legacy BloodHound (<= 4.3.1), use `bloodhound-python`. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install bloodhound-ce-python
```

## Common Workflows

### Basic Enumeration with Password
Collect default information (Groups, LocalAdmin, Session, Trusts) using standard credentials:
```bash
bloodhound-ce-python -u 'username' -p 'password' -d example.local -c Default -v
```

### Collection using NT/LM Hashes
Perform enumeration without a cleartext password:
```bash
bloodhound-ce-python -u 'username' --hashes 'aad3b435b51404eeaad3b435b51404ee:582627a569730369330c8c6743546721' -d example.local -c All
```

### Stealthy/Limited Collection (DCOnly)
Collect information only from the Domain Controller, avoiding direct connections to every workstation:
```bash
bloodhound-ce-python -u 'username' -p 'password' -d example.local -c DCOnly --zip
```

### Kerberos Authentication with CCache
Use an existing Kerberos ticket for authentication:
```bash
export KRB5CCNAME=/path/to/ticket.ccache
bloodhound-ce-python -k -no-pass -d example.local -c All
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-c`, `--collectionmethod` | Info to collect: `Group`, `LocalAdmin`, `Session`, `Trusts`, `Default` (all previous), `DCOnly` (no computer connections), `DCOM`, `RDP`, `PSRemote`, `LoggedOn`, `Container`, `ObjectProps`, `ACL`, `All` (all except LoggedOn). Comma-separated. |
| `-d`, `--domain` | Domain to query |
| `-v` | Enable verbose output |

### Authentication Options
| Flag | Description |
|------|-------------|
| `-u`, `--username` | Username format: `username[@domain]` |
| `-p`, `--password` | Password for the user |
| `-k`, `--kerberos` | Use Kerberos ccache file |
| `--hashes` | LM:NTLM hashes |
| `-no-pass` | Do not ask for password (useful for `-k`) |
| `-aesKey` | AES key for Kerberos Authentication (128 or 256 bits) |
| `--auth-method` | `{auto,ntlm,kerberos}`. Force specific method or use auto for fallback |

### Collection Options
| Flag | Description |
|------|-------------|
| `-ns`, `--nameserver` | Alternative name server to use for queries |
| `--dns-tcp` | Use TCP instead of UDP for DNS queries |
| `--dns-timeout` | DNS query timeout in seconds (default: 3) |
| `-dc`, `--domain-controller` | Override which DC to query (hostname) |
| `-gc`, `--global-catalog` | Override which GC to query (hostname) |
| `-w`, `--workers` | Number of workers for computer enumeration (default: 10) |
| `--exclude-dcs` | Skip DCs during computer enumeration |
| `--disable-pooling` | Don't use subprocesses for ACL parsing (debugging only) |
| `--disable-autogc` | Don't automatically select a Global Catalog |
| `--zip` | Compress the JSON output files into a zip archive |
| `--computerfile` | File containing computer FQDNs to use as allowlist |
| `--cachefile` | Cache file (experimental) |
| `--ldap-channel-binding` | Use LDAP Channel Binding (forces LDAPS) |
| `--use-ldaps` | Use LDAP over TLS on port 636 by default |
| `-op`, `--outputprefix` | String to prepend to output file names |

## Notes
- **Compatibility**: This tool is strictly for BloodHound **Community Edition**.
- **DNS**: Ensure your `/etc/resolv.conf` points to the Domain Controller or use the `-ns` flag, as the tool relies heavily on resolving internal AD hostnames.
- **Performance**: Increasing `--workers` can speed up large environment scans but may increase the likelihood of detection or network congestion.