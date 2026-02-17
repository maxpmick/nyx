---
name: medusa
description: Fast, parallel, modular login brute-forcer for network services. It supports multiple protocols via independent modules and allows for concurrent testing of hosts, users, and passwords. Use when performing password auditing, credential brute-forcing, or vulnerability assessments against services like SSH, FTP, HTTP, SMB, or RDP.
---

# medusa

## Overview
Medusa is a speedy, massively parallel, modular, login brute-forcer. It is designed to support as many services as possible that allow remote authentication through a modular framework. It belongs to the Password Attacks, Information Gathering, Vulnerability Analysis, and Web Application Testing domains.

## Installation (if not already installed)
Medusa is typically pre-installed on Kali Linux. If it is missing:

```bash
sudo apt update
sudo apt install medusa
```

## Common Workflows

### Brute-force SSH with a single user and a password list
```bash
medusa -h 192.168.1.100 -u admin -P /usr/share/wordlists/rockyou.txt -M ssh
```

### Test multiple hosts for a specific credential (SMB)
```bash
medusa -H targets.txt -u Administrator -p Password123 -M smbnt
```

### Parallel scan with "Password = Username" check
```bash
medusa -h 192.168.1.50 -U users.txt -P passwords.txt -e ns -M ftp -t 10
```

### Stop after the first valid credential is found on any host
```bash
medusa -H network_range.txt -U users.txt -P passwords.txt -M ssh -F
```

## Complete Command Reference

### Basic Syntax
```bash
medusa [-h host|-H file] [-u username|-U file] [-p password|-P file] [-C file] -M module [OPT]
```

### Target Selection
| Flag | Description |
|------|-------------|
| `-h [TEXT]` | Target hostname or IP address |
| `-H [FILE]` | File containing target hostnames or IP addresses |

### User and Password Options
| Flag | Description |
|------|-------------|
| `-u [TEXT]` | Username to test |
| `-U [FILE]` | File containing usernames to test |
| `-p [TEXT]` | Password to test |
| `-P [FILE]` | File containing passwords to test |
| `-C [FILE]` | File containing combo entries (format: user:pass or host