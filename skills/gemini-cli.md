---
name: gemini-cli
description: Access Google Gemini AI models directly from the terminal to perform automated tasks, execute code, or manage MCP servers. Use when requiring AI-assisted command-line operations, automated script generation, or interacting with Model Context Protocol (MCP) extensions during penetration testing or development.
---

# gemini-cli

## Overview
An open-source AI agent that brings Gemini's capabilities to the terminal. It supports interactive chat, one-shot prompts, and tool execution through extensions and MCP (Model Context Protocol) servers. Category: Information Gathering / Automation.

## Installation (if not already installed)
Assume gemini-cli is already installed. If you get a "command not found" error:

```bash
sudo apt install gemini-cli
```
Note: Requires `nodejs` as a dependency.

## Common Workflows

### One-shot prompt (Non-interactive)
```bash
gemini "Explain the output of this nmap scan: $(cat scan.nmap)"
```

### Interactive mode with a starting prompt
```bash
gemini -i "Help me write a python script to parse logs"
```

### YOLO mode (Auto-approve all actions)
```bash
gemini --yolo "Update all outdated packages on this system and fix broken dependencies"
```

### Using specific MCP servers
```bash
gemini --allowed-mcp-server-names filesystem,google-maps "Find the nearest coffee shop to London Eye"
```

## Complete Command Reference

```
gemini [options] [command]
```

### Commands

| Command | Description |
|---------|-------------|
| `gemini [query..]` | Launch Gemini CLI (Default) |
| `gemini mcp` | Manage MCP (Model Context Protocol) servers |
| `gemini extensions <command>` | Manage Gemini CLI extensions |

### Positionals

| Argument | Description |
|----------|-------------|
| `query` | Positional prompt. Defaults to one-shot; use `-i` for interactive |

### Options

| Flag | Description |
|------|-------------|
| `-d, --debug` | Run in debug mode (Default: false) |
| `-m, --model` | Specify the Gemini model to use |
| `-p, --prompt` | Prompt appended to stdin (Deprecated: use positional query instead) |
| `-i, --prompt-interactive` | Execute the provided prompt and continue in interactive mode |
| `-s, --sandbox` | Run the agent in a sandbox environment |
| `-y, --yolo` | Automatically accept all actions (YOLO mode) |
| `--approval-mode` | Set approval mode: `default` (prompt), `auto_edit` (approve edits), `yolo` (approve all) |
| `--experimental-acp` | Starts the agent in ACP mode |
| `--allowed-mcp-server-names` | Array of allowed MCP server names |
| `--allowed-tools` | Array of tools allowed to run without confirmation |
| `-e, --extensions` | List of extensions to use (Default: all) |
| `-l, --list-extensions` | List all available extensions and exit |
| `--include-directories` | Additional directories to include in workspace (comma-separated or multiple flags) |
| `--screen-reader` | Enable screen reader mode for accessibility |
| `-o, --output-format` | Output format: `text`, `json`, `stream-json` |
| `-v, --version` | Show version number |
| `-h, --help` | Show help message |

## Notes
- **YOLO Mode**: Use `--yolo` with extreme caution as the AI can execute commands on your host system without confirmation.
- **MCP**: The Model Context Protocol allows the agent to connect to external data sources and tools.
- **Environment**: Ensure your `GOOGLE_API_KEY` is set in your environment variables for the tool to function.