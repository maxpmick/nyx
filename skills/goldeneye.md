---
name: goldeneye
description: Perform HTTP Denial of Service (DoS) testing by exhausting web server resources using HTTP Keep-Alive and No-Cache attack vectors. Use when stress testing web servers, evaluating application resilience against Layer 7 DoS attacks, or verifying the effectiveness of Web Application Firewalls (WAF) and rate-limiting configurations during penetration testing.
---

# goldeneye

## Overview
GoldenEye is an HTTP DoS test tool designed to check if a site is susceptible to Denial of Service attacks. It opens multiple parallel connections against a target URL using "HTTP Keep Alive + NoCache" as the primary attack vector to exhaust server resources. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume goldeneye is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install goldeneye
```

Dependencies: python3.

## Common Workflows

### Basic Stress Test
Launch a default attack against a target URL with 10 workers and 500 sockets.
```bash
goldeneye http://example.com
```

### High-Intensity Attack
Increase the number of concurrent workers and sockets to test server limits.
```bash
goldeneye http://example.com -w 50 -s 1000
```

### POST Method Attack with Custom User-Agents
Use the POST method and a specific list of user-agents to bypass simple filters.
```bash
goldeneye http://example.com -m post -u /usr/share/wordlists/useragents.txt
```

### Testing HTTPS without SSL Verification
Test a secure site while ignoring certificate errors (useful for self-signed certs in lab environments).
```bash
goldeneye https://example.com -n
```

## Complete Command Reference

```bash
goldeneye <url> [OPTIONS]
```

### Options

| Flag | Description | Default |
|------|-------------|---------|
| `-u`, `--useragents` | File containing a list of user-agents to use for requests | Randomly generated |
| `-w`, `--workers` | Number of concurrent workers (processes) | 10 |
| `-s`, `--sockets` | Number of concurrent sockets per worker | 500 |
| `-m`, `--method` | HTTP Method to use: `get`, `post`, or `random` | get |
| `-n`, `--nosslcheck` | Do not verify the target's SSL Certificate | True |
| `-d`, `--debug` | Enable Debug Mode for more verbose output | False |
| `-h`, `--help` | Shows the help message and exit | N/A |

## Notes
- **Legal Warning**: Only use this tool against systems you have explicit permission to test. Unauthorized DoS attacks are illegal.
- **Resource Usage**: This tool can consume significant local CPU and network bandwidth. Monitor your local system performance during high-intensity tests.
- **WAF/IPS**: Modern Web Application Firewalls and Intrusion Prevention Systems may quickly block the IP address running GoldenEye due to the high volume of requests.