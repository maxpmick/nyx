---
name: dirsearch
description: Advanced web path brute-forcer and directory scanner. Use to discover hidden directories, files, and sensitive endpoints on web servers during web application security testing, reconnaissance, or vulnerability analysis.
---

# dirsearch

## Overview
dirsearch is a feature-rich command-line tool designed to brute force directories and files in webservers. It supports high-performance multi-threading, recursive scanning, and advanced request/connection settings. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume dirsearch is already installed. If missing:

```bash
sudo apt update && sudo apt install dirsearch
```

## Common Workflows

### Basic scan with extensions
```bash
dirsearch -u https://example.com -e php,html,js
```

### Recursive scan using a custom wordlist and excluding 404s
```bash
dirsearch -u https://example.com -e conf,txt -w /usr/share/wordlists/dirb/common.txt -r -x 404
```

### Scanning a list of URLs from a file with JSON output
```bash
dirsearch -l targets.txt -e * --format json -o results.json
```

### Using a proxy (Tor) and random User-Agents
```bash
dirsearch -u https://example.com -e php --tor --random-agent
```

## Complete Command Reference

### Mandatory Options
| Flag | Description |
|------|-------------|
| `-u URL`, `--url=URL` | Target URL(s), can use multiple flags |
| `-l PATH`, `--url-file=PATH` | URL list file |
| `--stdin` | Read URL(s) from STDIN |
| `--cidr=CIDR` | Target CIDR |
| `--raw=PATH` | Load raw HTTP request from file (use `--scheme` to set scheme) |
| `-s SESSION_FILE`, `--session=SESSION_FILE` | Session file |
| `--config=PATH` | Full path to config file (Default: config.ini) |

### Dictionary Settings
| Flag | Description |
|------|-------------|
| `-w WORDLISTS`, `--wordlists=WORDLISTS` | Customize wordlists (separated by commas) |
| `-e EXTENSIONS`, `--extensions=EXTENSIONS` | Extension list separated by commas (e.g. php,asp) |
| `-f`, `--force-extensions` | Add extensions to the end of every wordlist entry |
| `-O`, `--overwrite-extensions` | Overwrite other extensions in the wordlist with your extensions |
| `--exclude-extensions=EXTENSIONS` | Exclude extension list (e.g. asp,jsp) |
| `--remove-extensions` | Remove extensions in all paths (e.g. admin.php -> admin) |
| `--prefixes=PREFIXES` | Add custom prefixes to all wordlist entries |
| `--suffixes=SUFFIXES` | Add custom suffixes to all wordlist entries (ignores directories) |
| `-U`, `--uppercase` | Uppercase wordlist |
| `-L`, `--lowercase` | Lowercase wordlist |
| `-C`, `--capital` | Capital wordlist |

### General Settings
| Flag | Description |
|------|-------------|
| `-t THREADS`, `--threads=THREADS` | Number of threads |
| `-r`, `--recursive` | Brute-force recursively |
| `--deep-recursive` | Perform recursive scan on every directory depth |
| `--force-recursive` | Do recursive brute-force for every found path, not only directories |
| `-R DEPTH`, `--max-recursion-depth=DEPTH` | Maximum recursion depth |
| `--recursion-status=CODES` | Valid status codes to perform recursive scan |
| `--subdirs=SUBDIRS` | Scan sub-directories of the given URL[s] |
| `--exclude-subdirs=SUBDIRS` | Exclude subdirectories during recursive scan |
| `-i CODES`, `--include-status=CODES` | Include status codes (e.g. 200,300-399) |
| `-x CODES`, `--exclude-status=CODES` | Exclude status codes (e.g. 301,500-599) |
| `--exclude-sizes=SIZES` | Exclude responses by sizes (e.g. 0B,4KB) |
| `--exclude-text=TEXTS` | Exclude responses by text, can use multiple flags |
| `--exclude-regex=REGEX` | Exclude responses by regular expression |
| `--exclude-redirect=STRING` | Exclude responses if regex matches redirect URL |
| `--exclude-response=PATH` | Exclude responses similar to response of this page |
| `--skip-on-status=CODES` | Skip target whenever hit one of these status codes |
| `--min-response-size=LENGTH` | Minimum response length |
| `--max-response-size=LENGTH` | Maximum response length |
| `--max-time=SECONDS` | Maximum runtime for the scan |
| `--exit-on-error` | Exit whenever an error occurs |

### Request Settings
| Flag | Description |
|------|-------------|
| `-m METHOD`, `--http-method=METHOD` | HTTP method (default: GET) |
| `-d DATA`, `--data=DATA` | HTTP request data |
| `--data-file=PATH` | File containing HTTP request data |
| `-H HEADERS`, `--header=HEADERS` | HTTP request header, can use multiple flags |
| `--header-file=PATH` | File containing HTTP request headers |
| `-F`, `--follow-redirects` | Follow HTTP redirects |
| `--random-agent` | Choose a random User-Agent for each request |
| `--auth=CREDENTIAL` | Auth credential (user:password or bearer token) |
| `--auth-type=TYPE` | Auth type (basic, digest, bearer, ntlm, jwt, oauth2) |
| `--cert-file=PATH` | Client-side certificate file |
| `--key-file=PATH` | Client-side certificate private key (unencrypted) |
| `--user-agent=USER_AGENT` | Set specific User-Agent |
| `--cookie=COOKIE` | Set HTTP Cookie header |

### Connection Settings
| Flag | Description |
|------|-------------|
| `--timeout=TIMEOUT` | Connection timeout |
| `--delay=DELAY` | Delay between requests |
| `--proxy=PROXY` | Proxy URL (HTTP/SOCKS), can use multiple flags |
| `--proxy-file=PATH` | File containing proxy servers |
| `--proxy-auth=CREDENTIAL` | Proxy authentication credential |
| `--replay-proxy=PROXY` | Proxy to replay with found paths |
| `--tor` | Use Tor network as proxy |
| `--scheme=SCHEME` | Scheme for raw request (Default: auto-detect) |
| `--max-rate=RATE` | Max requests per second |
| `--retries=RETRIES` | Number of retries for failed requests |
| `--ip=IP` | Server IP address |

### Advanced & View Settings
| Flag | Description |
|------|-------------|
| `--crawl` | Crawl for new paths in responses |
| `--full-url` | Full URLs in the output |
| `--redirects-history` | Show redirects history |
| `--no-color` | No colored output |
| `-q`, `--quiet-mode` | Quiet mode |

### Output Settings
| Flag | Description |
|------|-------------|
| `-o PATH`, `--output=PATH` | Output file |
| `--format=FORMAT` | Report format (simple, plain, json, xml, md, csv, html, sqlite) |
| `--log=PATH` | Log file |

## Notes
- Use `-e *` to scan for all extensions if the specific technology is unknown.
- Recursive scanning (`-r`) can be very time-consuming; use `--max-recursion-depth` to limit it.
- When using `--raw`, ensure you specify the `--scheme` (http/https) if it cannot be auto-detected.