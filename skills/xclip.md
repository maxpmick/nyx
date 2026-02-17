---
name: xclip
description: Command line interface to X11 selections (clipboard). Use to read data from standard input or files into the clipboard, or print clipboard contents to standard output. Essential for automating data transfer between the terminal and GUI applications, capturing command output to the clipboard, or piping clipboard data into scripts during penetration testing and general Linux administration.
---

# xclip

## Overview
xclip is a utility that provides an interface to X selections ("the clipboard") from the command line. It bridges the gap between terminal-based workflows and X11 GUI applications. It supports multiple selection types including PRIMARY, SECONDARY, and CLIPBOARD. Category: General Utility / Information Gathering.

## Installation (if not already installed)
Assume xclip is already installed. If you encounter a "command not found" error:

```bash
sudo apt install xclip
```

## Common Workflows

### Copy command output to the system clipboard
```bash
cat id_rsa.pub | xclip -selection clipboard
```

### Paste clipboard content to a file
```bash
xclip -selection clipboard -o > stolen_creds.txt
```

### Copy the contents of a file to the primary selection
```bash
xclip -i passwords.txt
```

### Remove trailing newline when copying (useful for passwords/tokens)
```bash
echo -n "secret_token" | xclip -selection clipboard -rmlastnl
```

### Copy and Paste Files
```bash
# Copy a file to the clipboard buffer
xclip-copyfile document.pdf

# Paste the file from the buffer into the current directory
xclip-pastefile
```

## Complete Command Reference

### xclip
Access an X server selection for reading or writing.

```
xclip [OPTION] [FILE]...
```

| Flag | Description |
|------|-------------|
| `-i`, `-in` | Read text into X selection from standard input or files (default) |
| `-o`, `-out` | Prints the selection to standard out (for piping to a file or program) |
| `-l`, `-loops` | Number of selection requests to wait for before exiting |
| `-d`, `-display` | X display to connect to (e.g., "localhost:0") |
| `-h`, `-help` | Usage information |
| `-selection` | Selection to access: `primary` (default), `secondary`, `clipboard`, or `buffer-cut` |
| `-noutf8` | Don't treat text as UTF-8; use old Unicode |
| `-target` | Use the given target atom |
| `-rmlastnl` | Remove the last newline character if present |
| `-version` | Version information |
| `-silent` | Errors only, run in background (default) |
| `-quiet` | Run in foreground, show what's happening |
| `-verbose` | Running commentary |

### xclip-copyfile
Copy files via the X clipboard.
```bash
xclip-copyfile <filename>
```

### xclip-cutfile
Move files via the X clipboard (marks for cut).
```bash
xclip-cutfile <filename>
```

### xclip-pastefile
Paste files previously copied or cut via xclip-copyfile/xclip-cutfile.
```bash
xclip-pastefile
```

## Notes
- **Selections**: By default, `xclip` uses the `PRIMARY` selection (middle-click paste). To use the standard "Ctrl+V" clipboard used by most GUI apps, you **must** specify `-selection clipboard`.
- **Persistence**: xclip often needs to stay running in the background to provide the data to the next application that requests it. The `-silent` flag (default) handles this.
- **Binary Data**: xclip can handle binary data, but it is primarily used for text.