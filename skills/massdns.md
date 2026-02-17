---
name: massdns
description: High-performance DNS stub resolver capable of resolving millions of domain names at extremely high speeds. Use when performing massive subdomain validation, large-scale DNS reconnaissance, or high-volume record lookups during the information gathering phase of a penetration test.
---

# massdns

## Overview
MassDNS is a high-performance DNS stub resolver designed for users who need to resolve a massive number of domain names (millions or billions). It can achieve speeds of over 350,000 names per second using public resolvers. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume massdns is already installed. If the command is missing:

```bash
sudo apt install massdns
```

## Common Workflows

### Basic Subdomain Validation
Resolve a list of subdomains using a resolvers file and output in simple text format:
```bash
massdns -r /usr/share/wordlists/dns/resolvers.txt -t A subdomains.txt -o S -w results.txt
```

### High-Speed Enumeration with Custom Record Type
Resolve MX records for a large list of domains with increased concurrent lookups:
```bash
massdns -r resolvers.txt -t MX -s 15000 domains.txt -o S > results.txt
```

### JSON Output for Tool Integration
Resolve A records and output in ndjson format for processing with `jq` or other tools:
```bash
massdns -r resolvers.txt subdomains.txt -o J -w results.json
```

### DNS Cache Snooping
Use non-recursive queries to check if a record exists in a specific resolver's cache:
```bash
massdns -r specific_resolver.txt domains.txt --norecurse -o S
```

## Complete Command Reference

```
massdns [options] [domainlist]
```

### General Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-b` | `--bindto` | Bind to IP address and port. (Default: 0.0.0.0:0) |
| | `--busy-poll` | Use busy-wait polling instead of epoll. |
| `-c` | `--resolve-count` | Number of resolves for a name before giving up. (Default: 50) |
| | `--drop-group` | Group to drop privileges to when running as root. (Default: nogroup) |
| | `--drop-user` | User to drop privileges to when running as root. (Default: nobody) |
| | `--filter` | Only output packets with the specified response code. |
| | `--flush` | Flush the output file whenever a response was received. |
| `-h` | `--help` | Show help message. |
| | `--ignore` | Do not output packets with the specified response code. |
| `-i` | `--interval` | Interval in ms to wait between multiple resolves of the same domain. (Default: 500) |
| `-l` | `--error-log` | Error log file path. (Default: /dev/stderr) |
| | `--norecurse` | Use non-recursive queries. Useful for DNS cache snooping. |
| `-o` | `--output` | Flags for output formatting (see Output Flags section). |
| | `--predictable` | Use resolvers incrementally. Useful for resolver tests. |
| | `--processes` | Number of processes to be used for resolving. (Default: 1) |
| `-q` | `--quiet` | Quiet mode. |
| | `--rcvbuf` | Size of the receive buffer in bytes. |
| | `--retry` | Unacceptable DNS response codes. (Default: REFUSED) |
| `-r` | `--resolvers` | Text file containing DNS resolvers (one per line). |
| | `--root` | Do not drop privileges when running as root. Not recommended. |
| `-s` | `--hashmap-size` | Number of concurrent lookups. (Default: 10000) |
| | `--sndbuf` | Size of the send buffer in bytes. |
| | `--status-format` | Format for real-time status updates: `json` or `ansi` (Default: ansi) |
| | `--sticky` | Do not switch the resolver when retrying. |
| | `--socket-count` | Socket count per process. (Default: 1) |
| `-t` | `--type` | Record type to be resolved (e.g., A, AAAA, PTR, MX, TXT). (Default: A) |
| | `--verify-ip` | Verify IP addresses of incoming replies. |
| `-w` | `--outfile` | Write to the specified output file instead of standard output. |

### Output Flags (`-o`)

| Flag | Description |
|------|-------------|
| `S` | Simple text output |
| `F` | Full text output |
| `B` | Binary output |
| `J` | ndjson output |

### Advanced Flags (for Simple Output Mode `S`)

| Flag | Description |
|------|-------------|
| `d` | Include records from the additional section. |
| `i` | Indent any reply record. |
| `l` | Separate replies using a line feed. |
| `m` | Only output reply records that match the question name. |
| `n` | Include records from the answer section. |
| `q` | Print the question. |
| `r` | Print the question with resolver IP address, Unix timestamp and return code prepended. |
| `s` | Separate packet sections using a line feed. |
| `t` | Include TTL and record class within the output. |
| `u` | Include records from the authority section. |

## Notes
- **Resolvers**: The quality of your results depends heavily on the `resolvers.txt` file. Using a mix of reliable public resolvers (Google, Cloudflare, Quad9) is recommended.
- **Performance**: Adjusting `-s` (hashmap-size) and `--processes` can significantly impact performance and network congestion.
- **Privileges**: By default, MassDNS drops privileges to `nobody:nogroup` if run as root. Use `--root` to override this (not recommended).