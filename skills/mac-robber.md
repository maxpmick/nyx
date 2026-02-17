---
name: mac-robber
description: Collect metadata from allocated files in mounted filesystems to create timelines of file activity. Use during digital forensics, incident response, or live system analysis to gather MAC (Modification, Access, Change) times for files. It is particularly useful for analyzing obscure UNIX filesystems that are mounted but not directly supported by other forensic suites like The Sleuth Kit.
---

# mac-robber

## Overview
mac-robber is a digital investigation tool that collects metadata from allocated files in a mounted filesystem. It is based on the `grave-robber` tool from The Coroner's Toolkit (TCT). The output is designed to be processed by the `mactime` tool (from The Sleuth Kit) to create a chronological timeline of file activity. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume mac-robber is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install mac-robber
```

## Common Workflows

### Collect metadata from a specific directory
```bash
mac-robber /home/user/Documents > metadata.txt
```

### Collect metadata from an entire mounted filesystem
```bash
mac-robber /mnt/suspect_drive/ > filesystem_metadata.txt
```

### Create a timeline using The Sleuth Kit's mactime
After collecting data with mac-robber, use `mactime` to generate a human-readable timeline:
```bash
mac-robber /mnt/analysis > raw_body.txt
mactime -b raw_body.txt -d -y > timeline.csv
```

## Complete Command Reference

```
mac-robber [-V] <directories>
```

| Flag | Description |
|------|-------------|
| `-V` | Print the version information to stdout and exit |
| `<directories>` | One or more directory paths to recursively process |

## Notes
- **Live Systems**: mac-robber will modify the **Access times** on directories it processes if the filesystem is mounted with write permissions.
- **Limitations**: Unlike The Sleuth Kit (TSK), mac-robber relies on the operating system's APIs. It **cannot** recover deleted files or see files hidden by active rootkits.
- **Read-Only Mounting**: For forensic integrity, it is recommended to mount the suspect filesystem as read-only before running mac-robber.
- **Output Format**: The tool outputs data in the "body file" format (version 3.x), which includes MD5 (if available), file path, inode, permissions, UID, GID, size, and MAC times.