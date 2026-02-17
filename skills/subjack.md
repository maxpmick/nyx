---
name: subjack
description: Scan subdomains to identify potential subdomain takeover vulnerabilities and hijackable CNAME records. Use when performing web application reconnaissance, bug bounty hunting, or infrastructure auditing to detect misconfigured DNS records pointing to unclaimed third-party services or non-existent domains (NXDOMAIN).
---

# subjack

## Overview
Subjack is a high-performance subdomain takeover tool written in Go. It identifies subdomains pointing to external services (like GitHub, Heroku, S3, etc.) that are no longer in use but still have active DNS records, allowing an attacker to claim the subdomain. It also identifies NXDOMAIN records available for registration. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume subjack is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install subjack
```

## Common Workflows

### Basic scan using a wordlist
```bash
subjack -w subdomains.txt -t 50 -o results.txt
```
Scans a list of subdomains using 50 threads and saves vulnerable hits to a text file.

### Scan a single domain
```bash
subjack -d example.com -ssl -v
```
Checks a specific domain using HTTPS and verbose output.

### Comprehensive scan with JSON output
```bash
subjack -w list.txt -a -c /usr/share/subjack/fingerprints.json -o results.json
```
Sends requests to every URL (not just those with CNAMEs) and saves detailed results in JSON format.

### Checking for dead records
```bash
subjack -w list.txt -m
```
Flags the presence of dead records that have valid CNAME entries but may not be immediately exploitable.

## Complete Command Reference

```
subjack [Options]
```

### Options

| Flag | Description |
|------|-------------|
| `-a` | Find hidden gems by sending requests to every URL. (Default: Requests are only sent to URLs with identified CNAMEs) |
| `-c <string>` | Path to configuration file. (Default: `/usr/share/subjack/fingerprints.json`) |
| `-d <string>` | Specify a single domain to check. |
| `-m` | Flag the presence of a dead record, but valid CNAME entry. |
| `-o <string>` | Output results to file. Subjack will write JSON if the file extension is `.json`. |
| `-ssl` | Force HTTPS connections. May increase accuracy. (Default: http://) |
| `-t <int>` | Number of concurrent threads. (Default: 10) |
| `-timeout <int>` | Seconds to wait before connection timeout. (Default: 10) |
| `-v` | Verbose mode: Display more information per each request. |
| `-w <string>` | Path to the wordlist containing subdomains to check. |

## Notes
- **Manual Verification**: Always double-check results manually to rule out false positives before attempting a takeover.
- **Fingerprints**: The tool relies on `fingerprints.json` to identify vulnerable services. Ensure this file is up to date for the best detection rates.
- **Speed**: Increasing threads (`-t`) can significantly speed up mass-testing but may lead to rate-limiting or network congestion.