---
name: jsql-injection
description: Java-based tool for automatic SQL injection and database information gathering. It supports 33 database engines and multiple injection strategies including Error, Blind, and Time-based. Use when performing web application security testing, database penetration testing, or automated vulnerability exploitation to extract data, read/write files, or obtain shells.
---

# jsql-injection

## Overview
jSQL Injection is a lightweight, cross-platform Java application used to find and exploit SQL injection vulnerabilities. It automates the process of data extraction from remote databases and includes post-exploitation features like file management and shell creation. Category: Web Application Testing / Database Assessment.

## Installation (if not already installed)
The tool requires a Java Runtime Environment (JRE).

```bash
sudo apt update
sudo apt install jsql-injection
```

## Common Workflows

### Launching the Graphical Interface
jSQL is primarily a GUI-based tool. To start the application:
```bash
jsql
```
*Note: If you encounter "Headless runtime not supported", ensure you are running in a desktop environment (X11/Wayland) with a full Java runtime.*

### Basic Exploitation Steps (GUI)
1. **Targeting**: Enter the vulnerable URL in the address bar (e.g., `http://example.com/index.php?id=1`).
2. **Injection**: Click the "Inject" button. jSQL will automatically fingerprint the database and select the best strategy.
3. **Data Extraction**: Navigate the "Database" tab to browse schemas, tables, and columns. Right-click items to "Load" or "Stop" data retrieval.
4. **Post-Exploitation**: Use the "File" tab to attempt reading system files or the "Shell" tab to deploy a web shell if permissions allow.

### Advanced Features
- **Admin Page Search**: Use the "Admin" tab to brute-force common administrative login paths.
- **Hash Cracking**: Use the "Bruteforce" tab to attempt cracking retrieved password hashes.
- **Tamper Scripts**: Use the "Sandbox" to write custom SQL transformation scripts to bypass WAFs.

## Complete Command Reference

### Execution Commands
| Command | Description |
|---------|-------------|
| `jsql` | Launches the jSQL Injection GUI application. |
| `jsql-injection` | Alias for the jSQL launcher. |

### Supported Database Engines
jSQL supports automatic injection for 33 engines:
Access, Altibase, C-treeACE, CockroachDB, CUBRID, DB2, Derby, Exasol, Firebird, FrontBase, H2, Hana, HSQLDB, Informix, Ingres, InterSystems-IRIS, MaxDB, Mckoi, MemSQL, MimerSQL, MonetDB, MySQL, Neo4j, Netezza, NuoDB, Oracle, PostgreSQL, Presto, SQLite, SQL Server, Sybase, Teradata, and Vertica.

### Injection Strategies
- **Normal**: Standard UNION-based queries.
- **Stacked**: Executing multiple queries in one statement.
- **Error**: Exploiting database error messages to leak data.
- **Blind**: Boolean-based inference (Parallel bitwise supported).
- **Time**: Inference based on database response delays (Parallel bitwise supported).

### Functional Modules
- **Database Fingerprint**: Basic error, Order By error, and Boolean single query methods.
- **Injection Processes**: Default, Zip, and Dios (Data In One Shot).
- **File Operations**: Read and write files on the host filesystem via SQL injection.
- **Shells**: Create and display Web shells and SQL shells.
- **Network**: 
    - Authentication: Basic, Digest, NTLM, and Kerberos.
    - Proxy: HTTP, SOCKS4, and SOCKS5 support.
- **Tools**: 
    - Admin page finder.
    - Hash brute-forcer.
    - Text encoder/decoder (Hash, Base64, etc.).

## Notes
- **Java Dependency**: Requires Java 11 to 20. It will not run in a "headless" environment as it requires a GUI.
- **WAF Bypass**: If a Web Application Firewall is present, use the "Sandbox" feature to apply tampering scripts to the injection payloads.
- **Performance**: Parallel bitwise strategies significantly speed up Blind and Time-based injections compared to traditional character-by-character methods.