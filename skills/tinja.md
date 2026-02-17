---
name: tinja
description: Analyze web pages for Template Injection (SSTI and CSTI) vulnerabilities. It supports 44 template engines across eight programming languages. Use when performing web application security assessments, vulnerability scanning, or specifically hunting for server-side or client-side template injection flaws.
---

# tinja

## Overview
TInjA (Template INJection Analyzer) is a comprehensive CLI tool designed to detect and verify template injection vulnerabilities. It supports a wide array of template engines and can perform both Server-Side Template Injection (SSTI) and Client-Side Template Injection (CSTI) analysis using a headless browser. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume tinja is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install tinja
```

## Common Workflows

### Scan a single URL
```bash
tinja url -u "http://example.com/search?q=test"
```

### Scan with custom headers and cookies
```bash
tinja url -u "http://example.com/profile" -H "Authorization: Bearer token" -c "session=12345"
```

### Enable Client-Side Template Injection (CSTI) scanning
```bash
tinja url -u "http://example.com" --csti
```

### Scan multiple URLs from a file and save report
```bash
tinja url -u "http://example.com" -u "http://test.com" --reportpath ./report.json
```

## Complete Command Reference

### Global Flags
These flags are available for all subcommands.

| Flag | Description |
|------|-------------|
| `--config string` | Set the path for a config file to be read |
| `-c, --cookie strings` | Add custom cookie(s) |
| `--csti` | Enable scanning for Client-Side Template Injections using a headless browser |
| `--escapereport` | Escape HTML special chars in the JSON report |
| `-H, --header strings` | Add custom header(s) |
| `-h, --help` | Help for tinja |
| `--precedinglength int` | Chars to memorize before a body reflection point (default 30) |
| `--proxycertpath string` | Set the path for the certificate of the proxy |
| `--proxyurl string` | Set the URL of the proxy |
| `-r, --ratelimit float` | Number of requests per second. 0 is infinite (default 0) |
| `--reportpath string` | Set the path for a report to be generated |
| `--subsequentlength int` | Chars to memorize after a body reflection point (default 30) |
| `--testheaders strings` | Headers to test (e.g., `--testheaders Host,Origin,X-Forwarded-For`) |
| `--timeout int` | Seconds until timeout (default 15) |
| `--useragentchrome` | Set Chrome as user-agent. Default is 'TInjA v[version]' |
| `-v, --verbosity int` | Output verbosity: 0=quiet, 1=default, 2=verbose (default 1) |
| `--version` | Version for tinja |

### Subcommands

#### `url`
Scan a single or multiple URLs.
- **Usage**: `tinja url [flags]`
- **Specific Flags**:
    - `-u, --url strings`: The URL(s) to scan.
    - `-m, --method string`: HTTP method to use (default "GET").
    - `-d, --data string`: Data to send in the request body.

#### `jsonl`
Scan targets defined in a JSONL (JSON Lines) file.
- **Usage**: `tinja jsonl [flags]`
- **Specific Flags**:
    - `-f, --file string`: Path to the JSONL file.

#### `raw`
Scan using a raw HTTP request file (e.g., a request captured in Burp Suite).
- **Usage**: `tinja raw [flags]`
- **Specific Flags**:
    - `-f, --file string`: Path to the raw request file.
    - `--scheme string`: Scheme to use (http/https) if not specified in file (default "https").

#### `help`
Help about any command.
- **Usage**: `tinja help [command]`

## Notes
- TInjA is highly effective because it uses polyglots and specific payloads for 44 different engines.
- When using `--csti`, ensure a compatible browser or environment is available for the headless browser to function.
- Use `--ratelimit` to avoid overwhelming target servers or triggering WAFs.