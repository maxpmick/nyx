---
name: caido
description: Perform web application security testing and auditing using a lightweight, fast, and modern intercepting proxy. Use when conducting web application penetration testing, intercepting HTTP/HTTPS traffic, replaying requests, or automating web security tasks. It serves as a modern alternative to Burp Suite or OWASP ZAP.
---

# caido

## Overview
Caido is a lightweight security auditing toolkit designed for web application penetration testing. It features a fast intercepting proxy, request replaying capabilities, and a modular architecture. It is built for performance and efficiency, making it suitable for both desktop and remote environments. Category: Web Application Testing.

## Installation (if not already installed)

Assume caido is already installed. If you get a "command not found" error:

```bash
sudo apt install caido
```

## Common Workflows

### Launching the Desktop Application
Simply run the command to start the Caido instance and open the interface:
```bash
caido
```

### Running Caido CLI (Headless Mode)
If using the CLI-specific binary (often used for remote servers):
```bash
caido-cli --listen 0.0.0.0:8080
```

### Specifying a Custom Data Directory
To keep project data in a specific location:
```bash
caido --data-path ~/projects/pentest-caido
```

## Complete Command Reference

The `caido` command launches the desktop application. The following flags and options are available for configuring the instance:

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help information |
| `-V`, `--version` | Print version information |
| `--data-path <path>` | Set the directory where Caido stores its data (projects, configuration, etc.) |
| `--listen <address>` | Specify the address and port for the Caido instance to listen on (e.g., `127.0.0.1:8080`) |
| `--no-browser` | Start the Caido backend without automatically opening the desktop window or system browser |

### Proxy Configuration

| Flag | Description |
|------|-------------|
| `--proxy-port <port>` | Set the port for the intercepting proxy (default is usually 8080) |
| `--proxy-address <address>` | Set the interface address for the intercepting proxy |

### Logging and Debugging

| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | Increase logging verbosity for troubleshooting |
| `--log-path <path>` | Specify a custom file path for application logs |

## Notes
- Caido uses a client-server architecture. Even the desktop app runs a local backend.
- Ensure your browser is configured to use the Caido proxy address (default `127.0.0.1:8080`) and that the Caido CA certificate is installed in your browser for HTTPS interception.
- Caido is designed to be resource-efficient compared to Java-based alternatives.