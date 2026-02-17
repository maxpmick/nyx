---
name: faraday-cli
description: Official command-line interface for Faraday, an Integrated Penetration Test Environment. Use to automate security workflows, manage workspaces, and interact with the Faraday server directly from the terminal. Ideal for CI/CD integration, bulk data management, and streamlining vulnerability reporting during penetration testing.
---

# faraday-cli

## Overview
The Faraday CLI is the official client for interacting with the Faraday platform. It allows users to manage workspaces, vulnerabilities, and hosts through the terminal or an interactive shell. Category: Vulnerability Analysis / Information Gathering.

## Installation (if not already installed)
Assume faraday-cli is already installed. If you encounter errors, install it using:

```bash
sudo apt update && sudo apt install faraday-cli
```

## Common Workflows

### Interactive Shell
Launch the interactive Faraday shell to run multiple commands in a persistent session:
```bash
faraday-cli
```

### List Workspaces
View all available workspaces on the Faraday server:
```bash
faraday-cli workspace list
```

### Create a New Workspace
Initialize a new workspace for a specific project:
```bash
faraday-cli workspace create "Internal_Pentest_2023"
```

### Import Tool Results
Import scan results (e.g., Nmap, Nessus) into a specific workspace:
```bash
faraday-cli tool report /path/to/nmap_scan.xml --workspace my_project
```

## Complete Command Reference

The `faraday-cli` can be used as a single-command execution tool or as an interactive shell.

### Global Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `command` | Optional command to run (e.g., `workspace`, `tool`, `vulnerability`). If omitted, enters interactive shell. |
| `command_args` | Optional arguments specific to the chosen command. |

### Subcommands

While the base help output is concise, the tool typically supports the following functional areas (accessible via `faraday-cli [command] -h`):

#### Workspace Management
Commands to manage Faraday workspaces.
- `workspace list`: List all workspaces.
- `workspace create <name>`: Create a new workspace.
- `workspace delete <name>`: Remove a workspace.

#### Tool Integration
Commands to process external tool outputs.
- `tool report <file>`: Upload and process a report file from supported security tools.

#### Vulnerability Management
Commands to interact with findings.
- `vulnerability list`: List vulnerabilities in the current or specified workspace.
- `vulnerability create`: Manually add a vulnerability.

#### Host and Service Management
- `host list`: List all discovered hosts.
- `service list`: List services associated with hosts.

## Notes
- **Interactive Mode**: If you run `faraday-cli` without arguments, it enters a `cmd2`-based interactive shell which provides tab-completion and command history.
- **Server Connection**: Ensure your Faraday server is running and the CLI is configured to point to the correct API URL and credentials (usually handled via environment variables or a config file if not prompted).
- **Dependencies**: Requires `faraday` server and several Python libraries (click, cmd2, simple-rest-client, etc.) to function correctly.