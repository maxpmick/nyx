---
name: mc
description: Manage files, edit text, and compare differences using a powerful text-mode full-screen interface. Use when performing file system navigation, remote file management (FTP/SSH), archive manipulation, or visual file editing and comparison in a terminal environment.
---

# mc (Midnight Commander)

## Overview
GNU Midnight Commander is a visual shell and file manager that uses a two-panel interface. It features an internal editor (mcedit), a file viewer (mcview), and a diff tool (mcdiff). It supports Virtual Filesystems (VFS) for handling remote files and archives as if they were local. Category: Information Gathering / System Administration.

## Installation (if not already installed)
Assume mc is already installed. If you get a "command not found" error:

```bash
sudo apt install mc
```

## Common Workflows

### Launch with specific directories in panels
```bash
mc /etc /var/log
```

### Edit a file directly with the internal editor
```bash
mcedit /etc/ssh/sshd_config
```

### Compare two files visually
```bash
mcdiff config.old config.new
```

### View a file without editing
```bash
mcview /var/log/syslog
```

## Complete Command Reference

### mc (Main File Manager)
Usage: `mc [OPTION…] [this_dir] [other_panel_dir]`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-terminal` | Terminal options |
| `--help-color` | Color options |
| `-V, --version` | Displays the current version |
| `-f, --datadir` | Print data directory |
| `-F, --datadir-info` | Print extended info about used data directories |
| `--configure-options` | Print configure options |
| `-P, --printwd=<file>` | Print last working directory to specified file |
| `-U, --subshell` | Enables subshell support (default) |
| `-u, --nosubshell` | Disables subshell support |
| `-l, --ftplog=<file>` | Log ftp dialog to specified file |
| `-v, --view=<file>` | Launches the file viewer on a file |
| `-e, --edit=<file> ...` | Edit files |

### mcdiff (Visual Diff Tool)
Usage: `mcdiff [OPTION…] file1 file2`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-terminal` | Terminal options |
| `--help-color` | Color options |
| `-V, --version` | Displays the current version |
| `-f, --datadir` | Print data directory |
| `-F, --datadir-info` | Print extended info about used data directories |
| `--configure-options` | Print configure options |
| `-P, --printwd=<file>` | Print last working directory to specified file |
| `-U, --subshell` | Enables subshell support (default) |
| `-u, --nosubshell` | Disables subshell support |
| `-l, --ftplog=<file>` | Log ftp dialog to specified file |
| `-v, --view=<file>` | Launches the file viewer on a file |
| `-e, --edit=<file> ...` | Edit files |

### mcedit (Internal Editor)
Usage: `mcedit [OPTION…] [+lineno] file1[:lineno] [file2[:lineno]...]`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-terminal` | Terminal options |
| `--help-color` | Color options |
| `-V, --version` | Displays the current version |
| `-f, --datadir` | Print data directory |
| `-F, --datadir-info` | Print extended info about used data directories |
| `--configure-options` | Print configure options |
| `-P, --printwd=<file>` | Print last working directory to specified file |
| `-U, --subshell` | Enables subshell support (default) |
| `-u, --nosubshell` | Disables subshell support |
| `-l, --ftplog=<file>` | Log ftp dialog to specified file |
| `-v, --view=<file>` | Launches the file viewer on a file |
| `-e, --edit=<file> ...` | Edit files |

### mcview (Internal Viewer)
Usage: `mcview [OPTION…] file`

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help options |
| `--help-all` | Show all help options |
| `--help-terminal` | Terminal options |
| `--help-color` | Color options |
| `-V, --version` | Displays the current version |
| `-f, --datadir` | Print data directory |
| `-F, --datadir-info` | Print extended info about used data directories |
| `--configure-options` | Print configure options |
| `-P, --printwd=<file>` | Print last working directory to specified file |
| `-U, --subshell` | Enables subshell support (default) |
| `-u, --nosubshell` | Disables subshell support |
| `-l, --ftplog=<file>` | Log ftp dialog to specified file |
| `-v, --view=<file>` | Launches the file viewer on a file |
| `-e, --edit=<file> ...` | Edit files |

## Notes
- Midnight Commander is highly useful for navigating complex directory structures over SSH.
- Use `F10` to exit the interface and `F9` to access the top menu.
- The subshell feature allows you to run standard shell commands while `mc` is running by pressing `Ctrl+O`.