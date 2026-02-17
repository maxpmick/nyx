---
name: eyewitness
description: Rapid web application triage tool designed to take screenshots of websites, provide server header info, and identify default credentials. Use when performing reconnaissance, web application testing, or vulnerability analysis to quickly visualize a large number of HTTP/HTTPS services from a list of URLs, Nmap XML, or Nessus output.
---

# eyewitness

## Overview
EyeWitness is a triage tool that automates the process of visiting web services to capture screenshots and gather metadata. It helps penetration testers quickly identify interesting targets within a large attack surface by providing a visual report. Category: Reconnaissance / Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume EyeWitness is already installed. If not, use:

```bash
sudo apt install eyewitness
```

## Common Workflows

### Screenshot a list of URLs
```bash
eyewitness -f urls.txt -d ./report_dir --no-prompt
```

### Process Nmap XML output
```bash
eyewitness -x scan_results.xml --web -d nmap_report
```

### Single URL capture with custom timeout
```bash
eyewitness --single https://example.com --timeout 15 -d single_report
```

### Resume a previous session
```bash
eyewitness --resume /path/to/ew.db
```

## Complete Command Reference

### Protocols
| Flag | Description |
|------|-------------|
| `--web` | HTTP Screenshot using Selenium |

### Input Options
| Flag | Description |
|------|-------------|
| `-f <Filename>` | Line-separated file containing URLs to capture |
| `-x <Filename.xml>` | Nmap XML or .Nessus file |
| `--single <URL>` | Single URL/Host to capture |
| `--no-dns` | Skip DNS resolution when connecting to websites |

### Timing Options
| Flag | Description |
|------|-------------|
| `--timeout <seconds>` | Max seconds to wait while requesting a page (Default: 7) |
| `--jitter <seconds>` | Randomize URLs and add a random delay between requests |
| `--delay <seconds>` | Delay between opening the navigator and taking the screenshot |
| `--threads <number>` | Number of threads to use for file-based input |
| `--max-retries <num>` | Max retries on timeouts |

### Report Output Options
| Flag | Description |
|------|-------------|
| `-d <Directory>` | Directory name for report output |
| `--results <num>` | Number of Hosts per page of report |
| `--no-prompt` | Don't prompt to open the report automatically |

### Web Options
| Flag | Description |
|------|-------------|
| `--user-agent <UA>` | User Agent to use for all requests |
| `--difference <num>` | Difference threshold for user agent request comparison (Default: 50) |
| `--proxy-ip <IP>` | IP of web proxy to go through |
| `--proxy-port <port>` | Port of web proxy to go through |
| `--proxy-type <type>` | Proxy type (socks5/http) |
| `--show-selenium` | Show display for selenium (non-headless) |
| `--resolve` | Resolve IP/Hostname for targets |
| `--add-http-ports <ports>` | Comma-separated additional ports to assume are http (e.g. '8018,8028') |
| `--add-https-ports <ports>`| Comma-separated additional ports to assume are https (e.g. '8018,8028') |
| `--only-ports <ports>` | Comma-separated list of exclusive ports to use (e.g. '80,8080') |
| `--prepend-https` | Prepend http:// and https:// to URLs without either |
| `--selenium-log-path <path>`| Selenium geckodriver log path |
| `--cookies <k1=v1,k2=v2>` | Additional cookies to add to the request |

### Resume Options
| Flag | Description |
|------|-------------|
| `--resume <ew.db>` | Path to db file if you want to resume a previous session |

## Notes
- EyeWitness automatically detects if the input file (`-f`) is a text list, Nmap XML, or Nessus XML.
- The tool uses `geckodriver` and Firefox by default for rendering.
- Reports are generated in HTML format, making them easy to browse and share.
- When using `--prepend-https`, the tool will attempt to connect to both HTTP and HTTPS versions of the provided hostnames.