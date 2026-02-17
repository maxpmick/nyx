---
name: dnsenum
description: Enumerate DNS information for a domain including host addresses, nameservers, MX records, subdomains via brute force and Google scraping, zone transfers, and reverse DNS lookups. Use when performing DNS reconnaissance, subdomain discovery, domain footprinting, or information gathering during penetration testing.
---

# dnsenum

## Overview
Dnsenum is a multithreaded perl script designed to gather as much information as possible about a domain. It discovers host addresses (A records), nameservers, MX records, performs zone transfers (AXFR), scrapes Google for subdomains, brute-forces subdomains from a file, calculates C-class network ranges, and performs reverse lookups. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnsenum is already installed. If you encounter a "command not found" error:

```bash
sudo apt install dnsenum
```

Dependencies: libhtml-parser-perl, libnet-dns-perl, libnet-ip-perl, libnet-netmask-perl, libnet-whois-ip-perl, libstring-random-perl, libwww-mechanize-perl, libxml-writer-perl, perl.

## Common Workflows

### Standard Enumeration
```bash
dnsenum example.com
```
Performs basic DNS record gathering, nameserver identification, and MX record discovery.

### Comprehensive Enumeration (Shortcut)
```bash
dnsenum --enum example.com
```
Equivalent to using `--threads 5 -s 15 -w`. Includes Google scraping and whois queries.

### Subdomain Brute Force with XML Output
```bash
dnsenum -f /usr/share/dnsenum/dns.txt --noreverse -o results.xml example.com
```
Brute-forces subdomains using a wordlist, skips reverse lookups, and saves results to an XML file.

### Recursive Subdomain Brute Force
```bash
dnsenum -f subdomains.txt -r example.com
```
Brute-forces subdomains and automatically performs recursion on any discovered subdomains that have their own NS records.

## Complete Command Reference

```bash
dnsenum [Options] <domain>
```

### General Options

| Flag | Description |
|------|-------------|
| `--dnsserver <server>` | Use this DNS server for A, NS, and MX queries |
| `--enum` | Shortcut equivalent to `--threads 5 -s 15 -w` |
| `-h`, `--help` | Print help message |
| `--noreverse` | Skip reverse lookup operations |
| `--nocolor` | Disable ANSIColor output |
| `--private` | Show and save private IPs at the end of `domain_ips.txt` |
| `--subfile <file>` | Write all valid subdomains to this file |
| `-t`, `--timeout <value>` | TCP and UDP timeout in seconds (default: 10s) |
| `--threads <value>` | Number of threads for performing queries |
| `-v`, `--verbose` | Show all progress and error messages |

### Google Scraping Options

| Flag | Description |
|------|-------------|
| `-p`, `--pages <value>` | Number of Google search pages to process (default: 5). Requires `-s` |
| `-s`, `--scrap <value>` | Max subdomains to scrape from Google (default: 15) |

### Brute Force Options

| Flag | Description |
|------|-------------|
| `-f`, `--file <file>` | Read subdomains from file for brute force (overrides default `dns.txt`) |
| `-u`, `--update <a\|g\|r\|z>` | Update the file from `-f` with valid subdomains: `a` (all), `g` (Google), `r` (reverse), `z` (zone transfer) |
| `-r`, `--recursion` | Recursion on subdomains: brute-force discovered subdomains with NS records |

### Whois Netrange Options

| Flag | Description |
|------|-------------|
| `-d`, `--delay <value>` | Max seconds to wait between whois queries, randomized (default: 3s) |
| `-w`, `--whois` | Perform whois queries on C-class network ranges |

### Reverse Lookup Options

| Flag | Description |
|------|-------------|
| `-e`, `--exclude <regexp>` | Exclude PTR records matching this regex from reverse lookup results |

### Output Options

| Flag | Description |
|------|-------------|
| `-o`, `--output <file>` | Output results in XML format (importable in MagicTree) |

## Notes
- If no `-f` flag is supplied, the tool defaults to `/usr/share/dnsenum/dns.txt`.
- The `--whois` flag can generate very large netranges, which may significantly increase the time required for reverse lookups.
- Google scraping uses the query `allinurl: -www site:domain` to find extra names.