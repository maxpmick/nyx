---
name: wig
description: Identify Content Management Systems (CMS), administrative applications, and server operating systems by analyzing checksums, string matching, and HTTP headers. Use when performing web application reconnaissance, fingerprinting technologies, or identifying software versions during the information gathering phase of a penetration test.
---

# wig

## Overview
wig (WebApp Information Gatherer) is a web application fingerprinting tool. It identifies CMS platforms and their versions by comparing file checksums and string matches against a known database. It also attempts to identify the host operating system by analyzing 'Server' and 'X-Powered-By' headers. Category: Web Application Testing / Information Gathering.

## Installation (if not already installed)
Assume wig is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install wig
```

## Common Workflows

### Basic scan of a single URL
```bash
wig http://example.com
```

### Scan multiple targets from a file with high threading
```bash
wig -l targets.txt -t 20 -a
```

### Thorough fingerprinting without making extra requests
```bash
wig -m -a http://example.com
```
The `-m` flag tries harder to find matches using existing data, while `-a` ensures the tool doesn't stop after the first CMS is identified.

### Scan through a proxy and save results to JSON
```bash
wig --proxy localhost:8080 -w results.json http://example.com
```

## Complete Command Reference

```
wig [options] [url]
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `url` | The target URL to scan (e.g., http://example.com) |

### Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-l INPUT_FILE` | File containing a list of URLs to scan, one per line |
| `-q` | Quiet mode: do not prompt for user input during the run |
| `-n STOP_AFTER` | Stop after this number of CMSs have been detected (Default: 1) |
| `-a` | Do not stop after the first CMS is detected (scan for all possible matches) |
| `-m` | "Match harder": Try to find a match without making additional requests |
| `-u` | Specify a custom User-Agent string to use in requests |
| `-d` | Disable the automated search for subdomains |
| `-t THREADS` | Number of threads to use for scanning |
| `--no_cache_load` | Do not load previously cached responses |
| `--no_cache_save` | Do not save the current session's responses to the cache |
| `-N` | Shortcut for both `--no_cache_load` and `--no_cache_save` |
| `--verbosity`, `-v` | Increase verbosity level. Use multiple times (e.g., `-vv`) for more detail |
| `--proxy PROXY` | Tunnel traffic through a proxy (Format: `localhost:8080`) |
| `-w OUTPUT_FILE` | File path to dump results into (JSON format) |

## Notes
- The tool uses a scoring system based on weights and "hits" for specific checksums to determine the most probable version of a CMS.
- OS detection is based on a database of known header values for Windows versions and various Linux distributions.
- Using the `-a` flag is recommended if you suspect a site might be running multiple applications or if you want a more exhaustive technology stack report.