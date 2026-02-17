---
name: arjun
description: Discover hidden HTTP parameters (GET/POST/JSON/XML) for URL endpoints using a large built-in dictionary and heuristic analysis. Use when performing web application reconnaissance, identifying undocumented API parameters, or searching for hidden inputs that might lead to vulnerabilities like IDOR, XSS, or SQL injection.
---

# arjun

## Overview
Arjun is an HTTP parameter discovery suite designed to find valid query parameters for URL endpoints. It uses a large default dictionary (over 25,000 names) and optimizes requests by sending multiple parameters in a single "chunk" to minimize network traffic. It supports various request methods and can passively extract parameters from external sources. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Arjun is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install arjun
```

## Common Workflows

### Basic GET Parameter Discovery
```bash
arjun -u https://api.example.com/v1/userinfo
```

### Discovering JSON Parameters with Custom Threads
```bash
arjun -u https://api.example.com/v1/login -m JSON -t 10
```

### Importing Targets and Exporting to Burp Suite
```bash
arjun -i targets.txt -oB 127.0.0.1:8080
```

### Passive Parameter Discovery
Collects potential parameter names from Wayback Machine, CommonCrawl, and AlienVault OTX.
```bash
arjun -u https://example.com/api/ -p
```

### Using Custom Headers and Casing
```bash
arjun -u https://example.com/ -m POST --headers "Authorization: Bearer token\nCookie: session=123" --casing likeThis
```

## Complete Command Reference

```bash
arjun [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h, --help` | Show the help message and exit |
| `-u URL` | Target URL to scan |
| `-o, -oJ JSON_FILE` | Path for JSON output file |
| `-oT TEXT_FILE` | Path for text output file |
| `-oB [BURP_PROXY]` | Output results to Burp Suite Proxy (Default: `127.0.0.1:8080`) |
| `-d DELAY` | Delay between requests in seconds (Default: `0`) |
| `-t THREADS` | Number of concurrent threads (Default: `5`) |
| `-w WORDLIST` | Wordlist file path (Default: `{arjundir}/db/large.txt`) |
| `-m METHOD` | Request method to use: `GET`, `POST`, `XML`, or `JSON` (Default: `GET`) |
| `-i [IMPORT_FILE]` | Import target URLs from a file |
| `-T TIMEOUT` | HTTP request timeout in seconds (Default: `15`) |
| `-c CHUNKS` | Chunk size: the number of parameters to be sent in a single request |
| `-q` | Quiet mode: suppresses standard output |
| `--rate-limit RATE_LIMIT` | Max number of requests to be sent out per second (Default: `9999`) |
| `--headers [HEADERS]` | Add custom HTTP headers. Separate multiple headers with a new line (`\n`) |
| `--passive [PASSIVE]` | Collect parameter names from passive sources (Wayback, CommonCrawl, OTX) |
| `--stable` | Prefer stability over speed (useful for fragile targets) |
| `--include INCLUDE` | Include specific data/parameters in every request |
| `--disable-redirects` | Disable following HTTP redirects |
| `--casing CASING` | Casing style for parameters (e.g., `like_this`, `likeThis`, `likethis`) |

## Notes
- **Efficiency**: Arjun can test thousands of parameters in just a few dozen requests by grouping them into chunks.
- **Passive Mode**: The `--passive` flag is excellent for initial OSINT before active brute-forcing.
- **Rate Limiting**: If the target application returns errors or blocks your IP, use `-d` (delay) or `--rate-limit` to slow down the scan.
- **Method Support**: When using `-m JSON` or `-m XML`, Arjun correctly formats the request body to match the expected content type.