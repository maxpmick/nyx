---
name: caldera
description: Scalable automated adversary emulation platform designed to automate red-team operations and incident response. Use when performing adversary emulation, testing security controls against MITRE ATT&CK techniques, or automating post-exploitation activities and incident response playbooks.
---

# caldera

## Overview
CALDERA is a cyber security framework built on the MITRE ATT&CK framework. It is designed to easily automate adversary emulation, assist manual red-teams, and automate incident response. It operates using a central server with an agent-based architecture to execute "abilities" (atomic actions) on target systems. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume CALDERA is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install caldera
```

## Common Workflows

### Start the server with default settings
```bash
caldera
```
Launches the server using the default configuration. Access the web UI (usually at `http://localhost:8888`) using the credentials found in `conf/local.yml` or `conf/default.yml`.

### Start with a fresh database
```bash
caldera --fresh
```
Removes the existing `object_store` on startup, effectively resetting the server state.

### Run with Debug logging
```bash
caldera -l DEBUG
```
Useful for troubleshooting plugin loading or agent connection issues.

### Build and serve the VueJS front-end
```bash
caldera --build
```
Compiles the front-end components to ensure the latest UI changes are served.

## Complete Command Reference

```
usage: server.py [-h] [-E ENVIRONMENT]
                 [-l {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--fresh]
                 [-P PLUGINS] [--insecure] [--uidev UIDEVHOST] [--build]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-E`, `--environment ENVIRONMENT` | Select a specific environment configuration file to use (e.g., `local`, `default`). |
| `-l`, `--log {DEBUG,INFO,WARNING,ERROR,CRITICAL}` | Set the logging verbosity level. Default is usually INFO. |
| `--fresh` | Remove the `object_store` (database) on start to begin with a clean state. |
| `-P`, `--plugins PLUGINS` | Start up the server with only a single specified plugin enabled. |
| `--insecure` | Start CALDERA with insecure default configuration values. This is equivalent to using `-E default`. |
| `--uidev UIDEVHOST` | Start the VueJS development server for front-end development alongside the CALDERA server. Requires providing a hostname (e.g., `localhost`). |
| `--build` | Build the VueJS front-end assets to serve them directly from the CALDERA server. |

## Notes
- **Default Credentials**: Check the configuration files in `/etc/caldera/` or the installation directory (often `conf/local.yml`) for the initial `admin` password.
- **Plugins**: CALDERA's power comes from its plugins (e.g., Stockpile, Atomic, Training). Use the web interface to manage and deploy agents like "Sandcat" (54ndc47).
- **Security**: Running with `--insecure` or default credentials is only recommended for isolated lab environments. Always change default passwords before deploying in a production-adjacent network.