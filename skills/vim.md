---
name: vim
description: Edit text files, scripts, and configuration files using the Vi IMproved (Vim) text editor. Use when modifying system files, writing exploit code, analyzing logs, or performing hex-to-binary conversions with xxd. Essential for terminal-based file manipulation during all phases of penetration testing and digital forensics.
---

# vim

## Overview
Vim is an advanced, highly configurable text editor based on the classic Vi editor. It includes features like syntax highlighting, multi-level undo, and extensive plugin support. It is a core utility in Kali Linux for editing files directly in the terminal. Category: Core Utility / Information Gathering / Exploitation.

## Installation (if not already installed)
Vim is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install vim
```

For specific versions:
- `sudo apt install vim-nox`: Support for scripting (Lua, Python, etc.) without GUI.
- `sudo apt install vim-gtk3`: GTK3 GUI version.
- `sudo apt install xxd`: Hex dump utility (usually part of vim-common).

## Common Workflows

### Basic File Editing
```bash
vim /etc/hosts
```
Opens the file. Use `i` for insert mode, `Esc` to return to normal mode, and `:wq` to save and quit.

### Comparing Two Files (Diff Mode)
```bash
vim -d config.old config.new
```
Opens both files side-by-side and highlights differences.

### Hex Dump and Reverse (xxd)
```bash
# Create a hex dump
xxd binary_payload > payload.hex

# Convert hex back to binary
xxd -r payload.hex > restored_binary
```

### Read from Stdin
```bash
cat /var/log/apache2/access.log | vim -
```

## Complete Command Reference

### Vim Arguments
```
vim [arguments] [file ..]       edit specified file(s)
vim [arguments] -               read text from stdin
vim [arguments] -t tag          edit file where tag is defined
vim [arguments] -q [errorfile]  edit file with first error
```

| Flag | Description |
|------|-------------|
| `--` | Only file names after this |
| `-v` | Vi mode (like "vi") |
| `-e` | Ex mode (like "ex") |
| `-E` | Improved Ex mode |
| `-s` | Silent (batch) mode (only for "ex") |
| `-d` | Diff mode (like "vimdiff") |
| `-y` | Easy mode (like "evim", modeless) |
| `-R` | Readonly mode (like "view") |
| `-Z` | Restricted mode (like "rvim") |
| `-m` | Modifications (writing files) not allowed |
| `-M` | Modifications in text not allowed |
| `-b` | Binary mode |
| `-l` | Lisp mode |
| `-C` | Compatible with Vi: 'compatible' |
| `-N` | Not fully Vi compatible: 'nocompatible' |
| `-V[N][fname]` | Be verbose [level N] [log messages to fname] |
| `-D` | Debugging mode |
| `-n` | No swap file, use memory only |
| `-r` | List swap files and exit |
| `-r <file>` | Recover crashed session |
| `-L` | Same as -r |
| `-A` | Start in Arabic mode |
| `-H` | Start in Hebrew mode |
| `-T <term>` | Set terminal type to `<terminal>` |
| `--not-a-term` | Skip warning for input/output not being a terminal |
| `--ttyfail` | Exit if input or output is not a terminal |
| `-u <vimrc>` | Use `<vimrc>` instead of any .vimrc |
| `-U <gvimrc>` | Use `<gvimrc>` instead of any .gvimrc (GUI only) |
| `--noplugin` | Don't load plugin scripts |
| `-p[N]` | Open N tab pages (default: one for each file) |
| `-o[N]` | Open N windows (default: one for each file) |
| `-O[N]` | Like -o but split vertically |
| `+` | Start at end of file |
| `+<lnum>` | Start at line `<lnum>` |
| `--cmd <cmd>` | Execute `<command>` before loading any vimrc file |
| `-c <cmd>` | Execute `<command>` after loading the first file |
| `-S <sess>` | Source file `<session>` after loading the first file |
| `-s <script>` | Read Normal mode commands from file `<scriptin>` |
| `-w <out>` | Append all typed commands to file `<scriptout>` |
| `-W <out>` | Write all typed commands to file `<scriptout>` |
| `-x` | Edit encrypted files |
| `-X` | Do not connect to X server |
| `-Y` | Do not connect to Wayland compositor |
| `--remote <f>` | Edit `<files>` in a Vim server if possible |
| `--remote-silent` | Same as --remote, don't complain if no server |
| `--remote-wait` | As --remote but wait for files to have been edited |
| `--remote-tab` | As --remote but use tab page per file |
| `--serverlist` | List available Vim server names and exit |
| `--servername` | Send to/become the Vim server `<name>` |
| `--startuptime` | Write startup timing messages to file |
| `--clean` | 'nocompatible', Vim defaults, no plugins, no viminfo |

### xxd Options (Hex Dump Utility)
```
xxd [options] [infile [outfile]]
xxd -r [-s [-]offset] [-c cols] [-ps] [infile [outfile]]
```

| Flag | Description |
|------|-------------|
| `-a` | Toggle autoskip: A single '*' replaces nul-lines |
| `-b` | Binary digit dump (incompatible with -ps) |
| `-C` | Capitalize variable names in C include file style (-i) |
| `-c <cols>` | Format `<cols>` octets per line (Default 16) |
| `-E` | Show characters in EBCDIC (Default ASCII) |
| `-e` | Little-endian dump (incompatible with -ps, -i, -r) |
| `-g <bytes>` | Number of octets per group (Default 2) |
| `-i` | Output in C include file style |
| `-l <len>` | Stop after `<len>` octets |
| `-n <name>` | Set the variable name used in C include output (-i) |
| `-o <off>` | Add `<off>` to the displayed file position |
| `-ps` | Output in postscript plain hexdump style |
| `-r` | Reverse: convert hexdump into binary |
| `-d` | Show offset in decimal instead of hex |
| `-s <seek>` | Start at `<seek>` bytes offset |
| `-u` | Use upper case hex letters |

### vimtutor / gvimtutor
```
vimtutor [[-l]anguage ISO639] [-c]hapter NUMBER] [-g]ui]
```
- `-l <lang>`: Set language (e.g., `en`, `es`, `fr`).
- `-c <num>`: Start at specific chapter.
- `-g`: Use GUI version.

## Notes
- **Safety**: When editing system configuration files, always create a backup first.
- **Binary Files**: Use `vim -b` or `xxd` for binary files to prevent Vim from adding trailing newlines or altering null bytes.
- **Exiting**: If stuck, press `Esc` then type `:q!` to quit without saving.