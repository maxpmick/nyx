---
name: wpscan
description: Scan remote WordPress installations to identify security issues, vulnerable plugins/themes, and perform user enumeration or password attacks. Use when performing web application reconnaissance, vulnerability analysis, or penetration testing specifically targeting WordPress-based websites.
---

# wpscan

## Overview
WPScan is a black box WordPress security scanner. It identifies WordPress versions, installed plugins and themes, and checks them against a database of known vulnerabilities. It also supports user enumeration and password brute-forcing via various interfaces. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume wpscan is already installed. If you get a "command not found" error:

```bash
sudo apt install wpscan
```

## Common Workflows

### Basic Scan and Plugin Enumeration
Scan a target and identify popular plugins:
```bash
wpscan --url http://example.com --enumerate p
```

### Comprehensive Vulnerability Scan
Enumerate vulnerable plugins, vulnerable themes, and users:
```bash
wpscan --url http://example.com -e vp,vt,u --api-token YOUR_TOKEN
```
*Note: An API token from wpscan.com is required to see specific vulnerability data.*

### Password Brute Force
Attack a specific user with a wordlist via the wp-login interface:
```bash
wpscan --url http://example.com --usernames admin --passwords /usr/share/wordlists/rockyou.txt --password-attack wp-login
```

### Stealthy Enumeration
Use a random user-agent and passive detection modes to reduce the footprint:
```bash
wpscan --url http://example.com --stealthy
```

## Complete Command Reference

### General Options

| Flag | Description |
|------|-------------|
| `--url URL` | The URL of the blog to scan (http or https). **Mandatory** unless update/help/version used. |
| `-h`, `--help` | Display simple help and exit. |
| `--hh` | Display full help and exit. |
| `--version` | Display the version and exit. |
| `-v`, `--verbose` | Verbose mode. |
| `--[no-]banner` | Whether or not to display the banner (Default: true). |
| `-o`, `--output FILE` | Output results to a file. |
| `-f`, `--format FORMAT` | Output format: `cli-no-colour`, `cli`, `cli-no-color`, `json`. |
| `--detection-mode MODE` | `mixed` (default), `passive`, `aggressive`. |
| `--user-agent`, `--ua VALUE` | Set a custom User-Agent string. |
| `--random-user-agent`, `--rua` | Use a random user-agent for each scan. |
| `--stealthy` | Alias for `--random-user-agent --detection-mode passive --plugins-version-detection passive`. |
| `--force` | Do not check if the target is running WordPress or returns a 403. |
| `--[no-]update` | Whether or not to update the Database. |
| `--api-token TOKEN` | The WPScan API Token to display vulnerability data. |

### Request Options

| Flag | Description |
|------|-------------|
| `--http-auth login:pass` | HTTP Basic Authentication. |
| `-t`, `--max-threads VALUE` | Max threads to use (Default: 5). |
| `--throttle MS` | Milliseconds to wait between requests. Sets threads to 1. |
| `--request-timeout SEC` | Request timeout in seconds (Default: 60). |
| `--connect-timeout SEC` | Connection timeout in seconds (Default: 30). |
| `--disable-tls-checks` | Disable SSL/TLS verification and downgrade to TLS1.0+. |
| `--proxy protocol://IP:port` | Use a proxy (e.g., `socks5://127.0.0.1:9050`). |
| `--proxy-auth login:pass` | Proxy authentication. |
| `--cookie-string COOKIE` | Cookie string (format: `cookie1=value1; cookie2=value2`). |
| `--cookie-jar FILE` | File to read/write cookies (Default: `/tmp/wpscan/cookie_jar.txt`). |

### Enumeration Options (`-e`, `--enumerate [OPTS]`)

Multiple options can be separated by commas. Default: `ap, cb`.

| Option | Description |
|------|-------------|
| `vp` | Vulnerable plugins |
| `ap` | All plugins |
| `p` | Popular plugins |
| `vt` | Vulnerable themes |
| `at` | All themes |
| `t` | Popular themes |
| `tt` | Timthumbs |
| `cb` | Config backups |
| `dbe` | Database exports |
| `u[range]` | User IDs range (e.g., `u1-5`). Default: `1-10`. |
| `m[range]` | Media IDs range (e.g., `m1-15`). Requires "Plain" permalinks. |

### Detection & Filtering Options

| Flag | Description |
|------|-------------|
| `--wp-content-dir DIR` | Custom wp-content directory name. |
| `--wp-plugins-dir DIR` | Custom plugins directory name. |
| `--plugins-detection MODE` | Mode for plugin enumeration: `mixed`, `passive` (default), `aggressive`. |
| `--plugins-version-detection MODE` | Mode for plugin versioning: `mixed` (default), `passive`, `aggressive`. |
| `--exclude-content-based REGEX` | Exclude responses matching regex (headers and body). |
| `--exclude-usernames REGEX` | Exclude usernames matching regex/string. |

### Password Attack Options

| Flag | Description |
|------|-------------|
| `-P`, `--passwords FILE` | Path to password wordlist. |
| `-U`, `--usernames LIST` | List of usernames (e.g., `'admin'`, `'a1,a2'`, or path to file). |
| `--password-attack ATTACK` | Force attack type: `wp-login`, `xmlrpc`, `xmlrpc-multicall`. |
| `--multicall-max-passwords N` | Max passwords per XMLRPC request (Default: 500). |
| `--login-uri URI` | Custom login page URI (Default: `/wp-login.php`). |

## Notes
- **API Token**: Without a free API token from wpscan.com, the tool will identify plugins but will not report if they are vulnerable.
- **WAF/IPS**: Aggressive scanning or high thread counts often trigger Web Application Firewalls. Use `--throttle` or `--stealthy` if blocked.
- **XML-RPC**: If `xmlrpc.php` is enabled on the target, it is usually the fastest method for password brute-forcing.