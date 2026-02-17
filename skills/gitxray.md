---
name: gitxray
description: Scan GitHub repositories, organizations, and contributors to collect security-relevant data, perform OSINT, and conduct digital forensics. Use this tool to identify sensitive information in unconventional places, analyze contributor activity, and automate the gathering of information from the GitHub REST API during reconnaissance or investigation phases.
---

# gitxray

## Overview
Gitxray (Git X-Ray) is a security tool designed for deep analysis of GitHub repositories. It leverages public GitHub REST APIs to gather information for OSINT and forensics purposes, seeking out data that is typically time-consuming to find manually. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume gitxray is already installed. If the command is not found, install it using:

```bash
sudo apt install gitxray
```

## Common Workflows

### Analyze a single repository
```bash
gitxray -r https://github.com/username/repo-name
```

### List all repositories in an organization
```bash
gitxray -o organization-name -l
```

### Focus on specific contributors within a repository
```bash
gitxray -r username/repo-name -c "contributor1,contributor2"
```

### Scan multiple repositories from a file and output to JSON
```bash
gitxray -rf repos.txt -out results.json -outformat json
```

### Filter results for specific keywords
```bash
gitxray -r username/repo-name -f "password,secret,api_key,internal"
```

## Complete Command Reference

```
usage: gitxray [-h] (-r REPOSITORY | -rf REPOSITORIES_FILE | -o ORGANIZATION)
               [-c CONTRIBUTOR | -l] [-f FILTERS] [--debug] [--shush]
               [-out OUTFILE] [-outformat {html,text,json}]
```

### Target Selection (Required - Choose one)

| Flag | Description |
|------|-------------|
| `-r`, `--repository REPOSITORY` | The repository to check (Including `https://github.com/` is optional). |
| `-rf`, `--repositories-file FILE` | A file containing repository URLs or names separated by newlines. |
| `-o`, `--organization ORG` | An organization to check all of its repositories (Including `https://github.com/` is optional). |

### Scoping and Filtering Options

| Flag | Description |
|------|-------------|
| `-c`, `--contributor USERS` | A comma-separated list of contributor usernames to focus on within the specified Repository or Organization. |
| `-l`, `--list` | List contributors (if a repository was specified) or list repositories (if an Org was specified). Useful for initial discovery before targeted scanning. |
| `-f`, `--filters KEYWORDS` | Comma-separated keywords to filter results by (e.g., `private,macbook,ssh,config`). |

### Output and Logging Options

| Flag | Description |
|------|-------------|
| `-out`, `--outfile FILE` | Set the location for the output log file. |
| `-outformat`, `--output-format` | Format for the log file: `html`, `text`, or `json` (default: `html`). |
| `--shush` | Reduced output in stdout; removes progress indicators for a cleaner console. |
| `--debug` | Enable Debug mode for an excessive amount of troubleshooting output. |
| `-h`, `--help` | Show the help message and exit. |

## Notes
- Gitxray relies on the GitHub REST API. Be mindful of GitHub's rate limits, especially when scanning large organizations or many repositories without an API token (if the environment supports one).
- The tool is particularly effective at finding "unconventional" data points that standard secret scanners might miss.
- When using `-l`, the tool acts as a discovery agent to help you refine your `-c` or `-r` targets.