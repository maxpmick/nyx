---
name: mysql-defaults
description: Manage and interact with MySQL/MariaDB databases using standard client and server metapackages. Use when performing database reconnaissance, exploiting SQL injection, managing backend data, or conducting post-exploitation tasks involving database credential harvesting and data exfiltration.
---

# mysql-defaults

## Overview
`mysql-defaults` is a set of metapackages in Kali Linux that provide the default implementation of MySQL/MariaDB. It ensures compatibility between different database versions and provides the necessary binaries for client-server interaction, development libraries, and configuration files. Category: Exploitation / Information Gathering / Web Application Testing.

## Installation (if not already installed)
These packages are usually pre-installed in Kali. If missing, install the specific component needed:

```bash
# For the command-line client
sudo apt install default-mysql-client

# For the database server
sudo apt install default-mysql-server

# For development headers (compiling tools)
sudo apt install default-libmysqlclient-dev
```

## Common Workflows

### Connecting to a Remote Database
Connect to a target database discovered during reconnaissance to attempt credential testing or data enumeration.
```bash
mysql -h <target-ip> -u <username> -p
```

### Local Database Setup for Tooling
Start the default MySQL/MariaDB service to support tools that require a backend database (e.g., Metasploit or custom scripts).
```bash
sudo systemctl start mariadb
sudo mysql_secure_installation
```

### Compiling Database Exploits
Use the development files provided by `default-libmysqlclient-dev` to compile C-based exploits or custom clients.
```bash
gcc exploit.c -o exploit $(mysql_config --cflags --libs)
```

## Complete Command Reference

The `mysql-defaults` metapackages provide the following primary components and tools:

### Client Tools (`default-mysql-client`)
| Tool | Description |
|------|-------------|
| `mysql` | The primary interactive command-line shell for SQL queries. |
| `mysqladmin` | Client for performing administrative operations (check config, monitor). |
| `mysqldump` | Tool for dumping/exporting databases for backup or exfiltration. |
| `mysqlcheck` | Table maintenance: check, repair, optimize, or analyze tables. |
| `mysqlshow` | Quickly show databases, tables, and columns. |
| `innotop` | A MySQL and InnoDB monitor (included in client metapackage). |
| `mysqlreport` | Generates a friendly report of important MySQL status values. |

### Server Components (`default-mysql-server`)
| Component | Description |
|-----------|-------------|
| `mysqld` | The MySQL/MariaDB server daemon. |
| `mysqld_safe` | Recommended way to start `mysqld` on Unix (adds safety features). |
| `mysql_install_db` | Initializes the MySQL data directory and system tables. |
| `mysql_secure_installation` | Script to improve security (set root password, remove anonymous users). |

### Development Files (`default-libmysqlclient-dev`)
| File/Utility | Description |
|--------------|-------------|
| `mysql_config` | Provides compiler flags and library paths for linking against `libmysqlclient`. |
| `libmysqlclient.so` | The shared library for client-side database communication. |

### Configuration (`mysql-common`)
| Path | Description |
|------|-------------|
| `/etc/mysql/my.cnf` | The global configuration file shared by clients and servers. |
| `/etc/mysql/conf.d/` | Directory for additional configuration snippets. |

## Notes
- **MariaDB Transition**: In Kali Linux and Debian-based systems, `mysql-defaults` points to **MariaDB** as the default provider. Commands remain compatible with `mysql` syntax.
- **Security**: When using the client, avoid passing passwords directly in the command line (`-pPASSWORD`) as they will appear in the process list and bash history. Use `-p` and wait for the prompt.
- **Permissions**: Accessing local databases often requires `sudo` if using the `unix_socket` authentication plugin (default for the root user in many MariaDB installations).