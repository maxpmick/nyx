---
name: dbeaver
description: Manage and query various database systems including MySQL, PostgreSQL, SQLite, Oracle, and SQL Server. Use when performing database reconnaissance, data exfiltration, SQL injection verification, or administrative tasks during penetration testing and digital forensics.
---

# dbeaver

## Overview
DBeaver is a universal database management tool and SQL client. It provides a graphical interface to interact with any database that has a JDBC driver, supporting a wide range of relational and NoSQL databases. Category: Web Application Testing / Information Gathering.

## Installation (if not already installed)
Assume DBeaver is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install dbeaver
```

Dependencies: `default-jre` (Java Runtime Environment).

## Common Workflows

### Launch the GUI
```bash
dbeaver &
```
Starts the application in the background to allow continued use of the terminal.

### Connect to a specific SQLite database file
```bash
dbeaver -con "driver=sqlite|database=/path/to/database.db"
```

### Open a specific SQL script on startup
```bash
dbeaver -f /path/to/exploit_queries.sql
```

### Reset workspace settings
```bash
dbeaver -resetWorkspace
```
Useful if the GUI is hanging or windows are misplaced.

## Complete Command Reference

DBeaver is primarily a GUI application based on the Eclipse platform. It supports the following command-line arguments:

### General Options

| Flag | Description |
|------|-------------|
| `-con <params>` | Open a connection with specified parameters. Format: `driver=...|prop1=value1|prop2=value2` |
| `-f <file>` | Open a specific file (SQL script, ER diagram, etc.) |
| `-p <project>` | Set the active project name |
| `-resetWorkspace` | Reset the UI workspace to default settings |
| `-nosplash` | Start DBeaver without showing the splash screen |
| `-vm <path>` | Specify the path to the Java Virtual Machine (JVM) to use |
| `-vmargs <args>` | Pass arguments directly to the JVM (must be the last argument) |

### Eclipse Platform Options (Inherited)

| Flag | Description |
|------|-------------|
| `-data <path>` | Specify the workspace directory location |
| `-configuration <path>` | Specify the configuration directory location |
| `-user <path>` | Specify the user data directory location |
| `-clean` | Clean the OSGi cache (useful for fixing plugin issues) |
| `-showlocation` | Show the workspace location in the window title bar |

## Notes
- DBeaver supports a vast array of databases: MySQL, PostgreSQL, SQLite, Oracle, DB2, SQL Server, Sybase, Teradata, and Cassandra.
- For security professionals, it is an excellent tool for browsing local application databases (like Chrome/Firefox history or mobile app SQLite dumps) and interacting with compromised remote database servers.
- If connecting to a remote database, ensure you have the appropriate JDBC driver; DBeaver will usually offer to download missing drivers automatically if internet access is available.