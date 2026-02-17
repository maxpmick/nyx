---
name: getsploit
description: Search and download exploits from online databases including Exploit-DB, Metasploit, and Packetstorm. Use when looking for proof-of-concept code, vulnerability research, or during the exploitation phase of a penetration test to find and retrieve exploit scripts directly to the working directory.
---

# getsploit

## Overview
Command line utility inspired by searchsploit that combines exploit searching with immediate downloading. It queries the Vulners database to aggregate results from Exploit-DB, Metasploit, Packetstorm, and other popular collections. Category: Exploitation.

## Installation (if not already installed)
Assume getsploit is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install getsploit
```

## Common Workflows

### Search for exploits by software name
```bash
getsploit wordpress 5.0
```

### Search and download (mirror) all matching exploits
```bash
getsploit --mirror eternalblue
```

### Search using a specific API key and limit results
```bash
getsploit --api-key YOUR_API_KEY --count 10 "struts2"
```

### Update the local database and perform a local search
```bash
getsploit --update
getsploit --local "smb ghost"
```

## Complete Command Reference

```
getsploit [OPTIONS] [QUERY]...
```

### Options

| Flag | Description |
|------|-------------|
| `-j`, `--json` | Show search results in JSON format instead of the default table view |
| `-m`, `--mirror` | Mirror (download) the exploit source code files to the current working directory |
| `-l`, `--local` | Perform the search in the local database instead of querying the online Vulners API |
| `-u`, `--update` | Update the local `getsploit.db` database for offline searching |
| `-s`, `--set-key` | Interactively set and save the Vulners API key to the configuration |
| `-k`, `--api-key TEXT` | Provide the Vulners API key directly in the command line |
| `-c`, `--count INTEGER` | Set the search result limit (Range: 1 to 1000) |
| `--help` | Show the help message and exit |

## Notes
- While getsploit works without an API key for basic queries, some features or higher rate limits may require a free API key from Vulners.com.
- When using `--mirror`, ensure you are in a dedicated directory as it may download multiple files depending on the query results.
- The tool aggregates results from multiple sources, so check the "Source" column in the output to identify the platform (e.g., `metasploit`, `exploitdb`).