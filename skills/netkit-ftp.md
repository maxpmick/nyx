---
name: netkit-ftp
description: Transfer files to and from a remote network site using the ARPANET standard File Transfer Protocol (FTP). Use when performing file transfers, exfiltrating data, uploading web shells, or interacting with FTP services during penetration testing and post-exploitation.
---

# netkit-ftp

## Overview
The user interface to the ARPANET standard File Transfer Protocol. It allows for interactive or automated file transfers between a local machine and a remote network site. Category: Information Gathering / Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume the tool is already installed. If the `ftp` command is missing:

```bash
sudo apt install ftp
```

## Common Workflows

### Connect and Login Manually
```bash
ftp 192.168.1.100
```
Prompts for username and password upon connection.

### Non-interactive Login (Inhibit Auto-login)
```bash
ftp -n 192.168.1.100
```
Connects to the host without attempting an automatic login, allowing for manual `user` and `pass` commands or script-driven interaction.

### Download Multiple Files without Prompting
```bash
ftp -i 192.168.1.100
# Inside FTP shell:
# mget *.txt
```
Disables interactive prompting during multiple file transfers (mget).

### Enable Passive Mode
```bash
ftp -p 192.168.1.100
```
Useful when the client is behind a firewall or NAT that prevents the server from initiating data connections back to the client.

## Complete Command Reference

### Usage
```bash
ftp [-46pinegvtd] [hostname]
pftp [-46pinegvtd] [hostname]
```

### Options

| Flag | Description |
|------|-------------|
| `-4` | Use IPv4 addresses only |
| `-6` | Use IPv6 addresses only |
| `-p` | Enable passive mode (default behavior for `pftp`) |
| `-i` | Turn off interactive prompting during multi-file transfers (`mget`) |
| `-n` | Inhibit auto-login upon initial connection |
| `-e` | Disable readline support (command history/editing), if present |
| `-g` | Disable filename globbing (wildcard expansion) |
| `-v` | Verbose mode: displays all responses from the remote server |
| `-t` | Enable packet tracing [Note: nonfunctional in this version] |
| `-d` | Enable debugging mode |

## Notes
- `pftp` is a symlink or alias to `ftp` that enables passive mode by default.
- When using `ftp` in scripts, the `-n` flag is often combined with a "here document" (EOF) to automate commands.
- Security Warning: FTP transmits credentials and data in cleartext. Use `sftp` or `lftp` with SSL/TLS if encryption is required.