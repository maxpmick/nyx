---
name: ffuf
description: Fast web fuzzer written in Go used for directory discovery, virtual host enumeration, and fuzzing of GET/POST parameters. Use when performing web application reconnaissance, identifying hidden files/directories, discovering subdomains via Host header fuzzing, or testing for injection points by fuzzing parameters.
---

# ffuf

## Overview
ffuf (Fuzz Faster U Fool) is a high-performance web fuzzer designed for speed and flexibility. It supports typical directory discovery, virtual host discovery (without DNS records), and complex parameter fuzzing using multiple wordlists and various HTTP methods. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
Assume ffuf is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install ffuf
```

## Common Workflows

### Directory and File Discovery
```bash
ffuf -w /usr/share/wordlists/dirb/common.txt -u https://example.com/FUZZ -e .php,.html,.txt
```

### Virtual Host Discovery
Fuzz the `Host` header to find subdomains or vhosts pointing to the same IP.
```bash
ffuf -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u https://example.com/ -H "Host: FUZZ.example.com" -ac
```

### POST Parameter Fuzzing
Fuzz a JSON body and filter out responses containing "error".
```bash
ffuf -w wordlist.txt -u https://example.com/api/login -X POST -H "Content-Type: application/json" -d '{"username": "FUZZ", "password": "password123"}' -fr "error"
```

### Multi-Wordlist Fuzzing (Clusterbomb)
Fuzz both the parameter name and the value simultaneously.
```bash
ffuf -w params.txt:PARAM -w values.txt:VAL -u https://example.com/?PARAM=VAL -mc 200
```

## Complete Command Reference

### HTTP Options
| Flag | Description |
|------|-------------|
| `-H` | Header `"Name: Value"`, separated by colon. Multiple flags accepted. |
| `-X` | HTTP method to use (e.g., GET, POST, PUT). |
| `-b` | Cookie data `"NAME1=VALUE1; NAME2=VALUE2"`. |
| `-cc` | Client cert for authentication (requires `-ck`). |
| `-ck` | Client key for authentication (requires `-cc`). |
| `-d` | POST data. |
| `-http2` | Use HTTP2 protocol (default: false). |
| `-ignore-body` | Do not fetch the response content (default: false). |
| `-r` | Follow redirects (default: false). |
| `-raw` | Do not encode URI (default: false). |
| `-recursion` | Scan recursively. URL must end in `FUZZ` (default: false). |
| `-recursion-depth` | Maximum recursion depth (default: 0). |
| `-recursion-strategy` | Strategy: `default` (redirect based) or `greedy` (all matches) (default: default). |
| `-replay-proxy` | Replay matched requests using this proxy. |
| `-sni` | Target TLS SNI (does not support FUZZ keyword). |
| `-timeout` | HTTP request timeout in seconds (default: 10). |
| `-u` | Target URL. |
| `-x` | Proxy URL (SOCKS5 or HTTP), e.g., `http://127.0.0.1:8080`. |

### General Options
| Flag | Description |
|------|-------------|
| `-V` | Show version information. |
| `-ac` | Automatically calibrate filtering options (default: false). |
| `-acc` | Custom auto-calibration string. Implies `-ac`. |
| `-ach` | Per host autocalibration (default: false). |
| `-ack` | Autocalibration keyword (default: FUZZ). |
| `-acs` | Custom auto-calibration strategies. Implies `-ac`. |
| `-c` | Colorize output (default: false). |
| `-config` | Load configuration from a file. |
| `-json` | JSON output, printing newline-delimited JSON records (default: false). |
| `-maxtime` | Maximum running time in seconds for entire process (default: 0). |
| `-maxtime-job` | Maximum running time in seconds per job (default: 0). |
| `-noninteractive` | Disable the interactive console functionality (default: false). |
| `-p` | Seconds of delay between requests, or range (e.g., "0.1" or "0.1-2.0"). |
| `-rate` | Rate of requests per second (default: 0). |
| `-s` | Silent mode; do not print additional information (default: false). |
| `-sa` | Stop on all error cases. Implies `-sf` and `-se`. |
| `-scraperfile` | Custom scraper file path. |
| `-scrapers` | Active scraper groups (default: all). |
| `-se` | Stop on spurious errors (default: false). |
| `-search` | Search for a FFUFHASH payload from ffuf history. |
| `-sf` | Stop when > 95% of responses return 403 Forbidden (default: false). |
| `-t` | Number of concurrent threads (default: 40). |
| `-v` | Verbose output; prints full URL and redirect locations (default: false). |

### Matcher Options
| Flag | Description |
|------|-------------|
| `-mc` | Match HTTP status codes or "all" (default: 200-299,301,302,307,401,403,405,500). |
| `-ml` | Match amount of lines in response. |
| `-mmode` | Matcher set operator: `and`, `or` (default: or). |
| `-mr` | Match regexp. |
| `-ms` | Match HTTP response size. |
| `-mt` | Match milliseconds to first byte (e.g., `>100` or `<100`). |
| `-mw` | Match amount of words in response. |

### Filter Options
| Flag | Description |
|------|-------------|
| `-fc` | Filter HTTP status codes from response. |
| `-fl` | Filter by amount of lines in response. |
| `-fmode` | Filter set operator: `and`, `or` (default: or). |
| `-fr` | Filter regexp. |
| `-fs` | Filter HTTP response size. |
| `-ft` | Filter by milliseconds to first byte (e.g., `>100` or `<100`). |
| `-fw` | Filter by amount of words in response. |

### Input Options
| Flag | Description |
|------|-------------|
| `-D` | DirSearch wordlist compatibility mode (used with `-e`). |
| `-e` | Comma separated list of extensions to append to FUZZ. |
| `-enc` | Encoders for keywords (e.g., `FUZZ:urlencode b64encode`). |
| `-ic` | Ignore wordlist comments (default: false). |
| `-input-cmd` | Command producing the input (requires `--input-num`). |
| `-input-num` | Number of inputs to test with `--input-cmd` (default: 100). |
| `-input-shell` | Shell to be used for running command. |
| `-mode` | Multi-wordlist mode: `clusterbomb`, `pitchfork`, `sniper` (default: clusterbomb). |
| `-request` | File containing the raw HTTP request. |
| `-request-proto` | Protocol for raw request (default: https). |
| `-w` | Wordlist path and optional keyword (e.g., `/path:KEYWORD`). |

### Output Options
| Flag | Description |
|------|-------------|
| `-debug-log` | Write internal logging to specified file. |
| `-o` | Write output to file. |
| `-od` | Directory path to store matched results. |
| `-of` | Output format: `json`, `ejson`, `html`, `md`, `csv`, `ecsv`, `all` (default: json). |
| `-or` | Don't create output file if no results are found (default: false). |

## Notes
- Use `-ac` (Auto-Calibration) frequently to automatically filter out "soft 404s" or default response sizes that clutter results.
- The `FUZZ` keyword is the default placeholder, but custom keywords can be defined using `-w path:KEYWORD`.
- When using `-recursion`, the URL must end with the `FUZZ` keyword.