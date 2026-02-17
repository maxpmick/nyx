---
name: pacu
description: Exploit configuration flaws within AWS environments using an open-source exploitation framework. Use when performing AWS penetration testing, cloud security audits, privilege escalation, backdooring IAM users, or attacking Lambda functions.
---

# pacu

## Overview
Pacu is an open-source AWS exploitation framework designed for offensive security testing against cloud environments. Created by Rhino Security Labs, it uses a modular architecture to enable a range of attacks including reconnaissance, privilege escalation, persistence, and data exfiltration. Category: Exploitation / Cloud Security.

## Installation (if not already installed)
Assume pacu is already installed. If you get a "command not found" error:

```bash
sudo apt install pacu
```

## Common Workflows

### Start a new session and import AWS keys
```bash
pacu --new-session pentest_aws --set-keys "my-alias,AKIA...,SECRET...,TOKEN..."
```

### List available modules and get info on a specific one
```bash
pacu --list-modules
pacu --module-name iam__privesc_scan --module-info
```

### Execute a module against specific regions
```bash
pacu --module-name enum_ebs --module-args "--regions us-east-1,us-west-2" --exec
```

### Check current identity and permissions
```bash
pacu --whoami
```

## Complete Command Reference

```bash
pacu [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--session <name>` | Specify the session name to use |
| `--activate-session` | Activate a session (use with `--session` to set the name) |
| `--new-session <name>` | Create and start a new session with the specified name |
| `--set-keys <alias,id,key,token>` | Set AWS credentials (alias, access key ID, secret key, and optional session token) |
| `--import-keys <profile>` | Import AWS credentials from a specific AWS CLI profile name |
| `--module-name <name>` | Specify the name of the module to interact with |
| `--data <service/all>` | Download/interact with data for a specific service or all services |
| `--module-args <args>` | Pass arguments to a module (e.g., `--module-args='--regions us-east-1'`) |
| `--list-modules` | List all available modules within the framework |
| `--pacu-help` | Display the internal Pacu help window/menu |
| `--module-info` | Get detailed information on a specific module (requires `--module-name`) |
| `--exec` | Execute the module specified by `--module-name` |
| `--set-regions <r1 r2 ...>` | Set the active regions for the session (use `<region1 region2>` or `all`) |
| `--whoami` | Display information regarding the current IAM user/identity |
| `--version` | Display the current Pacu version |
| `-q`, `--quiet` | Do not print the ASCII banner on startup |

## Notes
- Pacu stores session data in a local database; ensure you use `--session` to resume previous work.
- Many modules require specific permissions; use the `iam__brute_remediation` or `iam__enum_permissions` modules to understand what the current keys can access.
- When using `--module-args`, ensure the arguments are wrapped in quotes if they contain spaces or special characters.