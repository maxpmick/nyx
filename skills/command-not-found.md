---
name: command-not-found
description: Suggest and locate packages for missing commands in interactive sessions. Use when a command is not found on the system to identify which package needs to be installed, or to update the local database of command-to-package mappings.
---

# command-not-found

## Overview
A utility that provides a handler for missing commands, looking up available programs in the repositories that are not currently installed. It helps users identify the correct package to install when a binary is missing. Category: System Administration / Utility.

## Installation (if not already installed)
Assume the tool is already installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install command-not-found
```

## Common Workflows

### Finding the package for a missing command
If you try to run a tool like `gobuster` and it isn't installed, you can manually query it:
```bash
command-not-found gobuster
```

### Updating the command database
To ensure the tool knows about the latest packages available in the Kali repositories:
```bash
sudo update-command-not-found
```

### Searching for a command while ignoring local binaries
To see which package provides a command even if it is already installed locally:
```bash
command-not-found --ignore-installed ls
```

## Complete Command Reference

### command-not-found
Usage: `command-not-found [options] <command-name>`

| Flag | Description |
|------|-------------|
| `--version` | Show program's version number and exit |
| `-h`, `--help` | Show help message and exit |
| `-d DATA_DIR`, `--data-dir=DATA_DIR` | Use specific path to locate data fields |
| `--ignore-installed` | Ignore local binaries and display the available packages |
| `--no-failure-msg` | Do not print the standard '<command-name>: command not found' error |

### update-command-not-found
Updates the cache (databases) using files in `/var/cache/apt/apt-file`.

Usage: `update-command-not-found [-h|--help|-n|--no-apt-file]`

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print the help message |
| `-n`, `--no-apt-file` | Do not run `apt-file update` before updating the cache |

## Notes
- This tool is typically integrated into the shell (bash/zsh) to run automatically when a command is not found.
- It relies on `apt-file` data; if the database is stale, `update-command-not-found` should be run with root privileges.
- Dependencies include `apt-file`, `lsb-release`, `python3`, and `python3-apt`.