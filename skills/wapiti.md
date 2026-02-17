---
name: wapiti
description: Perform black-box security audits of web applications by crawling pages and fuzzing scripts/forms for vulnerabilities. Use when scanning for SQL injection, XSS, file inclusion, command execution, XXE, and SSRF. It is ideal for web application testing, vulnerability analysis, and automated reconnaissance of deployed web services.
---

# wapiti

## Overview
Wapiti is a web application vulnerability scanner that performs "black-box" scans. It crawls deployed web applications to identify scripts and forms, then acts as a fuzzer by injecting payloads to detect vulnerabilities like SQLi, XSS, and more. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume wapiti is already installed. If not, use:
```bash
sudo apt install wapiti
```

## Common Workflows

### Basic Scan
Scan a target website and generate a default HTML report:
```bash
wapiti -u http://example.com/ -o report_folder
```

### Authenticated Scan using Cookies
Use cookies from a browser (e.g., Firefox) to scan protected areas:
```bash
wapiti -u http://example.com/ -c firefox
```

### Targeted Module Scan
Scan only for XSS and SQL Injection with high verbosity:
```bash
wapiti -u http://example.com/ -m xss,sql -v 2
```

### API Scanning with Swagger
Scan an API using a Swagger/OpenAPI definition:
```bash
wapiti --swagger http://api.example.com/swagger.json -u http://api.example.com/
```

### Capture Cookies for Later Use
Use the utility to log in and save session cookies to a JSON file:
```bash
wapiti-getcookie -u http://example.com/login.php -c my_cookies.json --form-data "user=admin&pass=password"
```

## Complete Command Reference

### wapiti Options

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-u, --url URL` | Base URL for scan scope (default scope is folder) |
| `--swagger URI` | Swagger file URI (path or URL) to target API endpoints |
| `--data data` | Urlencoded data for POST request with base URL |
| `--scope {url,page,folder,subdomain,domain,punk}` | Set scan scope |
| `-m, --module MODULES_LIST` | List of modules to load |
| `--list-modules` | List available attack modules and exit |
| `-l, --level LEVEL` | Set attack level |
| `-p, --proxy PROXY_URL` | Set HTTP(S)/SOCKS proxy |
| `--tor` | Use Tor listener (127.0.0.1:9050) |
| `--mitm-port PORT` | Launch intercepting proxy on port instead of crawling |
| `--headless {no,hidden,visible}` | Use Firefox headless crawler (slower) |
| `--wait TIME` | Seconds to wait before analyzing page (headless only) |
| `-a, --auth-cred CREDENTIALS` | (DEPRECATED) Set HTTP auth credentials |
| `--auth-user USERNAME` | Set HTTP authentication username |
| `--auth-password PASSWORD` | Set HTTP authentication password |
| `--auth-method {basic,digest,ntlm}` | Set HTTP authentication method |
| `--form-cred CREDENTIALS` | (DEPRECATED) Set login form credentials |
| `--form-user USERNAME` | Set login form username |
| `--form-password PASSWORD` | Set login form password |
| `--form-url URL` | Set login form URL |
| `--form-data DATA` | Set login form POST data |
| `--form-enctype DATA` | Set enctype for form POST data |
| `--form-script FILENAME` | Use custom Python authentication plugin |
| `-c, --cookie COOKIE_FILE` | JSON cookie file or 'firefox'/'chrome' to load from browser |
| `-sf, --side-file SIDE_FILE` | Use Selenium IDE .side file for authentication |
| `-C, --cookie-value VALUE` | Set cookie(s) for every request (semicolon separated) |
| `--drop-set-cookie` | Ignore Set-Cookie headers from responses |
| `--skip-crawl` | Attack URLs from previous session without re-crawling |
| `--resume-crawl` | Resume stopped crawl even if attacks were performed |
| `--flush-attacks` | Flush attack history/vulnerabilities for current session |
| `--flush-session` | Flush all previous data for this target |
| `--store-session PATH` | Directory for attack history and session data |
| `--store-config PATH` | Directory for configuration databases |
| `-s, --start URL` | Add a URL to start scan with |
| `-x, --exclude URL` | Add a URL to exclude from scan |
| `-r, --remove PARAM` | Remove specific parameter from URLs |
| `--skip PARAM` | Skip attacking specific parameter(s) |
| `-d, --depth DEPTH` | Set exploration depth |
| `--max-links-per-page MAX` | Max in-scope links to extract per page |
| `--max-files-per-dir MAX` | Max pages to explore per directory |
| `--max-scan-time SEC` | Max seconds for the scan duration |
| `--max-attack-time SEC` | Max seconds for each attack module |
| `--max-parameters MAX` | Erase URLs/forms with more than MAX parameters |
| `-S, --scan-force FORCE` | Scan profile: paranoid, sneaky, polite, normal, aggressive, insane |
| `--tasks tasks` | Number of concurrent tasks for crawling |
| `--external-endpoint URL` | URL serving as endpoint for target |
| `--internal-endpoint URL` | URL serving as endpoint for attacker |
| `--endpoint URL` | URL serving as endpoint for both |
| `--dns-endpoint DOMAIN` | DNS endpoint for Log4Shell attack |
| `-t, --timeout SECONDS` | Request timeout |
| `-H, --header HEADER` | Set custom header for every request |
| `-A, --user-agent AGENT` | Set custom User-Agent |
| `--verify-ssl {0,1}` | Set SSL check (default 0) |
| `--color` | Colorize output |
| `-v, --verbose LEVEL` | Verbosity (0: quiet, 1: normal, 2: verbose) |
| `--log OUTPUT_PATH` | Output log file |
| `-f, --format FORMAT` | Output format: csv, html, json, txt, xml (Default: html) |
| `-o, --output PATH` | Output file or folder |
| `-dr, --detailed-report LVL` | Level 1: HTTP requests; Level 2: Requests and responses |
| `--no-bugreport` | Disable automatic bug reports on module failure |
| `--update` | Update attack modules and exit |
| `--cms CMS_LIST` | Target specific CMS: drupal, joomla, prestashop, spip, wp |
| `--wapp-url URL` | Custom URL for Wappalyzer DB update |
| `--wapp-dir PATH` | Custom directory for Wappalyzer DB |

### wapiti-getcookie Options

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `-u, --url URL` | First page to fetch for cookies |
| `-c, --cookie FILE` | Output JSON file for stored cookies |
| `-p, --proxy PROXY` | Proxy server address |
| `--tor` | Use Tor listener |
| `-a, --auth-cred CRED` | (DEPRECATED) Set HTTP auth credentials |
| `--auth-user USER` | Set HTTP username |
| `--auth-password PASS` | Set HTTP password |
| `--auth-method TYPE` | Auth type: basic, digest, ntlm |
| `--form-data DATA` | Login form POST data |
| `--form-enctype DATA` | Enctype for form POST data |
| `--headless MODE` | Use Firefox headless (no, hidden, visible) |
| `-A, --user-agent AGENT` | Custom User-Agent |
| `-H, --header HEADER` | Custom header |

## Notes
- Wapiti does not analyze source code; it is a purely functional black-box scanner.
- Vulnerabilities detected include: SQLi, XPath Injection, XSS, File Disclosure, Command Execution, XXE, CRLF Injection, Shellshock, and SSRF.
- It includes a "Nikto-style" check for dangerous files and a "DirBuster-style" directory brute-forcer.