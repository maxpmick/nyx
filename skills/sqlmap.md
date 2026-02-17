---
name: sqlmap
description: Automatically detect and exploit SQL injection vulnerabilities in web applications. It supports fingerprinting the DBMS, retrieving data, accessing the underlying file system, and executing OS commands. Use when performing web application security testing, database reconnaissance, or exploitation of identified SQL injection points.
---

# sqlmap

## Overview
sqlmap is an open-source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over database servers. It supports a wide range of database management systems including MySQL, Oracle, PostgreSQL, Microsoft SQL Server, and more. Category: Web Application Testing / Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume sqlmap is already installed. If not:
```bash
sudo apt install sqlmap
```

## Common Workflows

### Basic Database Enumeration
```bash
sqlmap -u "http://example.com/vuln.php?id=1" --dbs --batch
```

### Enumerating Tables and Dumping Data
```bash
sqlmap -u "http://example.com/vuln.php?id=1" -D target_db --tables
sqlmap -u "http://example.com/vuln.php?id=1" -D target_db -T users --dump
```

### Testing POST Data with Random User-Agent
```bash
sqlmap -u "http://example.com/login.php" --data="user=admin&pass=123" -p user --random-agent
```

### Gaining an OS Shell (if privileges allow)
```bash
sqlmap -u "http://example.com/prod.php?id=1" --os-shell
```

## Complete Command Reference

### sqlmap Options

| Flag | Description |
|------|-------------|
| `-h` | Show basic help message |
| `-hh` | Show advanced help message |
| `--version` | Show program's version number |
| `-v VERBOSE` | Verbosity level: 0-6 (default 1) |

**Target**
| Flag | Description |
|------|-------------|
| `-u URL`, `--url=URL` | Target URL (e.g. "http://www.site.com/vuln.php?id=1") |
| `-g GOOGLEDORK` | Process Google dork results as target URLs |

**Request**
| Flag | Description |
|------|-------------|
| `--data=DATA` | Data string to be sent through POST (e.g. "id=1") |
| `--cookie=COOKIE` | HTTP Cookie header value |
| `--random-agent` | Use randomly selected HTTP User-Agent header value |
| `--proxy=PROXY` | Use a proxy to connect to the target URL |
| `--tor` | Use Tor anonymity network |
| `--check-tor` | Check to see if Tor is used properly |

**Injection**
| Flag | Description |
|------|-------------|
| `-p TESTPARAMETER` | Testable parameter(s) |
| `--dbms=DBMS` | Force back-end DBMS to provided value |

**Detection**
| Flag | Description |
|------|-------------|
| `--level=LEVEL` | Level of tests to perform (1-5, default 1) |
| `--risk=RISK` | Risk of tests to perform (1-3, default 1) |

**Techniques**
| Flag | Description |
|------|-------------|
| `--technique=TECH` | SQL injection techniques to use (default "BEUSTQ") |

**Enumeration**
| Flag | Description |
|------|-------------|
| `-a`, `--all` | Retrieve everything |
| `-b`, `--banner` | Retrieve DBMS banner |
| `--current-user` | Retrieve DBMS current user |
| `--current-db` | Retrieve DBMS current database |
| `--passwords` | Enumerate DBMS users password hashes |
| `--dbs` | Enumerate DBMS databases |
| `--tables` | Enumerate DBMS database tables |
| `--columns` | Enumerate DBMS database table columns |
| `--schema` | Enumerate DBMS schema |
| `--dump` | Dump DBMS database table entries |
| `--dump-all` | Dump all DBMS databases tables entries |
| `-D DB` | DBMS database to enumerate |
| `-T TBL` | DBMS database table(s) to enumerate |
| `-C COL` | DBMS database table column(s) to enumerate |

**Operating system access**
| Flag | Description |
|------|-------------|
| `--os-shell` | Prompt for an interactive operating system shell |
| `--os-pwn` | Prompt for an OOB shell, Meterpreter or VNC |

**General**
| Flag | Description |
|------|-------------|
| `--batch` | Never ask for user input, use the default behavior |
| `--flush-session` | Flush session files for current target |

**Miscellaneous**
| Flag | Description |
|------|-------------|
| `--wizard` | Simple wizard interface for beginner users |

### sqlmapapi Options
The REST-JSON API server/client.

| Flag | Description |
|------|-------------|
| `-s`, `--server` | Run as a REST-JSON API server |
| `-c`, `--client` | Run as a REST-JSON API client |
| `-H HOST`, `--host=HOST` | Host of the API server (default "127.0.0.1") |
| `-p PORT`, `--port=PORT` | Port of the API server (default 8775) |
| `--adapter=ADAPTER` | Server (bottle) adapter to use (default "wsgiref") |
| `--database=DATABASE` | Set IPC database filepath (optional) |
| `--username=USERNAME` | Basic authentication username |
| `--password=PASSWORD` | Basic authentication password |

## Notes
- **Level/Risk**: Increasing `--level` (up to 5) expands the number of payloads and locations tested (like Cookies/Headers). Increasing `--risk` (up to 3) enables heavy-duty tests like OR-based injections which can potentially damage data.
- **Batch Mode**: Use `--batch` for non-interactive environments to accept all default answers.
- **Tamper Scripts**: For WAF/IPS evasion, use the `--tamper` option (available in `-hh`) with scripts found in `/usr/share/sqlmap/tamper/`.