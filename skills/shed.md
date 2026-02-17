---
name: shed
description: Simple hex editor with a pico-style interface for viewing and editing files in text mode using ncurses. Use when performing digital forensics, binary analysis, or manual file modification where a lightweight, low-memory footprint editor is required for large files or device nodes.
---

# shed

## Overview
shed (Simple Hex Editor) is an ncurses-based tool that displays bytes simultaneously as ASCII, hex, decimal, octal, and binary. It features a Pico-style interface and is particularly efficient for forensics because it does not load the entire file into memory, allowing for the handling of very large files and block devices. Category: Digital Forensics.

## Installation (if not already installed)
Assume shed is already installed. If the command is missing:

```bash
sudo apt install shed
```

## Common Workflows

### Basic file editing
```bash
shed evidence.bin
```
Opens the file in the interactive ncurses interface for viewing and editing.

### Forensic analysis (Read-Only)
```bash
shed -r /dev/sdb1
```
Opens a device file in read-only mode to prevent accidental data modification during investigation.

### Jumping to a specific offset
```bash
shed -s 0x1000 -H firmware.bin
```
Starts the editor with the cursor positioned at offset 4096 (0x1000) using hex offsets for the display.

### Editing a specific portion of a device
```bash
shed -L 512 /dev/sda
```
Sets the length to 512 bytes, useful for isolating and editing specific sectors like the Master Boot Record (MBR).

## Complete Command Reference

```
usage: shed [OPTIONS] [FILE]
```

### Options

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-r` | `--readonly` | Open FILE in read-only mode to prevent writes |
| `-s` | `--start=OFFSET` | Position the cursor to the specified OFFSET upon opening |
| `-H` | `--hex` | Start the interface using hexadecimal offsets |
| `-L` | `--length` | Set the length of the session (essential for device files/block devices) |
| `-h` | `--help` | Show the help message and exit |
| `-v` | `--version` | Show version information and exit |

## Notes
- **Interface**: Uses a Pico-style bottom menu for navigation and commands.
- **Memory Efficiency**: Since the file is not loaded into RAM, it is ideal for analyzing multi-gigabyte disk images or logs.
- **Bit Toggling**: In the binary column of the interface, you can toggle individual bits to modify the byte value.
- **Input Modes**: Changes can be entered in any of the displayed formats (ASCII, hex, decimal, octal, or binary).