---
name: httpx-toolkit
description: Fast and multi-purpose HTTP toolkit for probing multiple elements of a target list. Use for service discovery, technology fingerprinting, status code checking, and title grabbing during the reconnaissance and vulnerability analysis phases of a penetration test.
---

# httpx-toolkit

## Overview
httpx-toolkit is a high-performance HTTP toolkit designed for reliability and speed. It allows for multiple probers to run simultaneously, supporting features like technology detection, status code mapping, and smart auto-fallback from HTTPS to HTTP. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install httpx-toolkit
```

## Common Workflows

### Basic probing for live web services
```bash
cat domains.txt | httpx-toolkit -status-code -title -tech-detect
```

### Filtering for specific status codes and saving results
```bash
httpx-toolkit -l subdomains.txt -mc 200,403 -o live_web.txt
```

### Probing a CIDR range for specific ports
```bash
httpx-toolkit -l network_range.txt -p 80,443,8080,8443 -sc -location
```

### Extracting specific data using regex
```bash
cat urls.txt | httpx-toolkit -er "ID:[0-9]+" -silent
```

## Complete Command Reference

### Input Options
| Flag | Description |
|------|-------------|
| `-l`, `-list <string>` | Input file containing list of hosts to process |
| `-request <string>` | File containing raw request |

### Probes
| Flag | Description |
|------|-------------|
| `-sc`, `-status-code` | Display Status Code |
| `-td`, `-tech-detect` | Display wappalyzer based technology detection |
| `-cl`, `-content-length` | Display Content-Length |
| `-server`, `-web-server` | Display Server header |
| `-ct`, `-content-type` | Display Content-Type header |
| `-lc`, `-line-count` | Display Response body line count |
| `-wc`, `-word-count` | Display Response body word count |
| `-rt`, `-response-time` | Display the response time |
| `-title` | Display page title |
| `-location` | Display Location header |
| `-method` | Display Request method |
| `-websocket` | Display server using websocket |
| `-ip` | Display Host IP |
| `-cname` | Display Host cname |
| `-cdn` | Display if CDN in use |
| `-probe` | Display probe status |

### Matchers
| Flag | Description |
|------|-------------|
| `-mc`, `-match-code <string>` | Match response with given status code (e.g., `-mc 200,302`) |
| `-ml`, `-match-length <string>` | Match response with given content length |
| `-ms`, `-match-string <string>` | Match response with given string |
| `-mr`, `-match-regex <string>` | Match response with specific regex |
| `-er`, `-extract-regex <string>` | Display response content with matched regex |
| `-mlc`, `-match-line-count <string>` | Match Response body line count |
| `-mwc`, `-match-word-count <string>` | Match Response body word count |
| `-mfc`, `-match-favicon <string[]>` | Match response with specific favicon |

### Filters
| Flag | Description |
|------|-------------|
| `-fc`, `-filter-code <string>` | Filter response with given status code (e.g., `-fc 403,401`) |
| `-fl`, `-filter-length <string>` | Filter response with given content length |
| `-fs`, `-filter-string <string>` | Filter response with specific string |
| `-fe`, `-filter-regex <string>` | Filter response with specific regex |
| `-flc`, `-filter-line-count <string>` | Filter Response body line count |
| `-fwc`, `-filter-word-count <string>` | Filter Response body word count |
| `-ffc`, `-filter-favicon <string[]>` | Filter response with specific favicon |

### Rate Limit
| Flag | Description |
|------|-------------|
| `-t`, `-threads <int>` | Number of threads (default 50) |
| `-rl`, `-rate-limit <int>` | Max requests per second (default 150) |

### Miscellaneous
| Flag | Description |
|------|-------------|
| `-favicon` | Probes for favicon ("favicon.ico") and display pythonic hash |
| `-tls-grab` | Perform TLS(SSL) data grabbing |
| `-tls-probe` | Send HTTP probes on the extracted TLS domains |
| `-csp-probe` | Send HTTP probes on the extracted CSP domains |
| `-pipeline` | HTTP1.1 Pipeline probe |
| `-http2` | HTTP2 probe |
| `-vhost` | VHOST Probe |
| `-p`, `-ports <string[]>` | Port to scan (nmap syntax: e.g., 1,2-10,11) |
| `-path <string>` | File or comma separated paths to request |
| `-paths <string>` | File or comma separated paths to request (deprecated) |

### Output
| Flag | Description |
|------|-------------|
| `-o`, `-output <string>` | File to write output results |
| `-sr`, `-store-response` | Store http response to output directory |
| `-srd`, `-store-response-dir <string>` | Store http response to custom directory |
| `-csv` | Store output in CSV format |
| `-json` | Store output in JSONL(ines) format |
| `-irr`, `-include-response` | Include http request/response in JSON output (-json only) |
| `-include-chain` | Include redirect http chain in JSON output (-json only) |
| `-store-chain` | Include http redirect chain in responses (-sr only) |

### Configurations
| Flag | Description |
|------|-------------|
| `-r`, `-resolvers <string[]>` | List of custom resolvers (file or comma separated) |
| `-allow <string[]>` | Allowed list of IP/CIDR's to process |
| `-deny <string[]>` | Denied list of IP/CIDR's to process |
| `-random-agent` | Enable Random User-Agent (default true) |
| `-H`, `-header <string[]>` | Custom Header to send with request |
| `-http-proxy`, `-proxy <string>` | HTTP Proxy, e.g., http://127.0.0.1:8080 |
| `-unsafe` | Send raw requests skipping golang normalization |
| `-resume` | Resume scan using resume.cfg |
| `-fr`, `-follow-redirects` | Follow HTTP redirects |
| `-maxr`, `-max-redirects <int>` | Max number of redirects to follow per host (default 10) |
| `-fhr`, `-follow-host-redirects` | Follow redirects on the same host |
| `-vhost-input` | Get a list of vhosts as input |
| `-x <string>` | Request methods to use (e.g., 'all' for all HTTP methods) |
| `-body <string>` | Post body to include in HTTP request |
| `-s`, `-stream` | Stream mode - process input without sorting |
| `-sd`, `-skip-dedupe` | Disable dedupe input items (stream mode only) |
| `-pa`, `-probe-all-ips` | Probe all IPs associated with same host |
| `-ldp`, `-leave-default-ports` | Leave default HTTP/HTTPS ports (e.g., :80, :443) |

### Debug
| Flag | Description |
|------|-------------|
| `-silent` | Silent mode |
| `-v`, `-verbose` | Verbose mode |
| `-version` | Display version |
| `-nc`, `-no-color` | Disable color in output |
| `-debug` | Debug mode |
| `-debug-req` | Show all sent requests |
| `-debug-resp` | Show all received responses |
| `-stats` | Display scan statistic |

### Optimizations
| Flag | Description |
|------|-------------|
| `-nf`, `-no-fallback` | Display both probed protocol (HTTPS and HTTP) |
| `-nfs`, `-no-fallback-scheme` | Probe with input protocol scheme |
| `-maxhr`, `-max-host-error <int>` | Max error count per host before skipping (default 30) |
| `-ec`, `-exclude-cdn` | Skip full port scans for CDNs (only checks 80, 443) |
| `-retries <int>` | Number of retries |
| `-timeout <int>` | Timeout in seconds (default 5) |
| `-rsts`, `-response-size-to-save <int>` | Max response size to save in bytes |
| `-rstr`, `-response-size-to-read <int>` | Max response size to read in bytes |

## Notes
- This tool is packaged as `httpx-toolkit` on Kali to avoid conflict with the `python3-httpx` library.
- It uses the `retryablehttp` library to handle WAFs and network instability via retries and backoffs.
- Smart auto-fallback will try HTTPS first and then fallback to HTTP if the former fails.