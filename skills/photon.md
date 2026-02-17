---
name: photon
description: Incredibly fast crawler designed for open source intelligence (OSINT). It extracts URLs, parameters, emails, social media accounts, cloud buckets, secret keys, and subdomains. Use when performing web reconnaissance, surface area mapping, data scraping, or information gathering during the initial phases of a penetration test.
---

# photon

## Overview
Photon is a fast and flexible crawler designed for OSINT. It can extract a wide variety of data including URLs (in-scope and out-of-scope), parameters, secret keys, JS files, and DNS data. It organizes extracted information into a directory structure or exports it to JSON/CSV. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume photon is already installed. If the command is missing, install it via:

```bash
sudo apt install photon
```

## Common Workflows

### Basic crawl of a target domain
```bash
photon -u http://example.com
```
Crawls the target and saves findings (emails, links, scripts, etc.) in a directory named after the domain.

### Deep crawl with DNS enumeration and key discovery
```bash
photon -u http://example.com -l 3 -t 20 --dns --keys
```
Crawls 3 levels deep using 20 threads, while also attempting to find subdomains and API/secret keys.

### Using Wayback Machine as seeds for crawling
```bash
photon -u http://example.com --wayback
```
Fetches archived URLs from archive.org to use as initial seeds, helping discover old or hidden endpoints.

### Exporting results to JSON for automation
```bash
photon -u http://example.com -e json -o /tmp/results
```

## Complete Command Reference

```
usage: photon.py [-h] [-u ROOT] [-c COOK] [-r REGEX] [-e {csv,json}]
                 [-o OUTPUT] [-l LEVEL] [-t THREADS] [-d DELAY] [-v]
                 [-s SEEDS [SEEDS ...]] [--stdout STD]
                 [--user-agent USER_AGENT] [--exclude EXCLUDE]
                 [--timeout TIMEOUT] [--clone] [--headers] [--dns] [--keys]
                 [--only-urls] [--wayback]
```

### Core Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-u`, `--url ROOT` | Root URL to start crawling from |
| `-l`, `--level LEVEL` | Number of levels to crawl (depth) |
| `-t`, `--threads THREADS` | Number of threads to use for crawling |
| `-d`, `--delay DELAY` | Delay in seconds between requests |
| `-v`, `--verbose` | Enable verbose output |

### Extraction & Discovery Options

| Flag | Description |
|------|-------------|
| `-r`, `--regex REGEX` | Custom regex pattern to match and extract strings |
| `--dns` | Enumerate subdomains and DNS related data |
| `--keys` | Search for secret keys (auth/API keys and hashes) |
| `--wayback` | Fetch URLs from archive.org (Wayback Machine) to use as seeds |
| `--only-urls` | Only extract URLs and skip other data types |

### Request Configuration

| Flag | Description |
|------|-------------|
| `-c`, `--cookie COOK` | HTTP Cookie to use for requests |
| `-s`, `--seeds SEEDS` | Additional seed URLs (space separated) |
| `--user-agent USER_AGENT` | Custom user agent string(s) |
| `--headers` | Add custom headers to requests |
| `--timeout TIMEOUT` | HTTP request timeout in seconds |
| `--exclude EXCLUDE` | Exclude URLs matching this regex pattern |

### Output & Integration

| Flag | Description |
|------|-------------|
| `-e`, `--export {csv,json}` | Export format for the extracted data |
| `-o`, `--output OUTPUT` | Specify the output directory name |
| `--stdout STD` | Send specific variables to stdout |
| `--clone` | Clone the website pages locally |

## Notes
- Photon is highly threaded; increasing `-t` can significantly speed up crawls but may trigger WAFs or rate limiting.
- The `--dns` flag provides basic subdomain discovery; for exhaustive DNS recon, consider pairing with tools like `subfinder` or `amass`.
- Extracted data is typically saved in a folder named after the target domain unless `-o` is specified.