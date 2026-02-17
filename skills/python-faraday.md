---
name: python-faraday
description: A collaborative Penetration Test IDE (IPE) designed for distributing, indexing, and analyzing security audit data. It integrates with common security tools (Nmap, Burp, Nikto, etc.) to capture results in a multi-user environment. Use when managing a team-based penetration test, consolidating results from multiple scanners, or tracking vulnerabilities across a workspace in real-time.
---

# Faraday

## Overview
Faraday is an Integrated Penetration-Test Environment (IPE) that allows for the distribution, indexation, and analysis of data generated during a security audit. It functions as a collaborative middleware that captures the output of various security tools and organizes them into a unified database with a web interface and a specialized terminal. Category: Reporting / Vulnerability Analysis.

## Installation (if not already installed)
Faraday is typically pre-installed in Kali Linux. If missing:

```bash
sudo apt update
sudo apt install faraday
```

## Common Workflows

### Initialize and Start Faraday
Before the first run, initialize the database and create a superuser.
```bash
# Initialize the database
faraday-manage initdb
# Create an admin account
faraday-manage create-superuser
# Start the server
faraday-server
```

### Running Scans via Faraday Terminal
When running supported tools inside the Faraday environment, results are automatically parsed.
```bash
# Example: Nmap scan within a Faraday-aware shell
nmap -A 192.168.0.7
```

### Importing Existing Results
If you have scan files from other tools, use the ingest command to import them into a workspace.
```bash
faraday-manage ingest --workspace my_project --path /path/to/nmap_output.xml
```

### Managing Custom Fields
Add custom metadata to vulnerabilities for better reporting.
```bash
faraday-manage add-custom-field
```

## Complete Command Reference

### faraday / python-faraday
Kali wrapper scripts to manage the Faraday service.
- `faraday -h`: Starts the faraday.service.

### faraday-manage
Helper utility for database management, user administration, and configuration.

**Usage:** `faraday-manage [OPTIONS] COMMAND [ARGS]...`

**Options:**
- `-h, --help`: Show help message.

**Commands:**
| Command | Description |
|---------|-------------|
| `add-custom-field` | Custom field wizard for vulnerabilities |
| `change-password` | Changes the password of a user |
| `create-superuser` | Create ADMIN user for Faraday application |
| `create-tables` | Create database tables |
| `database-schema` | Create a PNG image of the Faraday data model |
| `delete-custom-field` | Custom field delete wizard |
| `generate-nginx-config` | Generate nginx configuration for production deployment |
| `import-vulnerability-templates` | Import Vulnerability templates for standardized reporting |
| `ingest` | Import vulnerabilities from one or all supported tool outputs |
| `initdb` | Create Faraday DB in Postgresql and initialize schema |
| `list-plugins` | List all available tool plugins |
| `migrate` | Migrates database schema to the latest version |
| `move-references` | Move references from deprecated models |
| `openapi-swagger` | Creates Faraday Swagger config file |
| `rename-user` | Change a username |
| `settings` | Manage application settings |
| `show-urls` | Show all available URLs in Faraday Server API |
| `sql-shell` | Open a SQL Shell connected to the Faraday database |
| `sync-hosts-stats` | Synchronize vulnerability severity statistics |

### faraday-server
The main backend service for Faraday.

**Usage:** `faraday-server [options]`

**Options:**
- `-h, --help`: Show help message.
- `--debug`: Run Faraday Server in debug mode.
- `--update_stats`: Updates host and workspace stats of failed commands.
- `--port PORT`: Overrides `server.ini` port configuration.
- `--bind_address BIND_ADDRESS`: Overrides `server.ini` bind_address configuration.
- `-v, --version`: Show program's version number.
- `--with-workers`: Starts Celery workers.
- `--with-workers-gevent`: Run workers in gevent mode.
- `--workers-queue WORKERS_QUEUE`: Specify Celery queue.
- `--workers-concurrency WORKERS_CONCURRENCY`: Set Celery concurrency level.
- `--workers-loglevel WORKERS_LOGLEVEL`: Set Celery log level.

### faraday-worker / faraday-worker-gevent
Standalone worker processes for handling background tasks.

**Options:**
- `-h, --help`: Show help message.
- `--queue QUEUE`: Celery queue name.
- `--concurrency CONCURRENCY`: Number of concurrent processes.
- `--loglevel LOGLEVEL`: Log level (DEBUG, INFO, WARNING, ERROR).

## Notes
- **Supported Plugins**: Faraday supports a wide range of tools including Nmap, Dirb, Burp, Nessus, SQLMap, Nikto, and Metasploit. Plugins are located in `/usr/share/python-faraday/plugins/repo`.
- **Web Interface**: Once the server is running, the dashboard is typically accessible via `http://localhost:5985`.
- **Database**: Faraday requires PostgreSQL to be running. Ensure the service is active: `sudo systemctl start postgresql`.