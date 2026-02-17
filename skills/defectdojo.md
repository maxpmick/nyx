---
name: defectdojo
description: Manage application security programs, triage vulnerabilities, and orchestrate security workflows. Use when setting up a vulnerability management platform, aggregating scan results from multiple tools, tracking remediation progress, or integrating security findings with JIRA and Slack.
---

# defectdojo

## Overview
DefectDojo is a security orchestration and vulnerability management platform. It allows security teams to maintain product information, triage vulnerabilities, and enrich data using heuristic algorithms. It acts as a central hub for security findings from various scanners. Category: Vulnerability Analysis / Identify.

## Installation (if not already installed)
Assume DefectDojo is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install defectdojo
```

## Common Workflows

### Initialize and Start DefectDojo
Running the main command initializes the database, runs migrations, and starts the services (Nginx, Gunicorn, Celery, Redis, and PostgreSQL).
```bash
sudo defectdojo
```

### Stop All Services
To gracefully shut down the DefectDojo ecosystem and its background workers:
```bash
sudo defectdojo-stop
```

### Accessing the Interface
Once started, the application is typically available via a web browser. Check the terminal output for the specific binding address (usually `http://localhost:8080` or similar depending on Nginx configuration).

## Complete Command Reference

### defectdojo
The primary executable. It manages the lifecycle of the application including database readiness checks, Django migrations, and service orchestration.

```bash
defectdojo [options]
```

*Note: The tool primarily uses environment variables and configuration files for advanced settings. Running the command without arguments initiates the standard startup sequence.*

| Action Performed | Description |
|------------------|-------------|
| Database Check | Verifies PostgreSQL user and database existence; creates them if missing. |
| Migrations | Automatically runs `makemigrations` and `migrate` to ensure the schema is up to date. |
| Service Start | Launches Celery workers, Redis, Nginx, and the Gunicorn application server. |

### defectdojo-stop
A utility script to stop all running components associated with the DefectDojo instance.

```bash
defectdojo-stop
```

## Notes
- **Privileges**: Since it manages system services (Nginx, Postgres), these commands usually require `sudo`.
- **First Run**: On the first execution, the tool will perform extensive database migrations which may take several minutes.
- **Integration**: DefectDojo supports importing results from 70+ tools including Burp, Nessus, Zap, and Nmap.
- **Data Persistence**: Data is stored in a local PostgreSQL database. Ensure backups are performed if used in production.