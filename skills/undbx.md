---
name: undbx
description: Extract, recover, and undelete e-mail messages from Microsoft Outlook Express .dbx files. Use when performing digital forensics, email recovery, or incident response involving legacy Windows mail clients to retrieve active, corrupted, or deleted email fragments.
---

# undbx

## Overview
UnDBX is a specialized tool designed to extract e-mail messages from MS Outlook Express .dbx files. It is particularly effective for forensic investigations as it can parse corrupted files to recover messages and attempt to undelete fragments of messages that have not yet been overwritten. Category: Digital Forensics / Recovery.

## Installation (if not already installed)
Assume undbx is already installed. If the command is missing:

```bash
sudo apt install undbx
```

## Common Workflows

### Basic Extraction
Extract all emails from a specific .dbx file into a destination folder:
```bash
undbx Inbox.dbx ./extracted_emails/
```

### Forensic Recovery and Undelete
Enable recovery mode to parse corrupted files and attempt to retrieve deleted message fragments:
```bash
undbx --recover Deleted\ Items.dbx ./recovered_messages/
```

### Batch Processing
Extract emails from an entire directory containing multiple .dbx files:
```bash
undbx /path/to/outlook_express_folder/ ./output_dir/
```

### Safe Filename Extraction
Extract messages using locale-safe filenames to avoid filesystem compatibility issues:
```bash
undbx -s Sent\ Items.dbx ./sent_emails/
```

## Complete Command Reference

```bash
undbx [<OPTION>] <DBX-FOLDER | DBX-FILE> [<OUTPUT-FOLDER>]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `-V`, `--version` | Show only the version string. |
| `-v`, `--verbosity N` | Set verbosity level to N (default: 3). |
| `-r`, `--recover` | Enable recovery mode for corrupted files and deleted fragments. |
| `-s`, `--safe-mode` | Generate locale-safe file names for the extracted .eml files. |
| `-D`, `--delete` | Delete messages from the destination directory that were marked as deleted in the .dbx file. (Default behavior is to move them to a 'deleted' sub-directory). |
| `-i`, `--ignore0` | Ignore empty messages during the extraction process. |
| `-d`, `--debug` | Output detailed debug messages for troubleshooting. |

## Notes
- By default, `undbx` preserves deleted messages by moving them to a sub-directory named `deleted` within your output folder. Use `-D` only if you wish to synchronize the output folder to match the "live" state of the .dbx file.
- Recovery mode (`-r`) is essential when dealing with "compacted" or corrupted databases where standard extraction might fail.
- The tool outputs messages in standard `.eml` format, which can be opened by most modern mail clients or text editors.