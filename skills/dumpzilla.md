---
name: dumpzilla
description: Extract and analyze forensic information from Mozilla-based browsers (Firefox, Iceweasel, Seamonkey). Use when performing digital forensics, incident response, or post-exploitation to recover browser history, passwords, cookies, downloads, and session data from a user profile directory.
---

# dumpzilla

## Overview
Dumpzilla is a Python 3 tool designed to extract forensically interesting data from Mozilla browser profiles. It supports Firefox, Iceweasel, and Seamonkey across Unix and Windows systems. It can visualize, search, and export browser artifacts like history, forms, and passwords. Category: Digital Forensics / Post-Exploitation.

## Installation (if not already installed)
Assume dumpzilla is already installed. If you encounter errors, ensure dependencies are met:

```bash
sudo apt install dumpzilla
```
Dependencies: `libnss3`, `python3`, `python3-lz4`, `python3-magic-ahupp`.

## Common Workflows

### Full profile analysis
Analyze a specific profile directory and dump all available information:
```bash
dumpzilla ~/.mozilla/firefox/xxxx.default --All
```

### Search browser history for specific URLs
Search for history entries containing "google" using wildcards:
```bash
dumpzilla ~/.mozilla/firefox/xxxx.default --History -url %google%
```

### Export profile data to JSON
Extract all forensic data and save it as JSON files for external analysis:
```bash
dumpzilla ~/.mozilla/firefox/xxxx.default --Export /tmp/forensic_export/
```

### Monitor browser activity in real-time
Watch URLs and form data being entered in real-time (Unix only):
```bash
dumpzilla ~/.mozilla/firefox/xxxx.default --Watch
```

## Complete Command Reference

```bash
python3 dumpzilla.py PROFILE_DIR [OPTIONS]
```

### Extraction Options

| Flag | Description |
|------|-------------|
| `--Addons` | Extract installed browser extensions and addons |
| `--Search` | Extract search engine history |
| `--Bookmarks` | Extract bookmarks. Supports `-bm_create_range` and `-bm_last_range` |
| `--Certoverride` | Extract certificate overrides |
| `--Cookies` | Extract cookies. Supports filtering by domain, name, and dates |
| `--Downloads` | Extract download history |
| `--Export <dir>` | Export all extracted data as JSON files to the specified directory |
| `--Forms` | Extract saved form data and autocomplete values |
| `--History` | Extract browsing history with URL and title filtering |
| `--Keypinning` | Extract HPKP/HSTS key pinning entries |
| `--OfflineCache` | Extract offline cache data |
| `--Preferences` | Extract browser configuration and preferences |
| `--Passwords` | Extract saved passwords (requires system NSS libraries) |
| `--Permissions` | Extract site-specific permissions |
| `--Session` | Extract current and last session data |
| `--Summary` | Show only a summary report without full data extraction |
| `--Thumbnails` | Extract website thumbnails/previews |
| `--Watch` | Daemon mode: shows URLs and text forms in real time (Unix only) |

### Filter & Sub-Options

| Flag | Description |
|------|-------------|
| `-bm_create_range <s e>` | Bookmark creation date range (start/end) |
| `-bm_last_range <s e>` | Bookmark last visit date range (start/end) |
| `-showdom` | Show DOM data in cookies |
| `-domain <string>` | Filter cookies by domain |
| `-name <string>` | Filter cookies by name |
| `-hostcookie <string>` | Filter cookies by host |
| `-access <date>` | Filter cookies by last access date |
| `-create <date>` | Filter cookies by creation date |
| `-secure <0\|1>` | Filter cookies by secure flag |
| `-httponly <0\|1>` | Filter cookies by HttpOnly flag |
| `-last_range <s e>` | Date range for last access/visit |
| `-create_range <s e>` | Date range for creation |
| `-range <s e>` | General date range for downloads |
| `-value <string>` | Filter form data by value |
| `-forms_range <s e>` | Date range for form entries |
| `-url <string>` | Filter history by URL |
| `-title <string>` | Filter history by page title |
| `-date <date>` | Filter history by specific date |
| `-history_range <s e>` | Date range for history entries |
| `-frequency` | Show frequency of visits in history |
| `-entry_type <HPKP\|HSTS>` | Filter keypinning by type |
| `-cache_range <s e>` | Date range for offline cache |
| `-extract <dir>` | Directory to extract cache/thumbnails |
| `-host <string>` | Filter permissions by host |
| `-modif <date>` | Filter permissions by modification date |
| `-modif_range <s e>` | Date range for permission modifications |
| `-extract_thumb <dir>` | Directory to extract thumbnails |
| `-text <string>` | Filter real-time watch by text string |
| `--RegExp` | Use Regular Expressions for string filters instead of Wildcards |
| `--Verbosity <LEVEL>` | Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL) |

## Notes
- **Wildcards**: By default, use `%` for any string and `_` for a single character. Use `\` to escape.
- **Date Syntax**: Use `YYYY-MM-DD hh:mi:ss` (wildcards are allowed in dates).
- **Profile Locations**:
  - Linux: `~/.mozilla/firefox/xxxx.default`
  - Windows: `%APPDATA%\Mozilla\Firefox\Profiles\xxxx.default`
  - macOS: `~/Library/Application Support/Firefox/Profiles/xxxx.default`
- **Security**: Password decryption requires the tool to access the local NSS databases (`key4.db`, `logins.json`).