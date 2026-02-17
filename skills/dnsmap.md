---
name: dnsmap
description: Scan a domain for subdomains using brute-forcing techniques with a built-in or external wordlist. Use when performing DNS reconnaissance, infrastructure enumeration, or vulnerability analysis to find hidden subdomains, remote access servers, or internal IP addresses (RFC 1918) exposed via DNS.
---

# dnsmap

## Overview
dnsmap is a DNS domain name brute-forcing tool used during the information gathering phase of a penetration test. It helps discover subdomains that are not publicly listed or accessible via zone transfers. It is particularly effective for mapping a target's infrastructure, finding unpatched test servers, and identifying non-obvious netblocks. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume dnsmap is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install dnsmap
```

## Common Workflows

### Basic Subdomain Brute Force
Uses the internal wordlist (~1000 words) with default 10ms delay.
```bash
dnsmap example.com
```

### Brute Force with External Wordlist and CSV Output
Uses a custom wordlist and saves results to a specific CSV file.
```bash
dnsmap example.com -w /usr/share/wordlists/dnsmap.txt -c /tmp/results.csv
```

### Stealthy Scanning with Delays and IP Filtering
Adds a random delay (up to 800ms) and ignores specific wildcard or false-positive IPs.
```bash
dnsmap example.com -d 800 -i 10.55.206.154,10.55.24.100 -r /tmp/
```

### Bulk Scanning Multiple Domains
Scans multiple domains listed in a file using default settings.
```bash
dnsmap-bulk domains.txt /tmp/results/
```

## Complete Command Reference

### dnsmap
```
dnsmap <target-domain> [options]
```

| Flag | Description |
|------|-------------|
| `-w <wordlist-file>` | Use an external wordlist instead of the built-in one. |
| `-r <regular-results-file>` | Save results to a plain text file. If no name is supplied, a timestamped filename is generated. Can accept a directory path. |
| `-c <csv-results-file>` | Save results in CSV format. If no name is supplied, a timestamped filename is generated. Can accept a directory path. |
| `-d <delay-millisecs>` | Maximum random delay in milliseconds between queries (1 to 300000). Default is 10ms. |
| `-i <ips-to-ignore>` | Comma-separated list of up to 5 IP addresses to ignore (useful for filtering false positives/wildcards). |

### dnsmap-bulk
```
dnsmap-bulk <domains-file> [results-path]
```

| Argument | Description |
|----------|-------------|
| `<domains-file>` | A file containing target domains, one per line. |
| `[results-path]` | Optional. Directory where results for each domain will be saved (uses `-r` internally). |

## Notes
- **Permissions**: Do NOT run dnsmap as root for security reasons; it does not require elevated privileges.
- **Performance**: dnsmap does not currently support parallel scanning and may be slower than multi-threaded alternatives.
- **Bulk Limitations**: `dnsmap-bulk` always uses default options (built-in wordlist, 10ms delay, no IP filtering).
- **Internal Wordlist**: The built-in list contains common English and Spanish terms like `ns1`, `firewall`, `servicios`, and `smtp`.