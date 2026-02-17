---
name: hakrawler
description: Fast web crawler designed for quick discovery of endpoints, assets, and JavaScript files. Use when performing web application reconnaissance, endpoint discovery, or gathering URLs for further vulnerability scanning and analysis.
---

# hakrawler

## Overview
hakrawler is a fast Go-based web crawler built on the Gocolly library. It is designed to quickly discover URLs, JavaScript file locations, forms, and other assets on a target web application. Category: Web Application Testing.

## Installation (if not already installed)
Assume hakrawler is already installed. If you get a "command not found" error:

```bash
sudo apt install hakrawler
```

## Common Workflows

### Basic crawl of a single URL
```bash
echo "https://example.com" | hakrawler
```

### Crawl with subdomains and unique output
```bash
echo "https://example.com" | hakrawler -subs -u
```

### Crawl through a proxy (e.g., Burp Suite) with custom headers
```bash
echo "https://example.com" | hakrawler -proxy http://127.0.0.1:8080 -h "Cookie: session=12345;;User-Agent: Mozilla/5.0"
```

### Depth-limited crawl with JSON output for automation
```bash
echo "https://example.com" | hakrawler -d 3 -json -t 20
```

## Complete Command Reference

hakrawler reads target URLs from **stdin**.

| Flag | Type | Description |
|------|------|-------------|
| `-d` | int | Depth to crawl. (default 2) |
| `-h` | string | Custom headers separated by two semi-colons. E.g. `-h "Cookie: foo=bar;;Referer: http://example.com/"` |
| `-insecure` | bool | Disable TLS verification. |
| `-json` | bool | Output results as JSON objects. |
| `-proxy` | string | Proxy URL. E.g. `-proxy http://127.0.0.1:8080` |
| `-s` | bool | Show the source of URL based on where it was found (e.g., href, form, script, etc.). |
| `-size` | int | Page size limit in KB. (default -1, no limit) |
| `-subs` | bool | Include subdomains for crawling. |
| `-t` | int | Number of threads to utilise. (default 8) |
| `-timeout` | int | Maximum time to crawl each URL from stdin, in seconds. (default -1, no timeout) |
| `-u` | bool | Show only unique URLs in the output. |

## Notes
- The tool is designed to be piped into other tools (like `ffuf`, `sqlmap`, or `nuclei`) or to receive input from tools like `subfinder` or `assetfinder`.
- Using the `-s` flag is highly recommended for manual analysis to understand how an endpoint was discovered.
- When crawling large sites, adjust the `-size` or `-timeout` to prevent the crawler from hanging on massive files or slow responses.