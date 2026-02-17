---
name: goofile
description: Search for specific file types within a given domain using search engine queries. Use when performing reconnaissance, information gathering, or document harvesting to find sensitive files like PDFs, DOCX, or configuration files exposed on a target's web infrastructure.
---

# goofile

## Overview
goofile is a command-line tool designed to search for specific file types hosted on a target domain. It is primarily used during the reconnaissance phase of a penetration test to discover publicly accessible documents and files that may contain sensitive information. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume goofile is already installed. If the command is missing:

```bash
sudo apt install goofile
```

Dependencies: python3, python3-requests.

## Common Workflows

### Search for PDFs on a specific domain
```bash
goofile -d kali.org -f pdf
```

### Search for Excel files with a specific keyword
```bash
goofile -d example.com -f xlsx -q "confidential"
```

### Using Google Custom Search API
To avoid scraping limitations and get more reliable results, use your own API key and Engine ID:
```bash
goofile -d example.com -f docx -k [YOUR_API_KEY] -e [YOUR_ENGINE_ID]
```

## Complete Command Reference

```bash
usage: goofile [-h] [-d DOMAIN] [-f FILETYPE] [-k KEY] [-e ENGINE] [-q QUERY] [--logging LOGGING]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-d DOMAIN`, `--domain DOMAIN` | The domain to search (e.g., kali.org). This is optional but recommended for targeted searches. |
| `-f FILETYPE`, `--filetype FILETYPE` | **Required.** The file extension to search for (e.g., pdf, doc, xls, txt). |
| `-k KEY`, `--key KEY` | Google Custom Search Engine API key (optional). |
| `-e ENGINE`, `--engine ENGINE` | Google Custom Search Engine ID (optional). |
| `-q QUERY`, `--query QUERY` | Filter results to only include files containing this specific keyword (optional). |
| `--logging LOGGING` | Set the logging verbosity (default is "INFO"). Useful for debugging connection issues. |

## Notes
- The tool is highly effective for finding "low-hanging fruit" such as leaked manuals, metadata-rich documents, or forgotten backups.
- If not using an API key (`-k`), the tool may be subject to search engine rate limiting or CAPTCHAs.
- Common filetypes to search for include: `pdf`, `doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `rtf`, `odp`, `ods`, `odt`, and `txt`.