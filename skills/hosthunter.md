---
name: hosthunter
description: Discover and extract hostnames associated with target IP addresses using OSINT techniques to map virtual hostnames. Use when performing infrastructure reconnaissance, identifying virtual hosts, mapping attack surfaces, or gathering hostnames from a list of IP addresses during penetration testing.
---

# hosthunter

## Overview
HostHunter is a reconnaissance tool used to efficiently discover and extract hostnames providing a set of target IP addresses. It utilizes simple OSINT techniques to map IP addresses with virtual hostnames and can generate CSV or TXT reports. It also includes beta functionality for capturing screenshots of discovered web applications. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume hosthunter is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt update
sudo apt install hosthunter
```

Dependencies include: chromium-driver, python3, python3-fake-useragent, python3-openssl, python3-requests, python3-selenium, and python3-urllib3.

## Common Workflows

### Scan a single IP address
```bash
hosthunter -t 192.168.1.100 -f txt -o results.txt
```

### Bulk scan from a file with CSV output
```bash
hosthunter targets.txt -f csv -o assessment_results.csv
```

### Extract hostnames and capture screenshots
```bash
hosthunter targets.txt --screen-capture -o web_discovery.csv
```
Note: This requires `chromium-driver` to be properly configured.

### Quick version check
```bash
hosthunter -V
```

## Complete Command Reference

```
usage: hosthunter [-h] [-f FORMAT] [-o OUTPUT] [-sc] [-t TARGET] [-V] [targets]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `targets` | Sets the path of the target IPs file (one IP per line). |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-f`, `--format FORMAT` | Choose between `CSV` and `TXT` output file formats. |
| `-o`, `--output OUTPUT` | Sets the path of the output file where results will be saved. |
| `-sc`, `--screen-capture` | Capture a screenshot of any associated Web Applications (Beta functionality). |
| `-t`, `--target TARGET` | Scan a single IP address instead of a file. |
| `-V`, `--version` | Displays the current version of HostHunter. |

## Notes
- The screen capture functionality (`-sc`) is currently in beta and relies on Selenium and Chromium Driver.
- HostHunter is most effective when targets are hosting multiple virtual hosts on the same IP address.
- Output files are useful for piping into other tools or importing into spreadsheets for analysis.