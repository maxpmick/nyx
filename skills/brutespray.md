---
name: brutespray
description: Automatically brute-force network services discovered from scanner output files. It parses Nmap (GNMAP/XML), Nessus (.nessus), Nexpose (XML), and other list formats to identify open ports and services, then attempts credential attacks. Use when you have completed a vulnerability scan or port discovery and want to automate the exploitation of discovered services like SSH, FTP, Telnet, or MySQL.
---

# brutespray

## Overview
Brutespray is a high-performance tool written in Golang (formerly Python) designed to automate the brute-forcing of network services. It takes output from popular scanners and maps discovered services to brute-force modules, eliminating the need to manually configure attacks for every discovered host. Category: Exploitation.

## Installation (if not already installed)
Assume brutespray is already installed. If the command is missing:

```bash
sudo apt install brutespray
```

## Common Workflows

### Brute-force from Nmap GNMAP output
Attack all discovered services in an Nmap scan using specific wordlists:
```bash
brutespray -f results.gnmap -u /usr/share/wordlists/metasploit/unix_users.txt -p /usr/share/wordlists/metasploit/password.lst -t 10 -T 2
```

### Target a specific service from a Nessus file
Only attempt to brute-force SSH services found within a Nessus export:
```bash
brutespray -f scan_results.nessus -s ssh -u admin -p /usr/share/wordlists/rockyou.txt
```

### Direct target attack (CIDR support)
Brute-force a specific range without a prior scan file:
```bash
brutespray -H ssh://192.168.1.0/24:22 -u user.txt -p pass.txt
```

### Using Combo lists
Use a colon-separated `user:pass` file for the attack:
```bash
brutespray -f nmap_out.xml -C /path/to/combos.txt
```

## Complete Command Reference

```
brutespray [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-C <string>` | Specify a combo wordlist delimited by ':', example: `user1:password` |
| `-H <string>` | Target in the format `service://host:port`. CIDR ranges supported. Default port used if not specified |
| `-P` | Print found hosts parsed from provided host and file arguments (dry run) |
| `-S` | List all supported services |
| `-T <int>` | Number of hosts to brute-force at the same time (default 5) |
| `-f <string>` | File to parse. Supported: Nmap (GNMAP/XML), Nessus (.nessus), Nexpose (XML), Lists, etc. |
| `-o <string>` | Directory containing successful attempts (default "brutespray-output") |
| `-p <string>` | Password or password file to use for brute-force |
| `-q` | Suppress the banner |
| `-r <int>` | Amount of times to retry after receiving connection failed (default 3) |
| `-s <string>` | Service type: ssh, ftp, smtp, etc. Default is "all" |
| `-t <int>` | Number of threads to use per host (default 10) |
| `-u <string>` | Username or user list to brute-force |
| `-w <duration>` | Set timeout of brute-force attempts (default 5s) |

## Notes
- **Performance**: The Golang version is significantly faster than the legacy Python version. Adjust `-t` (threads) and `-T` (parallel hosts) carefully to avoid crashing services or triggering rate limits.
- **Output**: Successful credentials are saved in the `brutespray-output` directory by default.
- **Service Support**: Use `brutespray -S` to see the current list of supported protocols (typically includes ssh, ftp, telnet, vnc, mssql, mysql, postgres, etc.).