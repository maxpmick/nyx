---
name: sn0int
description: Semi-automatic OSINT framework and package manager used to gather intelligence, enumerate attack surfaces, and map public information into a unified format. Use when performing reconnaissance, bug hunting, target footprinting, or managing OSINT investigation workflows and data.
---

# sn0int

## Overview
sn0int is a semi-automatic OSINT framework and package manager designed for IT security professionals and bug hunters. It automates the processing of public information to map attack surfaces and stores results in a structured database for follow-up investigations. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume sn0int is already installed. If you get a "command not found" error:

```bash
sudo apt install sn0int
```

## Common Workflows

### Initialize and start a new investigation
```bash
sn0int workspace create target_investigation
sn0int workspace select target_investigation
```

### Install and run a module
```bash
sn0int install kpcyrd/bing-subdomains
sn0int run bing-subdomains example.com
```

### Manage scope for automated processing
```bash
sn0int add domain example.com
sn0int scope domain example.com
sn0int run dns-bruteforce
```

### View workspace statistics
```bash
sn0int stats
```

## Complete Command Reference

```
sn0int [OPTIONS] [COMMAND]
```

### Global Options
| Flag | Description |
|------|-------------|
| `-w, --workspace <WORKSPACE>` | Select a different workspace instead of the default [env: `SN0INT_WORKSPACE=`] |
| `-h, --help` | Print help |
| `-V, --version` | Print version |

### Subcommands

| Command | Description |
|---------|-------------|
| `run` | Run a module directly |
| `sandbox` | For internal use |
| `login` | Login to the registry for publishing |
| `new` | Create a new module |
| `publish` | Publish a script to the registry |
| `install` | Install a module from the registry |
| `search` | Search in the registry |
| `pkg` | The sn0int package manager |
| `add` | Insert into the database |
| `select` | Select from the database |
| `delete` | Delete from the database |
| `activity` | Query logged activity |
| `scope` | Include entities in the scope |
| `noscope` | Exclude entities from scope |
| `autoscope` | Manage autoscope rules |
| `autonoscope` | Manage autonoscope rules |
| `rescope` | Rescope all entities based on autonoscope rules |
| `workspace` | Manage workspaces (create, select, delete, list) |
| `cal` | Calendar |
| `notify` | Notify |
| `fsck` | Verify blob storage for corrupt and dangling blobs |
| `export` | Export a workspace for external processing |
| `stats` | Show statistics about your current workspace |
| `repl` | Run a lua repl |
| `paths` | Show paths of various file system locations |
| `completions` | Generate shell completions |
| `help` | Print this message or the help of the given subcommand(s) |

## Notes
- **Workspaces**: sn0int uses workspaces to isolate data between different targets or investigations.
- **Modules**: Functionality is extended through modules written in Lua. You can find and install modules using the `search` and `install` commands.
- **Database**: All gathered intelligence is stored in a local SQLite database within the active workspace.
- **Sandboxing**: Modules are executed in a sandbox to ensure security during the intelligence gathering process.