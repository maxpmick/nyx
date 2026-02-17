---
name: missidentify
description: Identify Microsoft Windows win32 executable files (EXE, DLL, COM, etc.) based on file headers rather than extensions. Use during digital forensics, incident response, or malware analysis to find hidden or renamed executable binaries that lack standard extensions or are disguised as other file types.
---

# missidentify

## Overview
Miss Identify (missidentify) is a forensics tool designed to find MS Windows win32 applications. By default, it identifies executable files that do not have a standard executable extension (such as .exe, .dll, .com, .sys, .cpl, .hxs, .hxi, .olb, .rll, or .tlb). It is primarily used in forensics investigations to find malicious binaries attempting to evade detection through renaming. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt install missidentify
```

## Common Workflows

### Find hidden executables in a directory
Scan a directory for files that are win32 executables but do not have standard extensions:
```bash
missidentify /path/to/suspect/dir/*
```

### Recursive search for all executables
Search through all subdirectories and display every win32 executable found, regardless of whether its extension is "correct" or not:
```bash
missidentify -r -a /home/user/Downloads/
```

### Silent identification for scripting
Find hidden executables recursively, suppressing error messages and showing only the filenames without paths:
```bash
missidentify -rqb /mnt/evidence_drive/
```

## Complete Command Reference

```
missidentify [-Vh] [-rablv] [-s|-S len] [FILES]
```

### Options

| Flag | Description |
|------|-------------|
| `-r` | **Recursive mode**: All subdirectories are traversed. |
| `-q` | **Silent mode**: No error messages are displayed (useful for permission denied errors). |
| `-a` | **Display all**: Shows all executable files found, regardless of their file extension. |
| `-b` | **Bare filename**: Displays only the filename with no path information. |
| `-l` | **Relative paths**: Displays relative paths in filenames instead of absolute paths. |
| `-v` | **Verbose mode**: Displays the filename for every 10th file processed to show progress. |
| `-s` | **Display strings**: Extract and display strings from the identified files. |
| `-S <len>` | **Display strings (length)**: Display strings of at least length `len`. |
| `-V` | **Version**: Display version number and exit. |
| `-h` | **Help**: Display the help message and usage summary. |

## Notes
- By default, the tool filters out files that already have common Windows executable extensions (.exe, .dll, .com, .sys, .cpl, .hxs, .hxi, .olb, .rll, .tlb). Use `-a` to disable this filter.
- This tool is specifically tuned for win32 PE (Portable Executable) headers.
- It is highly effective for finding malware that has been renamed to look like configuration files (.conf, .txt) or data files.