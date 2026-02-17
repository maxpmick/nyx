---
name: juice-shop
description: Deploy and manage OWASP Juice Shop, a modern and sophisticated insecure web application. Use when setting up a vulnerable environment for security training, awareness demos, CTFs, or as a target for testing security tools and practicing exploitation of OWASP Top Ten vulnerabilities.
---

# juice-shop

## Overview
OWASP Juice Shop is an intentionally insecure web application written in Node.js, Express, and Angular. It contains vulnerabilities from the entire OWASP Top Ten along with many other security flaws found in real-world applications. It is designed to be used as a "guinea pig" for security tools and manual penetration testing practice. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux Labs. If missing:

```bash
sudo apt update
sudo apt install juice-shop
```

## Common Workflows

### Start the Juice Shop service
```bash
juice-shop
```
This initializes the service and automatically attempts to open the Web UI in the default browser at `http://127.0.0.1:42000`.

### Stop the Juice Shop service
```bash
juice-shop-stop
```
This stops the underlying systemd service and frees up port 42000.

### Verify service status
```bash
systemctl status juice-shop
```
Check if the application is currently running, active, or failed.

## Complete Command Reference

### juice-shop
Starts the OWASP Juice Shop application service.

| Flag | Description |
|------|-------------|
| `-h` | Displays the startup message and local URL. Note: This command primarily triggers the service start rather than a traditional help menu. |

**Output Details:**
- Default Web UI: `http://127.0.0.1:42000`
- The command will wait for the service to initialize before confirming the URL.

### juice-shop-stop
Stops the OWASP Juice Shop application service.

| Flag | Description |
|------|-------------|
| `-h` | Displays the systemd status and shutdown logs for the juice-shop service. |

## Notes
- **Security Warning**: Do not host this application on any internet-facing server or public folder. It is intentionally vulnerable and will lead to a full system compromise if exposed.
- **Port Conflict**: The application defaults to port `42000`. Ensure this port is not being used by other services before starting.
- **Persistence**: The application runs as a systemd service (`juice-shop.service`).
- **Browser Refresh**: You may need to refresh your browser once the service starts to properly load the Angular frontend.