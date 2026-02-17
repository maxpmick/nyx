---
name: dnstracer
description: Trace DNS queries to the source by determining where a specific DNS server gets its information for a hostname and following the chain back to the authoritative servers. Use when performing DNS reconnaissance, troubleshooting DNS resolution paths, identifying misconfigured name servers, or mapping the hierarchy of DNS authority during information gathering.
---

# dnstracer

## Overview
dnstracer determines where a given Domain Name Server (DNS) gets its information from for a given hostname and follows the chain of DNS servers back to the authoritative answer. It provides a clear view of the delegation path from the root or a specific server down to the target record. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume dnstracer is already installed. If you get a "command not found" error:

```bash
sudo apt install dnstracer
```

## Common Workflows

### Basic trace to authoritative source
```bash
dnstracer example.com
```

### Trace starting from the Root Servers
```bash
dnstracer -s . example.com
```

### Trace a specific record type with verbose output
```bash
dnstracer -q mx -v example.com
```

### Comprehensive trace with overview and no IPv6
```bash
dnstracer -o -4 -r 5 example.com
```

## Complete Command Reference

```
dnstracer [options] [host]
```

| Flag | Description |
|------|-------------|
| `-c` | Disable local caching (default: enabled) |
| `-C` | Enable negative caching (default: disabled) |
| `-o` | Enable overview of received answers (default: disabled) |
| `-q <querytype>` | Query-type to use for the DNS requests (default: A) |
| `-r <retries>` | Amount of retries for DNS requests (default: 3) |
| `-s <server>` | Use this server for the initial request (default: localhost). If `.` is specified, A.ROOT-SERVERS.NET will be used. |
| `-t <timeout>` | Limit time to wait per try (maximum timeout) |
| `-v` | Verbose output |
| `-S <ip address>` | Use this source address for the requests |
| `-4` | Don't query IPv6 servers |

## Notes
- Using `-s .` is highly recommended for a "clean" trace that starts from the global root hints rather than your local ISP's recursive resolver.
- The `-o` (overview) flag is useful for a summary of which servers provided authoritative vs. non-authoritative answers at a glance.
- If you are on a network without IPv6 connectivity, use `-4` to prevent timeouts or delays when the tool attempts to contact IPv6-only name servers.