---
name: dradis
description: Manage the Dradis Framework, a collaboration and reporting platform for penetration testers. Use when you need to aggregate output from multiple security scanners, track assessment progress, or generate professional reports. It provides a centralized web interface for teams to share findings and ensure consistent quality during security engagements.
---

# dradis

## Overview
Dradis is an open-source collaboration framework designed to simplify reporting and information sharing for security professionals. It allows testers to combine outputs from various tools (like Nmap, Nessus, Burp Suite) into a single repository. Category: Reporting Tools.

## Installation (if not already installed)
Assume Dradis is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install dradis
```

## Common Workflows

### Start the Dradis service
To begin using the web interface, start the background service:
```bash
sudo dradis
```
Once started, the application is typically accessible at `http://127.0.0.1:3000`.

### Check service status
Verify if the Dradis application is currently running:
```bash
systemctl status dradis
```

### Stop the Dradis service
To shut down the application and free up system resources:
```bash
sudo dradis-stop
```

## Complete Command Reference

Dradis on Kali Linux is managed primarily through service wrapper scripts rather than complex CLI flags.

### dradis
The main command to initialize and start the Dradis web application service. It checks for dependencies and starts the Puma web server.

| Command | Description |
|---------|-------------|
| `dradis` | Starts the Dradis service and listens on port 3000. |

### dradis-stop
A helper script to gracefully shut down the Dradis service.

| Command | Description |
|---------|-------------|
| `dradis-stop` | Stops the running `dradis.service` via systemd. |

### Service Management
Since Dradis is integrated as a system service, standard service commands apply:

| Command | Description |
|---------|-------------|
| `sudo service dradis start` | Alternative method to start the service. |
| `sudo service dradis stop` | Alternative method to stop the service. |
| `sudo service dradis restart` | Restarts the service (useful if the web UI becomes unresponsive). |

## Notes
- **First Run**: On the first launch, you will be prompted to create an initial shared password or set up an administrator account via the web interface.
- **Port Conflicts**: Dradis defaults to port `3000`. If another service (like Ruby on Rails apps or Gitea) is using this port, the service may fail to start.
- **Browser Access**: Access the interface at `http://localhost:3000` or `https://localhost:3000` depending on your local configuration.
- **Data Persistence**: Dradis uses a database to store findings; ensure the service is stopped gracefully to prevent data corruption.