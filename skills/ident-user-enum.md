---
name: ident-user-enum
description: Query the ident service (113/TCP) to determine the OS-level owner of processes listening on specific TCP ports. Use during the reconnaissance or information gathering phase to identify services running as root or to harvest usernames for subsequent password guessing attacks.
---

# ident-user-enum

## Overview
A simple Perl script used to query the ident service (TCP port 113) on a target system. It maps active TCP network processes to the specific OS-level usernames running them. This information helps penetration testers prioritize targets (e.g., attacking root-owned processes) or build user lists for credential attacks. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, install it using:

```bash
sudo apt update
sudo apt install ident-user-enum
```

Dependencies: `libio-socket-ip-perl`, `libnet-ident-perl`, `perl`.

## Common Workflows

### Identify owners of common infrastructure ports
```bash
ident-user-enum 192.168.1.13 22 80 443
```

### Check file sharing and RPC service owners
```bash
ident-user-enum 192.168.1.13 135 139 445
```

### Bulk port check for a single host
```bash
ident-user-enum 10.0.0.5 21 22 23 25 53 80 110 111 139 443 445
```

## Complete Command Reference

```bash
ident-user-enum [options] <ip> <port> [port [port ...]]
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<ip>` | The target IP address to query. |
| `<port>` | One or more TCP port numbers to check. Multiple ports are separated by spaces. |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help message and usage summary. |

## Notes
- **Requirement**: The target system must have an `identd` (Identification Protocol) service running and reachable on TCP port 113 for this tool to function.
- **Accuracy**: The results depend entirely on the honesty and configuration of the remote ident service.
- **Usage Tip**: If a port is identified as being owned by `root`, it may be a higher-value target for exploitation as it could lead to immediate full system compromise.
- **Username Harvesting**: Usernames discovered via ident can be fed into tools like `hydra` or `medusa` for brute-force attacks against other services like SSH or FTP.