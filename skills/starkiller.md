---
name: starkiller
description: A graphical user interface (GUI) frontend for the PowerShell Empire post-exploitation framework. Use when managing Empire agents, listeners, and modules through a visual dashboard instead of the command-line interface. Ideal for post-exploitation, lateral movement, and command-and-control (C2) operations during penetration testing.
---

# starkiller

## Overview
Starkiller is an Electron-based application written in VueJS that provides a comprehensive GUI for PowerShell Empire. It allows operators to interact with the Empire server to manage listeners, stagers, agents, and modules in a more intuitive, multi-user environment. Category: Post-Exploitation / Exploitation.

## Installation (if not already installed)

Starkiller is typically pre-installed in Kali Linux (Large/Everything). If missing, or to ensure dependencies are met:

```bash
sudo apt update
sudo apt install starkiller
```

**Dependencies:**
- `powershell-empire` (The backend server must be running for Starkiller to connect to).

## Common Workflows

### Starting the Empire Backend
Before launching Starkiller, the Empire server must be active.
```bash
sudo powershell-empire server
```

### Launching Starkiller
Start the GUI application from the terminal:
```bash
starkiller
```

### Connecting to the Server
Once the application opens, you will be prompted for connection details:
1. **URL**: `https://localhost:1337` (default)
2. **Username**: `empireadmin` (default)
3. **Password**: `password123` (default)

### Managing Agents
After logging in, use the "Agents" tab to interact with compromised hosts. You can:
- View check-in times and internal/external IPs.
- Execute shell commands or run specific Empire modules.
- Configure "Sleep" and "Jitter" settings for stealth.

## Complete Command Reference

Starkiller is primarily a GUI application. The command-line interface is used to launch the Electron wrapper.

```
starkiller [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help menu and exit. |
| `-v`, `--version` | Display the current version of Starkiller. |
| `--no-sandbox` | Useful when running in certain containerized or restricted environments where the Chrome sandbox causes issues. |

### GUI Functionality (Post-Launch)

Once the application is running, the following sections are available via the sidebar:

| Section | Description |
|---------|-------------|
| **Dashboard** | Overview of active agents, listeners, and recent notifications. |
| **Listeners** | Create and manage listeners (e.g., http, https, meterpreter). |
| **Stagers** | Generate payloads (e.g., multi/launcher, windows/dll) to drop on targets. |
| **Agents** | Interact with active sessions, execute commands, and browse files. |
| **Modules** | Search and execute Empire's library of post-exploitation scripts. |
| **Credentials** | View and manage harvested passwords, hashes, and tokens. |
| **Users** | Manage multi-user access to the Empire server. |

## Notes
- **Server Sync**: Starkiller is a client. If the `powershell-empire` server stops, Starkiller will lose its connection and functionality.
- **SSL/TLS**: By default, Empire uses self-signed certificates. You may need to accept a certificate warning or ensure the URL matches the server's configuration.
- **Multi-User**: Starkiller supports multiple operators connecting to the same Empire server simultaneously, making it effective for red team collaborations.