---
name: samba
description: A comprehensive suite for SMB/CIFS networking, Active Directory management, and LDAP-like database manipulation. Use for enumerating Windows shares, managing AD domains, performing remote command execution on Windows hosts (winexe), auditing SMB security (smbcacls), and interacting with LDB/TDB databases. Essential for reconnaissance, exploitation, and post-exploitation in Windows/Samba environments.
---

# Samba

## Overview
Samba is an implementation of the SMB/CIFS protocol providing file/print sharing and Active Directory integration. This skill covers the extensive toolset including `smbclient` for share access, `samba-tool` for AD management, `winexe` for remote execution, and various database utilities (`ldb`, `tdb`, `ctdb`).

## Installation (if not already installed)
Samba components are typically pre-installed on Kali. If missing:
```bash
sudo apt update
sudo apt install samba smbclient samba-common-bin winbind ldb-tools tdb-tools
```

## Common Workflows

### Enumerate Shares and Connect
```bash
# List shares on a host (anonymous or guest)
smbclient -L //192.168.1.100 -N

# Connect to a specific share with credentials
smbclient //192.168.1.100/Backup -U "DOMAIN\user%password"
```

### Remote Windows Command Execution
```bash
# Execute ipconfig on a remote Windows host
winexe -U "ADMINISTRATOR%password123" //192.168.1.105 "ipconfig /all"
```

### Active Directory User Management
```bash
# List all users in the domain
samba-tool user list -H ldap://dc1.example.com -U "admin"

# Reset a user password
samba-tool user setpassword username --newpassword="Password123!"
```

### Querying Domain Information via Winbind
```bash
# Convert a SID to a Name
wbinfo -s S-1-5-21-123456789-123456789-123456789-500

# List all domain groups
wbinfo -g
```

## Complete Command Reference

### smbclient
FTP-like client to access SMB/CIFS resources.
`smbclient [OPTIONS] service <password>`

| Flag | Description |
|------|-------------|
| `-M, --message=HOST` | Send message |
| `-I, --ip-address=IP` | Use this IP to connect to |
| `-E, --stderr` | Write messages to stderr instead of stdout |
| `-L, --list=HOST` | Get a list of shares available on a host |
| `-T, --tar=<c\|x>...` | Command line tar |
| `-D, --directory=DIR` | Start from directory |
| `-c, --command=STRING` | Execute semicolon separated commands |
| `-b, --send-buffer=BYTES` | Changes the transmit/send buffer |
| `-t, --timeout=SECONDS` | Changes the per-operation timeout |
| `-p, --port=PORT` | Port to connect to |
| `-g, --grepable` | Produce grepable output |
| `-q, --quiet` | Suppress help message |
| `-B, --browse` | Browse SMB servers using DNS |
| `-N, --no-pass` | Don't ask for a password |
| `-U, --user=USER` | Set the network username |

### winexe
Remote Windows-command executor.
`winexe [OPTION]... //HOST[:PORT] COMMAND`

| Flag | Description |
|------|-------------|
| `--uninstall` | Uninstall winexe service after remote execution |
| `--reinstall` | Reinstall winexe service before remote execution |
| `--runas=[DOM\]USER%PW` | Run as the given user (Warning: Cleartext over network) |
| `--runas-file=FILE` | Run as user options defined in a file |
| `--interactive=0\|1` | Desktop interaction (1=allow, requires --system) |
| `--ostype=0\|1\|2` | OS type: 0 (32-bit), 1 (64-bit), 2 (auto) |
| `-U, --user=USER` | Set the network username |
| `-A, --authentication-file=FILE` | Get credentials from a file |

### samba-tool
Main Samba administration tool for AD.
`samba-tool <subcommand>`

**Subcommands:**
`computer`, `contact`, `dbcheck`, `delegation`, `dns`, `domain`, `drs`, `dsacl`, `forest`, `fsmo`, `gpo`, `group`, `ldapcmp`, `ntacl`, `ou`, `processes`, `rodc`, `schema`, `service-account`, `shell`, `sites`, `spn`, `testparm`, `time`, `user`, `visualize`.

### rpcclient
Tool for executing client-side MS-RPC functions.
`rpcclient [OPTION...] BINDING-STRING|HOST`

| Flag | Description |
|------|-------------|
| `-c, --command=COMMANDS` | Execute semicolon separated cmds |
| `-I, --dest-ip=IP` | Specify destination IP address |
| `-p, --port=PORT` | Specify port number |

### smbcacls
Set or get ACLs on NT files/directories.
`smbcacls //server/share filename`

| Flag | Description |
|------|-------------|
| `-a, --add=ACL` | Add an ACE |
| `-M, --modify=ACL` | Modify an existing ACE |
| `-D, --delete=ACL` | Delete an ACE |
| `-S, --set=ACLS` | Set ACLs (overwrites) |
| `-C, --chown=USER` | Change ownership |
| `-G, --chgrp=GROUP` | Change group ownership |
| `--sddl` | Output/Input in SDDL format |

### nmblookup
Lookup NetBIOS names.
`nmblookup [OPTIONS] <NODE>`

| Flag | Description |
|------|-------------|
| `-B, --broadcast=ADDR` | Specify broadcast address |
| `-S, --status` | Lookup node status as well |
| `-A, --lookup-by-ip` | Do a node status on <name> as an IP |

### wbinfo
Query information from winbind daemon.

| Flag | Description |
|------|-------------|
| `-u, --domain-users` | List all domain users |
| `-g, --domain-groups` | List all domain groups |
| `-n, --name-to-sid=NAME` | Convert name to SID |
| `-s, --sid-to-name=SID` | Convert SID to name |
| `-a, --authenticate=U%P` | Authenticate user |
| `-t, --check-secret` | Check shared secret |

### LDB Tools (ldbsearch, ldbadd, ldbmodify, ldbdel, ldbedit)
LDAP-like database manipulation.

| Flag | Description |
|------|-------------|
| `-H, --url=URL` | Database URL (e.g., tdb://file.ldb) |
| `-b, --basedn=DN` | Base DN |
| `-s, --scope=SCOPE` | Search scope (base, one, sub) |
| `-r, --recursive` | Recursive delete (ldbdel) |

### TDB Tools (tdbtool, tdbdump, tdbbackup)
Trivial Database manipulation.

**tdbtool Commands:**
`create`, `open`, `erase`, `dump`, `keys`, `info`, `insert KEY DATA`, `show KEY`, `delete KEY`, `check`.

### CTDB Tools (ctdb, ctdb_diagnostics)
Clustered TDB management.

| Flag | Description |
|------|-------------|
| `-n, --node=INT` | Node specification |
| `-Y` | Machine readable output |

### Testing Tools (smbtorture, gentest, locktest, masktest)
Used for stress testing and behavior comparison between SMB servers.

## Notes
- **Security**: `winexe` with `--runas` sends passwords in cleartext.
- **Credentials**: Use `-A <file>` to avoid leaving passwords in shell history. Format: `username = <user>`, `password = <pass>`, `domain = <domain>`.
- **Paths**: SMB paths use forward slashes in Linux tools: `//server/share/path`.
- **AD DC**: To run a full Domain Controller, the `samba-ad-dc` package is required.