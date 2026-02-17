---
name: screen
description: Terminal multiplexer that manages multiple virtual terminals within a single session. Use to maintain persistent shell sessions, run long-running background tasks that survive SSH disconnections, share terminal sessions with other users, or connect to serial consoles. Essential for remote administration and maintaining tool execution during unstable network conditions.
---

# screen

## Overview
GNU Screen is a terminal multiplexer that runs several separate "screens" on a single physical character-based terminal. It allows users to detach sessions and resume them later, even from different locations. It includes VT100/ANSI terminal emulation, serial port support, and session logging. Category: Sniffing & Spoofing / Wireless Attacks / General Administration.

## Installation (if not already installed)
Assume screen is already installed. If you get a "command not found" error:

```bash
sudo apt install screen
```

## Common Workflows

### Start a named session for a long-running task
```bash
screen -S pentest-session
```
Run your tools (e.g., `nmap`, `metasploit`), then press `Ctrl+A` followed by `D` to detach.

### List and reattach to a session
```bash
screen -ls
screen -r pentest-session
```

### Run a command in a detached session (Daemon mode)
```bash
screen -dmS listener nc -lvnp 4444
```
Starts the netcat listener in the background immediately without attaching.

### Connect to a serial console
```bash
screen /dev/ttyUSB0 115200
```
Commonly used for hardware hacking or configuring network switches.

## Complete Command Reference

```
screen [-opts] [cmd [args]]
or: screen -r [host.tty]
```

### Options

| Flag | Description |
|------|-------------|
| `-4` | Resolve hostnames only to IPv4 addresses. |
| `-6` | Resolve hostnames only to IPv6 addresses. |
| `-a` | Force all capabilities into each window's termcap. |
| `-A -[r\|R]` | Adapt all windows to the new display width & height. |
| `-c file` | Read configuration file instead of '.screenrc'. |
| `-d (-r)` | Detach the elsewhere running screen (and reattach here). |
| `-dmS name` | Start as daemon: Screen session in detached mode. |
| `-D (-r)` | Detach and logout remote (and reattach here). |
| `-D -RR` | Do whatever is needed to get a screen session. |
| `-e xy` | Change command characters (default is Ctrl-A). |
| `-f` | Flow control on, `-fn` = off, `-fa` = auto. |
| `-h lines` | Set the size of the scrollback history buffer. |
| `-i` | Interrupt output sooner when flow control is on. |
| `-ls [match]` | List current screen sessions (SockDir). |
| `-list` | Alias for `-ls`. |
| `-L` | Turn on output logging. |
| `-Logfile file` | Set logfile name. |
| `-m` | Ignore `$STY` variable, do create a new screen session. |
| `-O` | Choose optimal output rather than exact vt100 emulation. |
| `-p window` | Preselect the named window if it exists. |
| `-q` | Quiet startup. Exits with non-zero return code if unsuccessful. |
| `-Q` | Commands will send the response to the stdout of the querying process. |
| `-r [session]` | Reattach to a detached screen process. |
| `-R` | Reattach if possible, otherwise start a new session. |
| `-s shell` | Shell to execute rather than `$SHELL`. |
| `-S sockname` | Name this session `<pid>.sockname` instead of `<pid>.<tty>.<host>`. |
| `-t title` | Set title (window's name). |
| `-T term` | Use term as `$TERM` for windows, rather than "screen". |
| `-U` | Tell screen to use UTF-8 encoding. |
| `-v` | Print Screen version information. |
| `-wipe [match]` | Clean up SockDir (remove "dead" sessions). |
| `-x` | Attach to a session that is not detached (Multi-display mode). |
| `-X` | Execute `<cmd>` as a screen command in the specified session. |

## Notes
- **Escape Key**: The default command prefix is `Ctrl+A`.
- **Detaching**: To leave a session running in the background, use `Ctrl+A` then `D`.
- **Termination**: To kill a screen session, type `exit` inside all windows or use `Ctrl+A` then `K`.
- **Logging**: Using `-L` is highly recommended during penetration tests to maintain an audit trail of all terminal activity.