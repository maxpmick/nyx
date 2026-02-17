---
name: humble
description: A fast, security-oriented HTTP headers analyzer. It checks for missing security headers, deprecated/insecure headers, and compliance with OWASP Secure Headers Project best practices. Use when performing web application reconnaissance, vulnerability analysis of web server configurations, or auditing HTTP response headers for security hardening.
---

# humble

## Overview
`humble` is a security-oriented HTTP headers analyzer. It identifies misconfigurations, missing security headers, and fingerprinting information in web server responses. It maps findings against OWASP best practices and can export results in multiple formats. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume `humble` is already installed. If you encounter errors, install it via:

```bash
sudo apt install humble
```

## Common Workflows

### Detailed Analysis of a URL
```bash
humble -u https://example.com -r
```
Analyzes the URL and provides a detailed report including the raw HTTP response headers.

### Exporting Findings to PDF
```bash
humble -u https://example.com -o pdf -of example_report
```
Analyzes the site and saves a detailed security report as `example_report.pdf`.

### CI/CD Integration
```bash
humble -u https://example.com -cicd
```
Outputs a concise JSON summary with totals and a security grade, ideal for automated pipelines.

### Checking Fingerprint Statistics
```bash
humble -f nginx
```
Shows fingerprinting statistics and common headers associated with the term "nginx".

### Analyzing Headers from a Local File
```bash
humble -if headers.txt
```
Analyzes a local file containing HTTP response headers (format `Header: Value`).

## Complete Command Reference

```
humble [-h] [-a] [-b] [-c] [-cicd] [-df] [-e [TESTSSL_PATH]] [-f [FINGERPRINT_TERM]] [-g] [-grd] [-H REQUEST_HEADER] [-if INPUT_FILE] [-l {es}] [-lic] [-o {csv,html,json,pdf,txt,xlsx,xml}] [-of OUTPUT_FILE] [-op OUTPUT_PATH] [-p PROXY] [-r] [-s [SKIP_HEADERS ...]] [-u URL] [-ua USER_AGENT] [-v]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-a` | Shows statistics of the performed analysis; if `-u` is omitted, statistics will be global |
| `-b` | Shows overall findings (brief mode); if omitted, detailed findings are shown |
| `-c` | Checks URL response HTTP headers for compliance with OWASP 'Secure Headers Project' best practices |
| `-cicd` | Shows only analysis summary, totals, and grade in JSON; suitable for CI/CD |
| `-df` | Do not follow redirects; if omitted, the last redirection in the chain is analyzed |
| `-e [TESTSSL_PATH]` | Shows only TLS/SSL checks; requires the path to `testssl.sh` |
| `-f [TERM]` | Shows fingerprint statistics; if `TERM` (e.g., 'Google') is omitted, the top 20 results are shown |
| `-g` | Shows guidelines for enabling security HTTP response headers on popular frameworks, servers, and services |
| `-grd` | Shows the checks used to grade an analysis, along with advice for improvement |
| `-H REQUEST_HEADER` | Adds a custom header to the request (must be in double quotes). Can be used multiple times |
| `-if INPUT_FILE` | Analyzes a local file containing HTTP response headers and values separated by ': ' |
| `-l {es}` | Defines the language for display (default is English; `es` for Spanish) |
| `-lic` | Shows the license for 'humble', along with permissions and limitations |
| `-o {format}` | Exports analysis to file. Formats: `csv`, `html`, `json`, `pdf`, `txt`, `xlsx`, `xml` |
| `-of OUTPUT_FILE` | Specifies the filename for the exported analysis |
| `-op OUTPUT_PATH` | Specifies the absolute path for the exported analysis |
| `-p PROXY` | Use a proxy (e.g., `http://127.0.0.1:8080`). Defaults to port 8080 if not specified |
| `-r` | Shows HTTP response headers and a detailed analysis; `-b` takes priority if both used |
| `-s [HEADERS ...]` | Skips 'deprecated/insecure' and 'missing' checks for the specified headers (space-separated) |
| `-u URL` | The URL to analyze (Scheme, host, and port). E.g., `https://example.com:443` |
| `-ua USER_AGENT` | User-Agent ID from `additional/user_agents.txt`. `0` shows all, `1` is default |
| `-v`, `--version` | Checks for updates |

## Notes
- **Grading**: Use `-grd` to understand how `humble` calculates the security grade of a site.
- **Redirects**: By default, `humble` follows redirects and analyzes the final destination. Use `-df` to stop at the first response.
- **Custom Headers**: When using `-H`, ensure the header and value are enclosed in double quotes, e.g., `-H "Authorization: Bearer token"`.