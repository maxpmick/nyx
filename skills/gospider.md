---
name: gospider
description: Fast web spider written in Go for comprehensive web crawling and information gathering. Use to discover subdomains, S3 buckets, and hidden links from source code, JavaScript files, robots.txt, sitemaps, and 3rd party archives like Wayback Machine and VirusTotal. Ideal for web application reconnaissance and attack surface mapping.
---

# gospider

## Overview
Gospider is a high-performance web crawler designed for security researchers. It automates the discovery of assets by parsing HTML, JavaScript, and configuration files, while also leveraging external data sources to find historical and hidden URLs. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume gospider is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install gospider
```

## Common Workflows

### Basic crawl of a single site
```bash
gospider -s "https://example.com/" -o output -c 10 -d 3
```
Crawls the site with 10 concurrent requests and a recursion depth of 3, saving results to the 'output' folder.

### Comprehensive reconnaissance using 3rd party sources
```bash
gospider -s "https://example.com/" -a -w -r --sitemap --robots
```
Includes URLs from Wayback Machine, Common Crawl, and VirusTotal, includes subdomains, and parses sitemaps/robots.txt.

### Crawling multiple sites from a list
```bash
gospider -S sites.txt -t 5 -c 10 -o results
```
Runs 5 sites in parallel, each with 10 concurrent requests.

### Using a proxy and custom headers
```bash
gospider -s "https://example.com/" -p http://127.0.0.1:8080 -H "Authorization: Bearer token" -u mobi
```
Routes traffic through a proxy (e.g., Burp Suite), adds a custom header, and uses a random mobile User-Agent.

## Complete Command Reference

### Target Options
| Flag | Description |
|------|-------------|
| `-s, --site string` | Site to crawl |
| `-S, --sites string` | File containing a list of sites to crawl |
| `--burp string` | Load headers and cookies from a Burp raw HTTP request file |

### Configuration Options
| Flag | Description |
|------|-------------|
| `-p, --proxy string` | Proxy URL (Ex: http://127.0.0.1:8080) |
| `-o, --output string` | Output folder path |
| `-u, --user-agent string` | User Agent: `web` (random desktop), `mobi` (random mobile), or a custom string (default "web") |
| `--cookie string` | Cookie string to use (e.g., "testA=a; testB=b") |
| `-H, --header stringArray` | Custom header (use multiple times for multiple headers) |
| `--blacklist string` | Blacklist URL Regex |
| `--no-redirect` | Disable following HTTP redirects |

### Performance & Timing
| Flag | Description |
|------|-------------|
| `-t, --threads int` | Number of sites to run in parallel (default 1) |
| `-c, --concurrent int` | Maximum allowed concurrent requests per domain (default 5) |
| `-d, --depth int` | Max recursion depth (0 for infinite) (default 1) |
| `-k, --delay int` | Delay in seconds before creating a new request |
| `-K, --random-delay int` | Extra randomized delay in seconds added to `--delay` |
| `-m, --timeout int` | Request timeout in seconds (default 10) |

### Discovery & Scraping Options
| Flag | Description |
|------|-------------|
| `--sitemap` | Try to find and crawl sitemap.xml |
| `--robots` | Try to find and crawl robots.txt (default true) |
| `-a, --other-source` | Find URLs from 3rd party (Archive.org, CommonCrawl.org, VirusTotal.com, AlienVault) |
| `-w, --include-subs` | Include subdomains found from 3rd party sources (default is main domain only) |
| `-r, --include-other-source` | Also include and crawl the URLs found from 3rd party sources |

### Debug & Output
| Flag | Description |
|------|-------------|
| `--debug` | Turn on debug mode |
| `-v, --verbose` | Turn on verbose output |
| `--version` | Check version |
| `-h, --help` | Show help message |

## Notes
- **JavaScript Parsing**: Gospider automatically attempts to find links and AWS S3 buckets within JavaScript files.
- **Output Format**: The output is designed to be "grep-friendly," making it easy to pipe into other tools like `httpx` or `nuclei`.
- **Resource Usage**: Increasing `-c` (concurrency) and `-t` (threads) significantly increases speed but may lead to rate-limiting or high CPU usage.