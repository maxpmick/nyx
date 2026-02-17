---
name: obsidian
description: A private and flexible markdown-based note-taking and knowledge management application. Use when organizing research, documenting penetration testing findings, managing personal wikis (Second Brain), or maintaining offline-first security documentation and reports.
---

# obsidian

## Overview
Obsidian is a powerful knowledge base that works on top of a local folder of plain text Markdown files. It is highly extensible with plugins and themes, making it ideal for security professionals to track engagements, store snippets, and link complex pieces of information. Category: Information Gathering / Reporting.

## Installation (if not already installed)

Assume Obsidian is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install obsidian
```

## Common Workflows

### Launch Obsidian from the terminal
```bash
obsidian
```

### Open a specific vault or file via URI (if configured)
Obsidian supports a custom URI scheme to open specific vaults or files directly:
```bash
xdg-open "obsidian://open?vault=my-pentest-notes"
```

### Organizing Pentest Findings
1. Create a new Vault for the engagement.
2. Use Markdown files for each host or vulnerability.
3. Use `[[Internal Links]]` to connect related findings (e.g., linking a discovered credential to the service where it was used).
4. Use the Graph View to visualize the attack surface or lateral movement paths.

## Complete Command Reference

Obsidian is primarily a Graphical User Interface (GUI) application. When launched from the command line, it accepts standard Electron/Chromium flags.

### Execution
| Command | Description |
|---------|-------------|
| `obsidian` | Launch the Obsidian application |

### Standard Electron/Chromium Flags (Commonly used)
| Flag | Description |
|------|-------------|
| `--disable-gpu` | Disables hardware acceleration (useful for troubleshooting display issues in VMs) |
| `--no-sandbox` | Disables the Chromium sandbox (not recommended, but sometimes required in specific containerized environments) |
| `--incognito` | Starts the browser engine in incognito mode |
| `--version` | Display the version of the application |

## Notes
- **Data Privacy**: Obsidian stores all data locally in Markdown files. This is highly beneficial for sensitive security documentation as it does not require cloud synchronization.
- **Extensibility**: The "Community Plugins" section within the app allows for advanced features like Git integration, Kanban boards, and Dataview for querying your notes.
- **Portability**: Since notes are plain `.md` files, they can be easily searched using standard Linux tools like `grep`, `awk`, or `sed` from the terminal.
- **Vaults**: Obsidian refers to a project folder as a "Vault". You can have multiple vaults for different security engagements to keep data isolated.