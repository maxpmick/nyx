---
name: bettercap-ui
description: Access and manage the Bettercap web interface for network attacks and monitoring. Use when a graphical dashboard is preferred over the CLI for MITM attacks, WiFi probing, BLE sniffing, and network monitoring. Trigger when the user needs to visualize network traffic, manage caplets via a browser, or requires a dashboard for bettercap operations.
---

# bettercap-ui

## Overview
The official web-based user interface for Bettercap. It provides a high-level dashboard to monitor network events, manage interactive sessions, and execute modules like spoofing, sniffing, and wireless attacks through a browser. Category: Sniffing & Spoofing / Wireless Attacks.

## Installation (if not already installed)

Assume the UI is already installed. If the UI files are missing or the web server fails to start, run:

```bash
sudo apt update
sudo apt install bettercap-ui
```

Dependencies: `bettercap`, `bettercap-caplets`.

## Common Workflows

### Launching the UI with Bettercap
To start the UI, you must run bettercap and load the `http-ui` (or `https-ui`) caplet.

```bash
sudo bettercap -caplet http-ui
```
By default, the UI will be available at `http://127.0.0.1:80/`.

### Customizing Credentials and Port
You can override the default credentials (user: `user`, pass: `pass`) and port by setting environment variables or editing the caplet.

```bash
sudo bettercap -eval "set http.server.address 0.0.0.0; set http.server.port 8080; set api.rest.username admin; set api.rest.password password123; caplet http-ui"
```

### Updating the UI and Caplets
Ensure you have the latest UI components and caplets downloaded:

```bash
sudo bettercap -eval "caplets.update; ui.update; q"
```

## Complete Command Reference

The `bettercap-ui` package itself provides the static assets (HTML/JS/CSS) located in `/usr/share/bettercap/ui`. It is controlled via `bettercap` using the following modules and variables:

### UI Caplets
These are the primary entry points to start the interface:

| Caplet | Description |
|--------|-------------|
| `http-ui` | Starts the UI on HTTP (Port 80 by default) |
| `https-ui` | Starts the UI on HTTPS (Port 443 by default) |

### Relevant Bettercap Configuration Variables
These variables must be set *before* or *during* the loading of the UI caplet to modify its behavior:

| Variable | Description |
|----------|-------------|
| `api.rest.address` | IP address for the REST API to bind to (default: `127.0.0.1`) |
| `api.rest.port` | Port for the REST API (default: `8081`) |
| `api.rest.username` | Username for API/UI authentication |
| `api.rest.password` | Password for API/UI authentication |
| `http.server.address` | IP address for the Web UI server to bind to |
| `http.server.port` | Port for the Web UI server |
| `http.server.path` | Local path to the UI files (default: `/usr/share/bettercap/ui`) |

### UI Management Commands (Inside Bettercap)

| Command | Description |
|---------|-------------|
| `ui.update` | Downloads and installs the latest version of the Web UI |
| `caplets.update` | Updates the local caplet repositories (required for UI caplets) |

## Notes
- **Default Credentials**: The default login is `user` and `pass`. It is highly recommended to change these if the UI is bound to a public interface.
- **API Dependency**: The Web UI is a frontend for Bettercap's REST API. If the `api.rest` module is not running or is blocked by a firewall, the UI will not function.
- **Local Path**: On Kali Linux, the UI assets are stored in `/usr/share/bettercap/ui`. If the UI fails to load, verify this directory exists.