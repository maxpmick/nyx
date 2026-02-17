---
name: bloodhound-python
description: A Python-based ingestor for BloodHound used to enumerate and collect Active Directory data including users, groups, sessions, and ACLs. Use during the reconnaissance or exploitation phases of a penetration test to identify attack paths, privilege escalation opportunities, and trust relationships within an AD environment.
---

# bloodhound-python

## Overview
`bloodhound-python` (also known as `bloodhound.py`) is an ingestor for BloodHound based on the Impacket library. It collects data from Active Directory domains and outputs JSON files that can be imported into the BloodHound GUI to visualize attack paths. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install bloodhound.py
```

## Common Workflows

### Basic Enumeration with Username/Password
Collect default information (Group, LocalAdmin, Session, Trusts) using standard password authentication:
```bash
bloodhound-python -u 'username' -p 'password' -d example.local -c Default -dc dc01.example.local
```

### Collection using NTLM Hashes
Perform enumeration without a plaintext password by providing the LM:NTLM hash:
```bash
bloodhound-python -u 'username' --hashes 'aad3b435b51404eeaad3b435b51404ee:58260639b33221a3a247ad75820f73f4' -d example.local -c All
```

### Stealthier "DCOnly" Collection
Collect information only from the Domain Controller, avoiding direct connections to every workstation (skips session and local admin enumeration):
```bash
bloodhound-python -u 'username' -p 'password' -d example.local -c DCOnly --zip
```

### Kerberos Authentication (using ccache)
Use an existing Kerberos ticket for authentication:
```bash
export KRB5CCNAME=/path/to/ticket.ccache
bloodhound-python -k -no-pass -d example.local -c All -dc dc01.example.local
```

## Complete Command Reference

```
bloodhound-python [-h] [-c COLLECTIONMETHOD] [-d DOMAIN] [-v] [-u USERNAME] [-p PASSWORD] [-k] [--hashes HASHES] [-no-pass] [-aesKey hex key] [--auth-method {auto,ntlm,kerberos}] [-ns NAMESERVER] [--dns-tcp] [--dns-timeout DNS_TIMEOUT] [-dc HOST] [-gc HOST] [-w WORKERS] [--exclude-dcs] [--disable-pooling] [--disable-autogc] [--zip] [--computerfile COMPUTERFILE] [--cachefile CACHEFILE] [--ldap-channel-binding] [--use-ldaps] [-op PREFIX_NAME]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-c`, `--collectionmethod` | Information to collect: `Group`, `LocalAdmin`, `Session`, `Trusts`, `Default` (previous 4), `DCOnly`, `DCOM`, `RDP`, `PSRemote`, `LoggedOn`, `Container`, `ObjectProps`, `ACL`, `All` (all except LoggedOn). Comma-separated list allowed. (Default: Default) |
| `-d`, `--domain` | Domain to query |
| `-v` | Enable verbose output |

### Authentication Options

| Flag | Description |
|------|-------------|
| `-u`, `--username` | Username. Format: `username[@domain]`. If domain is unspecified, the current domain is used |
| `-p`, `--password` | Password for the user |
| `-k`, `--kerberos` | Use Kerberos ccache file for authentication |
| `--hashes` | LM:NTLM hashes for Pass-the-Hash |
| `-no-pass` | Do not ask for a password (useful when using `-k`) |
| `-aesKey` | AES key to use for Kerberos Authentication (128 or 256 bits) in hex |
| `--auth-method` | Authentication method: `auto` (Kerberos with NTLM fallback), `ntlm`, or `kerberos` |

### Collection Options

| Flag | Description |
|------|-------------|
| `-ns`, `--nameserver` | Alternative name server to use for queries |
| `--dns-tcp` | Use TCP instead of UDP for DNS queries |
| `--dns-timeout` | DNS query timeout in seconds (default: 3) |
| `-dc`, `--domain-controller` | Override which DC to query (hostname) |
| `-gc`, `--global-catalog` | Override which GC to query (hostname) |
| `-w`, `--workers` | Number of workers for computer enumeration (default: 10) |
| `--exclude-dcs` | Skip Domain Controllers during computer enumeration |
| `--disable-pooling` | Don't use subprocesses for ACL parsing (debugging only) |
| `--disable-autogc` | Don't automatically select a Global Catalog |
| `--zip` | Compress the JSON output files into a zip archive |
| `--computerfile` | File containing computer FQDNs to use as an allowlist |
| `--cachefile` | Cache file (experimental) |
| `--ldap-channel-binding` | Use LDAP Channel Binding (forces LDAPS) |
| `--use-ldaps` | Use LDAP over TLS on port 636 by default |
| `-op`, `--outputprefix` | String to prepend to output file names |

## Notes
- **Limitations**: Does not currently support GPO local groups or full session resolution parity with the C# SharpHound equivalent.
- **Output**: Generates several JSON files (users.json, computers.json, etc.). These must be uploaded to the BloodHound interface to be useful.
- **Stealth**: The `LoggedOn` and `Session` collection methods involve connecting to remote registry or SMB shares on endpoints, which is noisier than `DCOnly`.