---
name: dnsrecon
description: A powerful DNS enumeration script used to gather information about a domain's infrastructure. It performs zone transfers, general record enumeration (MX, SOA, NS, A, AAAA, SPF, TXT), SRV record discovery, TLD expansion, wildcard resolution checks, subdomain brute forcing, and reverse lookups. Use during the reconnaissance phase of a penetration test to map out attack surfaces and identify hidden subdomains or misconfigured DNS servers.
---

# dnsrecon

## Overview
DNSRecon is a versatile Python-based DNS enumeration tool. It is designed to identify hostnames, subdomains, and IP addresses associated with a target domain using various techniques including dictionary attacks, cache snooping, and search engine scraping (Bing, Yandex, crt.sh). Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, install via:

```bash
sudo apt update && sudo apt install dnsrecon
```

## Common Workflows

### Standard Enumeration
Perform a general scan for SOA, NS, A, AAAA, MX, and SRV records:
```bash
dnsrecon -d example.com -t std
```

### Subdomain Brute Force
Use a specific wordlist to discover subdomains and filter out wildcard results:
```bash
dnsrecon -d example.com -D /usr/share/wordlists/dnsmap.txt -t brt -f
```

### Zone Transfer (AXFR)
Test all identified Name Servers for zone transfer vulnerabilities:
```bash
dnsrecon -d example.com -t axfr
```

### Reverse Lookup Brute Force
Perform reverse DNS lookups on a specific IP range:
```bash
dnsrecon -r 192.168.1.0/24 -t rvl
```

### Comprehensive Scan with Output
Perform standard enumeration, brute force, and crt.sh scraping, then save to JSON:
```bash
dnsrecon -d example.com -t std,brt,crt -D /usr/share/wordlists/amass/subdomains-top1mil-5000.txt --json results.json
```

## Complete Command Reference

### Basic Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--domain DOMAIN` | Target domain |
| `-iL`, `--input-list FILE` | File containing a list of domains to enumerate, one per line |
| `-n`, `--name_server NS` | Domain server to use (comma-separated list). Defaults to target's SOA |
| `-r`, `--range RANGE` | IP range for reverse lookup (first-last) or (range/bitmask) |
| `-D`, `--dictionary FILE` | Dictionary file of subdomains/hostnames for brute force |
| `-t`, `--type TYPE` | Type of enumeration to perform (see Enumeration Types below) |
| `--threads THREADS` | Number of threads for lookups and brute force |
| `--lifetime LIFETIME` | Time to wait for server response (default: 3.0) |
| `--tcp` | Use TCP protocol for queries |
| `-v`, `--verbose` | Enable verbosity |
| `-V`, `--version` | Show version |

### Enumeration Types (`-t`)
| Type | Description |
|------|-------------|
| `std` | Standard: SOA, NS, A, AAAA, MX, and SRV |
| `rvl` | Reverse lookup of a given CIDR or IP range |
| `brt` | Brute force domains and hosts using a dictionary |
| `srv` | Enumerate SRV records |
| `axfr` | Test all NS servers for a zone transfer |
| `bing` | Perform Bing search for subdomains and hosts |
| `yand` | Perform Yandex search for subdomains and hosts |
| `crt` | Perform crt.sh search for subdomains and hosts |
| `snoop` | Cache snooping against NS servers using `-D` list |
| `tld` | Test domain against all IANA registered TLDs |
| `zonewalk` | Perform a DNSSEC zone walk using NSEC records |

### Advanced Scanning & Filtering
| Flag | Description |
|------|-------------|
| `-a` | Perform AXFR with standard enumeration |
| `-s` | Reverse lookup IPv4 ranges in SPF records with standard enumeration |
| `-b` | Perform Bing enumeration with standard enumeration |
| `-y` | Perform Yandex enumeration with standard enumeration |
| `-k` | Perform crt.sh enumeration with standard enumeration |
| `-w` | Deep Whois analysis and reverse lookup of found IP ranges |
| `-z` | DNSSEC zone walk with standard enumeration |
| `-f` | Filter out records resolving to wildcard IPs from results |
| `--iw` | Continue brute forcing even if a wildcard is discovered |
| `--disable_check_nxdomain` | Disable check for NXDOMAIN hijacking |
| `--disable_check_recursion` | Disable check for recursion on name servers |
| `--disable_check_bindversion` | Disable check for BIND version on name servers |

### Output & Logging
| Flag | Description |
|------|-------------|
| `--db DB` | Save found records to an SQLite 3 file |
| `-x`, `--xml XML` | Save found records to an XML file |
| `-c`, `--csv CSV` | Save output to a CSV file |
| `-j`, `--json JSON` | Save output to a JSON file |
| `--loglevel LEVEL` | Log level: DEBUG, INFO, WARNING, ERROR, CRITICAL (default: INFO) |

## Notes
- **Wildcards**: Many domains use wildcard DNS. Use the `-f` flag to avoid bloating results with false positives, or `--iw` if you suspect legitimate hosts share the wildcard IP.
- **Performance**: Increasing `--threads` can speed up brute forcing but may lead to rate limiting or missed responses depending on the target DNS server's capacity.
- **Zone Transfers**: Successful AXFR results provide the entire zone file, which is a major information leak. Always check for this first.