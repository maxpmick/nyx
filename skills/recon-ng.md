---
name: recon-ng
description: A full-featured Web Reconnaissance framework written in Python for conducting open-source intelligence (OSINT). Use when performing domain enumeration, contact harvesting, credential leaks discovery, or mapping a target's web presence. It features a modular structure similar to Metasploit, allowing for automated data collection and storage in a structured database.
---

# recon-ng

## Overview
Recon-ng is a powerful environment for web-based reconnaissance. It provides independent modules, database interaction, and built-in convenience functions to automate the gathering of information from various public sources. It is designed exclusively for reconnaissance and does not include exploitation or social engineering tools. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume recon-ng is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install recon-ng
```

## Common Workflows

### Interactive Module Usage
Start the framework, search for a module, and execute it against a target:
```bash
recon-ng
[recon-ng][default] > marketplace search hackertarget
[recon-ng][default] > marketplace install recon/domains-hosts/hackertarget
[recon-ng][default] > modules load recon/domains-hosts/hackertarget
[recon-ng][default][hackertarget] > options set SOURCE example.com
[recon-ng][default][hackertarget] > run
[recon-ng][default][hackertarget] > show hosts
```

### Command Line Execution (recon-cli)
Run a specific module and exit without entering the interactive shell:
```bash
recon-cli -w my_workspace -m recon/domains-hosts/brute_hosts -o SOURCE=example.com -x
```

### Web Interface
Launch the web-based UI for reporting and analytics:
```bash
recon-web --host 127.0.0.1 --port 5000
```

### Resource File Automation
Run a batch of commands saved in a text file:
```bash
recon-ng -r commands.txt
```

## Complete Command Reference

### recon-ng (Interactive Shell)
The main entry point for the framework.

```bash
recon-ng [-h] [-w workspace] [-r filename] [--no-version] [--no-analytics] [--no-marketplace] [--stealth] [--accessible] [--version]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-w <workspace>` | Load or create a specific workspace |
| `-r <filename>` | Load commands from a resource file |
| `--no-version` | Disable version check (Default in Debian) |
| `--no-analytics` | Disable analytics reporting (Default in Debian) |
| `--no-marketplace` | Disable remote module management |
| `--stealth` | Disable all passive requests (shorthand for all `--no-*` flags) |
| `--accessible` | Use accessible outputs when available |
| `--version` | Display the current version |

### recon-cli (Command Line Interface)
Allows execution of Recon-ng modules directly from the terminal.

```bash
recon-cli [-h] [-w workspace] [-C command] [-c command] [-G] [-g name=value] [-M] [-m module] [-O] [-o name=value] [-x] [--no-version] [--no-analytics] [--no-marketplace] [--stealth] [--version] [--analytics]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-w <workspace>` | Load or create a workspace |
| `-C <command>` | Run a command at the global context |
| `-c <command>` | Run a command at the module context (pre-run) |
| `-G` | Show available global options |
| `-g <name=value>` | Set a global option (can be used multiple times) |
| `-M` | Show available modules |
| `-m <module>` | Specify the module to use |
| `-O` | Show available module options |
| `-o <name=value>` | Set a module option (can be used multiple times) |
| `-x` | Execute the module |
| `--no-version` | Disable version check |
| `--no-analytics` | Disable analytics reporting |
| `--no-marketplace` | Disable remote module management |
| `--stealth` | Disable all passive requests |
| `--version` | Display the current version |
| `--analytics` | Enable analytics reporting (sends to Google) |

### recon-web (Web Interface)
Starts the web-based user interface and API.

```bash
recon-web [-h] [--host HOST] [--port PORT]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--host <HOST>` | IP address to listen on (Default: 127.0.0.1) |
| `--port <PORT>` | Port to bind the web server to (Default: 5000) |

## Notes
- **Workspaces**: Use workspaces to isolate data for different targets or engagements.
- **Marketplace**: Since version 5, modules must be installed via the `marketplace` command within the interactive shell before they can be used.
- **API Keys**: Many modules require API keys (e.g., Shodan, Censys, Google). Use `keys add <key_name> <value>` within the shell to manage them.
- **Database**: Data is stored in a SQLite database per workspace. Use `show <table_name>` (e.g., `show hosts`, `show contacts`) to view gathered data.