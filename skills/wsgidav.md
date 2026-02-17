---
name: wsgidav
description: Deploy a generic and extendable WebDAV server based on WSGI to share file system folders. Use when needing to exfiltrate data, host a network share for lateral movement, or provide a remote file system for web application testing and exploitation.
---

# wsgidav

## Overview
wsgidav is a Python-based WebDAV server used to publish local file system folders over the network. It supports various authentication methods and WSGI server backends. Category: Sniffing & Spoofing / Post-Exploitation.

## Installation (if not already installed)
Assume wsgidav is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install python3-wsgidav
```

## Common Workflows

### Quick Anonymous Share
Share the `/tmp` directory publicly on port 80 without authentication:
```bash
wsgidav --port=80 --host=0.0.0.0 --root=/tmp --auth=anonymous
```

### Secure Local Share
Share the current directory on the default port (8080) accessible only to the local machine:
```bash
wsgidav --root=.
```

### Using a Custom Configuration
Run the server using a specific YAML or JSON configuration file:
```bash
wsgidav --config=~/my_wsgidav.yaml --port=443 --host=0.0.0.0
```

### High-Performance Server
Run using the `uvicorn` or `gunicorn` backend (requires the respective python packages to be installed):
```bash
wsgidav --server=uvicorn --root=/data --host=0.0.0.0
```

## Complete Command Reference

```
wsgidav [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-p`, `--port PORT` | Port to serve on (default: 8080) |
| `-H`, `--host HOST` | Host to serve from (default: localhost). Use `0.0.0.0` for public access |
| `-r`, `--root ROOT_PATH` | Path to a file system folder to publish for Read/Write as share '/' |
| `--auth {anonymous,nt,pam-login}` | Quick configuration of a domain controller when no config file is used |
| `--server {cheroot,ext-wsgiutils,gevent,gunicorn,paste,uvicorn,wsgiref}` | Type of pre-installed WSGI server to use (default: cheroot) |
| `--ssl-adapter {builtin,pyopenssl}` | SSL adapter used by 'cheroot' server if certificates are configured (default: builtin) |
| `-v`, `--verbose` | Increment verbosity by one (default: 3, range: 0..5) |
| `-q`, `--quiet` | Decrement verbosity by one |
| `-c`, `--config CONFIG_FILE` | Path to configuration file (default: looks for `wsgidav.yaml` or `wsgidav.json` in current directory) |
| `--no-config` | Do not try to load default configuration files |
| `--browse` | Open the system web browser on start |
| `-V`, `--version` | Print version info and exit (can be combined with `--verbose`) |

## Notes
- If no configuration file is specified, the application automatically looks for `wsgidav.yaml` or `wsgidav.json` in the current working directory.
- Using `--auth=anonymous` allows any user to read and write to the shared directory; use with caution in untrusted environments.
- The `cheroot` server is the default and supports SSL if configured in the YAML file.