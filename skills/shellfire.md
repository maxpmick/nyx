---
name: shellfire
description: Exploit Local File Inclusion (LFI), Remote File Inclusion (RFI), and command injection vulnerabilities. Use when performing web application exploitation to gain an interactive-like shell, automate payload delivery, or bypass filters during penetration testing.
---

# shellfire

## Overview
Shellfire is an exploitation shell designed to simplify the process of exploiting LFI, RFI, and command injection vulnerabilities. It provides an interactive interface to automate the inclusion of payloads and the execution of commands on a target web server. Category: Exploitation / Web Application Testing.

## Installation (if not already installed)
Assume shellfire is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install shellfire
```

Dependencies: python3, python3-pkg-resources, python3-requests.

## Common Workflows

### Basic Startup
```bash
shellfire
```
Launches the interactive shell where you can configure the target URL and injection points.

### Loading a Specific Configuration
```bash
shellfire -c my_exploit_config
```
Starts shellfire and automatically loads a previously saved configuration file.

### Generating a PHP Webshell Payload
```bash
shellfire --generate php > shell.php
```
Generates a standard PHP payload used for exploitation and saves it to a file.

### Debugging Mode
```bash
shellfire -d
```
Starts the shell with debugging enabled, showing the raw HTTP queries being sent to the target during execution.

## Complete Command Reference

```
usage: shellfire [-h] [-c [CONFIG]] [-d] [--generate PAYLOAD] [--version]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-c [CONFIG]` | Load a named configuration file on startup |
| `-d` | Enable debugging (displays raw HTTP queries during execution) |
| `--generate PAYLOAD` | Generate a payload to stdout. Supported values: `php`, `aspnet` |
| `--version` | Display the version information and exit |

### Internal Shell Commands
Once inside the shellfire interface, the following commands are typically available to configure the exploit:

| Command | Description |
|---------|-------------|
| `auth` | Configure HTTP authentication (Basic/Digest) |
| `cookies` | Manage HTTP cookies for the session |
| `find` | Search for specific strings in the server response |
| `history` | View command history |
| `http` | Set the HTTP method (GET/POST) |
| `marker` | Set the injection marker (default is `{}`) |
| `method` | Set the exploitation method (e.g., cmd, php, etc.) |
| `payload` | Configure the payload to be used |
| `url` | Set the target URL including the injection marker |

## Notes
- Shellfire is particularly effective at turning a simple command injection point into a more stable, shell-like environment.
- Use the `marker` command to define exactly where in the URL or POST data the command should be injected.
- The `--generate` flag is useful for creating the initial files needed for RFI (Remote File Inclusion) attacks.