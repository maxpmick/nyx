---
name: joplin
description: Manage notes and to-do lists in Markdown format with support for synchronization, encryption, and Evernote imports. Use when organizing research data, managing penetration testing tasks, or synchronizing documentation across multiple devices via CLI or GUI.
---

# joplin

## Overview
Joplin is an open-source note-taking and to-do application that handles large numbers of notes organized into notebooks. Notes are searchable, taggable, and stored in Markdown format. It supports synchronization with cloud services (Nextcloud, Dropbox, OneDrive, WebDAV) and E2EE (End-to-End Encryption). Category: Information Gathering / Documentation.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux "everything" metapackage. If missing:

```bash
# For the Desktop/GUI version
sudo apt install joplin

# For the Command Line Interface
sudo apt install joplin-cli
```

## Common Workflows

### Initialize and Create a Note
```bash
joplin mkbook "Pentest-Project-X"
joplin use "Pentest-Project-X"
joplin mknote "Recon-Findings"
joplin edit "Recon-Findings"
```

### Search and List Notes
```bash
joplin ls /          # List all notebooks
joplin ls -l         # List notes in current notebook with details
joplin search "SQLi" # Search for specific terms across all notes
```

### Import and Export
```bash
joplin import /path/to/notes.enex --format enex  # Import from Evernote
joplin export /path/to/backup/                   # Export all notes
```

### Synchronization Setup
```bash
joplin config sync.target 5                      # Set target to Dropbox (example)
joplin sync                                      # Start synchronization
```

## Complete Command Reference

The CLI is accessed via the `joplin` command. Use `joplin help <command>` for detailed info on specific subcommands.

### General Commands

| Command | Description |
|---------|-------------|
| `cat <item>` | Displays item content |
| `config [name] [value]` | Gets or sets a configuration condition |
| `cp <source> [destination]` | Copies an item to another notebook |
| `edit <item>` | Edits an item in an external editor |
| `export <path>` | Exports Joplin data to a directory |
| `help [command]` | Displays help for a command |
| `import <path> [notebook]` | Imports data (ENEX/Markdown) into Joplin |
| `ls [directory]` | Lists nodes in a directory |
| `mv <source> [destination]` | Moves an item to another notebook |
| `rm <item-pattern>` | Deletes an item |
| `search <query> [notebook]` | Searches for notes |
| `status` | Displays summary of notes and sync status |
| `sync` | Synchronizes local data with remote storage |
| `use <notebook>` | Switches to a specific notebook |
| `version` | Displays version information |

### Notebook & Note Management

| Command | Description |
|---------|-------------|
| `mkbook <notebook>` | Creates a new notebook |
| `mknote <note>` | Creates a new note |
| `mktodo <todo>` | Creates a new to-do |
| `ren <item> <name>` | Renames an item |
| `tag <command> [tag] [item]` | Manages tags (add, remove, list) |
| `todo <command> [todo]` | Manages to-do items (toggle, clear) |

### Global Options

| Flag | Description |
|------|-------------|
| `--profile <path>` | Use a specific profile directory |
| `--env <env>` | Specify environment (dev/prod) |
| `--log-level <level>` | Set logging level (none, error, warn, info, debug) |

## Notes
- **Editor**: By default, `joplin edit` uses the system default editor. You can change this via `joplin config editor vim`.
- **Sync Targets**: 
  - 0: None
  - 1: File system
  - 2: OneDrive
  - 3: Nextcloud
  - 4: WebDAV
  - 5: Dropbox
  - 6: Joplin Server
- **Storage**: On Linux, data is typically stored in `~/.config/joplin-desktop` or `~/.config/joplin`.