---
name: king-phisher
description: Simulate real-world phishing attacks to test and promote user awareness. It features a flexible architecture for full control over emails and server content, supporting campaigns from simple awareness training to complex credential harvesting. Use when performing social engineering assessments, phishing simulations, or red team engagements.
---

# king-phisher

## Overview
King Phisher is an open-source phishing campaign toolkit designed to simulate real-world attacks. It uses a client-server architecture where the server handles the delivery and hosting, while the GUI client provides a centralized interface for campaign management, message templating, and results tracking. Category: Social Engineering.

## Installation (if not already installed)
Assume King Phisher is already installed. If you encounter errors, install via:

```bash
sudo apt install king-phisher
```

## Common Workflows

### Starting the Phishing Server
The server must be running before the client can connect. It requires a configuration file (usually `server_config.yml`).
```bash
sudo king-phisher-server /etc/king-phisher/server_config.yml
```

### Verifying Server Configuration
Check the configuration file for syntax errors without starting the service.
```bash
king-phisher-server --verify-config /etc/king-phisher/server_config.yml
```

### Launching the Management Client
Start the GUI client to design emails, manage target lists, and view campaign statistics.
```bash
king-phisher-client
```

### Running Client with Debug Logging
Useful for troubleshooting connection issues or plugin errors.
```bash
king-phisher-client -L DEBUG
```

## Complete Command Reference

### king-phisher-client
The graphical user interface used by the operator to manage campaigns.

```
usage: KingPhisher [-h] [-v] [-L {DEBUG,INFO,WARNING,ERROR,FATAL}]
                   [--logger LOGGER] [--gc-debug-leak] [--gc-debug-stats]
                   [-c CONFIG_FILE] [--no-plugins] [--no-style]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-v`, `--version` | Show program's version number and exit |
| `-L`, `--log <LEVEL>` | Set the logging level (DEBUG, INFO, WARNING, ERROR, FATAL) |
| `--logger <LOGGER>` | Specify the root logger |
| `--gc-debug-leak` | Set the garbage collector DEBUG_LEAK flag |
| `--gc-debug-stats` | Set the garbage collector DEBUG_STATS flag |
| `-c`, `--config <FILE>` | Specify a custom configuration file to use |
| `--no-plugins` | Disable all client-side plugins |
| `--no-style` | Disable interface styling (GTK CSS) |

---

### king-phisher-server
The backend service that hosts the phishing pages and sends the emails.

```
usage: KingPhisherServer [-h] [-v] [-L {DEBUG,INFO,WARNING,ERROR,FATAL}]
                         [--logger LOGGER] [--gc-debug-leak]
                         [--gc-debug-stats] [-f] [--verify-config]
                         config_file
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-v`, `--version` | Show program's version number and exit |
| `-L`, `--log <LEVEL>` | Set the logging level (DEBUG, INFO, WARNING, ERROR, FATAL) |
| `--logger <LOGGER>` | Specify the root logger |
| `--gc-debug-leak` | Set the garbage collector DEBUG_LEAK flag |
| `--gc-debug-stats` | Set the garbage collector DEBUG_STATS flag |
| `-f`, `--foreground` | Run in the foreground (do not fork into background) |
| `--verify-config` | Verify the configuration file syntax and exit |
| `config_file` | **(Required)** Path to the server configuration file |

## Notes
- The server typically requires root privileges if binding to privileged ports (e.g., 80, 443).
- King Phisher supports Jinja2 templating for both email messages and server-side web pages.
- Ensure the `postgresql` service is running if the server is configured to use a local database.