---
name: dumpsterdiver
description: Analyze large volumes of data to find hardcoded secrets such as AWS keys, Azure Share keys, SSH keys, and passwords. Use when performing post-exploitation data mining, source code auditing, or searching through backups and logs for sensitive information leaks during a penetration test.
---

# dumpsterdiver

## Overview
DumpsterDiver is a tool designed to identify potential secret leaks in big volumes of data. It searches for high-entropy strings (keys) and passwords, and supports custom search rules via YAML configuration to identify specific patterns like email addresses or sensitive file types. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume DumpsterDiver is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install dumpsterdiver
```

## Common Workflows

### Basic secret and key search
Search for high-entropy keys in a specific directory:
```bash
dumpsterdiver -p ./captured_data/
```

### Searching for passwords with complexity filtering
Search for passwords with a minimum length of 10 and a complexity score of at least 7:
```bash
dumpsterdiver -p ./logs/ -s --min-pass 10 --pass-complex 7
```

### Advanced analysis with custom rules and output
Run advanced analysis using rules in `rules.yaml` and save results to a JSON file:
```bash
dumpsterdiver -p ./src/ -a -o results.json
```

### Cleaning up non-sensitive files
Analyze a folder and delete any files that do not contain identified secrets:
```bash
dumpsterdiver -p ./temp_loot/ -r
```

## Complete Command Reference

```
DumpsterDiver.py [-h] -p LOCAL_PATH [-r] [-a] [-s] [-o OUTFILE]
                 [--min-key MIN_KEY] [--max-key MAX_KEY]
                 [--entropy ENTROPY] [--min-pass MIN_PASS]
                 [--max-pass MAX_PASS]
                 [--pass-complex {1,2,3,4,5,6,7,8,9}]
                 [--exclude-files EXCLUDE_FILES [EXCLUDE_FILES ...]]
                 [--bad-expressions BAD_EXPRESSIONS [BAD_EXPRESSIONS ...]]
```

### Basic Usage Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit. |
| `-p LOCAL_PATH` | **Required.** Path to the folder containing files to be analyzed. |
| `-r`, `--remove` | When set, files which do not contain any secrets will be removed from the disk. |
| `-a`, `--advance` | Additionally analyze all files using rules specified in `~/.dumpsterdiver/rules.yaml`. |
| `-s`, `--secret` | Additionally analyze all files in search of hardcoded passwords. |
| `-o OUTFILE` | Save the output results in JSON format to the specified file. |

### Configuration Options

| Flag | Description |
|------|-------------|
| `--min-key MIN_KEY` | Minimum key length to be analyzed (default: 20). |
| `--max-key MAX_KEY` | Maximum key length to be analyzed (default: 80). |
| `--entropy ENTROPY` | The threshold for high entropy detection (default: 4.3). |
| `--min-pass MIN_PASS` | Minimum password length to be analyzed (default: 8). Requires `-s`. |
| `--max-pass MAX_PASS` | Maximum password length to be analyzed (default: 12). Requires `-s`. |
| `--pass-complex {1..9}` | Password complexity threshold from 1 (trivial) to 9 (very complex) (default: 8). Requires `-s`. |
| `--exclude-files <list>` | Specify file names or extensions to skip. Extensions must include the dot (e.g., `.pdf`). Separate multiple entries with spaces. |
| `--bad-expressions <list>` | Specify strings that, if found, cause the tool to skip the rest of the file. Separate multiple expressions with spaces. |

## Notes
- **Entropy:** Higher entropy values reduce false positives but may miss shorter or less complex keys.
- **Rules:** The `--advance` flag relies on `~/.dumpsterdiver/rules.yaml`. You can customize this file to look for specific patterns like IP addresses, credit card numbers, or internal hostnames.
- **Caution:** The `-r` (remove) flag is destructive. Ensure you have backups before running it on original data sources.