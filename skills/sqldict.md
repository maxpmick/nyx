---
name: sqldict
description: Perform dictionary attacks against Microsoft SQL Server (MSSQL) to crack user passwords. Use when conducting database penetration testing, password auditing, or credential exploitation against SQL Server instances.
---

# sqldict

## Overview
SQLdict is a specialized dictionary attack tool designed specifically for Microsoft SQL Server. It attempts to identify valid credentials by testing a list of passwords against a target SQL Server instance. Category: Database Testing / Password Attacks.

## Installation (if not already installed)

SQLdict is a Windows-based application that runs via Wine on Kali Linux. If it is not installed or Wine is missing:

```bash
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine32 sqldict
```

## Common Workflows

### Launching the Graphical Interface
Since SQLdict is a GUI-based tool running under Wine, launch it from the terminal to open the application window:
```bash
sqldict
```

### Typical Attack Pattern
1. **Target Selection**: Enter the IP address or hostname of the SQL Server.
2. **Authentication Method**: Choose between SQL Server Authentication or Windows Authentication (if applicable).
3. **User Configuration**: Specify the target username (commonly `sa`).
4. **Wordlist Selection**: Load a text file containing potential passwords.
5. **Execution**: Start the attack and monitor the output window for successful logins.

## Complete Command Reference

SQLdict is primarily a GUI-driven tool. When executed from the command line, it initializes the Wine environment to launch the executable.

```bash
sqldict
```

### GUI Options and Configuration Fields

| Field / Option | Description |
|----------------|-------------|
| **Server** | The IP address or DNS name of the target SQL Server instance. |
| **Database** | The specific database to connect to (defaults to `master`). |
| **Username** | The SQL account to target (e.g., `sa`). |
| **Password File** | Path to the dictionary/wordlist file to use for the attack. |
| **Load** | Button to browse and select the password wordlist. |
| **Start** | Begins the dictionary attack against the specified server. |
| **Stop** | Interrupts the current attack process. |

## Notes
- **Wine Dependency**: This tool requires `wine` or `wine32` to function on Linux. If the application fails to start, ensure your Wine environment is correctly configured.
- **Network Connectivity**: Ensure the target SQL Server (typically port 1433) is reachable from your machine.
- **Account Lockout**: Be aware that aggressive dictionary attacks may trigger account lockout policies on the target SQL Server or the underlying Windows domain.
- **Legacy Tool**: SQLdict is an older utility; for modern command-line driven MSSQL attacks, consider using `crackmapexec` (now `nxc`) or Impacket's `mssqlclient.py`.