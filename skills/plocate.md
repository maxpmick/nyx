---
name: plocate
description: Find files by name across the entire system using a pre-built index. It is a much faster, drop-in replacement for mlocate. Use when performing post-exploitation reconnaissance, searching for sensitive configuration files, locating specific binaries, or harvesting data during a penetration test or digital forensics investigation.
---

# plocate

## Overview
plocate is a high-performance `locate` implementation based on posting lists. It provides significantly faster search speeds than traditional locate tools by using a more efficient index format. It is optimized for both SSDs and HDDs. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume plocate is already installed. If you get a "command not found" error:

```bash
sudo apt install plocate
```

## Common Workflows

### Search for a file by name
```bash
plocate "config.php"
```

### Case-insensitive search with a limit
```bash
plocate -i -l 10 "passwords"
```

### Update the search database
```bash
sudo updatedb.plocate
```

### Search using basic regular expressions
```bash
plocate -r "\.conf$"
```

## Complete Command Reference

### plocate
Find files by name, quickly.

```
plocate [OPTION]... PATTERN...
```

| Flag | Description |
|------|-------------|
| `-b`, `--basename` | Search only the file name portion of path names |
| `-c`, `--count` | Print number of matches instead of the matches |
| `-d`, `--database DBPATH` | Search for files in DBPATH (default: /var/lib/plocate/plocate.db) |
| `-i`, `--ignore-case` | Search case-insensitively |
| `-l`, `--limit LIMIT` | Stop after LIMIT matches |
| `-0`, `--null` | Delimit matches by NUL instead of newline |
| `-N`, `--literal` | Do not quote filenames, even if printing to a tty |
| `-r`, `--regexp` | Interpret patterns as basic regexps (slow) |
| `--regex` | Interpret patterns as extended regexps (slow) |
| `-w`, `--wholename` | Search the entire path name (default) |
| `--help` | Print help message |
| `--version` | Print version information |

### plocate-build
Generate index for plocate from an existing mlocate database or plaintext file.

```
plocate-build MLOCATE_DB PLOCATE_DB
```

| Flag | Description |
|------|-------------|
| `-b`, `--block-size SIZE` | Number of filenames to store in each block (default 32) |
| `-p`, `--plaintext` | Input is a plaintext file, not an mlocate database |
| `-l`, `--require-visibility FLAG` | Check visibility before reporting files |
| `--help` | Print help message |
| `--version` | Print version information |

### updatedb.plocate
Update the database used by plocate. Configuration defaults are read from `/etc/updatedb.conf`.

```
updatedb.plocate [OPTION]...
```

| Flag | Description |
|------|-------------|
| `-f`, `--add-prunefs FS` | Omit also FS (space-separated) |
| `-n`, `--add-prunenames NAMES` | Omit also NAMES (space-separated) |
| `-e`, `--add-prunepaths PATHS` | Omit also PATHS (space-separated) |
| `--add-single-prunepath PATH` | Omit also PATH |
| `-U`, `--database-root PATH` | The subtree to store in database (default "/") |
| `-h`, `--help` | Print help message |
| `-o`, `--output FILE` | Database to update (default `/var/lib/plocate/plocate.db`) |
| `-b`, `--block-size SIZE` | Number of filenames to store in each block (default 32) |
| `--prune-bind-mounts FLAG` | Omit bind mounts (default "no") |
| `--prunefs FS` | Filesystems to omit from database |
| `--prunenames NAMES` | Directory names to omit from database |
| `--prunepaths PATHS` | Paths to omit from database |
| `-l`, `--require-visibility FLAG` | Check visibility before reporting files (default "yes") |
| `-v`, `--verbose` | Print paths of files as they are found |
| `-V`, `--version` | Print version information |

## Notes
- `plocate` relies on a database. If you have recently created a file and cannot find it, run `sudo updatedb.plocate` to refresh the index.
- The `--require-visibility` flag ensures that users only see files they have permissions to access.
- For complex pattern matching, `--regex` is powerful but significantly slower than standard pattern matching.