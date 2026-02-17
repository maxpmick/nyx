---
name: h8mail
description: Email OSINT and breach hunting tool used to find passwords and breach information across multiple services and local datasets. Use when performing reconnaissance, credential auditing, or investigating data leaks involving specific email addresses, domains, or usernames.
---

# h8mail

## Overview
h8mail is an email information and password lookup tool. It performs OSINT by querying various breach databases (like HaveIBeenPwned, Dehashed, and Snusbase) and can also search through local breach data, including the "Breach Compilation" torrent or raw text files. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume h8mail is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install h8mail
```

## Common Workflows

### Search for a single target using default services
```bash
h8mail -t target@example.com
```

### Search multiple targets from a file and output to CSV
```bash
h8mail -t targets.txt -o results.csv
```

### Search local breach data and BreachCompilation folder
```bash
h8mail -t targets.txt -lb /path/to/local/breaches/ -bc /path/to/BreachCompilation/
```

### Search for emails found on a specific website
```bash
h8mail -u https://example.com/staff-directory
```

### Generate a configuration file template
```bash
h8mail --gen-config
```

## Complete Command Reference

```
h8mail [-h] [-t USER_TARGETS [USER_TARGETS ...]]
       [-u USER_URLS [USER_URLS ...]] [-q USER_QUERY] [--loose]
       [-c CONFIG_FILE [CONFIG_FILE ...]] [-o OUTPUT_FILE]
       [-j OUTPUT_JSON] [-bc BC_PATH] [-sk]
       [-k CLI_APIKEYS [CLI_APIKEYS ...]]
       [-lb LOCAL_BREACH_SRC [LOCAL_BREACH_SRC ...]]
       [-gz LOCAL_GZIP_SRC [LOCAL_GZIP_SRC ...]] [-sf]
       [-ch [CHASE_LIMIT]] [--power-chase] [--hide] [--debug]
       [--gen-config]
```

### Target Options

| Flag | Description |
|------|-------------|
| `-t`, `--targets` | Either string inputs or files. Supports email pattern matching, filepath globbing, and multiple arguments. |
| `-u`, `--url` | Either string inputs or files. Parses URL pages for emails. Requires `http://` or `https://`. |
| `-q`, `--custom-query` | Perform a custom query for username, password, IP, hash, or domain. Performs an implicit "loose" search locally. |
| `--loose` | Allow loose search by disabling email pattern recognition. Use spaces as pattern separators. |

### Configuration & API Options

| Flag | Description |
|------|-------------|
| `-c`, `--config` | Configuration file for API keys (Snusbase, WeLeakInfo, Leak-Lookup, HaveIBeenPwned, Emailrep, Dehashed, hunterio). |
| `-k`, `--apikey` | Pass config options via CLI. Format: `"K=V,K=V"`. |
| `-sk`, `--skip-defaults` | Skips Scylla and HunterIO check. Ideal for local-only scans. |
| `--gen-config`, `-g` | Generates a `h8mail_config.ini` template in the current directory and exits. |

### Local Search Options

| Flag | Description |
|------|-------------|
| `-bc`, `--breachcomp` | Path to the BreachCompilation torrent folder. Uses the `query.sh` script included in the torrent. |
| `-lb`, `--local-breach` | Local cleartext breaches to scan. Supports files, folders, and globbing. Uses multiprocessing. |
| `-gz`, `--gzip` | Local `.tar.gz` compressed breaches to scan. Looks for 'gz' in filename. |
| `-sf`, `--single-file` | Use for very large cleartext or gzip files to view progress bar. Disables concurrent file searching for stability. |

### Output & Display Options

| Flag | Description |
|------|-------------|
| `-o`, `--output` | File to write CSV output. |
| `-j`, `--json` | File to write JSON output. |
| `--hide` | Obfuscates passwords (shows only first 4 characters). Ideal for demos. |
| `--debug` | Print request debug information. |

### Advanced Hunting (Chasing)

| Flag | Description |
|------|-------------|
| `-ch`, `--chase` | Add related emails from hunter.io to target list. Define number of emails per target to chase. |
| `--power-chase` | Add related emails from ALL API services to the ongoing target list. Use with `--chase`. |

## Notes
- To use premium services (like HaveIBeenPwned or Dehashed), you must provide API keys in the config file or via the `-k` flag.
- When searching local files, h8mail uses multiprocessing to speed up the search.
- Use `--hide` when performing live demonstrations to avoid exposing full credentials.