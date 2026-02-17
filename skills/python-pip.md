---
name: python-pip
description: Manage Python packages including installation, uninstallation, and dependency resolution from PyPI or version control. Use when setting up security tools written in Python, managing environment dependencies, or installing libraries for custom exploit scripts during penetration testing and digital forensics.
---

# python-pip

## Overview
pip is the standard package installer for Python. It allows for the installation and management of additional libraries and dependencies not distributed as part of the standard library. It supports virtual environments, package state replaying, and installation from version control repositories. Category: Digital Forensics / Incident Response / General Utility.

## Installation (if not already installed)
Assume pip is already installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install python3-pip
```

## Common Workflows

### Install a specific package
```bash
pip install requests
```

### Install requirements from a file
```bash
pip install -r requirements.txt
```

### List installed packages and check for updates
```bash
pip list --outdated
```

### Export current environment to a file
```bash
pip freeze > requirements.txt
```

### Search for a package on PyPI
```bash
pip search "packet sniffer"
```

## Complete Command Reference

### Commands
| Command | Description |
|:---|:---|
| `install` | Install packages. |
| `lock` | Generate a lock file. |
| `download` | Download packages. |
| `uninstall` | Uninstall packages. |
| `freeze` | Output installed packages in requirements format. |
| `inspect` | Inspect the python environment. |
| `list` | List installed packages. |
| `show` | Show information about installed packages. |
| `check` | Verify installed packages have compatible dependencies. |
| `config` | Manage local and global configuration. |
| `search` | Search PyPI for packages. |
| `cache` | Inspect and manage pip's wheel cache. |
| `index` | Inspect information available from package indexes. |
| `wheel` | Build wheels from your requirements. |
| `hash` | Compute hashes of package archives. |
| `completion` | A helper command used for command completion. |
| `debug` | Show information useful for debugging. |
| `help` | Show help for commands. |

### General Options
| Flag | Description |
|:---|:---|
| `-h, --help` | Show help. |
| `--debug` | Let unhandled exceptions propagate outside the main subroutine. |
| `--isolated` | Run pip in isolated mode, ignoring environment variables and user config. |
| `--require-virtualenv` | Allow pip to only run in a virtual environment. |
| `--python <python>` | Run pip with the specified Python interpreter. |
| `-v, --verbose` | Give more output (additive up to 3 times). |
| `-V, --version` | Show version and exit. |
| `-q, --quiet` | Give less output (additive up to 3 times: WARNING, ERROR, CRITICAL). |
| `--log <path>` | Path to a verbose appending log. |
| `--no-input` | Disable prompting for input. |
| `--keyring-provider <provider>` | Enable credential lookup via keyring [auto, disabled, import, subprocess]. |
| `--proxy <proxy>` | Specify a proxy (scheme://[user:passwd@]proxy.server:port). |
| `--retries <retries>` | Maximum attempts to establish a new HTTP connection (default: 5). |
| `--timeout <sec>` | Set the socket timeout (default: 15 seconds). |
| `--exists-action <action>` | Action when path exists: (s)witch, (i)gnore, (w)ipe, (b)ackup, (a)bort. |
| `--trusted-host <hostname>` | Mark host as trusted despite lack of valid HTTPS. |
| `--cert <path>` | Path to PEM-encoded CA certificate bundle. |
| `--client-cert <path>` | Path to SSL client certificate (private key and cert in one PEM). |
| `--cache-dir <dir>` | Store the cache data in <dir>. |
| `--no-cache-dir` | Disable the cache. |
| `--disable-pip-version-check` | Don't check PyPI for new pip versions. |
| `--no-color` | Suppress colored output. |
| `--use-feature <feature>` | Enable new functionality that may be backward incompatible. |
| `--use-deprecated <feature>` | Enable deprecated functionality. |
| `--resume-retries <retries>` | Max attempts to resume/restart incomplete download (default: 5). |

## Notes
- On modern Kali Linux (Debian-based), you may encounter "externally-managed-environment" errors when using pip globally. It is recommended to use `python3 -m venv` to create a virtual environment or use `pipx` for CLI tools.
- Use `pip3` explicitly if `pip` points to a legacy Python 2 version, though in current Kali versions, `pip` usually maps to `pip3`.