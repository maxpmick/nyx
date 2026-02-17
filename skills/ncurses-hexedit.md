---
name: ncurses-hexedit
description: Edit and view files or disks in hexadecimal, ASCII, and EBCDIC formats using a full-screen curses interface. Use when performing binary analysis, manual file carving, disk editing, or hex-level data modification during digital forensics or reverse engineering tasks.
---

# ncurses-hexedit

## Overview
Hexedit is a full-screen ncurses-based file editor that allows viewing and editing files in hexadecimal alongside ASCII or EBCDIC equivalents. It supports standard features like insert, delete, search (text or byte), undo, and highlighted changes. It can also edit fixed disks and includes a built-in base converter. Category: Digital Forensics / Reverse Engineering.

## Installation (if not already installed)
Assume hexeditor is already installed. If you get a "command not found" error:

```bash
sudo apt install ncurses-hexedit
```

## Common Workflows

### Basic file editing
```bash
hexeditor filename.bin
```
Opens the file in the standard hex editor interface.

### Editing a disk device (Read-Only)
```bash
hexeditor -d /dev/sdb
```
Allows safe inspection of raw disk data without accidental modification.

### Editing a disk device (Write Access)
```bash
hexeditor -d -f /dev/sdb
```
Forces the ability to write changes back to the disk device. Use with extreme caution.

### Fast editing with memory buffering
```bash
hexeditor -b large_file.dat
```
Buffers the entire file into memory, enabling faster navigation and the ability to use insert/delete operations.

## Complete Command Reference

```
hexeditor [options] [file]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help message and exit |
| `-8`, `--highbit` | Print high order 8-bit text |
| `-a`, `--alltext` | Print all text characters |
| `-b`, `--buffer` | Buffer the entire file in memory. Much faster and enables insert/delete features |
| `-d`, `--disk` | Edit a fixed disk (e.g., /dev/sda). Defaults to Read-only |
| `-f`, `--force` | Force editing of disk. Required to write changes to disk devices |
| `-n`, `--nocolor` | Force Gray scale mode, disabling colors |
| `-q`, `--quiet` | Quiet Mode; suppresses audible alerts/beeping |
| `-r`, `--readonly` | Open the file in read-only mode to prevent modifications |
| `-v`, `--version` | Print the version number and exit |

## Notes
- **Disk Editing**: When using the `-d` flag, the tool defaults to read-only. You must explicitly use `-f` to commit changes to a physical disk.
- **Insert/Delete**: These operations are typically only available when using the `-b` (buffer) mode, as modifying file size on disk requires memory buffering for the shift in data.
- **Interface**: The tool uses a standard curses interface. Keybindings for search, undo, and saving are usually displayed at the bottom of the terminal window or accessible via a help menu within the application.