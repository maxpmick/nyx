---
name: wfuzz
description: Brute-force web applications to discover hidden resources, directories, scripts, and parameters. Use for directory busting, parameter fuzzing (GET/POST), authentication brute-forcing, and testing for injections (SQLi, XSS) by replacing keywords with payload values.
---

# wfuzz

## Overview
Wfuzz is a flexible web application security tool designed to brute-force resources and parameters. It allows for complex fuzzing scenarios by replacing `FUZZ` keywords in URLs, headers, or post data with values from various payloads. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume wfuzz is already installed. If not:
```bash
sudo apt install wfuzz
```

## Common Workflows

### Directory and File Discovery
Fuzz for common directories and files, hiding 404 responses:
```bash
wfuzz -c -z file,/usr/share/wfuzz/wordlist/general/common.txt --hc 404 http://example.com/FUZZ
```

### Parameter Fuzzing (GET)
Test for hidden parameters or potential injections in a query string:
```bash
wfuzz -z file,/usr/share/wordlists/wfuzz/general/common.txt http://example.com/search.php?FUZZ=test
```

### POST Data Brute-forcing
Brute-force a login form using a wordlist for passwords:
```bash
wfuzz -c -z file,/usr/share/wordlists/rockyou.txt -d "username=admin&password=FUZZ" --hc 200 http://example.com/login.php
```

### Authenticated Fuzzing with Headers
Fuzz a protected directory using a session cookie:
```bash
wfuzz -c -w /usr/share/wordlists/dirb/common.txt -H "Cookie: sessionid=12345" --hc 404 http://example.com/FUZZ
```

## Complete Command Reference

### Basic Usage
- `FUZZ`, `FUZ2Z`, ..., `FUZnZ`: Keywords replaced by payload values.
- `FUZZ{baseline_value}`: Sets a baseline for filtering based on the first request.

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show basic help |
| `--help` | Show advanced help |
| `--filter-help` | Show filter language specification |
| `--version` | Show version details |
| `-e <type>` | List available encoders, payloads, iterators, printers, or scripts |
| `--recipe <file>` | Read options from a recipe file |
| `--dump-recipe <file>` | Print current options as a recipe |
| `--oF <file>` | Save results to a file for later consumption by wfuzz payload |
| `-c` | Output with colors |
| `-v` | Verbose information |
| `-f <file,printer>` | Store results in file using specified printer |
| `-o <printer>` | Show results using specified printer |
| `--interact` | Capture key presses to interact with the program (beta) |
| `--dry-run` | Print requests without sending them |
| `--prev` | Print previous HTTP requests |
| `--efield <expr>` | Show language expression with payload |
| `--field <expr>` | Show only the language expression, hide payload |

### Network Options
| Flag | Description |
|------|-------------|
| `-p <addr>` | Use Proxy (ip:port:type). Type: SOCKS4, SOCKS5, or HTTP |
| `-t <N>` | Number of concurrent connections (default: 10) |
| `-s <N>` | Time delay between requests in seconds (default: 0) |
| `-R <depth>` | Recursive path discovery maximum depth |
| `-D <depth>` | Maximum link depth level |
| `-L`, `--follow` | Follow HTTP redirections |
| `--ip <host:port>` | Connect to specific IP instead of URL host |
| `-Z` | Scan mode: ignore connection errors |
| `--req-delay <N>` | Max request time in seconds (default: 90) |
| `--conn-delay <N>` | Max connection phase time in seconds (default: 90) |

### Payload and Request Options
| Flag | Description |
|------|-------------|
| `-u <url>` | Specify the target URL |
| `-m <iterator>` | Iterator for combining payloads (default: product) |
| `-z <payload>` | Specify payload: `name[,parameter][,encoder]` |
| `--zP <params>` | Arguments for the specified payload |
| `--zD <default>` | Default parameter for the specified payload |
| `--zE <encoder>` | Encoder for the specified payload |
| `--slice <filter>` | Filter payload elements |
| `-w <wordlist>` | Alias for `-z file,wordlist` |
| `-V <alltype>` | Brute-force all parameters (allvars/allpost) |
| `-X <method>` | Specify HTTP method (e.g., HEAD, POST, FUZZ) |
| `-b <cookie>` | Specify a cookie (repeat for multiple) |
| `-d <postdata>` | Use POST data |
| `-H <header>` | Use header (e.g., "Host: FUZZ") |
| `--basic auth` | Basic authentication "user:pass" |
| `--ntlm auth` | NTLM authentication "user:pass" |
| `--digest auth` | Digest authentication "user:pass" |

### Scripting and Plugins
| Flag | Description |
|------|-------------|
| `-A` | Alias for `-v -c` |
| `--AA` | Alias for `-v -c --script=default,verbose` |
| `--AAA` | Alias for `-v -c --script=default,verbose,discover` |
| `--no-cache` | Disable plugins cache |
| `--script=` | Run default scripts |
| `--script=<plugins>` | Run specific scripts or categories (comma separated) |
| `--script-help=<plugins>` | Show help about scripts |
| `--script-args <args>` | Provide arguments to scripts (e.g., `grep.regex="..."`) |

### Filtering Options
| Flag | Description |
|------|-------------|
| `--hc <N[,N]>` | Hide responses with specified HTTP code |
| `--hl <N[,N]>` | Hide responses with specified line count |
| `--hw <N[,N]>` | Hide responses with specified word count |
| `--hh <N[,N]>` | Hide responses with specified character count |
| `--sc <N[,N]>` | Show responses with specified HTTP code |
| `--sl <N[,N]>` | Show responses with specified line count |
| `--sw <N[,N]>` | Show responses with specified word count |
| `--sh <N[,N]>` | Show responses with specified character count |
| `--ss <regex>` | Show responses matching regex in content |
| `--hs <regex>` | Hide responses matching regex in content |
| `--filter <expr>` | Show/hide using filter expression (Use `BBB` for baseline) |
| `--prefilter <expr>` | Filter items before fuzzing |

## Notes
- Use `-e payloads` to see all available payload types (file, range, list, etc.).
- Use `-e encoders` to see available encoding options like `urlencode`, `base64`, or `md5`.
- Multiple payloads can be used by defining multiple `-z` or `-w` flags and using `FUZZ`, `FUZ2Z`, etc. in the request.