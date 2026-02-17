---
name: emailharvester
description: Retrieve domain email addresses from popular search engines and social media platforms using a plugin-based architecture. Use when performing reconnaissance, open-source intelligence (OSINT) gathering, or identifying potential targets for phishing and social engineering campaigns during the information gathering phase.
---

# emailharvester

## Overview
EmailHarvester is a Python-based tool designed to retrieve domain-specific email addresses from various search engines (Google, Bing, Yahoo, ASK, Baidu, Dogpile, Exalead) and social platforms (Twitter, LinkedIn, GitHub, Instagram, etc.). It features a plugin system, proxy support, and the ability to export results to multiple formats. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, install it via:

```bash
sudo apt update && sudo apt install emailharvester
```

## Common Workflows

### Search all engines for a specific domain
```bash
emailharvester -d example.com -e all
```

### Search using a specific engine and save results
```bash
emailharvester -d example.com -e google -s results_file
```
This will create both `results_file.txt` and `results_file.xml`.

### Search all engines except specific social media plugins
```bash
emailharvester -d example.com -e all -r twitter,linkedin,github
```

### Use a proxy and custom User-Agent to avoid rate limiting
```bash
emailharvester -d example.com -u "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -x http://127.0.0.1:8080
```

## Complete Command Reference

```
emailharvester [-h] [-d DOMAIN] [-s FILE] [-e ENGINE] [-l LIMIT] [-u USER-AGENT] [-x PROXY] [--noprint] [-r EXCLUDED_PLUGINS] [-p]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-d`, `--domain DOMAIN` | The target domain to search for email addresses. |
| `-s`, `--save FILE` | Save the results into both a TXT and XML file using the provided filename. |
| `-e`, `--engine ENGINE` | Select search engine plugin (e.g., `-e google`). Use `all` to query all available plugins. |
| `-l`, `--limit LIMIT` | Limit the number of results returned by the search engines. |
| `-u`, `--user-agent USER-AGENT` | Set a custom User-Agent request header to mimic different browsers. |
| `-x`, `--proxy PROXY` | Setup a proxy server for requests (e.g., `-x http://127.0.0.1:8080`). |
| `--noprint` | Tell EmailHarvester NOT to print discovered emails to the terminal. |
| `-r`, `--exclude EXCLUDED_PLUGINS` | Plugins to exclude when `-e all` is selected (e.g., `-r google,twitter`). |
| `-p`, `--list-plugins` | List all available search engine and site plugins currently installed. |

## Notes
- When using `-e all`, the tool iterates through every available plugin. If certain engines are blocking your IP, use the `-r` flag to exclude them.
- The tool relies on scraping search engine results; frequent queries without a proxy or rotating User-Agents may lead to temporary IP bans from search providers.
- Available plugins typically include: Google, Bing, Yahoo, ASK, Baidu, Dogpile, Exalead, Twitter, LinkedIn, Google+, Github, Instagram, Reddit, and Youtube. Use `-p` to confirm the current list.