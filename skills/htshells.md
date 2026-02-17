---
name: htshells
description: Deploy self-contained .htaccess shells and attacks for remote code execution, information disclosure, and denial of service. Use when performing web application penetration testing, specifically when file upload restrictions can be bypassed by uploading or modifying .htaccess files to change server behavior or execute code in restricted environments.
---

# htshells

## Overview
htshells is a collection of web-based attacks leveraging `.htaccess` files. These attacks primarily target two categories: Remote Code/Command Execution (RCE) and Information Disclosure. It is particularly effective against Content Management Systems (CMS) that restrict uploads by extension but allow `.htaccess` files or place uploaded files in directories where configuration overrides are permitted. Category: Web Application Testing.

## Installation (if not already installed)
Assume htshells is already installed. If the directory `/usr/share/htshells` is missing:

```bash
sudo apt install htshells
```

## Common Workflows

### Identifying available shells and attacks
List the available htshell templates to choose the appropriate attack vector:
```bash
ls -R /usr/share/htshells
```

### Executing a PHP shell via .htaccess
If a server allows `.htaccess` but blocks `.php` uploads, you can use a shell that forces the server to execute a different file extension (or the `.htaccess` file itself) as PHP:
```bash
cat /usr/share/htshells/shell/mod_php.shell.htaccess
```
*Action: Upload the content to the target as `.htaccess` and access it via a browser to execute commands.*

### Information Disclosure
Use templates to reveal server configuration or sensitive files:
```bash
cat /usr/share/htshells/info/mod_info.htaccess
```

## Complete Command Reference

htshells is a collection of payload templates rather than a binary tool. The files are located in `/usr/share/htshells`.

### Directory Structure and Attack Categories

| Category/File | Description |
|---------------|-------------|
| `dos/` | Templates for Denial of Service attacks via server configuration. |
| `info/` | Templates for Information Disclosure (e.g., server status, config). |
| `shell/` | Templates for Remote Code Execution (RCE) and web shells. |
| `traversal/` | Templates for Directory Traversal attacks. |
| `mod_auth_remote.phish.htaccess` | Phishing attack using remote authentication modules. |
| `mod_badge.admin.htaccess` | Administrative access bypass/spoofing. |
| `mod_sendmail.rce.htaccess` | RCE via sendmail configuration. |

### Payload Details (Typical Contents)

Most shells in this package utilize one of the following methods:

1.  **AddHandler/SetHandler**: Forcing the server to treat `.htaccess` or other non-standard extensions as executable scripts (e.g., `AddType application/x-httpd-php .htaccess`).
2.  **auto_append_file/auto_prepend_file**: Using PHP configuration overrides within `.htaccess` to include malicious code.
3.  **mod_cgi**: Enabling CGI execution in directories where it is normally disabled.
4.  **ErrorDocument**: Triggering code execution via custom error handlers.

## Notes
- **Permissions**: These attacks require the Apache server to have `AllowOverride` enabled (specifically `AllowOverride Options` or `AllowOverride All`) for the target directory.
- **Stealth**: Many of these payloads allow the `.htaccess` file to act as the shell itself, meaning no additional files need to be uploaded to the server.
- **Compatibility**: Effectiveness depends heavily on the specific Apache modules loaded (e.g., `mod_php`, `mod_cgi`, `mod_info`).