---
name: pipal
description: Perform statistical analysis on password dumps and wordlists to identify patterns, common base words, and complexity trends. Use when analyzing leaked credentials, auditing password policies, or optimizing password cracking wordlists during penetration testing and security assessments.
---

# pipal

## Overview
Pipal is a password analyzer that provides statistical information on password lists. It helps security professionals interpret the composition of passwords by identifying top passwords, base words, length distributions, and character patterns. Category: Password Attacks / Reporting.

## Installation (if not already installed)
Assume pipal is already installed. If you get a "command not found" error:

```bash
sudo apt install pipal
```

Dependencies: ruby, ruby-json, ruby-levenshtein.

## Common Workflows

### Basic analysis of a password list
```bash
pipal passwords.txt
```

### Show the top 20 results for all categories
```bash
pipal -t 20 leaked_db.txt
```

### Analyze a wordlist and save results to a file
```bash
pipal -o analysis_results.txt /usr/share/wordlists/rockyou.txt
```

### Check available analysis modules
```bash
pipal --list-checkers
```

## Complete Command Reference

```
pipal [OPTION] ... FILENAME
```

### Options

| Flag | Description |
|------|-------------|
| `--help`, `-h`, `-?` | Show help message |
| `--top`, `-t <X>` | Show the top X results for each category (default: 10) |
| `--output`, `-o <filename>` | Save the statistical output to a specified file |
| `--gkey <API key>` | Google Maps API key to enable zip code lookups (optional) |
| `--list-checkers` | Show the available checkers (analysis modules) and which are enabled |
| `--verbose`, `-v` | Enable verbose output |

### Arguments

| Argument | Description |
|----------|-------------|
| `FILENAME` | The path to the password file or wordlist to analyze |

## Notes
- Pipal is highly effective for identifying "base words" (the root word before numbers or symbols are added), which is invaluable for creating targeted mask attacks in Hashcat or John the Ripper.
- You can hit `CTRL-C` during processing to finish early and dump statistics for the words already processed.
- The tool does not crack passwords; it provides the data necessary for a human to interpret patterns and improve cracking strategies.