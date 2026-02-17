---
name: maltego-teeth
description: Execute offensive security transforms within Maltego, integrating tools like Nmap, SQLMap, and Metasploit. Use when performing visual reconnaissance, automated vulnerability scanning, or mapping attack surfaces during the information gathering and exploitation phases of a penetration test.
---

# maltego-teeth

## Overview
Maltego Teeth is a collection of offensive transforms for Maltego. It allows users to bridge the gap between Maltego's data visualization and active security tools, enabling the execution of Nmap scans, SQLMap injections, and Metasploit modules directly against entities in the Maltego graph. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume maltego-teeth is already installed. If the transforms are missing or the command is not found:

```bash
sudo apt update
sudo apt install maltego-teeth
```

**Dependencies:** maltego, metasploit-framework, nmap, python3, python3-adns, python3-bs4, python3-easygui, python3-levenshtein, python3-mechanize, python3-metaconfig, python3-msgpack, sqlmap.

## Common Workflows

### Integrating Transforms into Maltego
Maltego Teeth is primarily used by importing its configuration into the Maltego GUI.
1. Open Maltego.
2. Go to the **Import** tab.
3. Select **Import Configuration**.
4. Navigate to the Maltego Teeth configuration file (typically located in `/usr/share/maltego-teeth/` or similar package directory).

### Running an Nmap Scan from a Graph Entity
1. Right-click an **IP Address** or **Domain** entity in the Maltego graph.
2. Navigate to the **Teeth** transform set.
3. Select an Nmap transform (e.g., `To Nmap (Quick Scan)`).
4. The results (ports, services) will be populated as new entities linked to the original target.

### Automated SQL Injection Testing
1. Identify a **URL** entity in the graph.
2. Run the `To SQLMap` transform.
3. Maltego Teeth invokes SQLMap in the background and returns findings such as database types or vulnerabilities as graph nodes.

## Complete Command Reference

Maltego Teeth is a suite of scripts and configuration files rather than a single CLI tool. The primary interaction occurs via the Maltego UI after importing the `.mtz` configuration.

### Included Transform Categories

| Category | Description |
|----------|-------------|
| **Nmap Transforms** | Run various Nmap scan types (Service detection, OS fingerprinting, script scanning) against IP/Domain entities. |
| **SQLMap Transforms** | Pass URL entities to SQLMap to test for SQL injection vulnerabilities. |
| **Metasploit Transforms** | Interface with the Metasploit Framework to check for exploitability or run auxiliary modules. |
| **Web Scraping** | Use BeautifulSoup and Mechanize to extract information from web entities. |
| **Reconnaissance** | Advanced DNS lookups using `python3-adns` and Levenshtein-based domain similarity checks. |

### Configuration and Paths
- **Configuration Files:** Usually found in `/etc/maltego-teeth/` or `/usr/share/maltego-teeth/config/`.
- **Transform Scripts:** Located in `/usr/share/maltego-teeth/transforms/`.
- **Working Directory:** Teeth may store temporary scan data or logs in `~/.maltego-teeth/`.

## Notes
- **GUI Requirement:** This tool requires the Maltego Desktop Client to be installed and configured.
- **Root Privileges:** Some transforms (like Nmap SYN scans) may require the Maltego process or the underlying scripts to have sudo/root privileges.
- **Tool Paths:** Ensure that `nmap`, `sqlmap`, and `msfconsole` are in your system PATH, as the transforms call these binaries directly.
- **Legal Warning:** Running offensive transforms against targets without authorization is illegal. Always ensure you have explicit permission before executing active scans.