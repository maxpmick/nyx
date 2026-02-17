---
name: apache-users
description: Enumerate valid system usernames on web servers running the Apache UserDir module (mod_userdir). Use when performing web application reconnaissance, user enumeration, or information gathering to identify potential login names for further exploitation or brute-force attacks.
---

# apache-users

## Overview
A Perl script designed to enumerate usernames on systems running Apache with the UserDir module enabled. It works by requesting the home directories of users (typically `/~username/`) and analyzing the HTTP response codes to distinguish between valid and invalid accounts. Category: Web Application Testing / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, install it using:

```bash
sudo apt install apache-users
```

Dependencies: `libio-all-lwp-perl`, `libio-socket-ip-perl`, `libparallel-forkmanager-perl`.

## Common Workflows

### Basic Enumeration
Identify valid users on a target host using a standard wordlist over HTTP:
```bash
apache-users -h 192.168.1.202 -l /usr/share/wordlists/metasploit/unix_users.txt -p 80 -s 0
```

### High-Performance Enumeration with SSL
Enumerate users over HTTPS using 20 threads and looking for a specific HTTP error code (e.g., 403 Forbidden) that indicates a user exists but directory listing is denied:
```bash
apache-users -h example.com -l /usr/share/wordlists/usernames.txt -p 443 -s 1 -e 403 -t 20
```

## Complete Command Reference

```
USAGE: apache-users [-h <host>] [-l <wordlist>] [-p <port>] [-s <ssl>] [-e <http_code>] [-t <threads>]
```

| Flag | Description |
|------|-------------|
| `-h` | Target IP address or hostname |
| `-l` | Path to the wordlist containing usernames to test |
| `-p` | Port number of the web server (default is usually 80) |
| `-s` | SSL Support: `1` for true (HTTPS), `0` for false (HTTP) |
| `-e` | The HTTP error code to look for that indicates a valid user (e.g., `403`) |
| `-t` | Number of concurrent threads to use for enumeration |

## Notes
- This tool relies on the Apache `mod_userdir` being enabled and configured in a way that reveals the existence of users through different HTTP response codes (e.g., 403 Forbidden vs 404 Not Found).
- Ensure you choose the correct `-e` code based on initial manual testing of a known valid and invalid user on the target system.