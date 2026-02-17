---
name: websploit
description: An automatic vulnerability assessment, web scanning, and exploitation framework with a modular structure similar to Metasploit. Use for Man-in-the-Middle (MITM) attacks, web directory brute-forcing, wireless scanning, and network vulnerability analysis during penetration testing.
---

# websploit

## Overview
WebSploit is an open-source exploitation framework designed for remote system analysis and vulnerability discovery. It features a modular command-line interface (CLI) that supports various security domains including web application testing, network sniffing, and wireless attacks. Category: Exploitation / Web Application Testing / Sniffing & Spoofing.

## Installation (if not already installed)
Assume websploit is already installed. If the command is missing:

```bash
sudo apt install websploit
```

Dependencies: python3, python3-requests, python3-scapy.

## Common Workflows

### Web Directory Enumeration
```bash
websploit
wsf > use web/dir_scanner
wsf:Dir_Scanner > set TARGET http://example.com
wsf:Dir_Scanner > run
```

### Wireless Network Scanning
```bash
websploit
wsf > use wifi/scan_wifi
wsf:Scan_Wifi > execute
```

### General Module Usage Pattern
1. Start the framework: `websploit`
2. List available modules: `show`
3. Select a module: `use <module_path>`
4. View required parameters: `options`
5. Configure parameters: `set <option_name> <value>`
6. Launch the attack: `run` or `execute`

## Complete Command Reference

WebSploit uses an interactive console. Launch it by typing `websploit` in the terminal.

### Global Console Commands

| Command | Description |
|---------|-------------|
| `help` | Shows all available commands in the current context |
| `show` | Shows all available modules in the framework database |
| `use <module>` | Selects and loads a specific module for use |
| `options` | Displays the current configuration and required options for the selected module |
| `set <option> <value>` | Sets a value for a specific module option |
| `run` | Executes the selected module |
| `execute` | Alias for `run`; executes the selected module |
| `back` | Exits the current module context and returns to the main prompt |
| `about` | Displays information about the author and version |
| `update` | (Disabled on Debian/Kali) Use `apt upgrade websploit` instead |
| `exit` | Terminate the WebSploit framework |

### Available Module Categories
While specific modules may vary by version, WebSploit typically includes:
- **web/**: Directory scanners, cross-site scripting (XSS) testers, etc.
- **network/**: MITM tools, ARP spoofing, and sniffing.
- **wifi/**: Access point scanning and wireless attacks.
- **exploit/**: Various vulnerability exploitation modules.

## Notes
- **Root Privileges**: WebSploit must be run as root (or via `sudo`) to perform network-level operations like sniffing or MITM attacks.
- **Modular Design**: If you are familiar with Metasploit, the workflow is nearly identical (use -> set -> run).
- **IPv6 Warning**: You may see a "No route found for IPv6 destination" warning on startup; this is typically non-fatal and relates to Scapy's initialization.