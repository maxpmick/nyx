---
name: gobuster
description: Brute-force tool for discovering URIs (directories/files), DNS subdomains, Virtual Host names, Open Amazon S3 buckets, Open Google Cloud buckets, and TFTP servers. Use when performing web reconnaissance, subdomain discovery, cloud storage enumeration, or fuzzing during penetration testing.
---

# gobuster

## Overview
Gobuster is a high-performance tool written in Go used to brute-force various targets. It supports directory/file enumeration, DNS subdomain discovery (with wildcard support), VHost identification, and cloud bucket discovery. Category: Web Application Testing / Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume gobuster is already installed. If you get a "command not found" error:

```bash
sudo apt install gobuster
```

## Common Workflows

### Directory and File Enumeration
```bash
gobuster dir -u http://10.10.10.121/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,html,txt
```

### DNS Subdomain Discovery
```bash
gobuster dns -d example.com -w /usr/share/wordlists/dns/subdomains-top1million-5000.txt
```

### Virtual Host Enumeration
```bash
gobuster vhost -u http://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt
```

### S3 Bucket Enumeration
```bash
gobuster s3 -w bucket-names.txt
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `--help`, `-h` | Show help |
| `--version`, `-v` | Print the version |

### dir Mode Options
Used for directory and file enumeration.

| Flag | Description |
|------|-------------|
| `-u`, `--url` | The target URL |
| `-w`, `--wordlist` | Path to the wordlist |
| `-x`, `--extensions` | File extensions to search for (e.g., php,asp,txt) |
| `-f`, `--add-slash` | Append / to each request |
| `-c`, `--cookies` | Cookies to use for the requests |
| `-e`, `--expanded` | Expanded mode, print full URLs |
| `-k`, `--no-tls-validation` | Skip TLS certificate verification |
| `-n`, `--no-status` | Don't print HTTP status codes |
| `-P`, `--password` | Password for Basic Auth |
| `-U`, `--username` | Username for Basic Auth |
| `-s`, `--status-codes` | Positive status codes (default "200,204,301,302,307,401,403") |
| `-b`, `--status-codes-blacklist` | Negative status codes (will override positive status codes) |
| `-t`, `--threads` | Number of concurrent threads (default 10) |
| `-a`, `--useragent` | Set the User-Agent string |
| `-r`, `--follow-redirect` | Follow HTTP redirects |
| `-H`, `--headers` | Specify HTTP headers, -H 'Header1: val1' -H 'Header2: val2' |
| `-p`, `--proxy` | Proxy to use for requests [http(s)://host:port] |
| `-o`, `--output` | Output file to write results to |

### dns Mode Options
Used for DNS subdomain enumeration.

| Flag | Description |
|------|-------------|
| `-d`, `--domain` | The target domain |
| `-w`, `--wordlist` | Path to the wordlist |
| `-r`, `--resolver` | Use custom DNS server (host:port) |
| `-c`, `--show-cname` | Show CNAME records (cannot be used with '-i' option) |
| `-i`, `--show-ips` | Show IP addresses |
| `-t`, `--threads` | Number of concurrent threads (default 10) |
| `--wildcard` | Force operation even if wildcard DNS is found |
| `-o`, `--output` | Output file to write results to |

### vhost Mode Options
Used for Virtual Host enumeration.

| Flag | Description |
|------|-------------|
| `-u`, `--url` | The target URL |
| `-w`, `--wordlist` | Path to the wordlist |
| `-c`, `--cookies` | Cookies to use for the requests |
| `-k`, `--no-tls-validation` | Skip TLS certificate verification |
| `-t`, `--threads` | Number of concurrent threads (default 10) |
| `-a`, `--useragent` | Set the User-Agent string |
| `-r`, `--follow-redirect` | Follow HTTP redirects |
| `-H`, `--headers` | Specify HTTP headers |
| `-o`, `--output` | Output file to write results to |

### fuzz Mode Options
Replaces the keyword `FUZZ` in URL, Headers, or Request Body.

| Flag | Description |
|------|-------------|
| `-u`, `--url` | The target URL |
| `-w`, `--wordlist` | Path to the wordlist |
| `-b`, `--excluded-status-codes` | Excluded status codes |
| `-m`, `--method` | HTTP method to use (default "GET") |
| `-d`, `--data` | HTTP Post data |

### s3 Mode Options
Used for AWS S3 bucket enumeration.

| Flag | Description |
|------|-------------|
| `-w`, `--wordlist` | Path to the wordlist |
| `-m`, `--max-retries` | Maximum retries on connection errors (default 3) |
| `-t`, `--threads` | Number of concurrent threads (default 10) |
| `-v`, `--verbose` | Verbose output (show all attempts) |

### gcs Mode Options
Used for Google Cloud Storage bucket enumeration.

| Flag | Description |
|------|-------------|
| `-w`, `--wordlist` | Path to the wordlist |
| `-t`, `--threads` | Number of concurrent threads (default 10) |

### tftp Mode Options
Used for TFTP server enumeration.

| Flag | Description |
|------|-------------|
| `-s`, `--server` | The target TFTP server |
| `-w`, `--wordlist` | Path to the wordlist |
| `-t`, `--threads` | Number of concurrent threads (default 10) |
| `--timeout` | Timeout for TFTP requests (default 1s) |

## Notes
- Gobuster does not support recursive directory brute-forcing.
- For `vhost` mode, it is often necessary to use the IP address as the URL parameter while setting the `Host` header via the wordlist.
- Use `-k` when dealing with self-signed certificates on HTTPS targets.