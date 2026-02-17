---
name: inspy
description: Enumerate LinkedIn employees and identify technologies used by a target company. Use when performing reconnaissance, social engineering preparation, or information gathering to discover potential targets, email addresses, and job titles within an organization.
---

# inspy

## Overview
InSpy is a Python-based LinkedIn enumeration tool designed to discover employees by title or department and identify technologies in use at a target company. It can generate potential email addresses based on discovered names using common corporate formats. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume inspy is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install inspy
```

## Common Workflows

### Basic Employee Enumeration
Search for employees at a specific company using the default title list:
```bash
inspy --domain example.com --titles example_company
```

### Employee Discovery with Custom Wordlist and Email Generation
Search for employees using a large title list and format their names into email addresses:
```bash
inspy --domain example.com --email first.last@example.com --titles /usr/share/inspy/wordlists/title-list-large.txt example_company
```

### Technology Identification
Search for technologies in use at a target company:
```bash
inspy --techspy /usr/share/inspy/wordlists/tech-list-small.txt cisco
```

### Exporting Results to JSON
Enumerate employees and save the output for programmatic processing:
```bash
inspy --titles --json results.json target_corp
```

## Complete Command Reference

```bash
usage: inspy [-h] [--domain DOMAIN] [--email EMAIL] [--titles [file]]
             [--html file] [--csv file] [--json file] [--xml file]
             company
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `company` | Company name to use for tasks. |

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--domain DOMAIN` | Company domain to use for searching. |
| `--email EMAIL` | Email format to create email addresses with. Accepted Formats: `first.last@xyz.com`, `last.first@xyz.com`, `firstl@xyz.com`, `lfirst@xyz.com`, `flast@xyz.com`, `lastf@xyz.com`, `first@xyz.com`, `last@xyz.com`. |
| `--titles [file]` | Discover employees by title and/or department. Titles and departments are imported from a new line delimited file. [Default: title-list-small.txt]. |
| `--empspy <file>` | Search LinkedIn for employees with the provided wordlist of job titles. |
| `--techspy <file>` | Search for technologies in use at the target company using the provided list of terms. |

### Output Options

| Flag | Description |
|------|-------------|
| `--html file` | Print results in HTML file. |
| `--csv file` | Print results in CSV format. |
| `--json file` | Print results in JSON format. |
| `--xml file` | Print results in XML format. |

## Notes
- You may need an API key from HunterIO for certain advanced functionality.
- LinkedIn enumeration is subject to rate limiting and changes in site structure; ensure the tool is updated to the latest version.
- Default wordlists are typically located in `/usr/share/inspy/wordlists/`.