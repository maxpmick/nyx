---
name: fierce
description: DNS reconnaissance tool for locating non-contiguous IP space and hostnames against specified domains. Use when performing DNS enumeration, identifying misconfigured networks that leak internal address space, or as a precursor to vulnerability scanning and exploitation. It is particularly effective for subdomain discovery and identifying targets both inside and outside a corporate network.
---

# fierce

## Overview
Fierce is a DNS scanner designed to locate non-contiguous IP space and hostnames. It functions as a reconnaissance tool to find likely targets by performing zone transfers, brute-forcing subdomains, and identifying internal address space leaks. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Fierce is typically pre-installed on Kali Linux. If missing, install it using:

```bash
sudo apt update
sudo apt install fierce
```

## Common Workflows

### Basic Domain Enumeration
Perform a default scan which includes attempting a zone transfer followed by a subdomain brute force:
```bash
fierce --domain example.com
```

### Subdomain Brute Force with Custom Wordlist
Use a specific wordlist to find subdomains:
```bash
fierce --domain example.com --subdomain-file /usr/share/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt
```

### Scanning Internal IP Ranges
Scan a specific internal range using CIDR notation to find associated hostnames:
```bash
fierce --range 192.168.1.0/24
```

### Expanding the Search Area
Scan the entire Class C network of any discovered records to find neighboring hosts:
```bash
fierce --domain example.com --wide
```

## Complete Command Reference

```
usage: fierce [-h] [--domain DOMAIN] [--connect] [--wide]
              [--traverse TRAVERSE] [--search SEARCH [SEARCH ...]]
              [--range RANGE] [--delay DELAY]
              [--subdomains SUBDOMAINS [SUBDOMAINS ...] |
              --subdomain-file SUBDOMAIN_FILE]
              [--dns-servers DNS_SERVERS [DNS_SERVERS ...] |
              --dns-file DNS_FILE] [--tcp]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--domain DOMAIN` | The domain name to test. |
| `--connect` | Attempt an HTTP connection to non-RFC 1918 (public) hosts discovered. |
| `--wide` | Scan the entire Class C range of any discovered records. |
| `--traverse TRAVERSE` | Scan IPs near discovered records. This will not enter adjacent Class C networks. |
| `--search SEARCH [SEARCH ...]` | Filter on these domains when expanding lookups. |
| `--range RANGE` | Scan an internal IP range using CIDR notation (e.g., 10.0.0.0/24). |
| `--delay DELAY` | Time (in seconds) to wait between lookups to avoid rate limiting. |
| `--subdomains SUBDOMAINS [SUBDOMAINS ...]` | Provide a space-separated list of subdomains to check manually. |
| `--subdomain-file SUBDOMAIN_FILE` | Use subdomains specified in this file (one per line). |
| `--dns-servers DNS_SERVERS [DNS_SERVERS ...]` | Use these specific DNS servers for reverse lookups. |
| `--dns-file DNS_FILE` | Use DNS servers specified in this file for reverse lookups (one per line). |
| `--tcp` | Use TCP instead of UDP for DNS queries. |

## Notes
- **Zone Transfers**: Fierce always attempts a zone transfer (AXFR) first as it is the most efficient way to gather all records if the server is misconfigured.
- **Wildcard DNS**: The tool automatically checks for wildcard DNS records to avoid false positives during brute-force attempts.
- **Performance**: Use the `--delay` flag if you suspect the target DNS server is rate-limiting your requests.
- **Internal Discovery**: The `--range` and `--traverse` options are highly effective for finding internal naming schemes that have been accidentally exposed.