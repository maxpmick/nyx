---
name: covenant-kbx
description: Manage the Covenant .NET command and control (C2) framework via Kaboxer. Covenant is a collaborative platform for red teamers designed to highlight the .NET attack surface and facilitate offensive .NET tradecraft. Use when setting up a C2 infrastructure, managing remote listeners, or conducting red team operations requiring a web-based multi-user interface.
---

# covenant-kbx

## Overview
Covenant is an ASP.NET Core, cross-platform command and control framework. It provides a web-based interface for multi-user collaboration and focuses on offensive .NET tradecraft. The `covenant-kbx` package uses Kaboxer to run Covenant within a containerized environment on Kali Linux. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
The tool is typically pre-installed in some Kali variants. If missing, install via:

```bash
sudo apt update
sudo apt install covenant-kbx
```

**Dependencies:**
* docker.io | docker-ce
* kaboxer
* xdg-utils

## Common Workflows

### Starting the C2 Server
To launch the Covenant service and the web interface:
```bash
sudo covenant-kbx start
```
After starting, the web interface is typically accessible via `https://localhost:7443`.

### Stopping the C2 Server
To shut down the Covenant container and stop the service:
```bash
sudo covenant-kbx stop
```

## Complete Command Reference

```
covenant-kbx <command>
```

### Subcommands

| Command | Description |
|---------|-------------|
| `start` | Starts the Covenant container and launches the web interface. |
| `stop`  | Stops the running Covenant container. |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help/usage message. |

## Notes
- **Initial Setup**: On the first launch, you will be prompted to create an initial administrative user via the web interface.
- **Containerization**: Since this tool runs via Kaboxer (Docker), ensure the Docker service is running (`sudo systemctl start docker`) if the tool fails to initialize.
- **Network Access**: By default, Covenant listens on port 7443 for the web UI. Ensure your firewall settings allow access if connecting from a remote machine.