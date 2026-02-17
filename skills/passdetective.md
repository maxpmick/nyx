---
name: passdetective
description: Scan shell command history for mistakenly written passwords, API keys, and secrets using regular expressions. Use when performing post-exploitation reconnaissance, local privilege escalation audits, or security hardening to identify exposed credentials in .bash_history, .zsh_history, or other shell logs.
---

# PassDetective

## Overview
PassDetective is a CLI tool designed to identify and extract sensitive information like passwords and API keys that have been accidentally included in shell command history. It belongs to the Post-Exploitation and Information Gathering domains.

## Installation (if not already installed)
Assume PassDetective is already installed. If the command is not found:

```bash
sudo apt install passdetective
```

## Common Workflows

### Scan current shell history for secrets
```bash
PassDetective extract
```
This command analyzes the shell history and displays any identified passwords or keys for inspection.

### Generate shell autocompletion
```bash
PassDetective completion bash > /etc/bash_completion.d/passdetective
```
Enables tab-completion for PassDetective commands in the bash shell.

### View help for specific subcommands
```bash
PassDetective extract --help
```

## Complete Command Reference

### Global Usage
```
PassDetective [command] [flags]
```

### Global Flags
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Help message for PassDetective |

### Subcommands

#### `extract`
The `extract` command allows you to automatically extract passwords from shell history descriptions. It analyzes the history of shell commands to identify and display passwords used in previous commands.

**Usage:**
```bash
PassDetective extract [flags]
```

#### `completion`
Generate the autocompletion script for the specified shell.

**Usage:**
```bash
PassDetective completion [shell]
```
**Available Shells:**
- `bash`
- `zsh`
- `fish`
- `powershell`

#### `help`
Help about any command.

**Usage:**
```bash
PassDetective help [command]
```

## Notes
- This tool is highly effective for finding credentials passed as command-line arguments (e.g., `mysql -u root -p'password123'`).
- It relies on regular expression patterns to identify secrets; results should be manually verified for false positives.
- Ensure you have read permissions for the shell history files of the target user when running this in a post-exploitation scenario.