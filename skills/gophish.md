---
name: gophish
description: Open-source phishing toolkit designed for businesses and penetration testers to execute phishing engagements and security awareness training. Use when performing social engineering assessments, simulating phishing campaigns, tracking email click-through rates, or managing credential harvesting landing pages.
---

# gophish

## Overview
Gophish is a powerful, open-source phishing framework that makes it easy to test an organization's exposure to phishing. It features a web-based interface to manage targets, build email templates, create landing pages, and monitor campaign results in real-time. Category: Social Engineering.

## Installation (if not already installed)

Assume gophish is already installed. If the command is missing:

```bash
sudo apt install gophish
```

Dependencies: adduser, libc6, libsqlite3-0, sudo.

## Common Workflows

### Starting the Gophish server
```bash
sudo gophish
```
This initializes the database (on first run), starts the admin server (default port 3333), and the phishing server (default port 80). Note the temporary admin password printed to the console on the first execution.

### Accessing the Web Interface
Once started, navigate to the admin panel in a web browser:
`https://127.0.0.1:3333`

### Stopping the Gophish service
```bash
sudo gophish-stop
```
Use this command to safely terminate the running gophish background processes.

### Typical Campaign Setup
1. **Sending Profiles**: Configure SMTP settings (e.g., using an open relay or Mailgun).
2. **Landing Pages**: Create the HTML page the victim sees (can clone existing sites).
3. **Email Templates**: Create the phishing email with tracking links.
4. **Users & Groups**: Import target email addresses via CSV.
5. **Campaigns**: Combine the above elements and launch.

## Complete Command Reference

### gophish
The main binary to start the phishing server and administrative interface.

```bash
gophish [options]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-c`, `--config` | Path to the configuration file (default: `config.json`) |

*Note: Most configuration (ports, TLS settings, database connection) is handled via the `config.json` file located in the gophish directory (usually `/usr/share/gophish` or the current working directory).*

### gophish-stop
A helper script provided in Kali Linux to stop the gophish service/process.

```bash
gophish-stop
```

## Notes
- **First Run**: On the first execution, gophish generates a random password for the `admin` user. Look for "Please login with the username admin and the password [random_string]" in the terminal output.
- **Permissions**: Gophish often requires `sudo` to bind to privileged ports like 80 (HTTP) or 443 (HTTPS).
- **Configuration**: To allow remote access to the admin panel, edit `config.json` and change `admin_server.listen_url` from `127.0.0.1:3333` to `0.0.0.0:3333`.
- **Database**: By default, gophish uses SQLite. For larger engagements, it can be configured to use MySQL in the `config.json`.