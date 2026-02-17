---
name: bloodhound
description: Use graph theory to reveal hidden and unintended relationships within Active Directory environments. Use when performing Active Directory reconnaissance, identifying complex attack paths, mapping privilege escalation routes, or analyzing domain relationships during penetration testing or red teaming.
---

# bloodhound

## Overview
BloodHound Community Edition is a single-page Javascript web application that uses graph theory to visualize Active Directory (AD) environments. It helps attackers and defenders identify highly complex attack paths that are otherwise difficult to see. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume BloodHound is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install -y bloodhound
```

Dependencies: curl, neo4j, postgresql.

## Common Workflows

### Initial Setup
Before running BloodHound for the first time, you must initialize the database services:
```bash
sudo bloodhound-setup
```

### Starting the Application
After configuration, start the BloodHound CE server:
```bash
sudo bloodhound
```
The application will be available via the web interface (typically on port 8080 or as specified in the output).

### Resetting Admin Password
If you lose access to the admin account, use this environment variable to recreate the default admin:
```bash
sudo env bhe_recreate_default_admin=true bloodhound
```

## Complete Command Reference

### bloodhound
The main command to start the BloodHound CE service.

| Flag | Description |
|------|-------------|
| `-h` | Show help message |

### bloodhound-setup
A configuration script to initialize the environment. It performs the following:
- Starts PostgreSQL service
- Creates the `bloodhound` database and user
- Starts the Neo4j service
- Provides instructions for initial password configuration

### Configuration Files
- `/etc/bhapi/bhapi.json`: Contains the API configuration and database credentials. This file must be updated manually after changing the Neo4j password.

## Notes

### Initial Configuration Steps
1. Run `sudo bloodhound-setup`.
2. Open a browser to `http://localhost:7474` (Neo4j interface).
3. Login with default credentials (`neo4j` / `neo4j`) and set a new password.
4. Update the `"secret"` field in `/etc/bhapi/bhapi.json` with your new Neo4j password.
5. Run `sudo bloodhound`.
6. Login to the BloodHound web UI with default credentials (`admin` / `admin`) and set a new secure password.

### Data Collection
BloodHound requires data collected from a target domain using ingestors like SharpHound (C#) or BloodHound.py (Python). This tool is the **visualizer** for that data.

### Security
Ensure the Neo4j and BloodHound interfaces are not exposed to untrusted networks, as they contain sensitive information about the target environment's security posture.