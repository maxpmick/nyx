---
name: azurehound
description: Collect Microsoft Azure data for BloodHound and BloodHound Enterprise. Use when performing cloud reconnaissance, auditing Azure Active Directory (Entra ID) permissions, identifying attack paths in Azure environments, or conducting post-exploitation analysis of cloud infrastructure.
---

# azurehound

## Overview
AzureHound is the official data collector for Microsoft Azure, designed to feed data into BloodHound and BloodHound Enterprise. It enumerates Azure AD (Entra ID) and Azure Resource Manager (ARM) environments to map out relationships and permissions. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume azurehound is already installed. If you get a "command not found" error:

```bash
sudo apt install azurehound
```

## Common Workflows

### List Azure Objects using a JWT
```bash
azurehound list --jwt "YOUR_JWT_TOKEN" --tenant "example.onmicrosoft.com"
```

### Start data collection for BloodHound Enterprise
```bash
azurehound start --config /path/to/config.json
```

### Authenticate and list subscriptions
```bash
azurehound list subscriptions -r "YOUR_REFRESH_TOKEN"
```

### Configure AzureHound interactively
```bash
azurehound configure
```

## Complete Command Reference

### Global Flags
| Flag | Description |
|------|-------------|
| `-c`, `--config <string>` | AzureHound configuration file (default: `~/.config/azurehound/config.json`) |
| `-h`, `--help` | Help for azurehound |
| `--json` | Output logs as JSON |
| `-j`, `--jwt <string>` | Use an acquired JWT to authenticate into Azure |
| `--log-file <string>` | Output logs to this file |
| `--pprof <string>` | During graceful shutdown, prints the pprof profile with the provided name to stderr |
| `--proxy <string>` | Sets the proxy URL for the AzureHound service |
| `-r`, `--refresh-token <string>` | Use an acquired refresh token to authenticate into Azure |
| `-v`, `--verbosity <int>` | AzureHound verbosity level (defaults to 0) [Min: -1, Max: 2] |
| `--version` | Version for azurehound |

### Subcommands

#### `completion`
Generate the autocompletion script for the specified shell.
- **Usage**: `azurehound completion [bash|zsh|fish|powershell]`

#### `configure`
Interactive or file-based configuration of AzureHound credentials and settings.
- **Usage**: `azurehound configure [flags]`

#### `list`
Lists Azure Objects. This is the primary command for manual data enumeration.
- **Usage**: `azurehound list [flags]`
- **Common Sub-targets**: `subscriptions`, `tenants`, `users`, `groups`, `devices`, `applications`, `service-principals`.

#### `start`
Start the Azure data collection service specifically for BloodHound Enterprise.
- **Usage**: `azurehound start [flags]`

#### `help`
Help about any command.
- **Usage**: `azurehound help [command]`

## Notes
- AzureHound requires appropriate permissions in the target Azure tenant to enumerate objects (typically Global Reader or similar).
- Authentication can be handled via interactive login, Service Principal (client ID/secret), JWT, or Refresh Tokens.
- The output files (usually JSON) are intended to be uploaded into the BloodHound GUI for visualization and analysis.