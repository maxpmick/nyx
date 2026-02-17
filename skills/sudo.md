---
name: sudo
description: Execute commands with superuser or another user's privileges, manage sudoers configurations, and replay session logs. Use when performing privilege escalation, administrative tasks, auditing user activity, or modifying system-protected files during post-exploitation and system administration.
---

# sudo

## Overview
Sudo (superuser do) allows a system administrator to delegate authority, giving specific users the ability to run commands as root or another user while providing an audit trail of the commands and their arguments. It includes utilities for safe editing of the sudoers file, log management, and session replaying. Category: Post-Exploitation / Identification / Password Attacks.

## Installation (if not already installed)
Assume sudo is already installed as it is a core Kali package. If missing:
```bash
sudo apt install sudo
```

## Common Workflows

### Execute command as root
```bash
sudo apt update
```

### Open a login shell as root
```bash
sudo -i
```

### Edit a protected file safely
```bash
sudoedit /etc/hosts
```

### List current user's privileges
```bash
sudo -l
```

### Check sudoers file for syntax errors
```bash
sudo visudo -c
```

## Complete Command Reference

### sudo
Execute a command as another user.

| Flag | Description |
|------|-------------|
| `-A, --askpass` | Use a helper program for password prompting |
| `-b, --background` | Run command in the background |
| `-B, --bell` | Ring bell when prompting |
| `-C, --close-from=num` | Close all file descriptors >= num |
| `-D, --chdir=dir` | Change the working directory before running command |
| `-E, --preserve-env` | Preserve user environment when running command |
| `--preserve-env=list` | Preserve specific environment variables |
| `-e, --edit` | Edit files instead of running a command (sudoedit) |
| `-g, --group=group` | Run command as the specified group name or ID |
| `-H, --set-home` | Set HOME variable to target user's home dir |
| `-h, --help` | Display help message and exit |
| `-h, --host=host` | Run command on host (if supported by plugin) |
| `-i, --login` | Run login shell as the target user |
| `-K, --remove-timestamp` | Remove timestamp file completely |
| `-k, --reset-timestamp` | Invalidate timestamp file |
| `-l, --list` | List user's privileges; use twice for longer format |
| `-n, --non-interactive` | Non-interactive mode, no prompts are used |
| `-P, --preserve-groups` | Preserve group vector instead of setting to target's |
| `-p, --prompt=prompt` | Use the specified password prompt |
| `-R, --chroot=dir` | Change the root directory before running command |
| `-r, --role=role` | Create SELinux security context with specified role |
| `-S, --stdin` | Read password from standard input |
| `-s, --shell` | Run shell as the target user |
| `-t, --type=type` | Create SELinux security context with specified type |
| `-T, --command-timeout=sec` | Terminate command after the specified time limit |
| `-U, --other-user=user` | In list mode, display privileges for specified user |
| `-u, --user=user` | Run command as specified user name or ID |
| `-V, --version` | Display version information and exit |
| `-v, --validate` | Update user's timestamp without running a command |
| `--` | Stop processing command line arguments |

### visudo
Safely edit the sudoers file.

| Flag | Description |
|------|-------------|
| `-c, --check` | Check-only mode (syntax check) |
| `-f, --file=file` | Specify sudoers file location |
| `-h, --help` | Display help message and exit |
| `-I, --no-includes` | Do not edit include files |
| `-q, --quiet` | Less verbose syntax error messages |
| `-s, --strict` | Strict syntax checking |
| `-V, --version` | Display version information and exit |

### cvtsudoers
Convert between sudoers file formats (sudoers, LDIF, JSON).

| Flag | Description |
|------|-------------|
| `-b, --base=dn` | The base DN for sudo LDAP queries |
| `-c, --config=file` | The path to the configuration file |
| `-d, --defaults=types` | Only convert Defaults of the specified types |
| `-e, --expand-aliases` | Expand aliases when converting |
| `-f, --output-format=fmt` | Set output format: JSON, LDIF or sudoers |
| `-i, --input-format=fmt` | Set input format: LDIF or sudoers |
| `-I, --increment=num` | Amount to increase each sudoOrder by |
| `-h, --help` | Display help message and exit |
| `-m, --match=filter` | Only convert entries that match the filter |
| `-M, --match-local` | Match filter uses passwd and group databases |
| `-o, --output=file` | Write converted sudoers to output_file |
| `-O, --order-start=num` | Starting point for first sudoOrder |
| `-p, --prune-matches` | Prune non-matching users, groups and hosts |
| `-P, --padding=num` | Base padding for sudoOrder increment |
| `-s, --suppress=sects` | Suppress output of certain sections |
| `-V, --version` | Display version information and exit |

### sudoreplay
Replay sudo session logs.

| Flag | Description |
|------|-------------|
| `-d, --directory=dir` | Specify directory for session logs |
| `-f, --filter=filter` | Specify which I/O type(s) to display |
| `-h, --help` | Display help message and exit |
| `-l, --list` | List available session IDs, with optional expression |
| `-m, --max-wait=num` | Max number of seconds to wait between events |
| `-n, --non-interactive` | No prompts, session is sent to the standard output |
| `-R, --no-resize` | Do not attempt to re-size the terminal |
| `-S, --suspend-wait` | Wait while the command was suspended |
| `-s, --speed=num` | Speed up or slow down output |
| `-V, --version` | Display version information and exit |

### sudo_logsrvd
Sudo event and I/O log server.

| Flag | Description |
|------|-------------|
| `-f, --file` | Path to configuration file |
| `-h, --help` | Display help message and exit |
| `-n, --no-fork` | Do not fork, run in the foreground |
| `-R, --random-drop` | Percent chance connections will drop |
| `-V, --version` | Display version information and exit |

### sudo_sendlog
Send sudo I/O log to remote log server.

| Flag | Description |
|------|-------------|
| `--help` | Display help message and exit |
| `-A, --accept` | Only send an accept event (no I/O) |
| `-b, --ca-bundle` | Certificate bundle file to verify server's cert |
| `-c, --cert` | Certificate file for TLS handshake |
| `-h, --host` | Host to send logs to |
| `-i, --iolog_id` | Remote ID of I/O log to be resumed |
| `-k, --key` | Private key file |
| `-n, --no-verify` | Do not verify server certificate |
| `-p, --port` | Port to use when connecting to host |
| `-r, --restart` | Restart previous I/O log transfer |
| `-R, --reject` | Reject the command with the given reason |
| `-s, --stop-after` | Stop transfer after reaching this time |
| `-t, --test` | Test audit server by sending log n times in parallel |
| `-V, --version` | Display version information and exit |

## Notes
- Always use `visudo` to edit the sudoers file to prevent syntax errors that could lock you out of root access.
- `sudo -i` provides a full root environment, whereas `sudo -s` only provides a root shell with the current user's environment.
- The `sudo-ldap` package is deprecated and will be removed in future Debian/Kali releases. Use `sssd` for LDAP sudo integration.