---
name: colly
description: Create and manage web scrapers and crawlers using the Colly framework. Use when performing web reconnaissance, data mining, automated information gathering, or archiving structured data from websites during penetration testing or OSINT phases.
---

# colly

## Overview
Colly is a lightning-fast and elegant scraping framework for Gophers (Go). It provides a clean interface to write any kind of crawler, scraper, or spider to extract structured data from websites. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume colly is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install colly
```

For development files (Golang):
```bash
sudo apt install golang-github-gocolly-colly-dev
```

## Common Workflows

### Initialize a new scraper project
```bash
colly new my-scraper
```
This creates a boilerplate scraper project in the specified directory.

### Get help for specific subcommands
```bash
colly new --help
```

## Complete Command Reference

```
Usage: colly COMMAND [arg...]
```

### Global Commands

| Command | Description |
|---------|-------------|
| `new` | Create a new scraper project template |

### Subcommand: colly new

Creates a new scraper project.

```
Usage: colly new [OPTIONS] NAME
```

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help information for the new command |

## Notes
- Colly is primarily used as a library within Go projects, but the `colly` CLI tool assists in bootstrapping new scraping projects.
- When building scrapers with the framework, it supports features like distributed scraping, caching, and automatic handling of cookies and sessions.
- Always respect `robots.txt` and website Terms of Service when performing automated crawling.