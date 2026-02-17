---
name: cherrytree
description: Manage hierarchical notes, documentation, and findings using a rich-text editor with syntax highlighting. Use when organizing penetration testing results, maintaining a knowledge base, documenting engagement progress, or managing structured data during information gathering and reporting phases.
---

# cherrytree

## Overview
CherryTree is a hierarchical note-taking application designed for structured data storage. It features rich text, syntax highlighting for various programming languages, image handling, and hyperlinks. It is a standard tool for security professionals to document engagement findings and maintain organized research. Category: Information Gathering / Reporting.

## Installation (if not already installed)
Assume cherrytree is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install cherrytree
```

## Common Workflows

### Launching the GUI
Simply run the command to open the application:
```bash
cherrytree
```

### Opening a specific notebook at a specific node
```bash
cherrytree ~/Documents/engagement_notes.ctb -n "Vulnerability Scan Results"
```

### Exporting a notebook to HTML for reporting
```bash
cherrytree ~/Documents/notes.ctb -x ~/Reports/html_export/
```

### Opening a password-protected notebook
```bash
cherrytree ~/Documents/secure_notes.ctb -P "yourpassword"
```

## Complete Command Reference

```
cherrytree [-V] [-N] [filepath [-n nodename] [-a anchorname] [-x export_to_html_dir] [-t export_to_txt_dir] [-p export_to_pdf_path] [-P password] [-w] [-s]]
```

### Arguments and Options

| Flag | Description |
|------|-------------|
| `filepath` | Path to the cherrytree document to open (.ctb, .ctz, .ctd, etc.) |
| `-V`, `--version` | Print the version of the application |
| `-N`, `--new-instance` | Force the opening of a new instance of the application |
| `-n`, `--node` | Focus on a specific node name in the opened document |
| `-a`, `--anchor` | Focus on a specific anchor name in the opened document |
| `-x`, `--export-to-html` | Export the document to HTML format at the specified directory |
| `-t`, `--export-to-txt` | Export the document to Plain Text format at the specified directory |
| `-p`, `--export-to-pdf` | Export the document to PDF format at the specified path |
| `-P`, `--password` | Provide the password for an encrypted document |
| `-w`, `--window-on-top` | Start the application with the window always on top |
| `-s`, `--secondary-monitor` | Start the application on the secondary monitor |

## Notes
- CherryTree supports both SQLite-based (.ctb) and XML-based (.ctd) file formats. SQLite is generally recommended for larger notebooks.
- When using the `-x`, `-t`, or `-p` export flags, the application can be used in a headless-like manner to generate reports from existing notes.
- Ensure you handle password-protected files carefully in command history; using `-P` in a terminal may leave the password in your `.bash_history`.