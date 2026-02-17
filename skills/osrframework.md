---
name: osrframework
description: A comprehensive Open Source Intelligence (OSINT) framework for performing username checking, DNS lookups, information leak research, deep web searches, and regular expression extraction. Use when performing reconnaissance, identifying a target's digital footprint across social media and web platforms, or verifying email and phone number associations during information gathering.
---

# OSRFramework

## Overview
OSRFramework is a set of libraries and CLI tools developed by i3visio for Open Source Intelligence tasks. It specializes in enumerating accounts across hundreds of platforms, generating potential aliases, and verifying email/phone data. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install osrframework
```

## Common Workflows

### Check username across all platforms
```bash
usufy -n "target_user"
```

### Search for a string across multiple OSINT sources
```bash
searchfy -q "target_name"
```

### Generate potential aliases from known info
```bash
alias_generator -n "John" -s1 "Doe" -y 1990 --numbers --leet
```

### Verify email existence for a specific nick
```bash
mailfy -n "target_nick" -p all
```

## Complete Command Reference

### osrf / osrframework-cli
The main entry point for the framework.
```bash
osrf <sub_command> [options]
```
**Subcommands:**
- `alias_generator`: Generate candidate usernames.
- `checkfy`: Verify if an email matches a pattern.
- `domainfy`: Check domain availability based on nicks.
- `mailfy`: Get info about email accounts.
- `phonefy`: Check phone numbers against spam lists.
- `searchfy`: Query multiple platforms.
- `usufy`: Search for nicknames on social media.

---

### usufy
Checks for profile existence across dozens of platforms.

| Flag | Description |
|------|-------------|
| `-n, --nicks <nick> ...` | List of nicks to process. |
| `-l, --list <file>` | Path to file with list of nicks (one per line). |
| `-p, --platforms <p> ...` | Select platforms (e.g., `github`, `instagram`, `all`). |
| `-t, --tags <tag> ...` | Select platforms by tags. |
| `-x, --exclude <p> ...` | Platforms to exclude. |
| `-e, --extension <ext>` | Output extension (Default: `csv`). |
| `-o, --output_folder <dir>` | Folder for generated documents. |
| `-T, --threads <num>` | Number of threads (Default: 32). |
| `-w, --web_browser` | Open found URIs in default browser. |
| `--info <action>` | `list_platforms` or `list_tags`. |
| `--show_tags` | Show platforms grouped by tags. |
| `-v, --verbose <0-2>` | Verbosity level: 0 (min), 1 (normal), 2 (debug). |
| `--avoid_download` | Do not store downloadable versions of profiles. |
| `--nonvalid <chars>` | Characters considered invalid for nicknames. |

---

### alias_generator
Generates candidate usernames based on personal details.

| Flag | Description |
|------|-------------|
| `-n, --name <NAME>` | Name of the person. |
| `-s1, --surname1 <S1>` | First surname. |
| `-s2, --surname2 <S2>` | Second surname. |
| `-c, --city <CITY>` | Linked city. |
| `-y, --year <YEAR>` | Birth year. |
| `--numbers` | Adds numbers at the end of nicknames. |
| `--leet` | Enables leet mode (e.g., 'a' -> '4'). |
| `--common-words` | Adds common words at the end. |
| `--locales` | Adds country-linked endings. |
| `--extra-words <words>` | Adds user-provided words to nicknames. |

---

### mailfy
Checks for the existence of email accounts.

| Flag | Description |
|------|-------------|
| `-m, --emails <list>` | List of emails to check. |
| `-M, --emails-file <f>` | File containing list of emails. |
| `-n, --nicks <list>` | Nicks to check in selected domains. |
| `--create-emails <f>` | Create emails from nicks in selected domains. |
| `-d, --domains <list>` | Domains to check (e.g., gmail.com). |
| `-p, --platforms <p>` | Platforms: `all`, `infojobs`, `instagram`, `keyserverubuntu`, `okcupid`. |
| `-T, --threads <num>` | Number of threads (Default: 16). |

---

### domainfy
Checks for domains resolving to an IP address.

| Flag | Description |
|------|-------------|
| `-n, --nicks <list>` | List of nicks to check as domains. |
| `-t, --tlds <types>` | List of TLD types to search. |
| `-u, --user-defined <tld>` | Additional TLDs to search. |
| `--whois` | Launch whois queries for found domains. |
| `-x, --exclude <domain>` | Domains to avoid (format: `.com`). |

---

### searchfy
Performs queries on multiple OSRFramework platforms.

| Flag | Description |
|------|-------------|
| `-q, --queries <list>` | List of queries to perform. |
| `-p, --platforms <p>` | Platforms: `all`, `github`, `instagram`, `keyserverubuntu`. |
| `-w, --web_browser` | Open results in browser. |
| `-x, --exclude <p>` | Platforms to exclude. |

---

### phonefy
Checks phone numbers against malicious/spam activity lists.

| Flag | Description |
|------|-------------|
| `-n, --numbers <list>` | List of phone numbers to process. |
| `-p, --platforms <p>` | Platforms: `all`, `infotelefonica`, `listaspam`, `xtelefonos`. |
| `-w, --web_browser` | Open results in browser. |

---

### checkfy
Finds potential emails based on nicks and a known pattern.

| Flag | Description |
|------|-------------|
| `-m, --email-pattern <p>` | The email pattern to match. |
| `-t, --type <type>` | Pattern type: `twitter` (suggestions style) or `regexp`. |
| `-n, --nicks <list>` | List of nicks to check. |

## Notes
- Most tools support `-o` for output directories and `-e` for file extensions (xls, csv, etc.).
- Use `osrf <command> --help` for the most up-to-date platform lists as they change frequently.
- High thread counts (`-T`) can lead to rate-limiting or system instability.