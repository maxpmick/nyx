---
name: powershell-empire
description: Deploy and manage post-exploitation agents on Windows (PowerShell), Linux, and macOS (Python). Use for post-exploitation tasks including credential harvesting, lateral movement, persistence, and situational awareness. It features cryptographically secure communications and evades detection by running PowerShell without powershell.exe.
---

# powershell-empire

## Overview
PowerShell Empire is a post-exploitation framework that combines the capabilities of the original PowerShell Empire and Python EmPyre projects. It provides a unified interface for managing pure-PowerShell Windows agents and pure-Python Linux/macOS agents. It includes numerous modules for tasks like Mimikatz, keylogging, and network pivoting. Category: Post-Exploitation.

## Installation (if not already installed)
Assume powershell-empire is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install powershell-empire
```

## Common Workflows

### Initial Setup
Before running the server for the first time, initialize the data directories:
```bash
powershell-empire setup
```

### Starting the Empire Server
Launch the headless server component which handles listeners and agents:
```bash
powershell-empire server
```

### Using the Client (CLI)
To interact with the server via the command line interface, use the `empire-client` (if installed) or connect via the integrated shell. Note: Modern Kali installations often use `powershell-empire client` or a separate `empire-client` command to connect to the `server`.

### Using the GUI (Starkiller)
Starkiller is the web-based GUI for Empire. Launch it to manage agents visually:
```bash
starkiller
```

## Complete Command Reference

### Main Entry Point: `powershell-empire`

```
usage: empire.py [-h] {server,setup} ...
```

#### Positional Arguments

| Argument | Description |
|----------|-------------|
| `server` | Launch the Empire Server (REST API and backend) |
| `setup` | Setup/initialize the data directories for Empire |

#### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |

---

### GUI Component: `starkiller`

Starkiller provides a graphical user interface for interacting with the Empire Server. When launched, it typically manages certificates and provides a login interface for the Empire API.

```bash
starkiller
```

**Output/Actions:**
- Automatically generates/verifies SSL certificates in `~/.local/share/empire/cert/`.
- Launches the Electron-based interface for multi-user collaboration.

## Notes
- **Architecture**: Empire follows a client-server architecture. The `server` must be running for any `client` or `starkiller` instance to function.
- **Security**: Communications between agents and the server are encrypted.
- **Stealth**: The Windows agent is designed to execute in memory without spawning `powershell.exe`, helping to bypass some basic security monitoring.
- **Database**: Empire uses a backend database (often MySQL/MariaDB or SQLite) to persist listeners, agents, and gathered data.