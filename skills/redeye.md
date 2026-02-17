---
name: redeye
description: Manage and organize data during penetration testing operations. Use when you need a centralized framework to track findings, manage assets, and maintain operational data in an efficient and organized manner throughout a pentest engagement.
---

# redeye

## Overview
Redeye is a data management tool designed to help penetration testers organize their findings and operational data efficiently. It provides a structured way to handle information gathered during various stages of a security assessment. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume Redeye is already installed. If you encounter errors, use the following command:

```bash
sudo apt install redeye
```

Dependencies include: python3, flask, neo4j, sqlite3, and various python libraries for document processing and networking.

## Common Workflows

### Start the Redeye Service
```bash
redeye
```
Initializes the backend services and the web interface for data management.

### Stop the Redeye Service
```bash
redeye-stop
```
Gracefully shuts down all running Redeye components and services.

### Accessing the Interface
Once the service is started, the tool typically provides a web-based dashboard. Check the terminal output for the specific local URL (usually `http://localhost:5000` or similar).

## Complete Command Reference

### redeye
The primary command to launch the Redeye framework service.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

### redeye-stop
Utility command to terminate the Redeye service and its background processes.

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |

## Notes
- Redeye uses a combination of SQLite and Neo4j for data persistence and relationship mapping. Ensure these services are not conflicted by other local instances if manual configuration has been performed.
- The tool is designed to be used throughout the lifecycle of a pentest, from initial reconnaissance to final reporting.
- Always ensure the service is stopped using `redeye-stop` to prevent database locks or corrupted session data.