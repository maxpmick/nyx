---
name: maryam
description: OWASP Maryam is a modular open-source framework for OSINT and data gathering. Use it to harvest data from open sources and search engines, perform reconnaissance, and collect information on targets during the information-gathering phase of a penetration test.
---

# maryam

## Overview
OWASP Maryam is a powerful modular framework written in Python, designed for Open Source Intelligence (OSINT) and data gathering. It provides an environment to quickly and thoroughly collect data from various search engines and public sources. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume Maryam is already installed. If the command is not found, install it using:

```bash
sudo apt install maryam
```

Dependencies include: python3, bs4, cloudscraper, dask, flask, gensim, lxml, matplotlib, numpy, pandas, plotly, requests, scipy, sklearn, vadersentiment, and wordcloud.

## Common Workflows

### Interactive Shell
Start the Maryam interactive console to explore modules:
```bash
maryam
```

### Execute a specific module command and exit
Search for subdomains using a specific module (e.g., bing_search) for a target domain:
```bash
maryam -e "modules/osint/bing_search -d example.com"
```

### Run a command and stay in the shell
Load a module and set options without exiting:
```bash
maryam -s "modules/osint/dns_search"
```

### Show available modules
Inside the Maryam shell:
```text
Maryam > show modules
```

## Complete Command Reference

### Primary CLI Arguments

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-e <command>` | Execute a specific Maryam command and exit immediately |
| `-s <command>` | Run a command and remain inside the Maryam interactive shell |
| `-v` | Show version information and exit |

### Internal Shell Commands
Once inside the Maryam interactive environment, the following commands are typically available:

| Command | Description |
|---------|-------------|
| `help` | Show help for commands |
| `show modules` | List all available OSINT and reconnaissance modules |
| `show options` | Show options for the currently selected module |
| `set <option> <value>` | Set a value for a module option (e.g., `set domain example.com`) |
| `run` | Execute the currently configured module |
| `search <term>` | Search for modules by keyword |
| `exit` | Exit the Maryam framework |

### Module Categories
Maryam organizes its capabilities into several categories:
- **Footprint**: Modules for identifying infrastructure and web technologies.
- **OSINT**: Modules for gathering data from search engines, social media, and public records.
- **Search**: Specialized search engine scrapers.
- **Crawler**: Web crawling and link extraction tools.

## Notes
- Maryam is highly modular; use `show modules` frequently to discover new data sources.
- Some modules may require API keys which can be set within the framework's configuration.
- As an OSINT tool, its effectiveness depends on the availability of third-party data sources and search engine accessibility.