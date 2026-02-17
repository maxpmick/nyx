---
name: skipfish
description: Fully automated, active web application security reconnaissance tool and vulnerability scanner. It prepares an interactive sitemap through recursive crawling and dictionary-based probes, then performs active security checks. Use when performing web application security assessments, vulnerability scanning, directory brute-forcing, and site mapping.
---

# skipfish

## Overview
Skipfish is a high-performance active web application security reconnaissance tool. It generates an interactive sitemap of a target site by carrying out a recursive crawl and dictionary-based probes. The resulting map is annotated with findings from various security checks. Category: Web Application Testing.

## Installation (if not already installed)
Assume skipfish is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install skipfish
```

## Common Workflows

### Basic Scan
Perform a standard scan using a specific wordlist and output directory.
```bash
skipfish -o ./report_dir -W /usr/share/skipfish/dictionaries/medium.wl http://example.com
```

### Authenticated Scan (Cookie-based)
Scan a restricted area by providing a session cookie.
```bash
skipfish -o ./auth_report -W /usr/share/skipfish/dictionaries/low_effort.wl -C "session=123456789" http://example.com/admin
```

### Targeted Scope Scan
Only follow URLs containing a specific string and exclude others.
```bash
skipfish -o ./target_report -W /usr/share/skipfish/dictionaries/complete.wl -I "/api/" -X "/logout" http://example.com
```

### Form Authentication
Automate login during the crawl using form credentials.
```bash
skipfish -o ./form_auth -W /usr/share/skipfish/dictionaries/medium.wl --auth-form http://example.com/login.php --auth-user admin --auth-pass password123 http://example.com
```

## Complete Command Reference

```bash
skipfish [ options ... ] -W wordlist -o output_dir start_url [ start_url2 ... ]
```

### Authentication and Access Options

| Flag | Description |
|------|-------------|
| `-A user:pass` | Use specified HTTP authentication credentials |
| `-F host=IP` | Pretend that 'host' resolves to 'IP' |
| `-C name=val` | Append a custom cookie to all requests |
| `-H name=val` | Append a custom HTTP header to all requests |
| `-b (i\|f\|p)` | Use headers consistent with MSIE (`i`), Firefox (`f`), or iPhone (`p`) |
| `-N` | Do not accept any new cookies |
| `--auth-form url` | Form authentication URL |
| `--auth-user user` | Form authentication user |
| `--auth-pass pass` | Form authentication password |
| `--auth-verify-url` | URL for in-session detection |

### Crawl Scope Options

| Flag | Description |
|------|-------------|
| `-d max_depth` | Maximum crawl tree depth (default: 16) |
| `-c max_child` | Maximum children to index per node (default: 512) |
| `-x max_desc` | Maximum descendants to index per branch (default: 8192) |
| `-r r_limit` | Max total number of requests to send (default: 100000000) |
| `-p crawl%` | Node and link crawl probability (default: 100%) |
| `-q hex` | Repeat probabilistic scan with given seed |
| `-I string` | Only follow URLs matching 'string' |
| `-X string` | Exclude URLs matching 'string' |
| `-K string` | Do not fuzz parameters named 'string' |
| `-D domain` | Crawl cross-site links to another domain |
| `-B domain` | Trust, but do not crawl, another domain |
| `-Z` | Do not descend into 5xx locations |
| `-O` | Do not submit any forms |
| `-P` | Do not parse HTML, etc, to find new links |

### Reporting Options

| Flag | Description |
|------|-------------|
| `-o dir` | Write output to specified directory (Required) |
| `-M` | Log warnings about mixed content / non-SSL passwords |
| `-E` | Log all HTTP/1.0 / HTTP/1.1 caching intent mismatches |
| `-U` | Log all external URLs and e-mails seen |
| `-Q` | Completely suppress duplicate nodes in reports |
| `-u` | Be quiet, disable realtime progress stats |
| `-v` | Enable runtime logging (to stderr) |

### Dictionary Management Options

| Flag | Description |
|------|-------------|
| `-W wordlist` | Use a specified read-write wordlist (Required) |
| `-S wordlist` | Load a supplemental read-only wordlist |
| `-L` | Do not auto-learn new keywords for the site |
| `-Y` | Do not fuzz extensions in directory brute-force |
| `-R age` | Purge words hit more than 'age' scans ago |
| `-T name=val` | Add new form auto-fill rule |
| `-G max_guess` | Maximum number of keyword guesses to keep (default: 256) |
| `-z sigfile` | Load signatures from this file |

### Performance Settings

| Flag | Description |
|------|-------------|
| `-g max_conn` | Max simultaneous TCP connections, global (default: 40) |
| `-m host_conn` | Max simultaneous connections, per target IP (default: 10) |
| `-f max_fail` | Max number of consecutive HTTP errors (default: 100) |
| `-t req_tmout` | Total request response timeout (default: 20 s) |
| `-w rw_tmout` | Individual network I/O timeout (default: 10 s) |
| `-i idle_tmout` | Timeout on idle HTTP connections (default: 10 s) |
| `-s s_limit` | Response size limit (default: 400000 B) |
| `-e` | Do not keep binary responses for reporting |

### Other Settings

| Flag | Description |
|------|-------------|
| `-l max_req` | Max requests per second (default: 0.000000 / unlimited) |
| `-k duration` | Stop scanning after the given duration (format h:m:s) |
| `--config file` | Load the specified configuration file |

## Notes
- **Wordlists**: Kali Linux stores default skipfish wordlists in `/usr/share/skipfish/dictionaries/`.
- **Output**: The tool generates an HTML report. View it by opening `index.html` in the specified output directory with a web browser.
- **Performance**: Skipfish is extremely fast; use the `-l` flag if you need to throttle requests to avoid crashing fragile applications or triggering WAFs.