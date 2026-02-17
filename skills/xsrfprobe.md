---
name: xsrfprobe
description: Advanced Cross Site Request Forgery (CSRF/XSRF) audit and exploitation toolkit. It features a powerful crawling engine and systematic checks to detect CSRF vulnerabilities, bypasses, and generate proof-of-concept exploits. Use when performing web application security testing, vulnerability analysis, or specifically auditing forms and endpoints for missing or weak CSRF protections.
---

# xsrfprobe

## Overview
XSRFProbe is a comprehensive toolkit designed to automate the discovery and exploitation of CSRF vulnerabilities. It performs deep analysis of tokens, checks for common bypasses, and can automatically generate exploitable HTML forms for discovered vulnerabilities. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume xsrfprobe is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install xsrfprobe
```

## Common Workflows

### Basic scan of a single target
```bash
xsrfprobe -u http://example.com/profile/update
```

### Full site crawl and audit with custom cookies
```bash
xsrfprobe -u http://example.com --crawl -c "PHPSESSID=i837c5n83u4, security=low"
```

### Stealthy scan with delays and random user-agents
```bash
xsrfprobe -u http://example.com/admin --delay 2 --random-agent --quiet
```

### Vulnerability assessment with malicious PoC generation
```bash
xsrfprobe -u http://example.com/settings --malicious -o ./exploit_dir
```

## Complete Command Reference

```
xsrfprobe -u <url> [args]
```

### Required Arguments

| Flag | Description |
|------|-------------|
| `-u`, `--url URL` | Main URL to test |

### Optional Arguments

| Flag | Description |
|------|-------------|
| `-c`, `--cookie COOKIE` | Cookie value(s) for requests. Separate multiple cookies with commas (e.g., `-c "ID=123, SES=abc"`) |
| `-o`, `--output OUTPUT` | Output directory for stored files. Default is `output/` |
| `-d`, `--delay DELAY` | Time delay between requests in seconds. Default is 0 |
| `-q`, `--quiet` | Quiet mode. Reports only when vulnerabilities are found; minimal screen output |
| `-H`, `--headers HEADERS` | Comma separated list of custom headers (e.g., `--headers "X-Requested-With=Dumb"`) |
| `-v`, `--verbose` | Increase verbosity (use `-vv` for more detail) |
| `-t`, `--timeout TIMEOUT` | HTTP request timeout in seconds (integer or float, e.g., `10.0`) |
| `-E`, `--exclude EXCLUDE` | Comma separated list of paths/directories to exclude from scope |
| `--user-agent USER_AGENT` | Specify a single custom user-agent string |
| `--max-chars MAXCHARS` | Max character length for generated custom token values. Default is 6 |
| `--crawl` | Crawl the entire site and simultaneously test all discovered endpoints |
| `--no-analysis` | Skip Post-Scan Analysis of gathered tokens |
| `--malicious` | Generate a malicious CSRF Form for real-world exploit scenarios |
| `--skip-poc` | Skip PoC Form Generation for POST-based CSRF |
| `--no-verify` | Do not verify SSL certificates |
| `--display` | Print response headers during requests |
| `--update` | Update XSRFProbe to the latest version from GitHub |
| `--random-agent` | Use random user-agents for requests |
| `--version` | Display version information and exit |

## Notes
- When using `--crawl`, ensure you have permission to scan the entire domain as it will discover and test every link found.
- The tool is particularly effective at identifying if CSRF tokens are tied to a session or if they are static/predictable.
- Generated PoCs are saved in the directory specified by `-o` or the default `output/` folder.