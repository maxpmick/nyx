---
name: findomain
description: Fast and comprehensive subdomain enumeration tool. Supports data sourcing from multiple APIs, brute-forcing, port scanning, HTTP status checks, and screenshotting. Use during the reconnaissance phase of a penetration test to discover an organization's external attack surface and monitor for new subdomains.
---

# findomain

## Overview
Findomain is a high-performance subdomain enumerator designed for speed and completeness. It integrates with various APIs, supports monitoring modes with database integration (PostgreSQL), and can perform active checks like port scanning and screenshotting using Chromium. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume findomain is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install findomain
```
*Note: Screenshotting features require `chromium` to be installed.*

## Common Workflows

### Basic Enumeration
Search for subdomains and show only those that resolve to an IP:
```bash
findomain -t example.com -r
```

### Enumeration with IP Discovery and Output
Find subdomains, show their IP addresses, and save results to `example.com.txt`:
```bash
findomain -t example.com -i -o
```

### Brute-force Mode
Use a custom wordlist to discover subdomains via brute-force:
```bash
findomain -t example.com -w /usr/share/wordlists/dirb/common.txt -r
```

### Comprehensive Recon (Port Scan & Screenshots)
Find subdomains, check HTTP status, scan ports 0-1000, and take screenshots:
```bash
findomain -t example.com --http-status --pscan --screenshots ./screenshots
```

## Complete Command Reference

### Target & Input Options
| Flag | Description |
|------|-------------|
| `-t, --target <TARGET>` | Target host domain |
| `-f, --file <FILES>` | Use a list of subdomains written in a file as input |
| `--stdin` | Read from stdin instead of files or arguments |
| `--import-subdomains <FILE>` | Import subdomains from one or multiple files (one per line) |
| `-n, --no-discover` | Prevent searching; useful when only importing/processing external data |

### Output & Filtering Options
| Flag | Description |
|------|-------------|
| `-r, --resolved` | Show/write only resolved subdomains |
| `-i, --ip` | Show/write the IP address of resolved subdomains |
| `-o, --output` | Write to auto-generated file (`target.txt`) |
| `-u, --unique-output <NAME>` | Write results to a specified filename |
| `-q, --quiet` | Remove informative messages; show only errors or results |
| `-v, --verbose` | Enable verbose mode for debugging |
| `--filter <STRING>` | Filter subdomains containing specific strings |
| `--exclude <STRING>` | Exclude subdomains containing specific strings |
| `--exclude-sources <SOURCES>` | Exclude specific APIs (e.g., certspotter, crtsh, facebook, spyse, virustotalapikey) |

### Active Scanning & Resolution
| Flag | Description |
|------|-------------|
| `-w, --wordlist <FILE>` | Enable brute-force mode using the specified wordlist |
| `-x, --as-resolver` | Use Findomain as a resolver for a list of domains in a file |
| `--enable-dot` | Enable DNS over TLS for resolving |
| `--ipv6-only` | Perform IPv6 lookups only |
| `--no-wildcards` | Disable wildcard detection during resolution |
| `--resolvers <FILE>` | Path to file(s) containing custom DNS IPs |
| `--resolver-timeout <SEC>` | Timeout for the resolver (Default: 1) |
| `--double-dns-check` | Re-check IPs with trusted resolvers to avoid false positives |
| `--validate` | Validate all subdomains from a specified file |

### HTTP & Screenshot Options
| Flag | Description |
|------|-------------|
| `--http-status` | Check the HTTP status of subdomains |
| `--http-timeout <SEC>` | HTTP status check timeout (Default: 5) |
| `--http-retries <INT>` | Number of retries for HTTP checks (Default: 1) |
| `--max-http-redirects <INT>` | Max redirects to follow (Default: 0) |
| `-s, --screenshots <PATH>` | Path to save screenshots of active websites |
| `--sandbox` | Enable Chrome/Chromium sandbox (Do not use if running as root) |
| `--no-resolve` | Disable pre-screenshotting jobs (HTTP check/IP discovery) |
| `--ua <FILE>` | Path to file containing user agent strings |

### Port Scanning Options
| Flag | Description |
|------|-------------|
| `--pscan` | Enable port scanner |
| `--iport <PORT>` | Initial port to scan (Default: 0) |
| `--lport <PORT>` | Last port to scan (Default: 1000) |
| `--tcp-connect-timeout <MS>` | TCP connection timeout in milliseconds (Default: 2000) |

### Database & Monitoring Options
| Flag | Description |
|------|-------------|
| `-m, --monitoring-flag` | Activate Findomain monitoring mode |
| `--postgres-user <USER>` | Postgresql username |
| `--postgres-password <PASS>` | Postgresql password |
| `--postgres-host <HOST>` | Postgresql host |
| `--postgres-port <PORT>` | Postgresql port |
| `--postgres-database <DB>` | Postgresql database |
| `--query-database` | Search subdomains already discovered in the DB |
| `-j, --jobname <NAME>` | Use a database identifier for specific jobs |
| `--query-jobname` | Extract all subdomains from DB matching a job name |
| `--reset-database` | Delete all data from the database |
| `--no-monitor` | Disable monitoring mode while saving data to DB |
| `--mtimeout` | Insert data even if webhook returns a timeout error |
| `--aempty` | Send webhook alerts even if no new subdomains are found |

### Performance & Threading
| Flag | Description |
|------|-------------|
| `--lightweight-threads <INT>` | Threads for IP discovery and HTTP checks (Default: 50) |
| `--screenshots-threads <INT>` | Threads for taking screenshots (Default: 10) |
| `--parallel-ip-ports-scan <INT>` | Number of IPs port-scanned simultaneously (Default: 10) |
| `--tcp-connect-threads <INT>` | Threads for TCP connections (Nmap `--min-rate` equivalent, Default: 500) |
| `--rate-limit <SEC>` | Rate limit in seconds for each target during enumeration |
| `--randomize` | Randomize target reading from files |

## Notes
- **API Keys**: To maximize results, configure API keys for services like Glassdoor, Facebook, and SecurityTrails in the configuration file (default: `findomain.toml`).
- **Root Usage**: The `--sandbox` flag for screenshots is disabled by default because Chromium cannot run as root with a sandbox. If running as a non-privileged user, enable `--sandbox` for better security.
- **External Tools**: The `--external-subdomains` flag allows integration with `amass` and `subfinder` if they are installed on the system.