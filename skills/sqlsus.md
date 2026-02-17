---
name: sqlsus
description: MySQL injection and takeover tool used to automate the exploitation of SQL injection vulnerabilities. It can retrieve database structures, inject complex queries, download files, crawl for writable directories, and upload backdoors. Use during web application penetration testing when a MySQL injection point is identified and requires advanced exploitation or database cloning.
---

# sqlsus

## Overview
sqlsus is an open-source MySQL injection and takeover tool written in Perl. It provides a command-line interface to exploit SQL injection vulnerabilities, allowing for database structure enumeration, file system access, and web backdoor deployment. Category: Web Application Testing / Database Assessment.

## Installation (if not already installed)
Assume sqlsus is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt install sqlsus
```

## Common Workflows

### Generate a configuration file
Before running a scan, you must generate and edit a configuration file to define the target and injection parameters.
```bash
sqlsus -g my_target.cfg
nano my_target.cfg
```

### Start an exploitation session
Once the configuration file is configured with the target URL and injection point, start the session.
```bash
sqlsus my_target.cfg
```

### Basic exploitation commands (inside sqlsus shell)
```bash
sqlsus> start          # Start the automated injection process
sqlsus> get databases  # Enumerate available databases
sqlsus> get tables     # Enumerate tables in the current database
sqlsus> clone          # Clone the entire database
```

## Complete Command Reference

### Command Line Options

| Flag | Description |
|------|-------------|
| `-g <file>` | Generate a default configuration file with the specified name |
| `-v` | Display version information |
| `-h` | Display help message |
| `<config_file>` | Path to the configuration file to start a session |

### Internal Shell Commands
Once a session is started with a configuration file, the following commands are available within the sqlsus prompt:

#### Information Gathering & Enumeration
| Command | Description |
|---------|-------------|
| `start` | Start the injection process and find the number of columns/union point |
| `get databases` | List all databases accessible to the current user |
| `get tables` | List tables in the current or specified database |
| `get columns` | List columns for a specific table |
| `get count` | Get the number of rows in a table |
| `get data` | Extract data from specific columns and tables |
| `get variables` | Retrieve MySQL system variables |
| `get functions` | Retrieve MySQL functions |
| `describe <table>` | Describe the structure of a specific table |

#### Advanced Exploitation
| Command | Description |
|---------|-------------|
| `clone` | Clone the database(s) locally into a SQLite database |
| `download <remote_file> <local_file>` | Download a file from the web server (requires FILE privilege) |
| `upload <local_file> <remote_path>` | Upload a file to the web server (requires FILE privilege and writable directory) |
| `backdoor` | Attempt to upload and control a web backdoor |
| `crawl` | Crawl the website to find writable directories for file uploads |
| `gen_find_path` | Generate a script to find the absolute path of the webroot |

#### Configuration & Interface
| Command | Description |
|---------|-------------|
| `set <option> <value>` | Change configuration options on the fly |
| `show <option>` | Display the current value of a configuration option |
| `test` | Test the connection and injection point |
| `shell` | Execute a local shell command |
| `exit` | Exit the sqlsus shell |

## Notes
- **Configuration is Key**: sqlsus relies heavily on the `.cfg` file. You must manually set the `url` and `injection_point` (using the `$$` marker) inside this file before starting.
- **Privileges**: Advanced features like `download`, `upload`, and `backdoor` require the MySQL user to have the `FILE` privilege and for the server to not be restricted by `secure_file_priv`.
- **Output**: sqlsus mimics a MySQL console for many commands, making it intuitive for users familiar with the MySQL CLI.