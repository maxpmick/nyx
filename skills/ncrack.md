---
name: ncrack
description: High-speed network authentication cracking tool designed for rapid, large-scale auditing of multiple hosts. Supports protocols including RDP, SSH, HTTP(S), SMB, POP3(S), VNC, FTP, and Telnet. Use when performing password attacks, credential stuffing, or security auditing against network services during penetration testing.
---

# ncrack

## Overview
Ncrack is a modular network authentication cracking tool with a syntax similar to Nmap. It features a dynamic engine that adapts behavior based on network feedback and provides fine-grained control over timing and parallelization. Category: Password Attacks / Web Application Testing.

## Installation (if not already installed)
Assume ncrack is already installed. If missing:

```bash
sudo apt install ncrack
```

## Common Workflows

### Basic SSH Brute Force
```bash
ncrack -v --user root -P /usr/share/wordlists/rockyou.txt 192.168.1.10:22
```

### RDP Attack with Strict Connection Limits
```bash
ncrack -v -iL targets.txt --user administrator -P passwords.txt -p rdp:CL=1
```

### Multi-Service Audit from Nmap XML
```bash
ncrack -v -iX nmap_results.xml -g CL=5,to=1h -f
```
Reads targets from Nmap output, sets a global limit of 5 concurrent connections per service, a 1-hour timeout, and stops after the first credential found (`-f`).

### HTTP Form Brute Force with Path
```bash
ncrack -v -p http:path=/login.php --user admin -P wordlist.txt 192.168.1.50
```

## Complete Command Reference

### Target Specification
| Flag | Description |
|------|-------------|
| `<target>` | Hostnames, IP addresses, networks (e.g., `scanme.nmap.org`, `10.0.0.0/24`) |
| `-iX <file>` | Input from Nmap's -oX XML output format |
| `-iN <file>` | Input from Nmap's -oN Normal output format |
| `-iL <file>` | Input from list of hosts/networks |
| `--exclude <list>` | Comma-separated list of hosts/networks to exclude |
| `--excludefile <file>` | Exclude list from file |

### Service Specification
Services can be defined as `service://target` or via `-p`.
| Flag | Description |
|------|-------------|
| `-p <service-list>` | Services/ports applied to all non-standard notation hosts |
| `-m <service>:<opts>` | Options applied to all services of this specific type |
| `-g <options>` | Options applied to every service globally |

**Service-Specific Arguments:**
- `ssl`: Enable SSL over the service
- `path <name>`: Used in modules like HTTP (escape `=` if used)
- `db <name>`: Used in MongoDB to specify the database
- `domain <name>`: Used in WinRM to specify the domain

### Timing and Performance
Values are in seconds unless suffixed with `ms`, `m`, or `h`.
| Flag | Description |
|------|-------------|
| `-T<0-5>` | Set timing template (0: Paranoid, 5: Insane) |
| `--connection-limit <n>` | Threshold for total concurrent connections |
| `--stealthy-linear` | Use only one connection per host sequentially (overrides other timing) |

**Granular Timing Options (used in -m or -g):**
- `cl`: Minimum concurrent parallel connections
- `CL`: Maximum concurrent parallel connections
- `at`: Authentication attempts per connection
- `cd`: Delay between each connection initiation
- `cr`: Caps number of service connection attempts
- `to`: Maximum cracking time for service

### Authentication
| Flag | Description |
|------|-------------|
| `-U <file>` | Username file |
| `-P <file>` | Password file |
| `--user <list>` | Comma-separated username list |
| `--pass <list>` | Comma-separated password list |
| `--passwords-first` | Iterate password list for each username (default is opposite) |
| `--pairwise` | Choose usernames and passwords in pairs |

### Output
| Flag | Description |
|------|-------------|
| `-oN <file>` | Output in normal format |
| `-oX <file>` | Output in XML format |
| `-oA <basename>` | Output in both normal and XML formats |
| `-v` | Increase verbosity (use multiple times for more effect) |
| `-d[level]` | Set debugging level (0-10) |
| `--nsock-trace <n>` | Set nsock trace level (0-10) |
| `--log-errors` | Log errors/warnings to normal output file |
| `--append-output` | Append to rather than overwrite output files |

### Miscellaneous
| Flag | Description |
|------|-------------|
| `--resume <file>` | Continue previously saved session |
| `--save <file>` | Save restoration file with specific filename |
| `-f` | Quit cracking a service after one valid credential is found |
| `-6` | Enable IPv6 cracking |
| `-sL`, `--list` | Only list hosts and services without cracking |
| `--datadir <dir>` | Specify custom Ncrack data file location |
| `--proxy <type://p:port>` | Use proxy (socks4, 4a, http) |
| `-V` | Print version |
| `-h` | Print help summary |

## Supported Modules
SSH, RDP, FTP, Telnet, HTTP(S), Wordpress, POP3(S), IMAP, CVS, SMB, VNC, SIP, Redis, PostgreSQL, MQTT, MySQL, MSSQL, MongoDB, Cassandra, WinRM, OWA, DICOM.

## Notes
- Ncrack's syntax is intentionally similar to Nmap to lower the learning curve.
- Use `-f` when you only need one working account to gain initial access.
- The `CL` (max connection limit) is critical for avoiding account lockouts or crashing fragile services like RDP.