---
name: changeme
description: Scan for default credentials across various protocols including HTTP/HTTPS, MSSQL, MySQL, Postgres, SSH, and more. Use when performing vulnerability assessments, internal penetration testing, or infrastructure auditing to identify systems using factory-default or common administrative passwords.
---

# changeme

## Overview
`changeme` is a default credential scanner designed to identify systems using common or factory-default passwords. Unlike many commercial scanners, it is built to be easily extensible via YAML-based credential files. It supports multiple protocols and can ingest targets from IP ranges, hostnames, or Nmap XML files. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume `changeme` is already installed. If the command is not found, use:

```bash
sudo apt update && sudo apt install changeme
```

## Common Workflows

### Scan a target for default HTTP credentials
```bash
changeme 192.168.1.50
```

### Scan a subnet for all supported protocols with 20 threads
```bash
changeme 192.168.1.0/24 --all --threads 20
```

### Use an Nmap XML file as input and output results in all formats
```bash
changeme scan_results.xml --oa -o internal_audit
```

### Search and scan targets directly from Shodan
```bash
changeme --shodan_query "strongswan" --shodan_key YOUR_API_KEY --protocols http
```

### Create a new credential file
```bash
changeme --mkcred
```

## Complete Command Reference

```
changeme [options] target
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `target` | Target to scan. Supports IP, subnet, hostname, nmap xml file, text file, or `proto://host:port` |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--all`, `-a` | Scan for all supported protocols |
| `--category`, `-c CATEGORY` | Category of default credentials to scan for |
| `--contributors` | Display credential file contributors |
| `--debug`, `-d` | Enable debug output |
| `--delay`, `-dl DELAY` | Delay in milliseconds to avoid 429 status codes (default: 500) |
| `--dump` | Print all of the currently loaded credentials |
| `--dryrun` | Print URLs to be scanned without actually scanning them |
| `--fingerprint`, `-f` | Fingerprint targets only; do not check credentials |
| `--fresh` | Flush any previous scans and start a new session |
| `--log`, `-l LOG` | Write logs to the specified logfile |
| `--mkcred` | Interactive tool to create a new credential YAML file |
| `--name`, `-n NAME` | Narrow testing to a specific credential name (e.g., "admin") |
| `--noversion` | Do not perform a version check |
| `--proxy`, `-p PROXY` | Use an HTTP(S) proxy |
| `--output`, `-o OUTPUT` | Name of result file. Extension determines type (csv, html, json) |
| `--oa` | Output results in all formats (csv, html, and json) |
| `--protocols PROTOCOLS` | Comma separated list of protocols to test (e.g., `http,ssh,ssh_key`). Defaults to `http` |
| `--portoverride` | Scan all protocols on all specified ports |
| `--redishost REDISHOST` | Specify Redis server host |
| `--redisport REDISPORT` | Specify Redis server port |
| `--resume`, `-r` | Resume a previously interrupted scan |
| `--shodan_query`, `-q QUERY` | Perform a Shodan query to find targets |
| `--shodan_key`, `-k KEY` | Shodan API key for queries |
| `--ssl` | Force SSL and fall back to non-SSL if an SSLError occurs |
| `--threads`, `-t THREADS` | Number of concurrent threads (default: 10) |
| `--timeout TIMEOUT` | Timeout in seconds for a request (default: 10) |
| `--useragent`, `-ua UA` | Custom User-Agent string |
| `--validate` | Validate the syntax of credential files |
| `--verbose`, `-v` | Enable verbose output |

## Notes
- Supported protocols include: `http`, `https`, `mssql`, `mysql`, `postgres`, `ssh`, `ssh_key`, `redis`, `mongodb`, `snmp`, and `telnet`.
- Credential data is stored in YAML files, making it easy to add new signatures without writing Python code.
- When using `--shodan_query`, ensure you have a valid API key and sufficient credits.
- The `--oa` flag is highly recommended for reporting as it generates all three output types simultaneously.