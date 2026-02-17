---
name: sqlitebrowser
description: A visual GUI tool to create, design, and edit SQLite database files. Use it for database forensics, web application data analysis, or inspecting local storage databases (like those from browsers or mobile apps) without needing complex SQL commands.
---

# sqlitebrowser

## Overview
SQLite Database Browser (DB Browser for SQLite) is a high-quality, visual, open-source tool to create, design, and edit database files compatible with SQLite. It features a spreadsheet-like interface for users to manage tables, indexes, and records. Category: Database / Digital Forensics / Web Application Testing.

## Installation (if not already installed)
Assume sqlitebrowser is already installed on Kali Linux. If not:

```bash
sudo apt update
sudo apt install sqlitebrowser
```

## Common Workflows

### Opening a database for forensic analysis
Launch the GUI and automatically load a specific database file (e.g., a browser history or messaging app database):
```bash
sqlitebrowser path/to/evidence.db
```

### Exporting data to CSV
1. Open the database in `sqlitebrowser`.
2. Navigate to **File** -> **Export** -> **Table(s) as CSV file...**
3. Select the desired tables and destination.

### Executing custom SQL queries
1. Open the database.
2. Click on the **Execute SQL** tab.
3. Type your query (e.g., `SELECT * FROM users WHERE admin = 1;`) and press the play icon or `F5`.

### Recovering/Compacting a database
To reduce file size or attempt to clean up a database:
1. Open the file.
2. Go to **Tools** -> **Compact Database**.

## Complete Command Reference

The tool is primarily a GUI application. The command-line interface is used to launch the application and optionally load a database file.

### Usage
```bash
sqlitebrowser [file]
```

### Arguments

| Argument | Description |
|----------|-------------|
| `file` | Optional path to an SQLite database file to open upon startup. |

### GUI Capabilities
Once the application is launched, the following actions are available via the interface:

*   **Database Management**: Create, open, compact, and close database files.
*   **Table Management**: Create, define, modify, and delete tables.
*   **Index Management**: Create, define, and delete indexes.
*   **Data Manipulation**: Browse, edit, add, and delete records in a spreadsheet view.
*   **Search**: Search for specific records across tables.
*   **Import**: 
    *   Import records from text files.
    *   Import tables from CSV files.
    *   Import databases from SQL dump files.
*   **Export**:
    *   Export records as text.
    *   Export tables to CSV files.
    *   Export databases to SQL dump files.
*   **SQL Execution**: Issue manual SQL queries and inspect results.
*   **Logging**: Examine a log of all SQL commands issued by the application during the session.

## Notes
*   **SQLCipher Support**: This version of `sqlitebrowser` includes `libsqlcipher`, allowing it to open and edit encrypted SQLite databases if the key is known.
*   **Forensics**: When using this for forensics, be aware that opening a database in "Write" mode (default) may alter file metadata or headers. Use a copy of the original evidence.
*   **Non-Shell Tool**: Unlike the `sqlite3` command-line tool, `sqlitebrowser` is designed for users who prefer a visual interface over a terminal-based SQL shell.