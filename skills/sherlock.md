---
name: sherlock
description: Hunt down social media accounts by username across over 300 networks including GitHub, Facebook, Instagram, and Telegram. Use when performing OSINT (Open Source Intelligence), digital footprinting, or person-of-interest investigations to identify linked accounts and online presence.
---

# sherlock

## Overview
Sherlock is an OSINT tool used to find usernames across hundreds of social networks. It works by querying unique profile URLs for a given username and analyzing the HTTP response to determine if the account exists. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume Sherlock is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install sherlock
```

## Common Workflows

### Basic search for a single username
```bash
sherlock user123
```

### Search for multiple usernames and save to a specific folder
```bash
sherlock user1 user2 user3 --folderoutput ./investigation_results
```

### Search using Tor for anonymity (requires Tor service)
```bash
sherlock --tor user123
```

### Filter search to specific sites only
```bash
sherlock --site GitHub --site Instagram --site Twitter user123
```

### Search with wildcard variations
```bash
sherlock "user{?}name"
```
This will check variations replacing `{?}` with `_`, `-`, and `.`.

## Complete Command Reference

```
sherlock [options] USERNAMES [USERNAMES ...]
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `USERNAMES` | One or more usernames to check. Use `{?}` to test variations with `_`, `-`, and `.` |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--version` | Display version information and dependencies |
| `--verbose`, `-v`, `-d`, `--debug` | Display extra debugging information and metrics |
| `--folderoutput`, `-fo <FOLDER>` | Folder to save results when checking multiple usernames |
| `--output`, `-o <FILE>` | File to save results when checking a single username |
| `--tor`, `-t` | Make requests over Tor (requires Tor in system path) |
| `--unique-tor`, `-u` | Make requests over Tor with a new circuit after each request |
| `--csv` | Create a Comma-Separated Values (CSV) file |
| `--xlsx` | Create a Microsoft Excel (xlsx) spreadsheet |
| `--site <SITE_NAME>` | Limit analysis to specific sites (can be used multiple times) |
| `--proxy`, `-p <PROXY_URL>` | Make requests over a proxy (e.g., `socks5://127.0.0.1:1080`) |
| `--dump-response` | Dump the HTTP response to stdout for targeted debugging |
| `--json`, `-j <JSON_FILE>` | Load site data from a local or online JSON file |
| `--timeout <TIMEOUT>` | Time in seconds to wait for responses (Default: 60) |
| `--print-all` | Output sites where the username was NOT found |
| `--print-found` | Output sites where the username was found (default behavior for terminal) |
| `--no-color` | Disable color in terminal output |
| `--browse`, `-b` | Open all found profile URLs in the default web browser |
| `--local`, `-l` | Force the use of the local `data.json` file |
| `--nsfw` | Include checking of NSFW sites from the default list |

## Notes
- **Tor Usage**: Using `--tor` or `--unique-tor` significantly increases runtime but provides anonymity and helps bypass rate limiting.
- **False Positives**: Some sites may return false positives if they use generic "User Not Found" pages that return a 200 OK status.
- **Rate Limiting**: Running broad searches frequently may result in your IP being temporarily blocked by certain social media platforms; consider using proxies or Tor.