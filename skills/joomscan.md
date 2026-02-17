---
name: joomscan
description: Scan Joomla-based websites to identify the version, detect known core vulnerabilities, enumerate components, and find sensitive files or misconfigurations. Use when performing web application security assessments, vulnerability analysis, or reconnaissance specifically targeting the Joomla Content Management System (CMS).
---

# joomscan

## Overview
OWASP Joomla Vulnerability Scanner (JoomScan) is a specialized tool written in Perl designed to identify security flaws in Joomla CMS installations. It automates the detection of versions, vulnerable extensions, administrative pages, and exposed directories. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume joomscan is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install joomscan
```

## Common Workflows

### Standard Vulnerability Scan
Perform a basic scan to identify the Joomla version, core vulnerabilities, and common interesting files.
```bash
joomscan -u http://example.com/joomla
```

### Comprehensive Component Enumeration
Scan for installed components and extensions to expand the attack surface.
```bash
joomscan -u http://example.com -ec
```

### Stealthy Scan with Random User-Agent
Use a random User-Agent string to bypass simple signature-based WAF filters.
```bash
joomscan -u http://example.com -r
```

### Scanning through a Proxy
Route traffic through a local proxy (like Burp Suite) for manual inspection.
```bash
joomscan -u http://example.com --proxy http://127.0.0.1:8080
```

## Complete Command Reference

```
joomscan [options]
```

### Target Options
| Flag | Description |
|------|-------------|
| `--url`, `-u <URL>` | The Joomla URL/domain to scan. |
| `--enumerate-components`, `-ec` | Try to enumerate installed Joomla components. |

### Request Options
| Flag | Description |
|------|-------------|
| `--cookie <String>` | Set a custom cookie string for the session. |
| `--user-agent`, `-a <User-Agent>` | Use the specified User-Agent string. |
| `--random-agent`, `-r` | Use a random User-Agent for every request. |
| `--timeout <Time-Out>` | Set the request timeout in seconds. |
| `--proxy=PROXY` | Use a proxy to connect. Supports `http`, `https`, and `socks`. |

### Information Options
| Flag | Description |
|------|-------------|
| `--about` | Display information about the authors. |
| `--help`, `-h` | Show the help screen and exit. |
| `--version` | Output the current version and exit. |

## Notes
- **Reports**: JoomScan automatically generates reports in both HTML and TXT formats. These are typically stored in `/usr/share/joomscan/reports/` or the current working directory under a `reports/` folder.
- **Detection Scope**: The tool checks for `robots.txt` entries, directory listing vulnerabilities, administrative interfaces, backup files, log files, and sensitive configuration files (e.g., `config.php.x`).
- **Dependencies**: Requires Perl and several Perl modules (`libwww-perl`, `libregexp-common-perl`, `liblwp-protocol-https-perl`).