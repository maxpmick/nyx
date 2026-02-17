---
name: theharvester
description: Gather open source intelligence (OSINT) including email addresses, subdomains, virtual hosts, open ports, and employee names from public sources. Use when performing reconnaissance, information gathering, or vulnerability analysis to map an organization's external attack surface and identify potential targets.
---

# theHarvester

## Overview
theHarvester is a comprehensive OSINT tool designed for the reconnaissance phase of a penetration test. It aggregates data from dozens of public sources (search engines, PGP key servers, and specialized databases) to identify subdomains, emails, and infrastructure details associated with a target domain. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install theharvester
```

## Common Workflows

### Basic search using a specific source
```bash
theHarvester -d example.com -l 500 -b google
```

### Comprehensive search using all available sources
```bash
theHarvester -d example.com -l 500 -b all
```

### Subdomain enumeration with DNS brute forcing and Shodan lookup
```bash
theHarvester -d example.com -l 200 -b bing,crtsh,virustotal -c -s
```

### Gathering intelligence and saving to a file
```bash
theHarvester -d example.com -l 500 -b duckduckgo,brave,threatminer -f assessment_results
```

## Complete Command Reference

### theHarvester Options

```
theHarvester [-h] -d DOMAIN [-l LIMIT] [-S START] [-p] [-s] [--screenshot SCREENSHOT] [-v] [-e DNS_SERVER] [-t] [-r [DNS_RESOLVE]] [-n] [-c] [-f FILENAME] [-w WORDLIST] [-a] [-q] [-b SOURCE]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--domain DOMAIN` | Company name or domain to search |
| `-l`, `--limit LIMIT` | Limit the number of search results (default: 500) |
| `-S`, `--start START` | Start with result number X (default: 0) |
| `-p`, `--proxies` | Use proxies for requests (configured in `/etc/theHarvester/proxies.yaml`) |
| `-s`, `--shodan` | Use Shodan to query discovered hosts |
| `--screenshot <dir>` | Take screenshots of resolved domains and specify output directory |
| `-v`, `--virtual-host` | Verify host name via DNS resolution and search for virtual hosts |
| `-e`, `--dns-server <srv>` | DNS server to use for lookup |
| `-t`, `--take-over` | Check for subdomain takeovers |
| `-r`, `--dns-resolve` | Perform DNS resolution on subdomains (can take optional resolver list) |
| `-n`, `--dns-lookup` | Enable DNS server lookup (default: False) |
| `-c`, `--dns-brute` | Perform a DNS brute force on the domain |
| `-f`, `--filename <file>` | Save the results to an XML and JSON file |
| `-w`, `--wordlist <file>` | Specify a wordlist for API endpoint scanning |
| `-a`, `--api-scan` | Scan for API endpoints |
| `-q`, `--quiet` | Suppress missing API key warnings |
| `-b`, `--source SOURCE` | Specify data sources (see list below) |

**Available Sources (`-b`):**
baidu, bevigil, bing, bingapi, brave, bufferoverun, builtwith, censys, certspotter, criminalip, crtsh, dehashed, dnsdumpster, duckduckgo, fullhunt, github-code, hackertarget, haveibeenpwned, hunter, hunterhow, intelx, leaklookup, netlas, onyphe, otx, pentesttools, projectdiscovery, rapiddns, rocketreach, securityscorecard, securityTrails, shodan, sitedossier, subdomaincenter, subdomainfinderc99, threatminer, tomba, urlscan, venacus, virustotal, whoisxml, yahoo, zoomeye.

### restfulHarvest Options
A RESTful API interface for theHarvester.

```
restfulHarvest [-h] [-H HOST] [-p PORT] [-l LOG_LEVEL] [-r]
```

| Flag | Description |
|------|-------------|
| `-H`, `--host HOST` | IP address to listen on (default: 127.0.0.1) |
| `-p`, `--port PORT` | Port to bind the web server to (default: 5000) |
| `-l`, `--log-level` | Set logging level [critical\|error\|warning\|info\|debug\|trace] |
| `-r`, `--reload` | Enable automatic reload (used during development) |

## Notes
- **Deprecation Warning**: Use the command `theHarvester` (case-sensitive). The lowercase `theharvester` is deprecated in Kali Linux.
- **API Keys**: Many sources (like Shodan, Hunter, or Censys) require API keys. These are typically configured in `/etc/theHarvester/api-keys.yaml`.
- **Proxies**: Proxy settings are managed via `/etc/theHarvester/proxies.yaml`.