---
name: payloadsallthethings
description: Access a comprehensive collection of payloads, bypasses, and methodologies for web application security testing and CTFs. Use when looking for specific injection strings (SQLi, XSS, Command Injection), bypass techniques for WAFs/filters, or structured checklists for various web vulnerabilities during the exploitation and web application testing phases.
---

# payloadsallthethings

## Overview
PayloadsAllTheThings is a massive repository of useful payloads and bypasses for Web Application Security and Pentest/CTF. It provides organized resources for common vulnerabilities like SQL injection, XSS, SSRF, and more. Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
The tool is a collection of files stored in the file system. To ensure the latest version is available:

```bash
sudo apt install payloadsallthethings
```

## Common Workflows

### Searching for a specific payload type
Since the tool is a directory-based collection, use `find` or `ls` to locate relevant payloads:
```bash
ls /usr/share/payloadsallthethings/SQL\ Injection
```

### Searching for a specific keyword within payloads
Search through all markdown files for a specific bypass technique (e.g., "filter bypass"):
```bash
grep -r "filter bypass" /usr/share/payloadsallthethings/
```

### Reading a methodology or cheat sheet
View the documentation for a specific vulnerability directly in the terminal:
```bash
cat /usr/share/payloadsallthethings/XSS\ Injection/README.md
```

## Complete Command Reference

The `payloadsallthethings` command is a helper script that displays the directory structure of the payload collection located at `/usr/share/payloadsallthethings`.

### Usage
```bash
payloadsallthethings [options]
```

### Options
| Flag | Description |
|------|-------------|
| `-h` | Display the help message and the directory structure of the payloads |

### Payload Categories (Directories)
All payloads are located in `/usr/share/payloadsallthethings/`. The following categories are available:

*   `AWS Amazon Bucket S3`
*   `CRLF Injection`
*   `CSRF Injection`
*   `CSV Injection`
*   `CVE Exploits`
*   `Command Injection`
*   `Directory Traversal`
*   `File Inclusion`
*   `GraphQL Injection`
*   `Insecure Deserialization`
*   `Insecure Direct Object References`
*   `Insecure Management Interface`
*   `Insecure Source Code Management`
*   `JSON Web Token`
*   `LDAP Injection`
*   `LaTeX Injection`
*   `Methodology and Resources`
*   `NoSQL Injection`
*   `OAuth`
*   `Open Redirect`
*   `SAML Injection`
*   `SQL Injection`
*   `Server Side Request Forgery`
*   `Server Side Template Injection`
*   `Type Juggling`
*   `Upload Insecure Files`
*   `Web Cache Deception`
*   `Web Sockets`
*   `XPATH Injection`
*   `XSS Injection`
*   `XXE Injection`
*   `_template_vuln`

## Notes
*   This tool is primarily a reference library. Most directories contain a `README.md` with explanations and several `.txt` files containing raw payloads for wordlists or manual testing.
*   The path `/usr/share/payloadsallthethings` is the standard location for these files on Kali Linux.
*   Many payloads require manual adjustment (e.g., changing IP addresses or domain names) before use.