---
name: gitleaks
description: Scan git repositories and local directories for hardcoded secrets such as passwords, API keys, and tokens. Use when performing security audits, repository reconnaissance, or CI/CD pipeline security checks to identify exposed credentials in past or present code commits.
---

# gitleaks

## Overview
Gitleaks is a Static Analysis Security Testing (SAST) tool designed to detect and prevent hardcoded secrets in git repositories. It scans commit history, staged changes, and local files to identify sensitive information. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume gitleaks is already installed. If you get a "command not found" error:

```bash
sudo apt install gitleaks
```

## Common Workflows

### Scan a local repository for leaks
```bash
gitleaks detect --source /path/to/repo -v
```

### Scan staged changes (pre-commit check)
```bash
gitleaks protect --staged -v
```

### Generate a report in SARIF format
```bash
gitleaks detect --report-path results.sarif --report-format sarif
```

### Scan using a custom configuration file
```bash
gitleaks detect --config my-custom-rules.toml --source .
```

## Complete Command Reference

### Global Flags
These flags apply to the base command and most subcommands.

| Flag | Description |
|------|-------------|
| `-b, --baseline-path <path>` | Path to baseline with issues that can be ignored |
| `-c, --config <path>` | Config file path (Precedence: flag > GITLEAKS_CONFIG env > .gitleaks.toml in source) |
| `--exit-code <int>` | Exit code when leaks are encountered (default: 1) |
| `-h, --help` | Help for gitleaks |
| `-l, --log-level <string>` | Log level (trace, debug, info, warn, error, fatal) (default: "info") |
| `--max-target-megabytes <int>` | Files larger than this size will be skipped |
| `--no-banner` | Suppress the Gitleaks banner |
| `--redact` | Redact secrets from logs and stdout |
| `-f, --report-format <string>` | Output format: json, csv, sarif (default: "json") |
| `-r, --report-path <path>` | File path to write the report |
| `-s, --source <path>` | Path to source (default: current directory ".") |
| `-v, --verbose` | Show verbose output from scan |

### Subcommands

#### detect
Scan a repository or directory for secrets in the history.
- **Usage**: `gitleaks detect [flags]`
- **Specific Flags**:
    - `--log-opts <string>`: Git log options (e.g., `--log-opts="--all --after=2023-01-01"`)
    - `--no-git`: Treat the source as a plain directory (skip git history)

#### protect
Scan uncommitted/staged changes to prevent secrets from being committed.
- **Usage**: `gitleaks protect [flags]`
- **Specific Flags**:
    - `--staged`: Scan only staged changes

#### completion
Generate the autocompletion script for the specified shell (bash, zsh, fish, powershell).
- **Usage**: `gitleaks completion [shell]`

#### help
Help about any command.

#### version
Display the version of gitleaks.

## Notes
- If no configuration is provided via `-c` or environment variables, gitleaks uses its built-in default rules.
- The `--redact` flag is highly recommended when sharing logs to prevent further exposure of the discovered secrets.
- For large repositories, use `--max-target-megabytes` to avoid performance issues with large binary files or logs.