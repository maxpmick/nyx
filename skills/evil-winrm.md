---
name: evil-winrm
description: Ultimate WinRM shell for hacking and penetration testing. It provides an interactive shell over the Windows Remote Management (WinRM) protocol using PowerShell Remoting Protocol (PSRP). Use this tool during post-exploitation to gain command execution on Windows hosts when valid credentials or hashes are available, typically targeting port 5985 (HTTP) or 5986 (HTTPS).
---

# evil-winrm

## Overview
Evil-WinRM is a specialized shell for exploiting the WinRM protocol. It allows for interactive PowerShell sessions, script loading, and C# executable execution. It supports various authentication methods including plaintext passwords, NTLM hashes (Pass-the-Hash), and Kerberos. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume evil-winrm is already installed. If the command is missing:

```bash
sudo apt install evil-winrm
```

## Common Workflows

### Basic Authentication (Plaintext)
```bash
evil-winrm -i 192.168.1.100 -u Administrator -p 'Password123!'
```

### Pass-the-Hash (NTLM)
```bash
evil-winrm -i 192.168.1.100 -u Administrator -H 32196B35ED9D6D0E79451D9DF0941A33
```

### Using SSL and Custom Scripts/Executables
```bash
evil-winrm -i 10.10.10.10 -u user -p pass -S -s /opt/scripts -e /opt/exes
```
Once connected, you can use `Bypass-404` or load scripts directly from the specified local paths.

### Kerberos Authentication
Ensure `/etc/krb5.conf` is configured correctly for the realm.
```bash
evil-winrm -i dc01.contoso.com -r CONTOSO.COM
```

## Complete Command Reference

```
Usage: evil-winrm -i IP -u USER [Options]
```

### Connection Options

| Flag | Description |
|------|-------------|
| `-i`, `--ip IP` | **Required.** Remote host IP, hostname, or FQDN (FQDN required for Kerberos) |
| `-u`, `--user USER` | Username (required if not using Kerberos) |
| `-p`, `--password PASS` | Password for authentication |
| `-H`, `--hash HASH` | NTLM hash for Pass-the-Hash authentication |
| `-P`, `--port PORT` | Remote host port (default: 5985) |
| `-U`, `--url URL` | Remote URL endpoint (default: `/wsman`) |
| `-S`, `--ssl` | Enable SSL (typically uses port 5986) |
| `-a`, `--user-agent UA` | Specify connection user-agent (default: `Microsoft WinRM Client`) |

### Authentication & Security Options

| Flag | Description |
|------|-------------|
| `-c`, `--pub-key PATH` | Local path to public key certificate |
| `-k`, `--priv-key PATH` | Local path to private key certificate |
| `-r`, `--realm DOMAIN` | Kerberos auth realm (must match `/etc/krb5.conf` configuration) |
| `--spn SPN_PREFIX` | SPN prefix for Kerberos authentication (default: `HTTP`) |

### Feature & Environment Options

| Flag | Description |
|------|-------------|
| `-s`, `--scripts PATH` | Local path to PowerShell scripts to make available in the session |
| `-e`, `--executables PATH` | Local path to C# executables to make available in the session |
| `-l`, `--log` | Log the WinRM session to a file |
| `-n`, `--no-colors` | Disable ANSI color output |
| `-N`, `--no-rpath-completion` | Disable remote path completion |

### Information Options

| Flag | Description |
|------|-------------|
| `-V`, `--version` | Show version information |
| `-h`, `--help` | Display the help message |

## Notes
- **Script Loading**: When using `-s`, you can load scripts into memory by simply typing the filename within the Evil-WinRM shell.
- **Binary Execution**: When using `-e`, C# binaries can be executed directly from memory using the `Invoke-Binary` command or by typing the name.
- **SSL**: If the target uses a self-signed certificate, ensure you use the `-S` flag.
- **Kerberos**: Requires a valid Ticket Granting Ticket (TGT) in the local cache and proper DNS resolution of the target's FQDN.