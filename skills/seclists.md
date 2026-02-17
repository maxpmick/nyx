---
name: seclists
description: Access a massive collection of multiple types of security lists including usernames, passwords, URLs, sensitive data grep strings, fuzzing payloads, and web shells. Use when performing brute-force attacks, directory discovery, fuzzing, credential stuffing, or vulnerability exploitation during penetration testing.
---

# seclists

## Overview
SecLists is the ultimate security tester's companion, providing a comprehensive collection of lists used during security assessments. It is organized into logical categories like Discovery, Fuzzing, Passwords, and Payloads to streamline reconnaissance and exploitation phases. Category: Password Attacks / Web Application Testing / Reconnaissance.

## Installation (if not already installed)
SecLists is typically pre-installed on Kali Linux. If missing or to ensure the latest version:

```bash
sudo apt update && sudo apt install seclists
```

The lists are installed to `/usr/share/seclists/`.

## Common Workflows

### DNS Subdomain Brute Forcing
Use a common DNS list with a tool like `ffuf` or `gobuster`:
```bash
gobuster dns -d example.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

### Web Directory Discovery
Search for common PHP files and directories:
```bash
ffuf -u http://example.com/FUZZ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -e .php,.txt
```

### Credential Stuffing / Password Cracking
Use the popular "RockYou" list for password cracking:
```bash
john --wordlist=/usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt hashes.txt
```

### Fuzzing for XSS Payloads
Test an input field for Cross-Site Scripting:
```bash
ffuf -u http://example.com/search?q=FUZZ -w /usr/share/seclists/Fuzzing/XSS/XSS-Jhaddix.txt
```

## Complete Command Reference

The `seclists` command itself is a helper to show the directory structure, but the primary value is the file system at `/usr/share/seclists/`.

### Directory Structure (Categories)

| Directory | Description |
|-----------|-------------|
| `Discovery/` | Lists for finding subdomains, web content, SNMP communities, and infrastructure. |
| `Fuzzing/` | Payloads for XSS, SQLi, Local File Inclusion (LFI), and format string vulnerabilities. |
| `IOCs/` | Indicators of Compromise (IPs, domains, hashes associated with malware). |
| `Miscellaneous/` | Various lists that don't fit elsewhere (e.g., user agents, source code keywords). |
| `Passwords/` | Common passwords, leaked databases (RockYou), default credentials, and WiFi-WPA lists. |
| `Pattern-Matching/` | Regex patterns for finding sensitive data like credit cards or social security numbers. |
| `Payloads/` | Specific files for testing AV bypass, zip bombs, and malicious file uploads. |
| `Usernames/` | Common usernames, names by ethnicity, and honeypot-captured usernames. |
| `Web-Shells/` | A collection of web shells for various languages (PHP, ASPX, JSP) and frameworks. |

### Key Sub-Directories for Discovery

*   `/usr/share/seclists/Discovery/DNS/`
*   `/usr/share/seclists/Discovery/Web-Content/`
*   `/usr/share/seclists/Discovery/Web-Services/`

### Key Sub-Directories for Passwords

*   `/usr/share/seclists/Passwords/Common-Credentials/`
*   `/usr/share/seclists/Passwords/Default-Credentials/`
*   `/usr/share/seclists/Passwords/Leaked-Databases/`

## Notes
- **Storage**: The full installation takes approximately 1.83 GB of disk space.
- **Compressed Files**: Some large lists (like `rockyou.txt`) might be stored as `.gz` files in some environments. Use `zcat` or `gunzip` if the raw text file is not immediately visible, though the Kali package usually provides the extracted version.
- **Updates**: This package is updated frequently in the Kali repositories to include new leaked data and discovery patterns.