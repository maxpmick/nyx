---
name: assetfinder
description: Find domains and subdomains related to a given domain by leveraging multiple third-party data sources. Use when performing initial reconnaissance, subdomain discovery, and mapping an organization's external attack surface during penetration testing or bug bounty hunting.
---

# assetfinder

## Overview
assetfinder is a lightweight command-line tool designed to discover domains and subdomains associated with a specific target domain. It aggregates data from various sources including crt.sh, certspotter, hackertarget, threatcrowd, Wayback Machine, dns.bufferover.run, Facebook Graph API, Virustotal, and findsubdomains to provide a comprehensive list of related assets. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume assetfinder is already installed. If the command is not found, install it using:

```bash
sudo apt install assetfinder
```

## Common Workflows

### Basic Domain Discovery
Find all related domains and subdomains for a target:
```bash
assetfinder example.com
```

### Subdomain-Only Discovery
Filter results to only include subdomains of the target domain (excluding related but different root domains):
```bash
assetfinder --subs-only example.com
```

### Integration with other tools
Pipe results into `httprobe` to find active web servers among the discovered subdomains:
```bash
assetfinder --subs-only example.com | httprobe
```

## Complete Command Reference

```
assetfinder [options] <domain>
```

### Options

| Flag | Description |
|------|-------------|
| `-subs-only` | Only include subdomains of the search domain in the output. By default, assetfinder may return other related domains discovered through its data sources. |
| `-h`, `--help` | Show help message and usage information. |

## Notes
- assetfinder relies on external APIs and web scraping; availability of results depends on the uptime and data freshness of the third-party sources (e.g., crt.sh, VirusTotal).
- It is a "passive" tool, meaning it does not interact directly with the target's infrastructure, making it ideal for stealthy initial reconnaissance.
- For best results in automated pipelines, combine with `sort -u` to remove any duplicate entries returned by different sources.