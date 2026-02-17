---
name: python-pipx
description: Install and run Python applications in isolated virtual environments to avoid dependency conflicts and system pollution. Use when you need to install CLI tools written in Python (like black, eth-brownie, or crackmapexec) while keeping them separate from the global Python environment, or when you want to run a Python tool once without permanently installing it.
---

# python-pipx

## Overview
pipx is a tool to help you install and run end-user applications written in Python. It creates an isolated virtual environment for each application and its dependencies, then adds a symlink to the application's executable in your PATH. This ensures that different tools don't have conflicting dependencies and your system Python remains clean. Category: Information Gathering / Exploitation / General Utility.

## Installation (if not already installed)
Assume pipx is already installed on Kali Linux. If not:

```bash
sudo apt install pipx
pipx ensurepath
```

## Common Workflows

### Install a Python CLI tool
Installs the package in a dedicated venv and symlinks the binary to `~/.local/bin`.
```bash
pipx install crackmapexec
```

### Run a tool without installing
Downloads the package to a temporary environment, runs the command, and cleans up.
```bash
pipx run holehe email@example.com
```

### Inject a dependency into an existing pipx environment
Useful for adding plugins or extra libraries to an installed tool.
```bash
pipx inject tool-name extra-library-name
```

### Upgrade all installed tools
```bash
pipx upgrade-all
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--quiet`, `-q` | Give less output (can be used up to 2 times) |
| `--verbose`, `-v` | Give more output (can be used up to 3 times) |
| `--global` | Perform action globally for all users |
| `--version` | Print version and exit |

### Subcommands

| Subcommand | Description |
|------------|-------------|
| `install` | Install a package into an isolated virtual environment |
| `install-all` | Install all packages |
| `uninject` | Uninstall injected packages from an existing Virtual Environment |
| `inject` | Install additional packages into an existing Virtual Environment |
| `pin` | Pin the specified package to prevent it from being upgraded |
| `unpin` | Unpin the specified package |
| `upgrade` | Upgrade a package |
| `upgrade-all` | Upgrade all packages (runs `pip install -U`) |
| `upgrade-shared` | Upgrade shared libraries |
| `uninstall` | Uninstall a package and its virtual environment |
| `uninstall-all` | Uninstall all pipx-managed packages |
| `reinstall` | Reinstall a package |
| `reinstall-all` | Reinstall all packages |
| `list` | List all installed packages and their binaries |
| `interpreter` | Interact with interpreters managed by pipx |
| `run` | Run a package binary from a temporary virtual environment |
| `runpip` | Run pip directly within a pipx-managed Virtual Environment |
| `ensurepath` | Ensure pipx directories are in your PATH |
| `environment` | Print environment variables and paths used by pipx |
| `completions` | Print instructions for enabling shell completions |

### Environment Variables
| Variable | Description |
|----------|-------------|
| `PIPX_HOME` | Overrides default location (`~/.local/share/pipx/venvs`) |
| `PIPX_GLOBAL_HOME` | Used instead of `PIPX_HOME` when `--global` is used |
| `PIPX_BIN_DIR` | Overrides location of app symlinks (`~/.local/bin`) |
| `PIPX_GLOBAL_BIN_DIR` | Used instead of `PIPX_BIN_DIR` when `--global` is used |
| `PIPX_MAN_DIR` | Overrides location of manual pages |
| `PIPX_GLOBAL_MAN_DIR` | Used instead of `PIPX_MAN_DIR` when `--global` is used |
| `PIPX_DEFAULT_PYTHON` | Overrides default python used for commands |
| `PIPX_USE_EMOJI` | Overrides emoji behavior in output |
| `PIPX_HOME_ALLOW_SPACE` | Overrides default warning on spaces in the home path |

## Notes
- pipx runs with regular user permissions; never use `sudo pipx install`.
- After the first installation, you may need to restart your terminal or run `source ~/.bashrc` (or equivalent) for the new binaries to be recognized in your PATH.
- Virtual Environments are stored in `/root/.local/share/pipx/venvs` (when root) or `~/.local/share/pipx/venvs` (when user).