---
name: gvm
description: Manage the Greenbone Vulnerability Manager (formerly OpenVAS), a modular security auditing tool for testing remote systems for vulnerabilities. Use when performing vulnerability analysis, network security auditing, or managing the OpenVAS scanner services and feeds.
---

# gvm

## Overview
The Greenbone Vulnerability Manager (GVM) is a comprehensive vulnerability scanning and management solution. It consists of several components including the OpenVAS scanner, Notus scanner, and the Greenbone Security Assistant (Web UI). Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume GVM is already installed. If the commands are missing:

```bash
sudo apt update
sudo apt install gvm
```

## Common Workflows

### Initial Setup and Configuration
Run this once to initialize the database, generate certificates, and download the initial vulnerability feeds.
```bash
sudo gvm-setup
```

### Verifying Installation Health
Check if all services are correctly configured and if feeds are up to date.
```bash
sudo gvm-check-setup
```

### Starting the Vulnerability Scanner
Start all background services and the Web UI.
```bash
sudo gvm-start
```
Once started, access the interface at `https://127.0.0.1:9392`.

### Stopping all GVM Services
Gracefully shut down the scanner, manager, and web assistant.
```bash
sudo gvm-stop
```

### Updating Vulnerability Feeds (NVTs)
If `gvm-check-setup` reports missing NVTs, run the synchronization script.
```bash
sudo greenbone-feed-sync --type nvt
```

## Complete Command Reference

GVM on Kali is managed via a set of helper scripts that orchestrate the underlying daemons (`gsad`, `gvmd`, `openvas-scanner`, `ospd-openvas`, `notus-scanner`).

### gvm-setup
Initializes the GVM environment.
- Starts PostgreSQL service.
- Creates GVM certificate files.
- Creates and migrates the PostgreSQL database (`gvmd`).
- Configures the Feed Import Owner.
- Performs the initial synchronization of vulnerability feeds.

### gvm-check-setup
Diagnostic tool to verify the readiness of the GVM installation.
- Checks for presence and versions of OpenVAS and Notus scanners.
- Verifies CA certificates and file permissions.
- Checks Redis server connectivity and socket configuration.
- Validates MQTT server URI configuration.
- Verifies the integrity and presence of the NVT (Network Vulnerability Test) collection.

### gvm-start
Starts the GVM service stack.
- Launches the Greenbone Security Assistant (gsad) on port 9392.
- Launches the GVM daemon (gvmd).
- Launches the OSPd wrapper for OpenVAS.
- Launches the Notus scanner.

### gvm-stop
Stops all active GVM services.
- Stops `gsad.service`.
- Stops `gvmd.service`.
- Stops `ospd-openvas.service`.
- Stops `notus-scanner.service`.

## Notes
- **Web UI Access**: By default, the interface is available at `https://127.0.0.1:9392`.
- **Feed Updates**: Vulnerability feeds (NVTs, SCAP, Cert data) require regular updates to detect the latest threats. Use `greenbone-feed-sync` if the automated updates fail.
- **Permissions**: Most `gvm-*` helper scripts require `sudo` or root privileges to manage system services and databases.
- **Database**: GVM relies heavily on PostgreSQL; ensure the PostgreSQL service is functional if troubleshooting database errors.