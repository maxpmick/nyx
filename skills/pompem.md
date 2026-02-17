---
name: pompem
description: Search for exploits and vulnerabilities across multiple major databases including PacketStorm, CXSecurity, ZeroDay, Vulners, NVD, and WPScan. Use when performing vulnerability research, exploit discovery, or automated reconnaissance to find publicly available proof-of-concepts and security advisories.
---

# pompem

## Overview
Pompem is an exploit and vulnerability finder designed to automate searches across the most important security databases. It facilitates the work of pentesting and forensics by aggregating results from PacketStorm security, CXSecurity, ZeroDay, Vulners, National Vulnerability Database (NVD), and the WPScan Vulnerability Database. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume pompem is already installed. If you get a "command not found" error:

```bash
sudo apt install pompem
```

Dependencies: python3, python3-requests.

## Common Workflows

### Basic search for a specific software
```bash
pompem --search "wordpress 5.0"
```

### Search for multiple keywords and export to HTML
```bash
pompem -s "apache,struts" --html
```

### Search and download exploit files
```bash
pompem -s "smb,eternalblue" --get
```

### Search and save results to a text file
```bash
pompem -s "fortios" --txt
```

## Complete Command Reference

```
pompem [Options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-s`, `--search <keyword,keyword...>` | Text for search. Multiple keywords can be separated by commas |
| `--txt` | Write the search results to a .txt file |
| `--html` | Write the search results to an .html file |
| `--update` | Upgrade the tool to the latest version |
| `-g`, `--get` | Download the found exploit files to the local system |

## Notes
- Pompem aggregates data from multiple external APIs; ensure you have internet connectivity when running searches.
- When using the `--get` flag, be cautious as you are downloading exploit code which may be flagged by antivirus or endpoint protection.
- The tool is particularly effective for identifying CVEs and associated exploit modules (like Metasploit scripts) hosted on public repositories.