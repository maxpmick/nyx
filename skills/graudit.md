---
name: graudit
description: Perform static analysis and source code auditing using grep-based signature sets to identify potential security flaws. Use when reviewing source code for vulnerabilities, performing white-box security assessments, or identifying insecure functions in various programming languages during the reconnaissance or vulnerability analysis phases.
---

# graudit

## Overview
Graudit (Grep Rough Audit) is a source code auditing tool that uses a set of signatures to find potential security flaws in source code. It is a lightweight alternative to static analysis applications like RATS, SWAAT, and flaw-finder, relying on the GNU utility grep for flexibility and minimal dependencies. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume graudit is already installed. If you get a "command not found" error:

```bash
sudo apt install graudit
```

## Common Workflows

### Basic scan of a source directory
```bash
graudit /path/to/source/code
```
Uses the default database to scan the specified directory.

### Scan using a specific language database
```bash
graudit -d php /path/to/php/project
```
Targets PHP-specific vulnerabilities by using the PHP signature database.

### List all available signature databases
```bash
graudit -l
```

### High-intensity scan excluding specific files
```bash
graudit -A -x "*.js,*.sql,*.md" /path/to/project
```
Scans all files (including "unwanted" ones) while excluding JavaScript, SQL, and Markdown files.

## Complete Command Reference

```
graudit [opts] /path/to/scan
```

### Scan Options

| Flag | Description |
|------|-------------|
| `-d <dbname>` | Database to use or `/path/to/file.db`. Uses default if not specified |
| `-A` | Scan unwanted and difficult (ALL) files |
| `-x <list>` | Exclude files (comma separated list, e.g., `-x *.js,*.sql`) |
| `-i` | Case in-sensitive scan |
| `-c <num>` | Number of lines of context to display (default: 2) |

### Display and Output Options

| Flag | Description |
|------|-------------|
| `-B` | Suppress banner |
| `-L` | Vim friendly lines (format: `file:line:match`) |
| `-b` | Colour blind friendly template |
| `-z` | Suppress colors |
| `-Z` | High contrast colors |

### Information Options

| Flag | Description |
|------|-------------|
| `-l` | List all available databases |
| `-v` | Print version number |
| `-h` | Print help screen |

## Notes
- Graudit is a "rough" audit tool; it identifies potential hotspots that require manual verification to confirm if they are actual vulnerabilities.
- Databases are typically stored in `/usr/share/graudit/` or the tool's installation directory. Common databases include `c`, `dotnet`, `html`, `java`, `js`, `php`, `python`, and `ruby`.
- The `-A` flag is useful for finding secrets or flaws in configuration files or documentation that are normally skipped.