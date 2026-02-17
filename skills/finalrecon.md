---
name: finalrecon
description: Perform comprehensive web reconnaissance including header analysis, SSL certificate inspection, WHOIS lookups, crawling, DNS enumeration, subdomain discovery, directory searching, and port scanning. Use when conducting initial information gathering on a web target to identify technologies, hidden paths, and infrastructure details.
---

# finalrecon

## Overview
FinalRecon is a fast and simple Python-based tool for web reconnaissance. It follows a modular structure to provide detailed information across multiple security domains including DNS, SSL, and web directory structure. Category: Reconnaissance / Information Gathering / Web Application Testing.

## Installation (if not already installed)
Assume finalrecon is already installed. If you encounter errors, install it via:

```bash
sudo apt install finalrecon
```

## Common Workflows

### Full Reconnaissance
Perform all available checks (headers, SSL, WHOIS, DNS, subdomains, directory search, port scan) against a target:
```bash
finalrecon --url https://example.com --full
```

### Directory Brute Force with Custom Wordlist
Search for hidden directories using a specific wordlist and file extensions:
```bash
finalrecon --url https://example.com --dir -w /usr/share/wordlists/dirb/common.txt -e php,html,txt
```

### Subdomain and DNS Enumeration
Gather infrastructure details and discover subdomains:
```bash
finalrecon --url https://example.com --dns --sub
```

### Fast Port Scan with Custom Threads
Scan for open ports quickly by increasing the thread count:
```bash
finalrecon --url https://example.com --ps -pt 100
```

## Complete Command Reference

### Primary Modules
| Flag | Description |
|------|-------------|
| `--url URL` | Target URL (Required for most operations) |
| `--headers` | Analyze and display HTTP Header Information |
| `--sslinfo` | Fetch and analyze SSL Certificate Information |
| `--whois` | Perform a Whois Lookup for the domain |
| `--crawl` | Crawl the target website for links and resources |
| `--dns` | Perform DNS Enumeration |
| `--sub` | Perform Sub-Domain Enumeration |
| `--dir` | Perform Directory Search/Brute Force |
| `--wayback` | Fetch URLs from the Wayback Machine |
| `--ps` | Perform a Fast Port Scan |
| `--full` | Run all reconnaissance modules (Full Recon) |

### Extra Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-nb` | Hide the tool banner |
| `-dt DT` | Number of threads for directory enumeration [Default: 30] |
| `-pt PT` | Number of threads for port scan [Default: 50] |
| `-T T` | Request Timeout in seconds [Default: 30.0] |
| `-w W` | Path to Wordlist [Default: wordlists/dirb_common.txt] |
| `-r` | Allow HTTP Redirects [Default: False] |
| `-s` | Toggle SSL Verification [Default: True] |
| `-sp SP` | Specify SSL Port [Default: 443] |
| `-d D` | Custom DNS Servers [Default: 1.1.1.1] |
| `-e E` | File Extensions to check [Example: txt, xml, php] |
| `-o O` | Export Format (e.g., txt, json) [Default: txt] |
| `-cd CD` | Change export directory [Default: ~/.local/share/finalrecon] |
| `-k K` | Add API key for external services [Example: shodan@key] |

## Notes
- The tool automatically saves reports to `~/.local/share/finalrecon` unless changed with the `-cd` flag.
- When using `--sub` or `--ps`, increasing threads (`-pt`) can speed up results but may lead to rate limiting or missed ports on unstable connections.
- For `--dir` searches, always provide relevant extensions using `-e` to improve discovery of specific file types.