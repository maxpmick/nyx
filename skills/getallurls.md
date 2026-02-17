---
name: getallurls
description: Fetch known URLs from AlienVault's Open Threat Exchange, the Wayback Machine, and Common Crawl for any given domain. Use when performing reconnaissance, web application footprinting, or discovering hidden endpoints and historical parameters during the information gathering phase of a penetration test.
---

# getallurls (gau)

## Overview
getallurls (gau) fetches known URLs from AlienVault's Open Threat Exchange (OTX), the Wayback Machine, and Common Crawl for any given domain. It is a powerful tool for discovering a target's attack surface by identifying historical URLs, API endpoints, and parameters that may no longer be linked but still exist. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If the `gau` or `getallurls` command is not found, install it using:

```bash
sudo apt install getallurls
```

## Common Workflows

### Basic URL discovery for a domain
```bash
gau example.com
```

### Discover URLs including subdomains and save to a file
```bash
gau --subs example.com -o urls.txt
```

### Fetch URLs from specific providers only
```bash
gau --providers wayback,otx example.com
```

### Pipe multiple domains into gau
```bash
cat domains.txt | gau --threads 5
```

## Complete Command Reference

```
Usage of getallurls: [options] [domain]
```

| Flag | Description |
|------|-------------|
| `-json` | Write output as JSON format |
| `-o string` | Filename to write results to |
| `-p string` | HTTP proxy to use (e.g., `http://127.0.0.1:8080`) |
| `-providers string` | Providers to fetch URLs for. Default: `"wayback,otx,commoncrawl"` |
| `-random-agent` | Use a random User-Agent for requests |
| `-retries uint` | Amount of retries for HTTP client. Default: `5` |
| `-subs` | Include subdomains of the target domain |
| `-v` | Enable verbose mode |
| `-version` | Show gau version |

## Notes
- `gau` is often used in bug bounty hunting and initial reconnaissance to find sensitive files (like `.env`, `.git`, or backup files) that were indexed by web archives in the past.
- When using `--subs`, the tool will significantly increase the number of results by querying for all known subdomains of the target.
- You can pipe the output of `gau` into other tools like `httpx` to verify which discovered URLs are still live, or `grep` to filter for specific file extensions or keywords.