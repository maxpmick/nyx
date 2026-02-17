---
name: sigma-cli
description: Manage, list, and convert Sigma rules into various SIEM and EDR query languages using the pySigma library. Use when performing threat hunting, security monitoring, rule validation, or converting generic Sigma detection rules into actionable queries for platforms like Splunk, ELK, or Microsoft Sentinel.
---

# sigma-cli

## Overview
The Sigma command line interface (sigma-cli) is a tool built on the pySigma library to manage Sigma rules. It allows users to list available backends, manage plugins, validate rule syntax, and convert rules into specific query languages for security operations. Category: Vulnerability Analysis / Defensive Security.

## Installation (if not already installed)
Assume sigma-cli is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install sigma-cli
```

## Common Workflows

### List available conversion targets (backends)
```bash
sigma-cli list targets
```

### Convert a Sigma rule to a specific SIEM format
```bash
sigma-cli convert -t splunk -p sysmon windows/process_creation/proc_creation_win_mimikatz_command_line.yml
```

### Check Sigma rules for syntax errors and best practices
```bash
sigma-cli check /path/to/sigma/rules/
```

### Install a new backend plugin
```bash
sigma-cli plugin install elasticsearch
```

## Complete Command Reference

### Global Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |

### Subcommands

#### `analyze`
Analyze Sigma rule sets.
```bash
sigma-cli analyze [OPTIONS] [SIGMA_RULE]...
```

#### `check`
Check Sigma rules for validity and best practices.
```bash
sigma-cli check [OPTIONS] [SIGMA_RULE]...
```

#### `check-pysigma`
Check if the installed version of pySigma is compatible with the CLI.
```bash
sigma-cli check-pysigma [OPTIONS]
```

#### `convert`
Convert Sigma rules into queries for specific backends.
```bash
sigma-cli convert [OPTIONS] [SIGMA_RULE]...
```
*Note: Requires `-t` (target) and optionally `-p` (pipeline) arguments.*

#### `list`
List available targets (backends) or processing pipelines.
```bash
sigma-cli list [OPTIONS] {targets|pipelines}
```

#### `plugin`
Manage pySigma plugins (backends, processing pipelines).
```bash
sigma-cli plugin [OPTIONS] COMMAND [ARGS]...
```
**Plugin Subcommands:**
- `list`: List installed and available plugins.
- `install`: Install a plugin.
- `uninstall`: Remove a plugin.
- `update`: Update installed plugins.

#### `version`
Print the version of Sigma CLI.
```bash
sigma-cli version
```

## Notes
- Sigma rules are generic YAML files; `sigma-cli` requires "backends" (plugins) to convert these into specific query languages like Splunk SPL, Elastic DSL, or Sentinel KQL.
- Use `sigma-cli plugin list` to see what backends are currently available on your system.
- Processing pipelines (`-p`) are often necessary to map generic field names in Sigma rules to the specific naming conventions used in your environment (e.g., mapping `Image` to `process.executable`).