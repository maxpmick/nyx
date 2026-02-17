---
name: hostsman
description: Manage the local hosts file (/etc/hosts) by adding, removing, checking, or listing IP-to-hostname mappings. Use when performing local DNS redirection, setting up development environments, bypassing DNS for specific targets, or managing local name resolution during penetration testing.
---

# hostsman

## Overview
A cross-platform command line tool for handling hosts files. It allows for quick manipulation of `/etc/hosts` entries, including adding new mappings, removing existing ones, and verifying current entries. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume hostsman is already installed. If you get a "command not found" error:

```bash
sudo apt install hostsman
```

Dependencies: python3, python3-colorama, python3-mock, python3-pygments.

## Common Workflows

### List current hosts file content
```bash
hostsman -l
```

### Add a new mapping
```bash
sudo hostsman -i target-app.local:192.168.1.50
```
Note: Modifying `/etc/hosts` typically requires root privileges.

### Check if a hostname exists
```bash
hostsman -c dev.internal staging.internal
```

### Remove a mapping
```bash
sudo hostsman -r target-app.local
```

## Complete Command Reference

```
hostsman [-h] [-l | -c HOSTNAME [HOSTNAME ...] | -i HOSTNAME[:IP] [HOSTNAME[:IP] ...] | -r HOSTNAME [HOSTNAME ...]]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-l`, `--list` | Show the content of the hosts file. |
| `-c`, `--check HOSTNAME [HOSTNAME ...]` | Check if the specified host name(s) exist in the host file. |
| `-i`, `--insert HOSTNAME[:IP] [HOSTNAME[:IP] ...]` | Insert HOSTNAME[:IP] mappings. If IP is omitted, it may default to 127.0.0.1 depending on environment, but providing the IP is recommended. |
| `-r`, `--remove HOSTNAME [HOSTNAME ...]` | Remove mapping for the specified HOSTNAME(s) from the hosts file. |

## Notes
- Hosts file location: `/etc/hosts`.
- You must run `hostsman` with `sudo` or as the root user to perform `-i` (insert) or `-r` (remove) operations, as the hosts file is a protected system file.
- Multiple hostnames can be passed to the `-c`, `-i`, and `-r` flags in a single command.