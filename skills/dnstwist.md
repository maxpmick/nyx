---
name: dnstwist
description: Generate and analyze domain name permutations to detect typosquatting, phishing, brand impersonation, and fraud. Use when performing reconnaissance, brand protection audits, or identifying malicious domains that mimic a target organization's infrastructure.
---

# dnstwist

## Overview
dnstwist is a domain name permutation engine that generates a list of lookalike domains for a given target. It performs DNS queries (A, AAAA, NS, MX), checks for active mail servers, evaluates webpage similarity using fuzzy hashes (ssdeep/tlsh), and can perform visual similarity checks via screenshots. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnstwist is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install dnstwist
```

## Common Workflows

### Basic Scan for Registered Lookalikes
Scan a domain and show only those permutations that are actually registered.
```bash
dnstwist --registered example.com
```

### Comprehensive Phishing Analysis
Check for registered domains, perform GeoIP lookups, grab service banners, and check MX records for mail interception potential.
```bash
dnstwist --registered --geoip --banners --mxcheck example.com
```

### Webpage Similarity and Screenshots
Compare the visual and content similarity of lookalike domains to the original and save screenshots.
```bash
dnstwist --phash --screenshots ./caps --lsh ssdeep example.com
```

### Exporting Results
Generate permutations and save them to a JSON file for automated processing.
```bash
dnstwist -f json -o results.json example.com
```

## Complete Command Reference

```
usage: /usr/bin/dnstwist [OPTION]... DOMAIN
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `domain` | Domain name or URL to scan |

### General Options
| Flag | Description |
|------|-------------|
| `-a`, `--all` | Print all DNS records instead of the first ones |
| `-b`, `--banners` | Determine HTTP and SMTP service banners |
| `-d`, `--dictionary FILE` | Generate more domains using dictionary FILE |
| `-f`, `--format FORMAT` | Output format: `cli`, `csv`, `json`, `list` (default: `cli`) |
| `--fuzzers LIST` | Use only selected fuzzing algorithms (separated with commas) |
| `-g`, `--geoip` | Lookup for GeoIP location |
| `-o`, `--output FILE` | Save output to FILE |
| `-r`, `--registered` | Show only registered domain names |
| `-u`, `--unregistered` | Show only unregistered domain names |
| `-t`, `--threads NUM` | Start specified NUM of threads (default: 10) |
| `-w`, `--whois` | Lookup WHOIS database for creation date and registrar |
| `--tld FILE` | Swap TLD for the original domain from FILE |
| `--nameservers LIST` | DNS or DoH servers to query (separated with commas) |
| `--useragent STRING` | Set User-Agent STRING (default: Mozilla/5.0 (linux 64-bit) dnstwist/...) |

### Mail Security Options
| Flag | Description |
|------|-------------|
| `-m`, `--mxcheck` | Check if MX host can be used to intercept emails |

### Web Similarity & Visual Options
| Flag | Description |
|------|-------------|
| `--lsh [LSH]` | Evaluate web page similarity with LSH algorithm: `ssdeep`, `tlsh` (default: `ssdeep`) |
| `--lsh-url URL` | Override URL to fetch the original web page from |
| `-p`, `--phash` | Render web pages and evaluate visual similarity |
| `--phash-url URL` | Override URL to render the original web page from |
| `--screenshots DIR` | Save web page screenshots into DIR |

## Notes
- **Fuzzy Hashing**: The `--lsh` and `-p` options require the target website to be live to establish a baseline for comparison.
- **Performance**: Increasing `--threads` can speed up large scans but may lead to rate-limiting by DNS servers or WHOIS providers.
- **MX Check**: The `--mxcheck` flag attempts to connect to the mail server to see if it accepts mail for the spoofed domain, which can be a sensitive operation.