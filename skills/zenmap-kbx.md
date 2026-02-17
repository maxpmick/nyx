---
name: zenmap-kbx
description: Launch and manage the Zenmap graphical user interface for Nmap within a Kaboxer container. Use when a GUI is preferred for Nmap scanning, results visualization, or network topology mapping, especially in environments where native GTK dependencies for Zenmap are unavailable.
---

# zenmap-kbx

## Overview
Zenmap is the official Nmap Security Scanner GUI. It is a multi-platform, free and open-source application designed to make Nmap easy for beginners to use while providing advanced features for experienced Nmap users. This specific package, `zenmap-kbx`, runs Zenmap inside a Docker container managed by Kaboxer to ensure compatibility with modern systems. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, install it via:

```bash
sudo apt update
sudo apt install zenmap-kbx
```
Note: This tool requires `docker.io` (or `docker-ce`) and `kaboxer` to function.

## Common Workflows

### Launch the Zenmap GUI
```bash
zenmap-kbx
```
This initializes the container and opens the graphical interface.

### Run Zenmap with specific Nmap arguments via GUI
Once the GUI is open, you can use the "Command" field to input standard Nmap flags. For example, to perform an Intense Scan:
`nmap -T4 -A -v <target>`

### Manage the underlying container
Since this is a Kaboxer-managed application, you can manage the container lifecycle:
```bash
kaboxer stop zenmap-kbx
```

## Complete Command Reference

The `zenmap-kbx` command is a wrapper for the Kaboxer container execution.

### Primary Command
| Command | Description |
|---------|-------------|
| `zenmap-kbx` | Launches the Zenmap GUI application. |

### Kaboxer Integration Options
As a Kaboxer-packaged tool, it supports standard Kaboxer management commands if called via the kaboxer binary:

| Command | Description |
|---------|-------------|
| `kaboxer run zenmap-kbx` | Run the application (same as calling the binary directly). |
| `kaboxer stop zenmap-kbx` | Stop the running container instance. |
| `kaboxer list` | List all installed Kaboxer applications, including zenmap-kbx. |
| `kaboxer delete zenmap-kbx` | Remove the container image and associated data. |

## Notes
- **Containerization**: Because Zenmap runs in a container, file paths provided for saving results or loading scripts must be accessible within the container's mount points (usually mapped to the user's home directory).
- **Root Privileges**: To perform raw packet scans (like SYN scans `-sS`), the container must have appropriate permissions. Running `zenmap-kbx` as a user in the `docker` group is typically required.
- **X11 Forwarding**: The tool automatically handles X11 socket forwarding to display the GUI on the host desktop.