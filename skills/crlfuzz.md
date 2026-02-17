---
name: crlfuzz
description: Scan for CRLF (Carriage Return Line Feed) injection vulnerabilities in web applications. Use when performing web application security testing, vulnerability scanning, or bug bounty hunting to identify potential HTTP Response Splitting or header injection flaws.
---

# crlfuzz

## Overview
CRLFuzz is a fast, multithreaded tool written in Go designed to identify CRLF injection vulnerabilities. It works by injecting payloads into various parts of an HTTP request and checking if the response headers are manipulated, which could lead to HTTP Response Splitting, Cross-Site Scripting (XSS), or cache poisoning. Category: Web Application Testing.

## Installation (if not already installed)
Assume crlfuzz is already installed. If the command is missing:

```bash
sudo apt install crlfuzz
```

## Common Workflows

### Scan a single URL
```bash
crlfuzz -u "http://example.com"
```

### Scan multiple targets from a file with high concurrency
```bash
crlfuzz -l targets.txt -c 50 -o results.txt
```

### Scan using POST requests with data
```bash
crlfuzz -u "http://example.com/login" -X POST -d "user=admin&pass=password"
```

### Pipe targets from another tool (like subfinder or httpx)
```bash
cat subdomains.txt | httpx -silent | crlfuzz -s
```

## Complete Command Reference

CRLFuzz accepts input via stdin (buffers) or via command-line options.

### Usage
```bash
[buffers] | crlfuzz [options]
crlfuzz [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-u, --url <URL>` | Define a single target URL to fuzz |
| `-l, --list <FILE>` | Fuzz multiple URLs contained within a text file |
| `-X, --method <METHOD>` | Specify the HTTP request method to use (default: `GET`) |
| `-o, --output <FILE>` | File path to save the discovery results |
| `-d, --data <DATA>` | Define request data for POST/PUT requests |
| `-H, --header <HEADER>` | Pass a custom header to the target (can be used multiple times) |
| `-x, --proxy <URL>` | Use a proxy for fuzzing (e.g., `http://127.0.0.1:8080`) |
| `-c, --concurrent <i>` | Set the concurrency level for parallel scanning (default: `20`) |
| `-s, --silent` | Silent mode: only output found vulnerabilities |
| `-v, --verbose` | Verbose mode: show detailed progress and request information |
| `-V, --version` | Show current CRLFuzz version |
| `-h, --help` | Display the help menu |

## Notes
- **Safety**: Use with caution. The tool sends payloads that attempt to manipulate HTTP headers; ensure you have authorization to test the target.
- **Piping**: The tool is designed to fit into automation pipelines, making it highly effective when combined with subdomain enumeration and live-host discovery tools.
- **False Positives**: While fast, always manually verify findings to ensure the CRLF injection is exploitable in the specific application context.