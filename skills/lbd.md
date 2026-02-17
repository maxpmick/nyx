---
name: lbd
description: Detect if a target domain uses DNS or HTTP load balancing. Use when performing web application reconnaissance, infrastructure analysis, or information gathering to identify if a target is served by multiple backend servers or a Content Delivery Network (CDN).
---

# lbd

## Overview
lbd (Load Balancing Detector) is a shell script that uses various techniques to detect if a given domain uses load balancing. It checks for DNS load balancing (multiple IP addresses for a single host) and HTTP load balancing by analyzing Server headers and Date headers in HTTP responses. Category: Reconnaissance / Information Gathering / Web Application Testing.

## Installation (if not already installed)
Assume lbd is already installed. If the command is missing:

```bash
sudo apt install lbd
```

## Common Workflows

### Basic Load Balancer Detection
The most common usage is providing a domain name to check for both DNS and HTTP load balancing.
```bash
lbd example.com
```

### Checking a specific port
You can specify a port if the web service is not running on the default port 80.
```bash
lbd example.com 443
```

### Analyzing results
- **DNS-Loadbalancing**: Found if the hostname resolves to multiple IP addresses.
- **HTTP-Loadbalancing [Server]**: Found if the `Server` HTTP header changes across multiple requests.
- **HTTP-Loadbalancing [Date]**: Found if the `Date` HTTP header shows time differences that suggest different backend clocks.

## Complete Command Reference

```bash
lbd <target> [port]
```

| Argument | Description |
|----------|-------------|
| `<target>` | The domain name or IP address to test. |
| `[port]` | Optional port number (defaults to 80). |

### Underlying Tool (host) Options
lbd relies on the `host` command for DNS queries. While lbd is a wrapper script, the `host` utility it uses supports the following flags (though lbd typically manages these internally):

| Flag | Description |
|------|-------------|
| `-a` | Equivalent to `-v -t ANY` |
| `-A` | Like `-a` but omits RRSIG, NSEC, NSEC3 |
| `-c <class>` | Specifies query class for non-IN data |
| `-C` | Compares SOA records on authoritative nameservers |
| `-d` | Equivalent to `-v` (verbose) |
| `-l` | Lists all hosts in a domain using AXFR |
| `-m <flag>` | Set memory debugging flag (trace\|record\|usage) |
| `-N <ndots>` | Changes the number of dots allowed before root lookup |
| `-p <port>` | Specifies the port on the server to query |
| `-r` | Disables recursive processing |
| `-R <number>` | Specifies number of retries for UDP packets |
| `-s` | A SERVFAIL response should stop query |
| `-t <type>` | Specifies the query type (A, AAAA, MX, etc.) |
| `-T` | Enables TCP/IP mode |
| `-U` | Enables UDP mode |
| `-v` | Enables verbose output |
| `-V` | Print version number and exit |
| `-w` | Wait forever for a reply |
| `-W <time>` | Specifies how long to wait for a reply |
| `-4` | Use IPv4 query transport only |
| `-6` | Use IPv6 query transport only |

## Notes
- lbd is a proof-of-concept tool and may yield false positives, especially with CDNs or complex WAF setups.
- It primarily detects differences in HTTP headers (`Server`, `Date`, `Diff`, and `Set-Cookie`).
- If a site uses a single load balancer (like a single F5 or HAProxy instance) that masks backend headers perfectly, lbd might report "NOT FOUND".