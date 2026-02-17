---
name: hexstrike-ai
description: Automate cybersecurity tasks using an AI-powered MCP (Model Context Protocol) platform featuring autonomous agents for reconnaissance, exploitation, and vulnerability intelligence. Use when performing automated bug bounty hunting, CTF challenges, red team operations, or zero-day research requiring an adaptive AI decision engine.
---

# hexstrike-ai

## Overview
HexStrike AI is an MCP (Model Context Protocol) cybersecurity automation platform. it utilizes a multi-agent architecture to perform autonomous reconnaissance, exploitation, and analysis. It consists of a backend API server and a client interface. Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
Assume hexstrike-ai is already installed. If you encounter errors, install via:

```bash
sudo apt update
sudo apt install hexstrike-ai
```

## Common Workflows

### Start the HexStrike AI Server
Launch the backend engine on the default port (8888) to handle AI decision-making and module execution.
```bash
hexstrike_server
```

### Run the Server on a Custom Port with Debugging
Useful for troubleshooting or avoiding port conflicts.
```bash
hexstrike_server --port 9090 --debug
```

### Connect the MCP Client to the Server
Launch the client to interact with the AI agents.
```bash
hexstrike_mcp --server http://127.0.0.1:8888
```

### Run Client with Extended Timeout
Use for complex tasks where the AI agent may take significant time to process results.
```bash
hexstrike_mcp --timeout 600 --debug
```

## Complete Command Reference

### hexstrike_server
The backend API server that manages the AI decision engine and integrated modules.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--debug` | Enable debug mode for detailed logging |
| `--port PORT` | Port for the API server (default: 8888) |

### hexstrike_mcp
The client interface used to interact with the HexStrike AI platform.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--server SERVER` | HexStrike AI API server URL (default: http://127.0.0.1:8888) |
| `--timeout TIMEOUT` | Request timeout in seconds (default: 300) |
| `--debug` | Enable debug logging |

## Notes
- The server initializes a process pool for worker tasks; ensure the system has sufficient resources for multi-agent operations.
- Integrated modules include tools for recon, exploitation, and analysis pipelines.
- The platform uses the Model Context Protocol (MCP) to interface with LLMs.