---
name: bing-ip2hosts
description: Enumerate hostnames and subdomains associated with a specific IP address using Bing's unique "ip:" search operator. Use during the reconnaissance phase of a penetration test or bug bounty to identify websites in shared hosting environments and expand the target's attack surface via OSINT.
---

# bing-ip2hosts

## Overview
bing-ip2hosts is a Bing.com web scraper that discovers hostnames by IP address. It leverages Bing's ability to search by IP, allowing security professionals to identify multiple domains hosted on the same server or discover hidden subdomains. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt install bing-ip2hosts bind9-dnsutils wget
```

## Common Workflows

### Enumerate hostnames for a single IP
```bash
bing-ip2hosts 173.194.33.80
```

### Discover subdomains for a domain name
```bash
bing-ip2hosts microsoft.com
```

### Bulk enumeration from a list with CSV output
```bash
bing-ip2hosts -i targets.txt -c -o results.csv
```

### Clean hostname-only output for piping
```bash
bing-ip2hosts -u -q 65.55.58.201 > hostnames.txt
```

## Complete Command Reference

```bash
bing-ip2hosts [OPTIONS] IP|hostname
```

### Options

| Flag | Description |
|------|-------------|
| `-o FILE` | Output discovered hostnames to the specified FILE. |
| `-i FILE` | Input a list of IP addresses or hostnames from a FILE for bulk processing. |
| `-n NUM` | Stop scraping after NUM consecutive pages return no new results (Default: 5). |
| `-l LANG` | Select the language for the `setlang` parameter (Default: en-us). |
| `-m MKT` | Select the market for the `setmkt` parameter (Default: unset). |
| `-u` | Only display hostnames. (Default includes URL prefixes like http://). |
| `-c` | CSV output. Formats output as `IP,hostname` on each line. |
| `-q` | Quiet mode. Disables progress output, displaying only final results. |
| `-t DIR` | Use the specified directory for temporary files instead of `/tmp`. |
| `-V` | Display the version number and exit. |

## Notes
- This tool performs web scraping; excessive use might lead to temporary IP rate-limiting by Bing.
- The `-n` flag is useful for "smart scraping" to ensure thorough discovery without infinite loops on large shared hosts.
- Results depend on Bing's search index and may vary over time.