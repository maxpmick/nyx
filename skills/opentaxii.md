---
name: opentaxii
description: Deploy and manage a TAXII (Trusted Automated eXchange of Indicator Information) server for sharing cyber threat intelligence (CTI). Use when setting up a central repository for STIX data, managing threat intelligence feeds, or creating a TAXII 2.1 compliant server for security operations and information sharing.
---

# opentaxii

## Overview
OpenTAXII is a robust Python implementation of TAXII Services (Trusted Automated eXchange of Indicator Information). It provides a feature-rich API for exchanging cyber threat intelligence and is designed to be compatible with the Cabby TAXII client library. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume OpenTAXII is already installed. If the commands are missing:

```bash
sudo apt update
sudo apt install opentaxii
```

## Common Workflows

### Initialize a Development Server
Start the built-in Flask development server for testing or local configuration.
```bash
opentaxii-run-dev
```

### Create an Admin Account
Create a new user with administrative privileges for the TAXII server.
```bash
opentaxii-create-account -u admin_user -p StrongPassword123 --admin
```

### Configure via YAML
Sync services, collections, and accounts from a configuration file.
```bash
opentaxii-sync-data config.yaml
```

### Manage API Roots and Collections
Add a new API root and then attach a collection to it.
```bash
opentaxii-add-api-root -t "Internal Threat Intel" -d "Private indicators" --default
opentaxii-add-collection -r "api_root_id" -t "Phishing Indicators" --public
```

## Complete Command Reference

### opentaxii-add-api-root
Add a new TAXII 2 ApiRoot object.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-t, --title TITLE` | Title of the API root |
| `-d, --description DESCRIPTION` | Description of the API root |
| `--default` | Set as default API root (default: False) |

### opentaxii-add-collection
Add a new TAXII 2 Collection object.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-r, --rootid ID` | API root ID of the collection |
| `-t, --title TITLE` | Title of the collection |
| `-d, --description DESCRIPTION` | Description of the collection |
| `-a, --alias ALIAS` | Alias of the collection |
| `--public` | Allow public read access (default: False) |
| `--public-write` | Allow public write access (default: False) |

### opentaxii-create-account
Create an account via OpenTAXII Auth API.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-u, --username USERNAME` | Username for the new account |
| `-p, --password PASSWORD` | Password for the new account |
| `-a, --admin` | Grant admin access (default: False) |

### opentaxii-update-account
Update an existing account.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-u, --username USERNAME` | Username of the account to update |
| `-f, --field {password,admin}` | Field to update |
| `-v, --value VALUE` | New value for the specified field |

### opentaxii-delete-blocks
Delete content blocks from specified collections within a time window.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-c, --collection COLLECTION` | Collection to remove content blocks from |
| `-m, --with-messages` | Delete inbox messages associated with deleted content blocks |
| `--begin BEGIN` | Exclusive beginning of time window (ISO8601 format) |
| `--end END` | Inclusive ending of time window (ISO8601 format) |

### opentaxii-sync-data
Create services, collections, and accounts from a YAML configuration.

| Argument/Flag | Description |
|---------------|-------------|
| `config` | **Positional**: YAML file with data configuration |
| `-h, --help` | Show help message and exit |
| `-f, --force-delete` | Force deletion of collections/blocks if not in config file |

### opentaxii-run-dev
Runs the Flask development server with debug mode enabled.

### opentaxii-job-cleanup
Removes completed or obsolete jobs from the environment.

## Notes
- OpenTAXII is designed to work seamlessly with the `cabby` client for testing and interaction.
- The `opentaxii-run-dev` command is intended for development and testing only; use a production-grade WSGI server (like Gunicorn) for deployment.
- Time windows for `opentaxii-delete-blocks` must follow the ISO8601 format (e.g., `2023-10-27T10:00:00Z`).