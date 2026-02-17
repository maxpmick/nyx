---
name: webshells
description: Access a curated collection of webshells for various server environments including ASP, ASPX, CFM, JSP, Perl, and PHP. Use when you have achieved file upload capabilities or command injection on a web server and need to establish a persistent backdoor, interactive shell, or remote command execution interface during web application penetration testing.
---

# webshells

## Overview
The `webshells` package is a repository of scripts designed to be uploaded to a compromised web server to execute remote commands. It includes shells for multiple languages and frameworks, providing both simple command execution and full reverse shell capabilities. Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
The package is usually pre-installed on Kali Linux. If missing:

```bash
sudo apt install webshells
```

## Common Workflows

### Locating a PHP Reverse Shell
To find a PHP script that can connect back to your listener:
```bash
ls -l /usr/share/webshells/php/php-reverse-shell.php
```
*Note: You must edit this file to set your local IP and port before uploading.*

### Using a Simple PHP Backdoor
For quick command execution via a web parameter:
```bash
cat /usr/share/webshells/php/simple-backdoor.php
```

### Accessing JSP Shells for Tomcat/JBoss
If targeting a Java-based web server:
```bash
ls /usr/share/webshells/jsp/
```

### Exploring Extended Collections
Accessing shells provided by the SecLists project via the symlink:
```bash
ls /usr/share/webshells/seclists/
```

## Complete Command Reference

The `webshells` "command" is primarily a directory structure located at `/usr/share/webshells/`.

### Directory Structure and Available Shells

| Language/Category | Path | Description |
|-------------------|------|-------------|
| **ASP** | `/usr/share/webshells/asp/` | Classic ASP shells (e.g., `cmdasp.asp`) |
| **ASPX** | `/usr/share/webshells/aspx/` | .NET/ASPX shells (e.g., `cmdasp.aspx`) |
| **CFM** | `/usr/share/webshells/cfm/` | ColdFusion shells (e.g., `cfexec.cfm`) |
| **JSP** | `/usr/share/webshells/jsp/` | Java Server Pages shells and reverse shells |
| **Perl** | `/usr/share/webshells/perl/` | Perl CGI and reverse shell scripts |
| **PHP** | `/usr/share/webshells/php/` | PHP backdoors, reverse shells, and findsock utilities |
| **Laudanum** | `/usr/share/webshells/laudanum` | Symlink to the Laudanum shell collection |
| **SecLists** | `/usr/share/webshells/seclists` | Symlink to the SecLists Web-Shells repository |

### File Manifest

- **ASP**: `cmd-asp-5.1.asp`, `cmdasp.asp`
- **ASPX**: `cmdasp.aspx`
- **CFM**: `cfexec.cfm`
- **JSP**: `cmdjsp.jsp`, `jsp-reverse.jsp`
- **Perl**: `perlcmd.cgi`, `perl-reverse-shell.pl`
- **PHP**: 
    - `findsock.c` (Source for socket hijacking)
    - `php-backdoor.php`
    - `php-findsock-shell.php`
    - `php-reverse-shell.php`
    - `qsd-php-backdoor.php`
    - `simple-backdoor.php`

## Notes
- **Configuration**: Most shells (especially reverse shells) require manual editing of the source code to configure the `LHOST` (your IP) and `LPORT` (your listener port) before deployment.
- **Detection**: These are well-known public webshells and are highly likely to be detected by Antivirus (AV) or Endpoint Detection and Response (EDR) systems if uploaded to a protected server.
- **Permissions**: Ensure the web server user has execution permissions for the uploaded script.