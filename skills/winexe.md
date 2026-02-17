---
name: winexe
description: Remotely execute commands on Windows systems (NT/2000/XP/2003 and later) from Linux using the SMB protocol. Use when performing lateral movement, remote administration, or executing payloads on a Windows target during penetration testing or post-exploitation phases.
---

# winexe

## Overview
Winexe is a utility that allows for remote command execution on Windows systems from a Linux environment. It functions similarly to PsExec but runs natively on Linux, leveraging Samba libraries to communicate with the Windows RPC service. Category: Exploitation / Post-Exploitation / Password Attacks.

## Installation (if not already installed)
Assume winexe is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install winexe
```

## Common Workflows

### Execute a single command with credentials
```bash
winexe -U 'DOMAIN/Username%Password' //192.168.1.100 'ipconfig /all'
```

### Spawn an interactive command prompt
```bash
winexe -U 'Administrator%Pass123' //10.0.0.5 'cmd.exe'
```

### Run a command as the SYSTEM account
```bash
winexe -U 'Admin%Pass' --system //192.168.1.50 'whoami'
```

### Use a credentials file to avoid password exposure in history
```bash
# Create a file (e.g., creds.txt) with:
# username = MyUser
# password = MyPassword
# domain = MYDOMAIN
winexe -A creds.txt //192.168.1.100 'hostname'
```

## Complete Command Reference

```
Usage: winexe [OPTION]... //HOST COMMAND
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display help message |
| `-V`, `--version` | Display version number |
| `-U`, `--user=[DOMAIN/]USERNAME[%PASSWORD]` | Set the network username and password |
| `-A`, `--authentication-file=FILE` | Get the credentials from a specified file |
| `-N`, `--no-pass` | Do not ask for a password |
| `-k`, `--kerberos=STRING` | Use Kerberos authentication: `-k [yes\|no]` |
| `-d`, `--debuglevel=DEBUGLEVEL` | Set debug level for troubleshooting |
| `--uninstall` | Uninstall the winexe service from the target after remote execution |
| `--reinstall` | Reinstall the winexe service on the target before remote execution |
| `--system` | Execute the command using the Windows SYSTEM account |
| `--profile` | Load the user's profile on the remote system |
| `--convert` | Try to convert characters between local and remote code-pages |
| `--runas=[DOMAIN\]USERNAME%PASSWORD` | Run as the given user (**WARNING**: Password is sent in cleartext over the network!) |
| `--runas-file=FILE` | Run as user options defined in a specified file |
| `--interactive=0\|1` | Desktop interaction: `0` (disallow), `1` (allow). If allow, also use `--system` (Windows requirement). Not supported on Vista and later. |
| `--ostype=0\|1\|2` | OS type: `0` (32-bit), `1` (64-bit), `2` (winexe decides). Determines which service version is installed. |

## Notes
- **Security Warning**: The `--runas` option sends passwords in cleartext over the network. Use with extreme caution.
- **Service Cleanup**: By default, winexe may leave a service behind on the target. Use `--uninstall` to ensure the service is removed after the command completes.
- **Modern Windows**: While the documentation mentions older versions (NT/2000/XP), winexe can work on newer Windows versions if SMBv1/v2 and administrative shares (C$, ADMIN$) are enabled and accessible.
- **Permissions**: Remote execution requires administrative privileges on the target machine.