---
name: pspy
description: Monitor Linux processes without root permissions by snooping on process events and file system changes. Use when performing post-exploitation enumeration, identifying cron jobs, discovering secrets passed as command-line arguments, or monitoring user activity on a Linux system during penetration testing or CTFs.
---

# pspy

## Overview
pspy is a command-line tool designed to monitor Linux processes without requiring root privileges. It captures commands run by other users, cron jobs, and transient processes as they execute by using inotify API to watch for process creation and scanning the /proc filesystem. Category: Post-Exploitation / Information Gathering.

## Installation (if not already installed)
Assume pspy is already installed. If you get a "command not found" error:

```bash
sudo apt install pspy
```

The package also provides pre-compiled static binaries for different architectures located at `/usr/share/pspy/`.

## Common Workflows

### Basic monitoring
```bash
pspy
```
Starts monitoring with default settings (scanning every 100ms, watching common directories recursively).

### High-frequency scanning for short-lived processes
```bash
pspy -i 10
```
Scans the `/proc` filesystem every 10ms to catch very fast-running scripts or cron jobs.

### Monitoring specific directories for file system events
```bash
pspy -f -d /var/www/html,/tmp
```
Prints file system events and monitors specific directories for changes.

### Stealthy monitoring with no color and truncated output
```bash
pspy --color=false -t 50
```
Disables ANSI colors and truncates long command strings to 50 characters for cleaner logging.

## Complete Command Reference

### Flags

| Flag | Description |
|------|-------------|
| `-c`, `--color` | Color the printed events (default: `true`) |
| `--debug` | Print detailed error messages for troubleshooting |
| `-d`, `--dirs stringArray` | Watch specific directories for events (non-recursive) |
| `-f`, `--fsevents` | Print file system events (inotify) to stdout |
| `-h`, `--help` | Help for pspy |
| `-i`, `--interval int` | Scan every 'interval' milliseconds for new processes (default: `100`) |
| `--ppid` | Record and display process Parent Process IDs (PPIDs) |
| `-p`, `--procevents` | Print new processes to stdout (default: `true`) |
| `-r`, `--recursive_dirs stringArray` | Watch these directories recursively (default: `[/usr, /tmp, /etc, /home, /var, /opt]`) |
| `-t`, `--truncate int` | Truncate process command strings longer than this value (default: `2048`) |

### Binaries Reference
The `pspy-binaries` package provides static versions for different architectures in `/usr/share/pspy/`:
- `pspy32`: 32-bit dynamic
- `pspy32s`: 32-bit static (small)
- `pspy64`: 64-bit dynamic
- `pspy64s`: 64-bit static (small)

## Notes
- pspy does not require root because it uses the `inotify` API to detect when files like `/proc` or `/tmp` are accessed/created, and it scans `/proc` for process information available to the current user.
- It is particularly effective for catching "secret" arguments (like passwords or API keys) passed to commands by other users or automated scripts.
- The default recursive watch list is extensive; if the system has a very high number of files, you may need to limit the watched directories using `-r` or `-d` to avoid hitting inotify limits.