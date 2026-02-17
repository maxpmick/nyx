---
name: poshc2
description: A proxy-aware Command & Control (C2) framework used for red teaming, post-exploitation, and lateral movement. It supports PowerShell, C#, and Python3 implants with encrypted communications. Use this tool to manage remote sessions, generate payloads, and execute post-exploitation modules during penetration testing engagements.
---

# poshc2

## Overview
PoshC2 is a modular, multi-user C2 framework primarily written in Python3. It generates a wide variety of payloads (executables, DLLs, shellcode) for Windows, *nix, and OSX. It features automated Apache rewrite rules for C2 proxying, SOCKS proxy integration via SharpSocks, and extensive logging in a PostgreSQL/SQLite database. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume PoshC2 is installed. If not, or if dependencies are missing:

```bash
sudo apt update
sudo apt install poshc2
```

## Common Workflows

### 1. Project Management
Before running any C2 operations, you must create or select a project.
```bash
# Create a new project
posh-project -n MyEngagement

# List existing projects
posh-project -l

# Switch to an existing project
posh-project -s MyEngagement
```

### 2. Starting the C2 Server
Once a project is selected, start the server to begin listening for implants.
```bash
# Start the C2 server in the current terminal
posh-server

# Alternatively, start the API server for GUI/External clients
posh-api-server
```

### 3. Interacting with Implants
Use the main handler to interact with checked-in implants.
```bash
posh
```

### 4. Configuration
Edit the configuration for the current project (e.g., callback hosts, jitter, kill dates).
```bash
posh-config
```

## Complete Command Reference

### posh-project
Manages PoshC2 projects. This is the mandatory first step.

| Flag | Description |
|------|-------------|
| `-n <name>` | Create a new project |
| `-s <name>` | Switch to an existing project |
| `-l` | List all projects |
| `-d <name>` | Delete a project |
| `-c` | Show the current active project |
| `-g` | Quietly show current project directory (useful for scripting) |

### posh
Starts the PoshC2 interactive handler/CLI for managing implants and executing modules.

### posh-server
Starts the main C2 server process which handles incoming communications from implants.

### posh-config
Opens the configuration file for the currently selected project in the default editor.

### posh-api-server
Starts the PoshC2 API server, allowing for multi-user collaboration and communication with external interfaces.

### posh-log
Displays the logs for the current project.

### posh-service
Starts PoshC2 as a background service.

### posh-stop-service
Stops the PoshC2 background service.

### posh-cookie-decrypter
A utility to decrypt PoshC2 cookies used in communication.

### fpc
The "Find-PoshCommand" utility used to search for specific modules or commands within the framework.

## Notes
- **Project Isolation**: All configuration, payloads, and database entries are siloed by project. Always verify your active project with `posh-project -c`.
- **Payloads**: Generated payloads are typically located in `/var/lib/poshc2/<project_name>/payloads/` after the server has been initialized.
- **OPSEC**: PoshC2 automatically generates Apache Rewrite rules to help you set up redirectors and protect your backend C2 server.
- **Dependencies**: Requires a variety of tools including `mingw-w64` for cross-compiling and `mono-devel` for C# support.