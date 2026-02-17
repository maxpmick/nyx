---
name: mongo-tools
description: A collection of utilities for MongoDB administration, data manipulation, and monitoring. Includes tools for importing/exporting data (JSON, CSV, BSON), performing backups and restores, managing GridFS files, and monitoring server performance. Use when performing database reconnaissance, data exfiltration, auditing MongoDB instances, or managing database backups during penetration testing.
---

# mongo-tools

## Overview
The `mongo-tools` package provides a suite of command-line utilities for interacting with MongoDB instances. These tools are essential for data migration, backup/recovery, and real-time performance monitoring. Category: Reconnaissance / Information Gathering & Exploitation.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install mongo-tools
```

## Common Workflows

### Exporting a collection to JSON
```bash
mongoexport --db=users --collection=profiles --out=profiles.json
```

### Dumping a remote database for exfiltration
```bash
mongodump --host=192.168.1.50 --port=27017 --db=staging --out=./dump/
```

### Restoring a BSON backup with Gzip compression
```bash
mongorestore --db=prod --gzip --archive=backup.gz
```

### Monitoring server performance in real-time
```bash
mongostat --host=localhost --rowcount=20 1
```

### Inspecting a BSON file without importing
```bash
bsondump --type=json --pretty data.bson
```

## Complete Command Reference

### bsondump
View and debug .bson files.
`Usage: bsondump <options> <file>`

| Flag | Description |
|------|-------------|
| `--help` | Print usage |
| `--version` | Print tool version |
| `--config=` | Path to configuration file |
| `-v, --verbose=<level>` | Detailed log output (e.g., -vvvvv or --verbose=N) |
| `--quiet` | Hide all log output |
| `--type=<type>` | Output type: `debug`, `json` |
| `--objcheck` | Validate BSON during processing |
| `--pretty` | Human-readable JSON output |
| `--bsonFile=` | Path to BSON file (default: stdin) |
| `--outFile=` | Path to output file (default: stdout) |

### mongodump
Export server content into .bson files.
`Usage: mongodump <options> <connection-string>`

| Flag | Description |
|------|-------------|
| `-h, --host=<hostname>` | MongoDB host |
| `--port=<port>` | Server port |
| `-u, --username=<user>` | Username for authentication |
| `-p, --password=<pass>` | Password for authentication |
| `-d, --db=<name>` | Database to use |
| `-c, --collection=<name>` | Collection to use |
| `-o, --out=<path>` | Output directory or '-' for stdout (default: 'dump') |
| `--gzip` | Compress output with Gzip |
| `--archive=<path>` | Dump as archive to path (or stdout if no value) |
| `--oplog` | Use oplog for point-in-time snapshot |
| `-q, --query=<json>` | Query filter (v2 Extended JSON) |
| `--queryFile=` | Path to file containing query filter |
| `--ssl` | Enable SSL connection |
| `--tlsInsecure` | Bypass server certificate validation |
| `--authenticationDatabase=` | Database holding user credentials |
| `--excludeCollection=` | Collection to exclude (can be used multiple times) |
| `--excludeCollectionsWithPrefix=` | Exclude collections by prefix |
| `-j, --numParallelCollections=` | Number of collections to dump in parallel |
| `--viewsAsCollections` | Dump views as normal collections |

### mongoexport
Export data in CSV or JSON format.
`Usage: mongoexport <options> <connection-string>`

| Flag | Description |
|------|-------------|
| `-f, --fields=<fields>` | Comma separated list of fields (Required for CSV) |
| `--fieldFile=<file>` | File with field names (1 per line) |
| `--type=<type>` | Output format: `json` or `csv` |
| `-o, --out=<file>` | Output file (default: stdout) |
| `--jsonArray` | Output as a JSON array |
| `--pretty` | Human-readable JSON |
| `--noHeaderLine` | Export CSV without the first line header |
| `--jsonFormat=<type>` | Extended JSON format: `canonical` or `relaxed` |
| `-q, --query=<json>` | Query filter |
| `--skip=<count>` | Number of documents to skip |
| `--limit=<count>` | Limit number of documents to export |
| `--sort=<json>` | Sort order (e.g., '{x:1}') |
| `--assertExists` | Fail if collection does not exist |

### mongoimport
Import CSV, TSV, or JSON data.
`Usage: mongoimport <options> <connection-string> <file>`

| Flag | Description |
|------|-------------|
| `--file=<filename>` | File to import from (default: stdin) |
| `--headerline` | Use first line as field list (CSV/TSV only) |
| `--type=<type>` | Input format: `json`, `csv`, or `tsv` |
| `--drop` | Drop collection before inserting |
| `--mode=<mode>` | `insert`, `upsert`, `merge`, `delete` (default: insert) |
| `--upsertFields=<fields>` | Fields for query when mode is upsert/merge |
| `--stopOnError` | Halt after any error |
| `--maintainInsertionOrder` | Insert in order of appearance |
| `-j, --numInsertionWorkers=` | Number of concurrent insert operations |
| `--columnsHaveTypes` | Field list specifies types (e.g., name.string()) |
| `--parseGrace=<grace>` | Behavior on type failure: `autoCast`, `skipField`, `skipRow`, `stop` |

### mongorestore
Restore backups to a running server.
`Usage: mongorestore <options> <connection-string> <directory or file>`

| Flag | Description |
|------|-------------|
| `--nsInclude=<pattern>` | Include matching namespaces |
| `--nsExclude=<pattern>` | Exclude matching namespaces |
| `--nsFrom=<pattern>` | Rename namespaces (requires --nsTo) |
| `--nsTo=<pattern>` | Target name for renamed namespaces |
| `--objcheck` | Validate objects before inserting |
| `--oplogReplay` | Replay oplog for point-in-time restore |
| `--archive=<file>` | Restore from archive file (or stdin) |
| `--dir=<dir>` | Input directory (use '-' for stdin) |
| `--dryRun` | View summary without importing |
| `--noIndexRestore` | Don't restore indexes |
| `--preserveUUID` | Preserve original collection UUIDs (requires --drop) |

### mongostat
Monitor live MongoDB server statistics.
`Usage: mongostat <options> <connection-string> <interval>`

| Flag | Description |
|------|-------------|
| `-n, --rowcount=<count>` | Number of stats lines to print (0 for indefinite) |
| `--discover` | Discover nodes and display stats for all |
| `--all` | Show all optional fields |
| `--json` | Output as JSON |
| `-i, --interactive` | Display stats in a non-scrolling interface |
| `-o=<fields>` | Custom fields to show (dot-syntax) |
| `--humanReadable=` | Print sizes in human format (default: true) |

### mongofiles
Manipulate GridFS files.
`Usage: mongofiles <options> <connection-string> <command> <filename or _id>`

**Commands:** `list`, `search`, `put`, `put_id`, `get`, `get_id`, `get_regex`, `delete`, `delete_id`.

| Flag | Description |
|------|-------------|
| `-l, --local=<file>` | Local filename for put/get |
| `-t, --type=<type>` | Content/MIME type for put |
| `-r, --replace` | Remove other files with same name after put |
| `--prefix=<prefix>` | GridFS prefix to use |

## Notes
- Connection strings must start with `mongodb://` or `mongodb+srv://`.
- Use `--tlsInsecure` when dealing with self-signed certificates common in lab environments.
- `mongodump` and `mongorestore` are the preferred tools for binary backups (BSON), while `mongoexport/import` are for human-readable data.