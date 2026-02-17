---
name: feroxbuster
description: Perform fast, recursive content discovery and forced browsing to enumerate unlinked resources like directories, files, and sensitive data. Use during the reconnaissance or web application testing phases to find hidden endpoints, backup files, or administrative panels using brute force and wordlists.
---

# feroxbuster

## Overview
A high-performance, recursive content discovery tool written in Rust. It uses brute force combined with wordlists to search for unlinked content (Predictable Resource Location) such as source code, credentials, and internal addressing. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume feroxbuster is already installed. If missing:
```bash
sudo apt install feroxbuster
```
Dependencies: fonts-noto-color-emoji, libc6, libgcc-s1, seclists.

## Common Workflows

### Standard Recursive Scan
```bash
feroxbuster -u http://127.0.0.1 -w /usr/share/seclists/Discovery/Web-Content/common.txt
```

### Thorough Discovery with Extensions and Smart Collection
```bash
feroxbuster -u http://example.com --thorough -x php,html,txt
```

### Piping Targets from STDIN
```bash
cat targets.txt | feroxbuster --stdin --silent -s 200 301 --redirects
```

### Authenticated Scan with Proxy (Burp Suite)
```bash
feroxbuster -u http://example.com --burp -b "session=12345" -H "Authorization: Bearer token"
```

## Complete Command Reference

### Target Selection
| Flag | Description |
|------|-------------|
| `-u, --url <URL>` | Target URL (required unless stdin/resume/request-file used) |
| `--stdin` | Read URL(s) from STDIN |
| `--resume-from <FILE>` | State file to resume a partially complete scan |
| `--request-file <FILE>` | Raw HTTP request file to use as a template |

### Composite Settings
| Flag | Description |
|------|-------------|
| `--burp` | Sets `--proxy http://127.0.0.1:8080` and `--insecure true` |
| `--burp-replay` | Sets `--replay-proxy http://127.0.0.1:8080` and `--insecure true` |
| `--data-urlencoded <D>` | Sets form-urlencoded header, data (supports @file), and POST method |
| `--data-json <D>` | Sets JSON header, data (supports @file), and POST method |
| `--smart` | Enables `--auto-tune`, `--collect-words`, and `--collect-backups` |
| `--thorough` | Enables `--smart` plus `--collect-extensions` and `--scan-dir-listings` |

### Proxy Settings
| Flag | Description |
|------|-------------|
| `-p, --proxy <URL>` | Proxy to use (e.g., http://host:port, socks5://host:port) |
| `-P, --replay-proxy <URL>` | Send only unfiltered requests through this proxy |
| `-R, --replay-codes <C>...` | Status codes to send through replay proxy (default: same as --status-codes) |

### Request Settings
| Flag | Description |
|------|-------------|
| `-a, --user-agent <UA>` | Set User-Agent (default: feroxbuster/2.13.0) |
| `-A, --random-agent` | Use a random User-Agent |
| `-x, --extensions <EXT>...` | Extensions to search for (supports @file) |
| `-m, --methods <M>...` | HTTP methods to use (default: GET) |
| `--data <DATA>` | Request body (supports @file) |
| `-H, --headers <H>...` | Specify HTTP headers (e.g., -H "Header: val") |
| `-b, --cookies <C>...` | Specify HTTP cookies (e.g., -b name=val) |
| `-Q, --query <Q>...` | URL query parameters (e.g., -Q token=123) |
| `-f, --add-slash` | Append / to each request's URL |
| `--protocol <PROTO>` | Protocol to use if not specified (default: https) |

### Filters
| Flag | Description |
|------|-------------|
| `--dont-scan <URL>...` | URLs or Regex patterns to exclude from recursion |
| `--scope <URL>...` | Additional domains/URLs to consider in-scope |
| `-S, --filter-size <S>...` | Filter out responses of specific size |
| `-X, --filter-regex <R>...` | Filter via regex matching on body/headers |
| `-W, --filter-words <W>...` | Filter out responses of specific word count |
| `-N, --filter-lines <L>...` | Filter out responses of specific line count |
| `-C, --filter-status <C>...` | Filter out status codes (deny list) |
| `--filter-similar-to <U>...` | Filter pages similar to the given URL (soft 404s) |
| `-s, --status-codes <C>...` | Status codes to include (allow list) |
| `--unique` | Only show unique responses |

### Client & Scan Settings
| Flag | Description |
|------|-------------|
| `-T, --timeout <SEC>` | Request timeout in seconds (default: 7) |
| `-r, --redirects` | Follow redirects |
| `-k, --insecure` | Disable TLS certificate validation |
| `--server-certs <FILE>` | Add custom root certificates (PEM/DER) |
| `--client-cert <PEM>` | PEM certificate for mTLS |
| `--client-key <PEM>` | PEM private key for mTLS |
| `-t, --threads <N>` | Number of concurrent threads (default: 50) |
| `-n, --no-recursion` | Do not scan recursively |
| `-d, --depth <N>` | Max recursion depth (0 is infinite, default: 4) |
| `--force-recursion` | Force recursion on all found endpoints |
| `--dont-extract-links` | Don't extract links from response body |
| `-L, --scan-limit <N>` | Limit total concurrent scans (default: 0/unlimited) |
| `--parallel <N>` | Run parallel instances (one per URL from stdin) |
| `--rate-limit <N>` | Limit requests per second per directory |
| `--response-size-limit <B>` | Limit response body read size (default: 4MB) |
| `--time-limit <SPEC>` | Limit total run time (e.g., 10m) |
| `-w, --wordlist <FILE>` | Path or URL of the wordlist |
| `--auto-tune` | Automatically lower rate on excessive errors |
| `--auto-bail` | Stop scanning on excessive errors |
| `-D, --dont-filter` | Don't auto-filter wildcard responses |
| `--scan-dir-listings` | Force recursion into directory listings |

### Dynamic Collection
| Flag | Description |
|------|-------------|
| `-E, --collect-extensions` | Automatically discover and add extensions |
| `-B, --collect-backups` | Request likely backup extensions (~, .bak, .old, etc) |
| `-g, --collect-words` | Discover words from responses and add to wordlist |
| `-I, --dont-collect <EXT>` | Extensions to ignore during collection |

### Output & Updates
| Flag | Description |
|------|-------------|
| `-v, --verbosity` | Increase verbosity (-vv, -vvv) |
| `--silent` | Only print URLs/JSON and turn off logging |
| `-q, --quiet` | Hide progress bars and banner |
| `--json` | Emit JSON logs |
| `-o, --output <FILE>` | Output file for results |
| `--debug-log <FILE>` | Output file for log entries |
| `--no-state` | Disable .state file creation |
| `--limit-bars <N>` | Limit number of directory scan bars shown |
| `-U, --update` | Update feroxbuster to latest version |

## Notes
- **Multiple Values**: Options like `-x`, `-H`, and `-S` accept multiple values separated by spaces or commas (e.g., `-x php,txt,js`).
- **File Input**: Many flags support reading from a file if the input starts with `@` (e.g., `-x @exts.txt`).
- **Performance**: Use `--threads` and `--scan-limit` to balance speed against target stability.
- **Wildcards**: By default, feroxbuster attempts to filter wildcard (soft 404) responses automatically. Use `-D` to disable this.