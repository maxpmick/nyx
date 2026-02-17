---
name: evil-winrm-py
description: Execute commands on remote Windows machines using the WinRM (Windows Remote Management) protocol. This Python-based tool provides an interactive shell with features like file upload/download, command history, and colorized output. Use it during exploitation or post-exploitation phases to gain remote shell access to Windows hosts using credentials, NTLM hashes (Pass-the-Hash), or certificates.
---

# evil-winrm-py

## Overview
Python-based tool for executing commands on remote Windows machines via WinRM. It supports multiple authentication methods including NTLM, Pass-the-Hash, Certificate, and Kerberos. It is a functional alternative to the original Ruby-based Evil-WinRM. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install evil-winrm-py
```

## Common Workflows

### Basic Authentication
Connect to a remote host using a username and password:
```bash
evil-winrm-py -i 192.168.1.100 -u Administrator -p 'P@ssword123!'
```

### Pass-the-Hash (PtH)
Connect using an NTLM hash instead of a plaintext password:
```bash
evil-winrm-py -i 10.10.10.15 -u Administrator -H 32196B35ED9D6D0E36745159D936C392
```

### Secure Connection with SSL
Connect to a WinRM service over HTTPS (usually port 5986):
```bash
evil-winrm-py -i 10.10.10.15 -u Administrator -p 'Password' --ssl --port 5986
```

### Certificate Authentication
Connect using a private key and certificate:
```bash
evil-winrm-py -i 10.10.10.15 --priv-key-pem cert.key --cert-pem cert.pem --ssl
```

## Complete Command Reference

The tool can be invoked using either `evil-winrm-py` or the alias `ewp`.

```
usage: evil-winrm-py [-h] -i IP [-u USER] [-p PASSWORD] [-H HASH]
                     [--priv-key-pem PRIV_KEY_PEM] [--cert-pem CERT_PEM]
                     [--uri URI] [--ua UA] [--port PORT] [--no-pass] [--ssl]
                     [--log] [--debug] [--no-colors] [--version]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-i`, `--ip IP` | Remote host IP address or hostname (Required) |
| `-u`, `--user USER` | Username for authentication |
| `-p`, `--password PASSWORD` | Password for authentication |
| `-H`, `--hash HASH` | NTLM hash (nthash) for Pass-the-Hash authentication |
| `--priv-key-pem FILE` | Local path to the private key PEM file |
| `--cert-pem FILE` | Local path to the certificate PEM file |
| `--uri URI` | WSMAN URI (default: `/wsman`) |
| `--ua UA` | User agent string for the WinRM client (default: "Microsoft WinRM Client") |
| `--port PORT` | Remote host port (default: `5985`) |
| `--no-pass` | Do not prompt for a password |
| `--ssl` | Use SSL (HTTPS) for the connection |
| `--log` | Log the entire session to a file |
| `--debug` | Enable verbose debug logging |
| `--no-colors` | Disable colorized output in the shell |
| `--version` | Show program's version number and exit |

## Notes
- WinRM typically listens on port `5985` (HTTP) or `5986` (HTTPS).
- If using `--ssl`, ensure you specify the correct port if it differs from the default.
- Once a session is established, the tool provides an interactive PowerShell-like environment.
- This tool is a Python implementation; for the original Ruby version, use `evil-winrm`.