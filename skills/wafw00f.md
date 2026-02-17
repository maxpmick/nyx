---
name: wafw00f
description: Identify and fingerprint Web Application Firewall (WAF) products protecting a website. It works by sending normal and malicious HTTP requests and analyzing responses to detect signatures or behavioral patterns. Use during the reconnaissance or vulnerability analysis phases of a web application penetration test to identify defensive technologies and adjust exploitation strategies.
---

# wafw00f

## Overview
wafw00f is a Python-based tool used to identify and fingerprint Web Application Firewall (WAF) products. It sends a series of HTTP requests (both benign and "malicious") and analyzes response headers and body content to determine if a WAF is present and which specific product is in use. Category: Reconnaissance / Information Gathering, Vulnerability Analysis, Web Application Testing.

## Installation (if not already installed)
Assume wafw00f is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install wafw00f
```

## Common Workflows

### Basic WAF detection for a single site
```bash
wafw00f https://www.example.com
```

### Scan multiple targets from a file and save to JSON
```bash
wafw00f -i targets.txt -o results.json
```

### Find all matching WAFs with increased verbosity
```bash
wafw00f -a -vv https://www.example.com
```

### Use a proxy to bypass IP-based blocks
```bash
wafw00f https://www.example.com -p http://127.0.0.1:8080
```

## Complete Command Reference

```
wafw00f url1 [url2 [url3 ... ]]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-v`, `--verbose` | Enable verbosity. Use multiple times (e.g., `-vv`) for more detail |
| `-a`, `--findall` | Find all WAFs matching signatures; do not stop after the first match |
| `-r`, `--noredirect` | Do not follow 3xx HTTP redirections |
| `-t TEST`, `--test=TEST` | Test for one specific WAF product |
| `-o OUTPUT`, `--output=OUTPUT` | Write output to file. Format (csv, json, text) is determined by extension. Use `-` for stdout |
| `-f FORMAT`, `--format=FORMAT` | Force output format to `csv`, `json`, or `text` |
| `-i INPUT`, `--input-file=INPUT` | Read targets from a file (csv, json, or text). CSV/JSON require a `url` field |
| `-l`, `--list` | List all WAFs that WAFW00F is currently able to detect |
| `-p PROXY`, `--proxy=PROXY` | Use an HTTP/SOCKS proxy (e.g., `http://127.0.0.1:8080` or `socks5://127.0.0.1:1080`) |
| `-V`, `--version` | Print the current version and exit |
| `-H HEADERS`, `--headers=HEADERS` | Pass custom headers via a text file to overwrite default headers |
| `-T TIMEOUT`, `--timeout=TIMEOUT` | Set the timeout for HTTP requests (in seconds) |
| `--no-colors` | Disable ANSI colors in the terminal output |

## Notes
- WAF detection logic follows a three-step process:
    1. Sends a normal HTTP request and analyzes the response.
    2. Sends potentially malicious requests to trigger WAF responses.
    3. Uses heuristic algorithms to guess if a WAF is present based on previous responses.
- If using an input file for CSV or JSON, ensure the column or key is named `url`.
- Using `-a` is recommended if a site might be behind multiple layers of protection (e.g., a CDN WAF and an on-premise WAF).