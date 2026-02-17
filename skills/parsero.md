---
name: parsero
description: Audit robots.txt files to identify disallowed entries and check their accessibility. Use when performing web reconnaissance, information gathering, or vulnerability analysis to discover hidden directories, sensitive files, or misconfigured access controls that administrators intended to hide from search engines.
---

# parsero

## Overview
Parsero is a Python-based script that automates the auditing of `robots.txt` files. It extracts "Disallow" entries and checks the HTTP status code of each path to see if the resources are actually accessible. It can also cross-reference these entries with Bing to see if disallowed paths have been indexed regardless of the robots.txt instructions. Category: Web Application Testing / Information Gathering.

## Installation (if not already installed)
Assume parsero is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install parsero
```

Dependencies: `python3`, `python3-bs4`, `python3-urllib3`.

## Common Workflows

### Basic Audit of a Single Domain
Analyze a specific URL and check the status of all disallowed entries:
```bash
parsero -u http://example.com
```

### Filter for Accessible Resources
Show only the entries that return an "HTTP 200 OK" status code, indicating the "hidden" content is publicly accessible:
```bash
parsero -u http://example.com -o
```

### Check for Search Engine Leakage
Search Bing to see if any of the disallowed paths have been indexed by the search engine despite the robots.txt restrictions:
```bash
parsero -u http://example.com -sb
```

### Bulk Scanning
Scan multiple domains provided in a text file (one URL per line):
```bash
parsero -f domains_list.txt
```

## Complete Command Reference

```
usage: parsero [-h] [-u URL] [-o] [-sb] [-f FILE]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-u URL` | Specify the target URL to be analyzed |
| `-o` | Show only the "HTTP 200" status code results |
| `-sb` | Search in Bing indexed Disallows to find leaked paths |
| `-f FILE` | Scan a list of domains from a specified file |

## Notes
- `robots.txt` is often used by administrators to hide sensitive areas (like `/admin/` or `/backup/`). Parsero helps identify if these areas are actually protected by authentication or merely hidden by convention.
- The `-sb` flag is particularly useful for finding "Security through Obscurity" failures where sensitive paths were discovered by crawlers before the robots.txt was implemented or via external links.