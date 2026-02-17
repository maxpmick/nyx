---
name: python-virtualenv
description: Create isolated Python environments with their own executables and library sets. Use when managing project-specific dependencies, avoiding conflicts with system-wide Python packages, or testing code across different Python versions during exploitation development or post-exploitation scripting.
---

# python-virtualenv

## Overview
`virtualenv` is a tool used to create isolated Python environments. Unlike the standard `venv` module, it is faster, more extendable, and can discover and create environments for arbitrarily installed Python versions. It allows users to install modules via pip without root access and without affecting the global system state. Category: Development / Post-Exploitation.

## Installation (if not already installed)
Assume `virtualenv` is already installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install python3-virtualenv
```

## Common Workflows

### Create a basic virtual environment
```bash
virtualenv my_project_env
```

### Create an environment using a specific Python interpreter
```bash
virtualenv -p /usr/bin/python3.11 my_env
```

### Activate the environment
```bash
source my_env/bin/activate
```

### Create an environment with access to system site-packages
```bash
virtualenv --system-site-packages my_env
```

### Clear an existing environment and recreate it
```bash
virtualenv --clear my_env
```

## Complete Command Reference

```
virtualenv [options] dest
```

### General Options

| Flag | Description |
|------|-------------|
| `--version` | Display the version of the virtualenv package and its location, then exit |
| `--with-traceback` | On failure also display the stacktrace internals of virtualenv (default: False) |
| `--read-only-app-data` | Use app data folder in read-only mode (default: False) |
| `--app-data APP_DATA` | A data folder used as cache (default: /root/.local/share/virtualenv) |
| `--reset-app-data` | Start with empty app data folder (default: False) |
| `--upgrade-embed-wheels` | Trigger a manual update of the embedded wheels (default: False) |
| `-h`, `--help` | Show help message and exit |

### Verbosity Options

| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | Increase verbosity (default: 2). Mapping: CRITICAL=0 to NOTSET=5 |
| `-q`, `--quiet` | Decrease verbosity (default: 0) |

### Discovery Options

| Flag | Description |
|------|-------------|
| `--discovery {builtin}` | Interpreter discovery method (default: builtin) |
| `-p`, `--python py` | Interpreter based on what to create environment (path/identifier) |
| `--try-first-with py_exe` | Try first these interpreters before starting the discovery |

### Creator Options

| Flag | Description |
|------|-------------|
| `--creator {builtin,cpython3-posix,venv}` | Create environment via specified method (default: builtin) |
| `dest` | Directory to create virtualenv at |
| `--clear` | Remove the destination directory if it exists before starting |
| `--no-vcs-ignore` | Don't create VCS ignore directive in the destination directory |
| `--system-site-packages` | Give the virtual environment access to the system site-packages dir |
| `--symlinks` | Try to use symlinks rather than copies (default: True) |
| `--copies`, `--always-copy` | Try to use copies rather than symlinks |

### Seeder Options

| Flag | Description |
|------|-------------|
| `--seeder {app-data,pip}` | Seed packages install method (default: app-data) |
| `--no-seed`, `--without-pip` | Do not install seed packages |
| `--no-download`, `--never-download` | Disable download of latest pip/setuptools/wheel from PyPI (default: True) |
| `--download` | Enable download of the latest pip/setuptools/wheel from PyPI |
| `--extra-search-dir d [d ...]` | Path containing wheels to extend the internal wheel list |
| `--pip version` | Version of pip to install: embed, bundle, none or exact version (default: bundle) |
| `--setuptools version` | Version of setuptools to install: embed, bundle, none or exact version (default: none) |
| `--no-pip` | Do not install pip |
| `--no-setuptools` | Do not install setuptools |
| `--no-periodic-update` | Disable periodic (14 days) update of embedded wheels (default: True) |
| `--symlink-app-data` | Symlink the python packages from the app-data folder |

### Activator Options

| Flag | Description |
|------|-------------|
| `--activators list` | Comma separated list of activators to generate (bash,cshell,fish,nushell,powershell,python) |
| `--prompt prompt` | Alternative prompt prefix (use `.` for current directory name) |

## Notes
- To exit a virtual environment, simply run the `deactivate` command.
- Configuration can be managed via `/root/.config/virtualenv/virtualenv.ini` or the `VIRTUALENV_CONFIG_FILE` environment variable.
- Using `--system-site-packages` is useful when you need large system-installed libraries (like `python3-scapy`) but want to install smaller dependencies locally.