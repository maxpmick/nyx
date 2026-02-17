---
name: dvwa
description: Deploy and manage Damn Vulnerable Web Application (DVWA), a PHP/MySQL web application designed for security professionals to test skills and tools legally. Use when setting up a local lab environment for web application security testing, practicing exploitation of common vulnerabilities (SQLi, XSS, CSRF), or demonstrating web security concepts in a controlled environment.
---

# dvwa

## Overview
Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that is intentionally vulnerable. It serves as a training aid for security professionals and students to practice discovering and exploiting web vulnerabilities across various difficulty levels. Category: Web Application Testing / Kali Labs.

## Installation (if not already installed)
Assume DVWA is already installed. If the commands are missing:

```bash
sudo apt update
sudo apt install dvwa
```

Dependencies include `apache2`, `mariadb-server`, `php`, and several PHP modules.

## Common Workflows

### Start the DVWA environment
This command initializes the database and starts the necessary web server services.
```bash
sudo dvwa-start
```
After running this, the application is typically accessible at `http://127.0.0.1/dvwa/` or `http://localhost/dvwa/`.

### Stop the DVWA environment
This command shuts down the services associated with the DVWA lab to free up system resources and secure the host.
```bash
sudo dvwa-stop
```

### Resetting the Lab
If the application becomes unstable or you wish to clear previous exploits, run the start command again or use the "Setup / Reset DB" button within the web interface.

## Complete Command Reference

The DVWA package in Kali Linux provides helper scripts to manage the local lab environment.

### dvwa-start
Starts the DVWA service. This script typically handles:
- Starting the Apache2 or Nginx web server.
- Starting the MariaDB/MySQL database server.
- Ensuring the environment is configured for local access.

### dvwa-stop
Stops the DVWA service. This script typically handles:
- Stopping the web server.
- Stopping the database server.

## Notes
- **Security Warning**: Do not host DVWA on any internet-facing server or public HTML folder. It is intentionally insecure and will lead to system compromise if exposed.
- **Default Credentials**: The default login for the web interface is usually `admin` / `password`.
- **Difficulty Levels**: The application features "Low", "Medium", "High", and "Impossible" security levels, which can be toggled within the "DVWA Security" settings page to test different bypass techniques.
- **Database Setup**: On the first run, you may need to click the "Create / Reset Database" button at the bottom of the setup page in your browser.