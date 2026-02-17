---
name: metagoofil
description: Search Google and download specific file types (PDF, DOC, XLS, etc.) from a target domain to identify public documents and prepare for metadata extraction. Use during the reconnaissance and information gathering phases of a penetration test to find sensitive information, usernames, or software versions hidden in document metadata.
---

# metagoofil

## Overview
Metagoofil is an information gathering tool designed for identifying and downloading public documents (pdf, doc, xls, ppt, docx, pptx, xlsx) belonging to a target company. It performs specialized Google searches to locate these files. Note: Modern versions focus on the discovery and downloading of files; a separate metadata extraction tool (like `exiftool`) is often used on the downloaded results. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Metagoofil is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install metagoofil
```

## Common Workflows

### Basic Search (View Only)
Search for PDF and DOCX files indexed for a domain without downloading them:
```bash
metagoofil -d example.com -t pdf,docx -l 50
```

### Download Target Documents
Search for the first 100 results and download up to 25 PDF files to a specific directory:
```bash
metagoofil -d kali.org -t pdf -l 100 -n 25 -o ./kali_docs -w
```

### Stealthy Enumeration
Search with a longer delay between Google queries to avoid IP blocking and use a random User-Agent:
```bash
metagoofil -d example.com -t xls,xlsx -e 60 -u -w
```

### Save Search Results to File
Save the discovered HTML links to a specific text file for later processing:
```bash
metagoofil -d example.com -t all -f discovery_links.txt
```

## Complete Command Reference

```bash
metagoofil -d DOMAIN -t FILE_TYPES [options]
```

### Required Options

| Flag | Description |
|------|-------------|
| `-d DOMAIN` | Domain to search (e.g., kali.org). |
| `-t FILE_TYPES` | File types to download (pdf, doc, xls, ppt, odp, ods, docx, xlsx, pptx). Use `ALL` to search all 17,576 three-letter extensions. |

### Search & Download Control

| Flag | Description |
|------|-------------|
| `-e DELAY` | Delay in seconds between searches. Default: 30.0. |
| `-l SEARCH_MAX` | Maximum Google results to search. Default: 100. |
| `-n DOWNLOAD_FILE_LIMIT` | Maximum number of files to download per filetype. Default: 100. |
| `-o SAVE_DIRECTORY` | Directory to save downloaded files. Default: "." (current directory). |
| `-r NUMBER_OF_THREADS` | Number of downloader threads. Default: 8. |
| `-w` | **Download** the files. If omitted, the tool only displays search results. |

### Output & Connectivity

| Flag | Description |
|------|-------------|
| `-f [SAVE_FILE]` | Save HTML links to a file. If `-f` is used without a name, it saves to `html_links_<TIMESTAMP>.txt`. |
| `-i URL_TIMEOUT` | Seconds to wait before timeout for unreachable/stale pages. Default: 15. |
| `-u [USER_AGENT]` | Set User-Agent. No `-u`: Googlebot 2.1; `-u` alone: Randomize; `-u "string"`: Custom string. |
| `-h, --help` | Show help message and exit. |

## Notes
- **Metadata Extraction**: Recent versions of Metagoofil focus on file acquisition. To extract metadata from the downloaded files, use a tool like `exiftool`: `exiftool ./downloads/*`.
- **Google Blocking**: If you perform too many searches too quickly, Google may temporarily block your IP address. Increase the `-e` (delay) value if you encounter CAPTCHAs or blocks.
- **File Types**: While common office formats are standard, the `ALL` keyword can be used for exhaustive discovery of obscure file extensions.