---
name: mcp-kali-server
description: Establish an API bridge connecting Model Context Protocol (MCP) clients to a Kali Linux API server to execute terminal commands remotely. Use when integrating AI assistants (like Claude Desktop) with Kali Linux tools for AI-assisted penetration testing, CTF solving, or automated security workflows involving tools like nmap, nxc, and gobuster.
---

# mcp-kali-server

## Overview
A lightweight API bridge that connects MCP Clients to an API server, allowing the execution of Linux terminal commands. This enables AI models to interact directly with Kali Linux tools, web applications, and network services for security assessments and automated exploitation. Category: Exploitation / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If "command not found" occurs:

```bash
sudo apt update && sudo apt install mcp-kali-server
```

Dependencies: python3, python3-flask, python3-mcp, python3-requests.

## Common Workflows

### Start the API Server
Run the server on the Kali machine where tools will be executed:
```bash
kali-server-mcp --port 5000
```

### Connect the MCP Client
Run the client bridge to connect an AI assistant to the local or remote Kali server:
```bash
mcp-server --server http://localhost:5000 --timeout 600
```

### Debugging Connection Issues
Enable debug mode on both components to troubleshoot command execution or connectivity:
```bash
# Terminal 1: Server
kali-server-mcp --debug
# Terminal 2: Client
mcp-server --debug
```

## Complete Command Reference

### kali-server-mcp
The backend component that runs on the Kali Linux host to receive and execute commands.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--debug` | Enable Flask debug mode |
| `--port PORT` | Port for the API server (default: 5000) |

### mcp-server
The client-side bridge that interfaces between the MCP-compatible AI application and the Kali API server.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--server SERVER` | Kali API server URL (default: http://localhost:5000) |
| `--timeout TIMEOUT` | Request timeout in seconds for command execution (default: 300) |
| `--debug` | Enable debug logging |

## Notes
- **Security Warning**: This tool allows remote command execution. Ensure the API server is only accessible over trusted networks or via secure tunnels.
- The default timeout of 300 seconds may need to be increased for long-running scans like `nmap` or `gobuster`.
- This bridge is specifically designed for integration with platforms like Claude Desktop or 5ire.