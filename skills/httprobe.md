---
name: httprobe
description: Take a list of domains and probe for working HTTP and HTTPS servers. Use this tool during the reconnaissance and information gathering phase to identify which discovered subdomains or hosts are actually running web services, helping to narrow down the attack surface for web application testing.
---

# httprobe

## Overview
httprobe is a lightweight utility designed to take a list of domains and probe them for working HTTP and HTTPS servers. It helps security researchers quickly identify live web assets from a large list of potential hostnames. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume httprobe is already installed. If the command is not found, install it using:

```bash
sudo apt install httprobe
```

## Common Workflows

### Basic probing of a domain list
```bash
cat domains.txt | httprobe
```
Reads domains from a file and outputs the working URLs (e.g., http://example.com and https://example.com).

### High concurrency probing with custom timeout
```bash
cat subdomains.txt | httprobe -c 50 -t 5000
```
Sets the concurrency to 50 and the timeout to 5 seconds (5000ms).

### Probing for non-standard ports
```bash
cat domains.txt | httprobe -p http:8080 -p https:8443
```
Probes the default ports plus additional custom ports for both protocols.

### Preferring HTTPS and skipping defaults
```bash
cat domains.txt | httprobe -prefer-https -s -p https:8443
```
Only attempts HTTP if HTTPS fails, and skips the standard 80/443 probes in favor of a custom port.

## Complete Command Reference

httprobe accepts a list of domains via `stdin`.

| Flag | Type | Description |
|------|------|-------------|
| `-c` | int | Set the concurrency level (split equally between HTTPS and HTTP requests) (default 20) |
| `-method` | string | HTTP method to use (default "GET") |
| `-p` | value | Add additional probe in the format `proto:port` (can be used multiple times) |
| `-prefer-https` | switch | Only try plain HTTP if HTTPS fails |
| `-s` | switch | Skip the default probes (http:80 and https:443) |
| `-t` | int | Timeout in milliseconds (default 10000) |
| `-h` | switch | Show help message |

## Notes
- The tool is designed to be used in a pipeline (e.g., after `subfinder` or `assetfinder`).
- By default, it probes both `http://` on port 80 and `https://` on port 443.
- When using `-p`, you must specify the protocol and port, such as `-p http:8000`.