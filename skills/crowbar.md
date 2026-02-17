---
name: crowbar
description: Brute force tool designed to attack protocols using non-traditional methods, such as SSH private keys instead of passwords, and RDP with NLA support. Use when performing password attacks or credential stuffing against OpenVPN, RDP, VNC, or SSH services during penetration testing, especially when private keys have been recovered.
---

# crowbar

## Overview
Crowbar is a brute forcing tool developed to attack specific protocols in unique ways. Unlike many tools that focus on username/password combinations for all services, Crowbar specializes in SSH private key authentication, RDP with Network Level Authentication (NLA), VNC keys, and OpenVPN. Category: Password Attacks.

## Installation (if not already installed)
Assume crowbar is already installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install crowbar
```

Dependencies include `freerdp3-x11`, `openvpn`, `python3-nmap`, `python3-paramiko`, and `vncviewer`.

## Common Workflows

### RDP Brute Force
Attack a single RDP host using a specific username and a password wordlist:
```bash
crowbar -b rdp -s 192.168.1.100/32 -u admin -C /usr/share/wordlists/rockyou.txt -n 1
```

### SSH Private Key Attack
Attempt to authenticate to a server using a folder full of discovered private keys:
```bash
crowbar -b sshkey -s 192.168.1.105/32 -u root -k ~/recovered_keys/ -n 5
```

### VNC Key Brute Force
Attack a VNC service using a key file:
```bash
crowbar -b vnckey -s 10.0.0.5/32 -k /path/to/vnc.key
```

### OpenVPN Brute Force
Brute force OpenVPN using a configuration file and password list:
```bash
crowbar -b openvpn -s 10.0.0.1/32 -m client.conf -u vpnuser -C passwords.txt
```

## Complete Command Reference

```
crowbar [options]
```

### Required Options

| Flag | Description |
|------|-------------|
| `-b`, `--brute {openvpn,rdp,sshkey,vnckey}` | Target service to attack |

### Target Selection

| Flag | Description |
|------|-------------|
| `-s`, `--server SERVER` | Static target (IP or CIDR range) |
| `-S`, `--serverfile FILE` | Multiple targets stored in a file |
| `-p`, `--port PORT` | Alter the port if the service is not using the default value |
| `-d`, `--discover` | Perform a port scan before attacking to identify open ports |

### Authentication Options

| Flag | Description |
|------|-------------|
| `-u`, `--username USER` | Static name to login with (supports multiple: `-u user1 user2`) |
| `-U`, `--usernamefile FILE` | Multiple names to login with, stored in a file |
| `-c`, `--passwd PASS` | Static password to login with |
| `-C`, `--passwdfile FILE` | Multiple passwords to login with, stored in a file |
| `-k`, `--keyfile FILE/DIR` | [SSH/VNC] (Private) Key file or folder containing multiple files |
| `-m`, `--config CONFIG` | [OpenVPN] Configuration file |

### Performance and Output

| Flag | Description |
|------|-------------|
| `-n`, `--number THREAD` | Number of threads to be active at once |
| `-t`, `--timeout SEC` | [SSH] How long to wait for each thread in seconds |
| `-l`, `--log FILE` | Log file (only write attempts) |
| `-o`, `--output FILE` | Output file (write everything else) |
| `-v`, `--verbose` | Enable verbose output (use `-vv` for more detail) |
| `-D`, `--debug` | Enable debug mode |
| `-q`, `--quiet` | Only display successful logins |
| `-h`, `--help` | Show help message and exit |

## Notes
- **RDP Threading**: It is often recommended to use `-n 1` for RDP brute forcing to avoid stability issues or account lockouts on the target.
- **SSH Keys**: When using `-b sshkey`, the tool iterates through keys provided in the `-k` path.
- **Network Ranges**: The `-s` flag accepts CIDR notation (e.g., `192.168.1.0/24`).