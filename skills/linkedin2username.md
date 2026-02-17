---
name: linkedin2username
description: Generate username lists for companies on LinkedIn by scraping employee names. Use this tool during the reconnaissance or information gathering phase of a penetration test to build target lists for credential stuffing, password spraying, or social engineering attacks. It requires valid LinkedIn credentials and can bypass search limits using geographic or keyword filters.
---

# linkedin2username

## Overview
OSINT tool designed to generate lists of probable usernames from a given company's LinkedIn page. It functions as a pure web-scraper using Selenium, requiring no API keys. It produces multiple username formats (e.g., flast, first.last) based on discovered employee names. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, install it and its WebDriver dependency:

```bash
sudo apt update
sudo apt install linkedin2username chromium-driver
```

## Common Workflows

### Basic Username Generation
Scrape all available employees for a specific company (found in the LinkedIn URL) and output to the default directory:
```bash
linkedin2username -c uber
```

### Generate Email Addresses
Append a domain name to the discovered usernames to create a target email list:
```bash
linkedin2username -c tesla -n tesla.com
```

### Bypassing the 1,000 Record Limit
LinkedIn often limits search results. Use the Geoblast feature or specific keywords to split the search into smaller chunks and discover more employees:
```bash
linkedin2username -c microsoft -g -k 'sales,engineering,marketing'
```

### Stealthy Scraping with Proxies and Delays
Use a proxy (like Burp Suite) and insert sleep intervals to avoid detection or rate limiting:
```bash
linkedin2username -c apple -s 5 -x http://127.0.0.1:8080
```

## Complete Command Reference

```
usage: linkedin2username [-h] -c COMPANY [-n DOMAIN] [-d DEPTH] [-s SLEEP]
                         [-x PROXY] [-k KEYWORDS] [-g] [-o OUTPUT]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-c`, `--company COMPANY` | **Required.** Company name exactly as typed in the company LinkedIn profile page URL (e.g., for `linkedin.com/company/example`, use `example`). |
| `-n`, `--domain DOMAIN` | Append a domain name to username output. Example: `-n uber.com` outputs `jschmoe@uber.com`. |
| `-d`, `--depth DEPTH` | Search depth (number of loops of 50 results). If unset, the tool will attempt to grab all available records. |
| `-s`, `--sleep SLEEP` | Seconds to sleep between search loops. Defaults to 0. |
| `-x`, `--proxy PROXY` | Proxy server to use. **WARNING:** This will disable SSL verification. Example: `-x http://localhost:8080`. |
| `-k`, `--keywords KEYWORDS` | Filter results by a comma-separated list of keywords. Performs a separate loop for each keyword to help bypass the 1,000 record limit. Example: `-k 'sales,human resources'`. |
| `-g`, `--geoblast` | Attempts to bypass the 1,000 record search limit by running multiple searches split across different geographic regions. |
| `-o`, `--output OUTPUT` | Output Directory for the generated lists. Defaults to `li2u-output`. |

## Notes
- **Authentication**: Upon running, the tool will prompt for your LinkedIn username and password. It is highly recommended to use a "sock puppet" (fake) account to avoid risking your primary professional profile.
- **Dependencies**: Requires `chromium-driver` to be present in the system path for Selenium to automate the browser.
- **Reliability**: As a web-scraper, this tool may break if LinkedIn updates its site structure.
- **Output**: The tool creates several files in the output directory corresponding to different common username formats (e.g., `f.last.txt`, `first.last.txt`, `flast.txt`).