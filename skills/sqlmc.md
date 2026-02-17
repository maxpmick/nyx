---
name: sqlmc
description: Scan a domain for SQL injection vulnerabilities by crawling URLs to a specified depth and testing discovered links. Use when performing automated web application security assessments, massive SQLi scanning, or vulnerability discovery during the reconnaissance and exploitation phases of a penetration test.
---

# sqlmc

## Overview
SQLMC (SQL Injection Massive Checker) is a tool designed to scan a domain for SQL injection vulnerabilities. It crawls a target URL up to a specified depth, extracts links, and checks each for potential SQLi flaws, reporting findings in a tabular format. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume sqlmc is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install sqlmc
```

Dependencies: figlet, python3, python3-aiohttp, python3-bs4, python3-pyfiglet, python3-tabulate.

## Common Workflows

### Basic scan of a domain
Scan a website with a crawl depth of 2 to find and test links for SQL injection.
```bash
sqlmc -u http://example.com -d 2
```

### Deep scan with file output
Crawl deeper into a web application and save the identified vulnerabilities to a text file.
```bash
sqlmc -u https://target-app.local -d 5 -o results.txt
```

### Quick surface check
Perform a shallow scan to quickly identify obvious entry points on the homepage.
```bash
sqlmc -u http://192.168.1.50 -d 1
```

## Complete Command Reference

```bash
sqlmc [-h] -u URL -d DEPTH [-o OUTPUT]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-u`, `--url URL` | **Required.** The target URL to scan (e.g., http://example.com) |
| `-d`, `--depth DEPTH` | **Required.** The maximum depth for the web crawler to follow links |
| `-o`, `--output OUTPUT` | The file path where the scan results should be saved |

## Notes
- The tool uses a crawler to find parameters; if a page has no links or parameters, no tests will be performed.
- Ensure you have explicit permission to scan the target, as automated crawlers can generate significant traffic and trigger security alerts.
- The depth parameter significantly impacts execution time; higher values (e.g., >5) may take a long time on complex sites.