---
name: sublist3r
description: Enumerate subdomains of websites using OSINT by aggregating results from search engines (Google, Bing, Baidu) and specialized services (Netcraft, VirusTotal, DNSdumpster). Use when performing reconnaissance, asset discovery, or bug hunting to map out a target's attack surface.
---

# sublist3r

## Overview
Sublist3r is a Python-based tool designed to enumerate subdomains of websites using Open Source Intelligence (OSINT). It aggregates results from many search engines and databases and includes an integrated Subbrute module for brute-force discovery. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume sublist3r is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install sublist3r
```

## Common Workflows

### Basic Enumeration
Search for subdomains using all default passive engines:
```bash
sublist3r -d example.com
```

### Enumeration with Brute Force
Enable the Subbrute module to find subdomains that might not be indexed by search engines:
```bash
sublist3r -d example.com -b
```

### Targeted Engine Search
Limit the search to specific engines (e.g., Google and Bing) and save to a file:
```bash
sublist3r -d example.com -e google,bing -o subdomains.txt
```

### Real-time Verbose Discovery with Port Scanning
Display results in real-time and check for open HTTP/HTTPS ports:
```bash
sublist3r -d example.com -v -p 80,443
```

## Complete Command Reference

```bash
sublist3r [-h] -d DOMAIN [-b [BRUTEFORCE]] [-p PORTS] [-v [VERBOSE]] [-t THREADS] [-e ENGINES] [-o OUTPUT] [-n]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-d`, `--domain DOMAIN` | **Required.** The domain name to enumerate subdomains for. |
| `-b`, `--bruteforce` | Enable the subbrute bruteforce module to increase discovery potential. |
| `-p`, `--ports PORTS` | Scan the discovered subdomains against specified comma-separated TCP ports (e.g., `80,443,8080`). |
| `-v`, `--verbose` | Enable verbosity and display results in real-time as they are found. |
| `-t`, `--threads THREADS` | Number of threads to use for the subbrute bruteforce module. |
| `-e`, `--engines ENGINES` | Specify a comma-separated list of search engines to use (e.g., `google,bing,yahoo,ask,baidu,netcraft,virustotal,threatcrowd,dnsdumpster,reversedns`). |
| `-o`, `--output OUTPUT` | Save the discovered subdomains to a specified text file. |
| `-n`, `--no-color` | Disable colored output in the terminal. |

## Notes
- Sublist3r utilizes several passive sources: Google, Yahoo, Bing, Baidu, Ask, Netcraft, Virustotal, ThreatCrowd, DNSdumpster, and ReverseDNS.
- The tool is particularly effective for bug bounty hunters and penetration testers during the initial information gathering phase.
- Using the `-b` (bruteforce) flag significantly increases the time required but often finds subdomains that passive OSINT misses.