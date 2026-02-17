---
name: netwox
description: A comprehensive networking toolbox containing over 200 individual tools for sniffing, spoofing, scanning, and protocol-specific testing (DNS, HTTP, FTP, etc.). Use when performing network troubleshooting, security auditing, packet crafting, or protocol analysis. It includes both a command-line interface (netwox) and a graphical frontend (netwag).
---

# netwox / netwag

## Overview
Netwox is a massive suite of networking utilities (223+ tools) built on the netwib library. It covers a wide range of functions including address conversion, packet sniffing, spoofing, and client/server simulation for numerous protocols. Category: Sniffing & Spoofing / Reconnaissance.

## Installation (if not already installed)

Assume the tools are installed. If commands are missing:

```bash
sudo apt install netwox netwag
```

## Common Workflows

### Interactive Help Mode
If you don't know the specific tool number, run netwox alone to browse categories:
```bash
netwox
```

### Searching for a Tool
Use the graphical frontend to search for specific functionality (e.g., "syn flood" or "icmp"):
```bash
netwag
```

### Getting Help for a Specific Tool
Every tool in the suite is identified by a number. To see how to use tool 23:
```bash
netwox 23 --help
```

### Viewing Full Tool Description
To see the detailed technical description and all parameters for tool 23:
```bash
netwox 23 --help2
```

### Running a Tool with Parameters
Example of running a tool (e.g., tool 23) with extended options:
```bash
netwox 23 --extended
```

## Complete Command Reference

### netwox (CLI)
The primary interface for the toolbox.

```
netwox [number] [parameters...]
```

| Parameter | Description |
|-----------|-------------|
| `number` | The specific ID of the tool to execute (1-223+) |
| `--help` | Display simple help/usage for the specified tool number |
| `--help2` | Display full description and detailed help for the specified tool number |
| `--extended` / `-e` | Run the tool with extended parameters (if supported by that tool) |

### netwag (GUI)
A Tcl/Tk graphical frontend for netwox that assists in command construction and history management.

```
netwag [options]
```

| Flag | Description |
|------|-------------|
| `-sync` | Use synchronous mode for display server |
| `-colormap` | Colormap for main window |
| `-display` | Display to use |
| `-geometry` | Initial geometry for window |
| `-name` | Name to use for application |
| `-visual` | Visual for main window |
| `-use` | Id of window in which to embed application |
| `--` | Marks the end of the options |
| `-help` | Print summary of command-line options and abort |

## Notes
- Netwox is organized by tool numbers. Because there are over 200 tools, using `netwox` (interactive mode) or `netwag` (GUI) is the recommended way to discover the correct tool number for your task.
- Many tools require root privileges for raw socket access (sniffing/spoofing).
- The documentation for specific tool numbers is often more detailed in the `netwox-doc` package (`/usr/share/doc/netwox/`).