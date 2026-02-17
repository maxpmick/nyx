---
name: sara
description: Perform security audits and configuration analysis on MikroTik RouterOS devices. Use when assessing the security posture of MikroTik hardware, checking for misconfigurations, or identifying known CVEs associated with specific RouterOS versions during infrastructure assessments or penetration tests.
---

# sara

## Overview
Sara (RouterOS Security Inspector) is an autonomous configuration analyzer designed to find security issues on MikroTik hardware. It connects via SSH to audit the device configuration and can check the running version against known vulnerabilities. Category: Vulnerability Analysis / Infrastructure Auditing.

## Installation (if not already installed)
Assume sara is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install sara
```

Dependencies: python3, python3-colorama, python3-netmiko, python3-packaging, python3-requests.

## Common Workflows

### Standard Security Audit
Connect to a MikroTik router using password authentication to perform a configuration check:
```bash
sara --ip 192.168.88.1 --username admin --password 'yourpassword'
```

### Vulnerability Check (CVE)
Perform a configuration audit and specifically check the RouterOS version against known CVEs:
```bash
sara --ip 192.168.88.1 --username admin --password 'yourpassword' --cve
```

### Key-Based Authentication
Connect using an SSH key with a passphrase, skipping the legal confirmation prompt:
```bash
sara --ip 10.0.0.1 --username admin --ssh-key ~/.ssh/id_rsa --passphrase 'keypass' --skip-confirmation
```

## Complete Command Reference

```bash
usage: sara [-h] [--ip IP] [--username USERNAME] [--password PASSWORD]
             [--ssh-key SSH_KEY] [--passphrase PASSPHRASE] [--port PORT]
             [--cve] [--skip-confirmation]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--ip IP` | The IP address or hostname of the MikroTik router |
| `--username USERNAME` | SSH username (a Read-Only account is sufficient) |
| `--password PASSWORD` | SSH password for the specified user |
| `--ssh-key SSH_KEY` | Path to the SSH private key for authentication |
| `--passphrase PASSPHRASE` | Passphrase for the specified SSH key |
| `--port PORT` | SSH port of the router (default: 22) |
| `--cve` | Check the RouterOS version against a database of known CVEs |
| `--skip-confirmation` | Skips the legal usage confirmation prompt at startup |

## Notes
- **Permissions**: A Read-Only (RO) account on the RouterOS device is usually sufficient for the inspector to gather the necessary configuration data.
- **Legal**: Only use this tool on devices you own or have explicit permission to audit. Unauthorized use on third-party systems is illegal.
- **CVE Check**: The `--cve` flag requires an internet connection to fetch or compare against vulnerability data.