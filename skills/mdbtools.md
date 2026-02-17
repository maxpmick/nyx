---
name: mdbtools
description: A suite of tools for manipulating and exporting JET / MS Access (MDB/ACCDB) database files. Use when performing database forensics, extracting data from legacy Windows applications, or converting Access databases to SQL/CSV/JSON formats during penetration testing or digital forensics.
---

# mdbtools

## Overview
mdbtools is a collection of utilities for accessing and manipulating Microsoft Access (JET) database files. It allows for table listing, schema extraction, data export to various formats, and executing SQL queries against MDB/ACCDB files without requiring a Windows environment. Category: Database / Digital Forensics.

## Installation (if not already installed)
The tools are typically pre-installed on Kali Linux. If missing:
```bash
sudo apt install mdbtools
```

## Common Workflows

### List all tables in a database
```bash
mdb-tables database.mdb
```

### Export a specific table to CSV
```bash
mdb-export database.mdb "Users" > users.csv
```

### Generate SQL Schema for a specific backend (e.g., MySQL)
```bash
mdb-schema database.mdb mysql
```

### Run an interactive SQL shell
```bash
mdb-sql database.mdb
```

## Complete Command Reference

### mdb-tables
List tables in an MDB database.
- `-S, --system`: Include system tables.
- `-1, --single-column`: One table name per line.
- `-d, --delimiter=char`: Table name delimiter.
- `-t, --type=type`: Type of entry.
- `-T, --showtype`: Show type.
- `--version`: Show version.

### mdb-export
Export data from MDB file to CSV or INSERT statements.
- `-H, --no-header`: Suppress header row.
- `-d, --delimiter=char`: Column delimiter (default: comma).
- `-R, --row-delimiter=char`: Row delimiter.
- `-Q, --no-quote`: Don't wrap text-like fields in quotes.
- `-q, --quote=char`: Quote character (default: double quote).
- `-X, --escape=format`: Escape quoted characters.
- `-e, --escape-invisible`: Use C-style escaping (\r, \t, \n, \\).
- `-I, --insert=backend`: Generate INSERT statements for specified backend.
- `-N, --namespace=namespace`: Prefix identifiers with namespace.
- `-S, --batch-size=int`: Size of insert batches.
- `-D, --date-format=format`: Set date format (strftime).
- `-T, --datetime-format=format`: Set date/time format (strftime).
- `-0, --null=char`: Representation of NULL value.
- `-b, --bin=strip|raw|octal|hex`: Binary export mode.
- `-B, --boolean-words`: Use TRUE/FALSE instead of 0/1.

### mdb-sql
SQL interface to MDB files.
- `-d, --delim=char`: Use this delimiter.
- `-P, --no-pretty-print`: Disable pretty printing.
- `-H, --no-header`: Don't print header.
- `-F, --no-footer`: Don't print footer.
- `-i, --input=file`: Read SQL from file.
- `-o, --output=file`: Write result to file.

### mdb-schema
Generate schema creation DDL.
- `-T, --table=table`: Only create schema for named table.
- `-N, --namespace=namespace`: Prefix identifiers with namespace.
- `--drop-table` / `--no-drop-table`: Include/exclude DROP TABLE statements.
- `--not-null` / `--no-not-null`: Include/exclude NOT NULL constraints.
- `--default-values` / `--no-default-values`: Include/exclude default values.
- `--not-empty` / `--no-not_empty`: Include/exclude not empty constraints.
- `--comments` / `--no-comments`: Include/exclude COMMENT ON statements.
- `--indexes` / `--no-indexes`: Include/exclude indexes.
- `--relations` / `--no-relations`: Include/exclude foreign key constraints.

### mdb-json
Export data to JSON format.
- `-D, --date-format=format`: Set date format.
- `-T, --datetime-format=format`: Set date/time format.
- `-U, --no-unprintable`: Change unprintable characters to spaces.

### mdb-count
Print the number of records in a table.
- `mdb-count <file> <table>`

### mdb-ver
Display MDB file version.
- `-M, --version`: Show mdbtools version.

### mdb-prop
Display properties of an object.
- `mdb-prop <file> <object name> [<prop col>]`

### mdb-queries
List or export queries.
- `-L, --list`: List queries (default).
- `-1, --newline`: Use newline as delimiter for listing.
- `-d, --delimiter=delim`: Specify delimiter.

### mdb-import
Import CSV data into an MDB database.
- `-H, --header lines`: Skip lines of CSV header.
- `-d, --delimiter char`: Column delimiter (default: comma).

### mdb-hexdump
Hexdump utility for binary files.
- `mdb-hexdump file [pagenumber]`

### mdb-array (Deprecated)
Export table to a C array.
- `mdb-array <file> <table>`

### mdb-header (Deprecated)
Write C header file from database.
- `mdb-header [database]`

### mdb-parsecsv (Deprecated)
Convert CSV table dump into C file.
- `mdb-parsecsv file`

## Notes
- **Environment Variables**:
  - `MDB_JET3_CHARSET`: Defines input charset for JET3 (Access 97) files (default: CP1252).
  - `MDBICONV`: Defines output charset (default: UTF-8).
  - `MDBOPTS`: Colon-separated debug options (e.g., `debug_all`, `debug_row`).
- **Safety**: `mdb-import` does not enforce constraints; use with caution as it may violate database integrity.
- **Deprecation**: `mdb-array`, `mdb-header`, and `mdb-parsecsv` are deprecated and may be removed in future versions.