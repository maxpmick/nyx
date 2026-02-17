---
name: caido-cli
description: A lightweight web security auditing toolkit and intercepting proxy. Use when performing web application security testing, intercepting HTTP/HTTPS traffic, or managing Caido instances from the command line. It serves as a modern alternative to Burp Suite for security professionals.
---

# caido-cli

## Overview
Caido is a lightweight web security auditing toolkit designed for speed and efficiency. The CLI version allows users to run the Caido backend, manage listeners, and configure the environment for web application penetration testing. Category: Web Application Testing.

## Installation (if not already installed)
Assume caido-cli is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install caido-cli
```

## Common Workflows

### Start Caido with default settings
```bash
caido-cli
```
Starts the backend and automatically opens the UI in the default browser.

### Start on a specific interface and port
```bash
caido-cli --listen 0.0.0.0:8080
```
Useful for running Caido on a remote VPS or a specific network interface.

### Headless mode for remote servers
```bash
caido-cli --no-open --listen 0.0.0.0:8080
```
Starts the service without attempting to open a local browser window.

### Custom data storage and guest access
```bash
caido-cli --data-path ./caido-data --allow-guests
```
Stores all project data in a local directory and enables guest login mode.

## Complete Command Reference

```
caido-cli [OPTIONS]
```

### Options

| Flag | Description |
|------|-------------|
| `-l, --listen <ADDR:PORT>` | Listening address for the Caido instance |
| `--invisible` | Enable invisible mode for all listeners (useful for non-proxy aware clients) |
| `--no-sync` | Disable synchronization with the Caido sync server |
| `--proxy-listen <ADDR:PORT>` | Specific listening addresses for the intercepting proxy |
| `--ui-listen <ADDR:PORT>` | Specific listening addresses for the web UI |
| `--ui-domain <UI_DOMAIN>` | Allowed domains for accessing the UI |
| `--no-open` | Do not automatically open the UI in a browser tab on startup |
| `--debug` | Record and display detailed debug logs |
| `--reset-cache` | Reset the instance cache of cloud data |
| `--reset-credentials` | **DANGEROUS**: Reset the instance credentials |
| `--data-path <DATA_PATH>` | Directory to store project data, logs, and configuration |
| `--no-logging` | Disable file-based logging |
| `--no-renderer-sandbox` | Disable sandboxing for the renderer process |
| `--import-ca-cert <PATH>` | Import an existing CA certificate for HTTPS interception |
| `--import-ca-cert-pass <PASS>` | Password for the imported CA certificate |
| `--allow-guests` | Allow users to log in as guests without an account |
| `--safe` | Enable safe mode (disables certain features for stability) |
| `-h, --help` | Print help information |
| `-V, --version` | Print version information |

## Notes
- **Security**: Using `--listen 0.0.0.0` exposes the Caido instance to the network. Ensure you use strong credentials or firewall rules.
- **Data Persistence**: By default, Caido stores data in standard OS-specific application directories. Use `--data-path` to keep project data portable.
- **CA Certificate**: To intercept HTTPS traffic, you must download the CA certificate from the Caido UI and install it in your browser/system or provide one via `--import-ca-cert`.