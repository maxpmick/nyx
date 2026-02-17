---
name: uniscan
description: Scan web applications for LFI, RFI, RCE, and other vulnerabilities. Use when performing web application security assessments, vulnerability scanning, fingerprinting servers, or automating dork-based discovery via Google and Bing.
---

# uniscan

## Overview
Uniscan is a vulnerability scanner designed to identify Remote File Inclusion (RFI), Local File Inclusion (LFI), and Remote Command Execution (RCE) vulnerabilities. It also supports web/server fingerprinting, directory/file brute forcing, and search engine dorking. Category: Web Application Testing.

## Installation (if not already installed)
Assume uniscan is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install uniscan
```

## Common Workflows

### Comprehensive Scan of a Single URL
Perform directory, file, robots/sitemap, dynamic, and static checks:
```bash
uniscan -u https://www.example.com/ -qweds
```

### Server and Web Fingerprinting
Identify server software, versions, and web technologies used:
```bash
uniscan -u https://www.example.com/ -gj
```

### Batch Scanning in Background
Scan a list of URLs from a file and run the process in the background:
```bash
uniscan -f sites.txt -bqweds
```

### Search Engine Dorking (Bing/Google)
Find potential targets using specific search queries:
```bash
uniscan -i "ip:192.168.1.1"
uniscan -o "inurl:php?id="
```

## Complete Command Reference

### General Options

| Flag | Description |
|------|-------------|
| `-h` | Display help message |
| `-u <url>` | Target URL (e.g., https://www.example.com/) |
| `-f <file>` | Path to a file containing a list of URLs to scan |
| `-b` | Run Uniscan in the background |

### Enumeration and Fingerprinting

| Flag | Description |
|------|-------------|
| `-g` | Enable Web fingerprinting |
| `-j` | Enable Server fingerprinting |
| `-q` | Enable Directory checks (brute force/discovery) |
| `-w` | Enable File checks |
| `-e` | Enable robots.txt and sitemap.xml checks |

### Vulnerability Scanning

| Flag | Description |
|------|-------------|
| `-d` | Enable Dynamic checks (LFI, RFI, RCE, etc.) |
| `-s` | Enable Static checks |
| `-r` | Enable Stress checks |

### Search Engine Dorks

| Flag | Description |
|------|-------------|
| `-i <dork>` | Perform a Bing search with the specified dork |
| `-o <dork>` | Perform a Google search with the specified dork |

### GUI Version
Uniscan also includes a graphical user interface which can be launched with:
```bash
uniscan-gui
```

## Notes
- **Dynamic Checks (`-d`)**: These involve active interaction with parameters to find injection-style vulnerabilities.
- **Static Checks (`-s`)**: These typically analyze the page source and headers for information disclosure.
- **Stress Checks (`-r`)**: Use with caution as these may impact the availability of the target service.
- **Dependencies**: Requires Perl and Moose (`libmoose-perl`). If running the GUI, `perl-tk` is required.