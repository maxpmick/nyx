---
name: laudanum
description: A collection of injectable web shells and scripts for various environments including PHP, ASP, ASPX, JSP, and ColdFusion. Use during post-exploitation or web application testing when a file upload vulnerability, command injection, or administrative access allows for placing files on a web server to gain remote command execution, perform DNS queries, or retrieve LDAP information.
---

# laudanum

## Overview
Laudanum is a collection of injectable web files designed to be used during penetration testing when a vulnerability allows for the upload or creation of files on a target web server. It supports multiple languages and frameworks (PHP, ASP, ASPX, JSP, ColdFusion) and provides functionalities such as shells, DNS query tools, and LDAP retrieval. Category: Web Application Testing / Post-Exploitation.

## Installation (if not already installed)
Assume laudanum is already installed. The files are located in `/usr/share/laudanum`. If the directory is missing:

```bash
sudo apt install laudanum
```

## Common Workflows

### Locating a PHP Reverse Shell
To find the available PHP payloads to upload to a compromised web server:
```bash
ls -R /usr/share/laudanum/php/
```

### Using the ASPX Shell
If you have administrative access to a Windows IIS server or a file upload vulnerability:
1. Copy `/usr/share/laudanum/aspx/shell.aspx` to your local working directory.
2. Upload `shell.aspx` to the target server.
3. Access the file via a browser to execute system commands.

### Deploying a WordPress Plugin Shell
For compromised WordPress sites with plugin installation privileges:
1. Locate the plugin shell at `/usr/share/laudanum/wordpress/laudanum.zip`.
2. Upload and activate the zip file as a new plugin in the WordPress dashboard.
3. Access the shell via the provided plugin path.

## Complete Command Reference

Laudanum is a library of files rather than a standalone binary. The primary "command" is navigating the file structure located at `/usr/share/laudanum`.

### Directory Structure

| Path | Description |
|------|-------------|
| `/usr/share/laudanum/asp/` | Classic ASP shells and tools |
| `/usr/share/laudanum/aspx/` | ASP.NET shells and tools |
| `/usr/share/laudanum/cfm/` | ColdFusion (CFM) shells |
| `/usr/share/laudanum/jsp/` | Java Server Pages (JSP) shells |
| `/usr/share/laudanum/php/` | PHP shells, DNS tools, and LDAP tools |
| `/usr/share/laudanum/wordpress/` | Malicious WordPress plugin for shell access |
| `/usr/share/laudanum/helpers/` | Supporting scripts and configuration helpers |

### Included Tools by Language

#### PHP (`/usr/share/laudanum/php/`)
- `config.php`: Configuration file for PHP shells.
- `dns.php`: Tool for performing DNS queries from the web server.
- `filebrowser.php`: Web-based file explorer.
- `ldap.php`: Tool for LDAP information retrieval.
- `php-reverse-shell.php`: Reverse shell payload.
- `shell.php`: Simple web-based command execution shell.

#### ASPX (`/usr/share/laudanum/aspx/`)
- `shell.aspx`: ASP.NET command execution shell.
- `dns.aspx`: DNS lookup tool for .NET environments.

#### JSP (`/usr/share/laudanum/jsp/`)
- `cmd.jsp`: Basic JSP command execution.
- `war/`: Directory containing WAR file templates for deployment.

## Notes
- **Security**: Many of these shells are well-known to Antivirus (AV) and Endpoint Detection and Response (EDR) solutions. They may require obfuscation before deployment on hardened targets.
- **Configuration**: Some scripts (especially PHP) require you to edit a `config` file or the source code itself to set allowed IP addresses or listener ports before uploading.
- **Permissions**: Ensure the web server user has execution permissions for the uploaded files.