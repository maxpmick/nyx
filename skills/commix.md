---
name: commix
description: Automated all-in-one OS command injection and exploitation tool. Use to find and exploit command injection vulnerabilities in web applications, parameters, or HTTP headers. Ideal for web application testing, penetration testing, and security research when command injection is suspected.
---

# commix

## Overview
Commix (short for [comm]and [i]njection e[x]ploiter) is an automated tool written in Python for detecting and exploiting command injection vulnerabilities. It automates the process of finding vulnerable parameters and provides a pseudo-terminal shell for post-exploitation. Category: Web Application Testing.

## Installation (if not already installed)
Assume commix is already installed. If not:
```bash
sudo apt install commix
```
Dependencies: metasploit-framework, python3, unicorn-magic.

## Common Workflows

### Basic POST injection test
```bash
commix --url="http://192.168.1.1/form.php" --data="id=1&name=test"
```

### Exploiting with Cookies and specific parameter
```bash
commix --url="http://target.tld/vuln.php?id=1" --cookie="PHPSESSID=12345" -p id
```

### High-level detection on HTTP Headers
```bash
commix --url="http://target.tld/index.php" --level=3
```

### Automated exploitation with Batch mode
```bash
commix --url="http://target.tld/search.php" --data="q=INJECT_HERE" --batch
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help and exit |
| `-v VERBOSE` | Verbosity level (0-4, Default: 0) |
| `--version` | Show version number and exit |
| `--output-dir=OUT` | Set custom output directory path |
| `-s SESSION_FILE` | Load session from a stored (.sqlite) file |
| `--flush-session` | Flush session files for current target |
| `--ignore-session` | Ignore results stored in session file |
| `-t TRAFFIC_FILE` | Log all HTTP traffic into a textual file |
| `--time-limit=TIME` | Run with a time limit in seconds |
| `--batch` | Never ask for user input, use default behavior |
| `--skip-heuristics` | Skip heuristic detection for code injection |
| `--codec=CODEC` | Force codec for character encoding (e.g., 'ascii') |
| `--charset=CHARSET` | Time-related injection charset (e.g., '0123456789abcdef') |
| `--check-internet` | Check internet connection before assessing target |
| `--answers=ANSWERS` | Set predefined answers (e.g., 'quit=N,follow=N') |

### Target Options
| Flag | Description |
|------|-------------|
| `-u URL`, `--url=URL` | Target URL |
| `--url-reload` | Reload target URL after command execution |
| `-l LOGFILE` | Parse target from HTTP proxy log file |
| `-m BULKFILE` | Scan multiple targets given in a textual file |
| `-r REQUESTFILE` | Load HTTP request from a file |
| `--crawl=DEPTH` | Crawl website starting from target URL (Default: 1) |
| `--crawl-exclude=REG` | Regexp to exclude pages from crawling |
| `-x SITEMAP_URL` | Parse target(s) from remote sitemap(.xml) file |
| `--method=METHOD` | Force usage of given HTTP method (e.g., 'PUT') |

### Request Options
| Flag | Description |
|------|-------------|
| `-d DATA`, `--data=..` | Data string to be sent through POST |
| `--host=HOST` | HTTP Host header |
| `--referer=REFERER` | HTTP Referer header |
| `--user-agent=AGENT` | HTTP User-Agent header |
| `--random-agent` | Use a randomly selected HTTP User-Agent header |
| `--param-del=PDEL` | Set character for splitting parameter values |
| `--cookie=COOKIE` | HTTP Cookie header |
| `--cookie-del=CDEL` | Set character for splitting cookie values |
| `-H HEADER` | Extra header (e.g., 'X-Forwarded-For: 127.0.0.1') |
| `--headers=HEADERS` | Extra headers (e.g., 'Accept-Language: fr\nETag: 123') |
| `--proxy=PROXY` | Use a proxy to connect to the target URL |
| `--tor` | Use the Tor network |
| `--tor-port=PORT` | Set Tor proxy port (Default: 8118) |
| `--tor-check` | Check to see if Tor is used properly |
| `--auth-url=URL` | Login panel URL |
| `--auth-data=DATA` | Login parameters and data |
| `--auth-type=TYPE` | HTTP authentication type (Basic, Digest, Bearer) |
| `--auth-cred=CRED` | HTTP authentication credentials (e.g., 'admin:admin') |
| `--abort-code=CODE` | Abort on specific HTTP error code(s) |
| `--ignore-code=CODE` | Ignore specific HTTP error code(s) |
| `--force-ssl` | Force usage of SSL/HTTPS |
| `--ignore-proxy` | Ignore system default proxy settings |
| `--ignore-redirects` | Ignore redirection attempts |
| `--timeout=TIMEOUT` | Seconds to wait before timeout (Default: 30) |
| `--retries=RETRIES` | Retries when connection timeouts (Default: 3) |
| `--drop-set-cookie` | Ignore Set-Cookie header from response |

### Enumeration Options
| Flag | Description |
|------|-------------|
| `--all` | Retrieve everything |
| `--current-user` | Retrieve current user name |
| `--hostname` | Retrieve current hostname |
| `--is-root` | Check if current user has root privileges |
| `--is-admin` | Check if current user has admin privileges |
| `--sys-info` | Retrieve system information |
| `--users` | Retrieve system users |
| `--passwords` | Retrieve system users password hashes |
| `--privileges` | Retrieve system users privileges |
| `--ps-version` | Retrieve PowerShell's version number |

### File Access Options
| Flag | Description |
|------|-------------|
| `--file-read=FILE` | Read a file from the target host |
| `--file-write=FILE` | Write to a file on the target host |
| `--file-upload=FILE` | Upload a file on the target host |
| `--file-dest=PATH` | Host's absolute filepath to write/upload to |

### Injection Options
| Flag | Description |
|------|-------------|
| `-p TEST_PARAM` | Testable parameter(s) |
| `--skip=SKIP_PARAM` | Skip testing for given parameter(s) |
| `--suffix=SUFFIX` | Injection payload suffix string |
| `--prefix=PREFIX` | Injection payload prefix string |
| `--technique=TECH` | Specify injection technique(s) to use |
| `--skip-technique` | Specify injection technique(s) to skip |
| `--maxlen=MAXLEN` | Max length of output for time-based injection |
| `--delay=DELAY` | Seconds to delay between each HTTP request |
| `--time-sec=TIMESEC` | Seconds to delay the OS response |
| `--tmp-path=PATH` | Set absolute path of web server's temp directory |
| `--web-root=ROOT` | Set web server document root (e.g., '/var/www') |
| `--alter-shell=SH` | Use an alternative os-shell (e.g., 'Python') |
| `--os-cmd=OS_CMD` | Execute a single operating system command |
| `--os=OS` | Force back-end OS ('Windows' or 'Unix') |
| `--tamper=TAMPER` | Use script(s) for tampering injection data |
| `--msf-path=PATH` | Set local path where Metasploit is installed |

### Detection Options
| Flag | Description |
|------|-------------|
| `--level=LEVEL` | Level of tests to perform (1-3, Default: 1) |
| `--skip-calc` | Skip math calculation during detection |
| `--skip-empty` | Skip testing parameters with empty values |
| `--failed-tries=N` | Set number of failed tries in file-based technique |
| `--smart` | Perform thorough tests only if positive heuristic(s) |

### Miscellaneous Options
| Flag | Description |
|------|-------------|
| `--shellshock` | Use the 'shellshock' injection module |
| `--ignore-dependencies`| Ignore required third-party library dependencies |
| `--list-tampers` | Display list of available tamper scripts |
| `--alert=ALERT` | Run host OS command when injection is found |
| `--no-logging` | Disable logging to a file |
| `--purge` | Safely remove all content from commix data directory |
| `--skip-waf` | Skip heuristic detection of WAF/IPS protection |
| `--mobile` | Imitate smartphone via User-Agent |
| `--offline` | Work in offline mode |
| `--wizard` | Simple wizard interface for beginners |
| `--disable-coloring` | Disable console output coloring |

## Notes
- **Pseudo-Terminal**: Once an injection is confirmed, Commix offers a pseudo-shell. Use `reverse_tcp` or `bind_tcp` within this shell for better stability.
- **WAF Bypass**: Use `--tamper` scripts or `--skip-waf` if the target is behind a firewall.
- **Permissions**: File read/write operations require appropriate permissions on the target server's filesystem. Use `--tmp-path` if the default web root is not writable.