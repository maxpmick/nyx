---
name: waybackpy
description: Interface with the Wayback Machine's SavePageNow, CDX Server, and Availability APIs. Use to retrieve historical versions of web pages, archive current pages, and enumerate known URLs or subdomains for a given target during reconnaissance and OSINT investigations.
---

# waybackpy

## Overview
waybackpy is a Python package and CLI tool that interfaces with the Internet Archive's Wayback Machine. It allows users to save pages, search for the oldest/newest/closest archives, and perform advanced URL discovery using the CDX Server API. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume waybackpy is already installed. If the command is missing:

```bash
sudo apt install waybackpy
```

## Common Workflows

### Archive a URL
Saves the current state of a webpage to the Wayback Machine.
```bash
waybackpy --url https://example.com --save
```

### Find the Oldest Archive
Retrieves the URL of the earliest recorded snapshot of a site.
```bash
waybackpy --url https://example.com --oldest
```

### Enumerate Known URLs and Subdomains
Lists all URLs known to the Wayback Machine for a domain and its subdomains, saving them to a file.
```bash
waybackpy --url example.com --known-urls --subdomain --file
```

### Find Archive Near a Specific Date
Search for a snapshot close to January 2010.
```bash
waybackpy --url https://example.com --near --year 2010 --month 1
```

## Complete Command Reference

```bash
waybackpy [OPTIONS]
```

### General Options
| Flag | Description |
|------|-------------|
| `-u, --url TEXT` | URL on which Wayback machine operations are to be performed. |
| `-ua, --user-agent TEXT` | User agent (default: 'waybackpy 3.0.6'). |
| `-v, --version` | Show waybackpy version. |
| `-l, --license` | Show license information. |
| `--help` | Show help message and exit. |

### Availability API Options
| Flag | Description |
|------|-------------|
| `-n, -au, --newest` | Retrieve the newest archive of the URL. |
| `-o, --oldest` | Retrieve the oldest archive of the URL. |
| `-N, --near` | Retrieve archive close to a specified time (use with date flags). |
| `-Y, --year INTEGER` | Year (1994-9999). |
| `-M, --month INTEGER` | Month (1-12). |
| `-D, --day INTEGER` | Day (1-31). |
| `-H, --hour INTEGER` | Hour (0-24). |
| `-MIN, --minute INTEGER` | Minute (0-60). |

### SavePageNow (Save) API Options
| Flag | Description |
|------|-------------|
| `-s, --save` | Save the specified URL's webpage and print the archive URL. |
| `-h, --headers` | Show headers data of the SavePageNow API. |

### CDX Server API Options
| Flag | Description |
|------|-------------|
| `--cdx` | Flag to explicitly use the CDX API. |
| `-ku, --known-urls` | List known URLs for the target. |
| `-sub, --subdomain` | Include known URLs for subdomains (use with `--known-urls`). |
| `-f, --file` | Save the discovered URLs into a file in the current directory. |
| `-st, --start-timestamp TEXT` | Start timestamp in `yyyyMMddhhmmss` format. |
| `-et, --end-timestamp TEXT` | End timestamp in `yyyyMMddhhmmss` format. |
| `-C, --closest TEXT` | Archive closest to the provided timestamp. |
| `-f, --cdx-filter TEXT` | Filter on specific CDX fields. |
| `-mt, --match-type TEXT` | Match type: exact, prefix, host, or domain. |
| `-st, --sort TEXT` | Sort order: default, closest, or reverse. |
| `-up, --use-pagination` | Use the CDX pagination API. |
| `-gz, --gzip TEXT` | Set to 'false' to disable gzip compression (default: true). |
| `-c, --collapse TEXT` | Filter/collapse results based on a field or substring. |
| `-l, --limit TEXT` | Max records to return per API call (default: 25000). |
| `-cp, --cdx-print TEXT` | Print only specific fields of the CDX response. |

## Notes
- The tool is highly effective for discovering hidden endpoints or historical files (like `robots.txt` or `sitemap.xml`) that no longer exist on the live site.
- When using `--known-urls`, the `--subdomain` flag is essential for a comprehensive attack surface overview.
- Rate limiting may apply depending on the Internet Archive's current load.