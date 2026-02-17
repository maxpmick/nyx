---
name: oscanner
description: Oracle assessment framework for enumerating SIDs, versions, account roles, privileges, hashes, and password policies. Use when performing database security assessments, Oracle reconnaissance, or credential auditing during penetration testing.
---

# oscanner

## Overview
Oscanner is a Java-based Oracle assessment framework with a plugin-based architecture. It automates the discovery of Oracle database information including SID enumeration, version detection, account roles/privileges, password policy enumeration, and dictionary-based password testing. Category: Database Assessment / Web Application Testing.

## Installation (if not already installed)
Assume oscanner is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install oscanner
```
Requires: `default-jre`.

## Common Workflows

### Scan a single Oracle server on a custom port
```bash
oscanner -s 192.168.1.15 -P 1521
```

### Scan multiple servers from a list
```bash
oscanner -f targets.txt -v
```

### Scan with verbose output for troubleshooting
```bash
oscanner -s 10.0.0.50 -v
```

## Complete Command Reference

```bash
oscanner -s <ip> -r <repfile> [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-s <servername>` | Specify the target Oracle server IP address or hostname |
| `-f <serverlist>` | Specify a file containing a list of target servers to scan |
| `-P <portnr>` | Specify the Oracle TNS listener port (default is usually 1521) |
| `-v` | Enable verbose output to see detailed progress and errors |
| `-r <repfile>` | Specify a report file (Note: usage syntax indicates this flag for reporting) |
| `-h` | Display the help message and version information |

## Notes
- **Plugin Capabilities**: The tool automatically attempts to run plugins for:
    - SID Enumeration
    - Password tests (common & dictionary)
    - Oracle version enumeration
    - Account roles and privileges enumeration
    - Account hash extraction
    - Audit information enumeration
    - Password policy enumeration
    - Database link enumeration
- **Output**: Results are typically presented in a graphical Java tree structure if the environment supports GUI, otherwise text output is provided in the terminal.
- **SID Discovery**: If the tool fails to enumerate SIDs automatically, it may attempt to load them from a local service file.