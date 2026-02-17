---
name: evilginx2
description: Man-in-the-middle attack framework used for phishing login credentials and session cookies to bypass 2-factor authentication (2FA). Use when performing advanced social engineering, adversary-in-the-middle (AiTM) attacks, or testing the efficacy of multi-factor authentication implementations during penetration testing.
---

# evilginx2

## Overview
evilginx2 is a standalone man-in-the-middle (MitM) framework written in Go. It implements its own HTTP and DNS servers to act as a proxy between a victim's browser and a target website. By capturing session cookies in real-time, it allows attackers to bypass 2-factor authentication (2FA) protections. Category: Social Engineering / Exploitation.

## Installation (if not already installed)
Assume evilginx2 is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install evilginx2
```

## Common Workflows

### Basic Startup
Launch the interactive console using default configuration paths:
```bash
sudo evilginx2
```

### Developer Mode
Run with self-signed certificates for local testing and phishlet development:
```bash
sudo evilginx2 -developer
```

### Custom Configuration Path
Start the tool using a specific directory for configuration and phishlets:
```bash
sudo evilginx2 -c ./my_config -p ./my_phishlets
```

### Interactive Console Setup (Typical Sequence)
Once inside the `evilginx2` shell, the typical workflow is:
1. Configure the external IP: `config ip <your_external_ip>`
2. Configure the domain: `config domain <your_phishing_domain>`
3. Select a phishlet: `phishlets hostname <phishlet_name> <your_phishing_domain>`
4. Enable the phishlet: `phishlets enable <phishlet_name>`
5. Create a lure: `lures create <phishlet_name>`
6. Get the lure URL: `lures get <lure_id>`

## Complete Command Reference

### CLI Flags
These flags are used when launching the binary from the terminal.

| Flag | Description |
|------|-------------|
| `-c <string>` | Configuration directory path (where config and database are stored) |
| `-debug` | Enable debug output for troubleshooting |
| `-developer` | Enable developer mode (generates self-signed certificates for all hostnames) |
| `-p <string>` | Phishlets directory path |
| `-t <string>` | HTML redirector pages directory path |
| `-v` | Show version information |

### Internal Console Commands
Once the tool is running, it provides an interactive shell with the following command categories:

#### config
Manage global configuration settings.
- `config` - View current configuration.
- `config ip <ip>` - Set the external IP address of the server.
- `config domain <domain>` - Set the base domain name used for phishing.

#### phishlets
Manage phishlet modules.
- `phishlets` - List available phishlets.
- `phishlets hostname <name> <hostname>` - Set the hostname for a specific phishlet.
- `phishlets enable <name>` - Enable a phishlet.
- `phishlets disable <name>` - Disable a phishlet.
- `phishlets get-url <name>` - Get the URL for a phishlet.

#### lures
Manage phishing URLs (lures).
- `lures` - List created lures.
- `lures create <phishlet>` - Create a new lure for a phishlet.
- `lures edit <id>` - Edit an existing lure.
- `lures delete <id>` - Delete a lure.
- `lures get <id>` - Get the phishing URL for a specific lure.

#### sessions
Manage captured credentials and cookies.
- `sessions` - List all captured sessions.
- `sessions <id>` - View detailed information for a specific session (including cookies).

## Notes
- **Permissions**: Must be run as `root` or with `sudo` to bind to privileged ports (80, 443, 53).
- **DNS**: Ensure your domain's nameservers point to the IP address of the server running evilginx2.
- **Certificates**: In non-developer mode, evilginx2 automatically attempts to retrieve SSL certificates from Let's Encrypt. Port 80 must be open for this process.
- **Phishlets**: Phishlets are YAML files that define how the proxy interacts with the target site. Default phishlets are usually located in `/usr/share/evilginx2/phishlets/`.