---
name: tmux
description: Manage multiple terminal sessions from a single window, allowing for persistent sessions that remain running even after disconnection. Use when performing long-running tasks (like brute-forcing or scanning), managing multiple CLI tools simultaneously, or maintaining remote access stability during penetration testing and wireless attacks.
---

# tmux

## Overview
tmux is a terminal multiplexer that enables multiple terminals (windows) to be accessed and controlled from a single terminal. It operates on a client-server model, allowing sessions to persist in the background. It is essential for maintaining state during remote SSH sessions and organizing complex workflows. Category: Kali Core / Wireless Attacks.

## Installation (if not already installed)
Assume tmux is already installed as it is a Kali core package. If missing:

```bash
sudo apt install tmux
```

## Common Workflows

### Start a new named session
```bash
tmux new -s reconnaissance
```

### Detach from a session
Press `Ctrl+b` then `d`. The session continues running in the background.

### List active sessions
```bash
tmux ls
```

### Reattach to a specific session
```bash
tmux attach -t reconnaissance
```

### Split window into panes
- Vertical split: `Ctrl+b` then `%`
- Horizontal split: `Ctrl+b` then `"`

## Complete Command Reference

### Global Flags
```
tmux [-2CDlNuVv] [-c shell-command] [-f file] [-L socket-name] [-S socket-path] [-T features] [command [flags]]
```

| Flag | Description |
|------|-------------|
| `-2` | Force tmux to assume the terminal supports 256 colours |
| `-C` | Start in control mode |
| `-D` | Do not start the tmux server as a daemon |
| `-l` | Behave as a login shell |
| `-N` | Do not start the server even if it is not running |
| `-u` | Write UTF-8 to the terminal even if the environment does not indicate support |
| `-V` | Report the tmux version |
| `-v` | Request verbose logging |
| `-c <shell-command>` | Execute a shell command |
| `-f <file>` | Specify an alternative configuration file (default is `~/.tmux.conf`) |
| `-L <socket-name>` | Specify the name of the server socket to use |
| `-S <socket-path>` | Specify a full alternative path to the server socket |
| `-T <features>` | Set terminal features |

### Common Subcommands

| Subcommand | Description |
|------------|-------------|
| `new-session` (or `new`) | Create a new session |
| `attach-session` (or `attach`) | Attach to an existing session |
| `list-sessions` (or `ls`) | List all sessions managed by the server |
| `kill-session` | Destroy a given session |
| `kill-server` | Kill the tmux server and all sessions |
| `list-commands` | List all supported tmux commands |
| `source-file` | Execute tmux commands from a file |

## Notes
- **Prefix Key**: By default, all tmux commands are preceded by the prefix `Ctrl+b`.
- **Persistence**: If your SSH connection drops, the tmux session and all processes running inside it (e.g., `nmap`, `aircrack-ng`) will continue to run.
- **Key Bindings**: tmux supports both vi and emacs key layouts for navigation and copy mode.
- **Socket Location**: Communication takes place through a socket, by default placed in `/tmp`. Use `-L` or `-S` if you need to isolate sessions or share them with other users.