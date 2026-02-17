---
name: spiderfoot
description: Automate OSINT collection and reconnaissance for targets including IP addresses, domains, hostnames, subnets, ASNs, email addresses, or names. Use when performing information gathering, footprinting, or black-box penetration testing to identify publicly available data and infrastructure details.
---

# spiderfoot

## Overview
SpiderFoot is an OSINT automation tool designed to gather intelligence about a specific target. It can be used offensively for reconnaissance or defensively to identify data leaks. It integrates with numerous data sources to map out a target's digital footprint. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume spiderfoot is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install spiderfoot
```

## Common Workflows

### Start the Web Interface
By default, SpiderFoot runs a web server for a GUI-based experience.
```bash
spiderfoot -l 127.0.0.1:5001
```

### Passive Reconnaissance (CLI)
Perform a passive scan on a domain to avoid direct interaction with the target's infrastructure.
```bash
spiderfoot -s example.com -u passive -o json
```

### Targeted OSINT for Email Addresses
Search for information specifically related to an email address using all available modules.
```bash
spiderfoot -s target@example.com -u all
```

### Specific Event Collection
Collect only specific types of data, such as "IP_ADDRESS" and "GEOINFO".
```bash
spiderfoot -s example.com -t IP_ADDRESS,GEOINFO -f
```

## Complete Command Reference

### spiderfoot (Main Tool)
```
usage: sf.py [-h] [-d] [-l IP:port] [-m mod1,mod2,...] [-M] [-C scanID]
             [-s TARGET] [-t type1,type2,...]
             [-u {all,footprint,investigate,passive}] [-T] [-o {tab,csv,json}]
             [-H] [-n] [-r] [-S LENGTH] [-D DELIMITER] [-f]
             [-F type1,type2,...] [-x] [-q] [-V] [-max-threads MAX_THREADS]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--debug` | Enable debug output |
| `-l IP:port` | IP and port to listen on (starts web server) |
| `-m mod1,mod2,...` | Specific modules to enable |
| `-M`, `--modules` | List all available modules |
| `-C scanID`, `--correlate scanID` | Run correlation rules against a specific scan ID |
| `-s TARGET` | Target for the scan (IP, Domain, Email, etc.) |
| `-t type1,type2,...` | Event types to collect (modules selected automatically) |
| `-u {all,footprint,investigate,passive}` | Select modules automatically by use case |
| `-T`, `--types` | List available event types |
| `-o {tab,csv,json}` | Output format (Default: tab) |
| `-H` | Don't print field headers, just data |
| `-n` | Strip newlines from data |
| `-r` | Include the source data field in tab/csv output |
| `-S LENGTH` | Maximum data length to display (Default: all) |
| `-D DELIMITER` | Delimiter to use for CSV output (Default: `,`) |
| `-f` | Filter out other event types that weren't requested with `-t` |
| `-F type1,type2,...` | Show only a specific set of event types in output |
| `-x` | **STRICT MODE**: Only enable modules that directly consume the target |
| `-q` | Disable logging (hides errors) |
| `-V`, `--version` | Display version and exit |
| `-max-threads MAX_THREADS` | Max number of modules to run concurrently |

### spiderfoot-cli (Command Line Interface Client)
Used to connect to and manage a running SpiderFoot server instance.
```
usage: sfcli.py [-h] [-d] [-s URL] [-u USER] [-p PASS] [-P PASSFILE] [-e FILE]
                [-l FILE] [-n] [-o FILE] [-i] [-q] [-k] [-b]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--debug` | Enable debug output |
| `-s URL` | Connect to SpiderFoot server URL (Default: `http://127.0.0.1:5001`) |
| `-u USER` | Username for authentication |
| `-p PASS` | Password for authentication (Visible in process list) |
| `-P PASSFILE` | File containing password for authentication |
| `-e FILE` | Execute commands from a file |
| `-l FILE` | Log command history to a file |
| `-n` | Disable history logging |
| `-o FILE` | Spool commands and output to a file |
| `-i` | Allow insecure server connections (ignore SSL errors) |
| `-q` | Silent output, only errors reported |
| `-k` | Turn off color-coded output |
| `-b`, `-v` | Print the banner with version and exit |

## Notes
- **API Keys**: Many SpiderFoot modules require API keys (e.g., Shodan, VirusTotal, Censys). These are typically configured via the Web UI (`-l` mode) under "Settings".
- **Strict Mode (`-x`)**: Useful when you want to ensure the tool doesn't "drift" too far from the initial target input.
- **Passive Mode**: Recommended for initial reconnaissance to avoid triggering security alerts on the target's infrastructure.