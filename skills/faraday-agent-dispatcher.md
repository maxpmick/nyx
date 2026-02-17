---
name: faraday-agent-dispatcher
description: Dispatch and manage Faraday agents to integrate external security tools with the Faraday platform. Use when automating vulnerability ingestion, orchestrating remote scanners, or synchronizing tool outputs (like ZAP or GVM) with a Faraday workspace during penetration testing or vulnerability management.
---

# faraday-agent-dispatcher

## Overview
The Faraday Agent Dispatcher is a helper tool designed to facilitate integrations between various security tools and the Faraday platform. It allows users to run agents that execute tools and automatically report findings back to a Faraday server. Category: Vulnerability Analysis / Reporting.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install faraday-agent-dispatcher
```

## Common Workflows

### Initial Configuration
Run the configuration wizard to set up the connection to your Faraday server (URL, credentials, and workspace).
```bash
faraday-dispatcher config-wizard
```

### Starting the Dispatcher
Once configured, start the dispatcher to begin listening for and executing agent tasks.
```bash
faraday-dispatcher run
```

### Running with Debug Logging
If troubleshooting connection issues with the Faraday server:
```bash
faraday-dispatcher run --log-level DEBUG
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-v`, `--version` | Show the version and exit. |
| `-h`, `--help` | Show the help message and exit. |

### Subcommands

#### config-wizard
Starts an interactive configuration session to set up the dispatcher's environment and server connectivity.
```bash
faraday-dispatcher config-wizard [OPTIONS]
```

#### run
Starts the dispatcher service to manage and execute Faraday agents.
```bash
faraday-dispatcher run [OPTIONS]
```

**Options for `run`:**
| Flag | Description |
|------|-------------|
| `--log-level [DEBUG|INFO|WARNING|ERROR|CRITICAL]` | Set the logging level (Default: INFO). |
| `--config-path <path>` | Specify a custom path to the configuration file. |
| `-h`, `--help` | Show the help message for the run command. |

## Notes
- This tool acts as a bridge; ensure the Faraday Server is reachable from the host running the dispatcher.
- It supports integrations with tools like OWASP ZAP (`python3-zapv2`) and Greenbone Vulnerability Manager (`python3-gvm`).
- Configuration is typically stored in `~/.faraday/config/agent_dispatcher.yaml` by default.