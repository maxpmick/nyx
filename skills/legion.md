---
name: legion
description: Semi-automated network penetration testing tool used for discovery, reconnaissance, and exploitation. It provides a graphical or headless interface to orchestrate various security tools like Nmap, Nikto, and Hydra. Use when performing network-wide vulnerability assessments, automated service enumeration, or managing complex penetration testing workflows.
---

# legion

## Overview
Legion is an open-source, extensible, and semi-automated network penetration testing tool. It is a fork of Sparta and acts as an orchestrator for numerous security tools to streamline the process of host discovery, service enumeration, and exploitation. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume legion is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install legion
```

Legion relies on a vast array of dependencies including `nmap`, `hydra`, `nikto`, `metasploit-framework`, and `sqlmap`.

## Common Workflows

### Launching the Graphical Interface
Simply run the command without arguments to start the PyQt6-based GUI:
```bash
legion
```

### Headless Scan from a Target List
Run a non-interactive scan against a list of targets and save the results to a file:
```bash
legion --headless --input-file targets.txt --output-file results.json
```

### Automated Discovery and Action Execution
Enable host discovery and automatically run scripted actions (like brute-forcing or service-specific scans) after discovery:
```bash
legion --headless --input-file 192.168.1.0/24 --discovery --run-actions
```

### AI Integration
Start the Legion MCP (Model Context Protocol) server for AI-assisted penetration testing:
```bash
legion --mcp-server
```

## Complete Command Reference

```
legion [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--mcp-server` | Start the MCP server for AI integration. |
| `--headless` | Run Legion in headless (CLI) mode without the GUI. |
| `--input-file <FILE>` | Path to a text file containing targets (hostnames, subnets, IPs, etc.). |
| `--discovery` | Enable host discovery (default: enabled). |
| `--staged-scan` | Enable staged scanning (scanning in phases). |
| `--output-file <FILE>` | Specify the output file path (supports `.legion` or `.json` formats). |
| `--run-actions` | Automatically run scripted actions and automated attacks after the scan or import is complete. |

## Notes
- **Extensibility**: Legion's power comes from its ability to call other tools. Ensure tools like `nmap`, `nikto`, and `hydra` are in your PATH.
- **Root Privileges**: Many underlying tools (like Nmap for SYN scans) require root privileges. It is recommended to run Legion with `sudo`.
- **Legacy**: As a fork of Sparta, it maintains a similar workflow but with updated Python 3 support and additional automation features.