---
name: code-oss
description: Open-source distribution of Visual Studio Code (VS Code) for source code editing, debugging, and development. Use when reviewing exploit code, writing custom scripts, analyzing configuration files, or managing development projects during penetration testing or security research.
---

# code-oss

## Overview
`code-oss` is the open-source version of Microsoft's Visual Studio Code. It is a feature-rich code editor providing syntax highlighting, debugging support, Git integration, and an extensive plugin ecosystem. In Kali Linux, the commands `code` and `vscode` are symlinked to `code-oss`. Category: Development / General Purpose.

## Installation (if not already installed)
Assume `code-oss` is already installed. If missing:

```bash
sudo apt install code-oss
```

## Common Workflows

### Open a file or directory
```bash
code-oss /path/to/project/
code-oss script.py
```

### Compare two files (diff mode)
```bash
code-oss --diff file1.js file2.js
```

### Open in a new window
```bash
code-oss --new-window .
```

### Install an extension via command line
```bash
code-oss --install-extension ms-python.python
```

## Complete Command Reference

```
code-oss [options] [paths...]
```

### General Options

| Flag | Description |
|------|-------------|
| `-d`, `--diff <file1> <file2>` | Compare two files with each other |
| `-a`, `--add <folder>` | Add folder(s) to the last active window |
| `-g`, `--goto <file:line[:character]>` | Open a file at a specific line and optional character position |
| `-n`, `--new-window` | Force opening a new window |
| `-r`, `--reuse-window` | Force opening a file or folder in an already opened window |
| `-w`, `--wait` | Wait for the files to be closed before returning |
| `--locale <locale>` | The locale to use (e.g. en-US or zh-TW) |
| `--user-data-dir <dir>` | Specifies the directory that user data is kept in |
| `-v`, `--version` | Print version |
| `-h`, `--help` | Print usage help |

### Extensions Management

| Flag | Description |
|------|-------------|
| `--extensions-dir <dir>` | Set the root path for extensions |
| `--list-extensions` | List the installed extensions |
| `--show-versions` | Show versions of installed extensions, when using `--list-extensions` |
| `--category <category>` | Filters installed extensions by provided category, when using `--list-extensions` |
| `--install-extension <ext-id\|path>` | Installs an extension |
| `--pre-release` | Installs the pre-release version of the extension |
| `--uninstall-extension <ext-id>` | Uninstalls an extension |
| `--enable-proposed-api <ext-id>` | Enables proposed API features for extensions |

### Troubleshooting

| Flag | Description |
|------|-------------|
| `--verbose` | Print verbose output (implies --wait) |
| `--log <level>` | Log level to use. Default is 'info'. Allowed values: critical, error, warn, info, debug, trace, off |
| `--disable-extensions` | Disable all installed extensions |
| `--disable-extension <ext-id>` | Disable a specific extension |
| `--sync <on\|off>` | Turn VSCord Settings Sync on or off |
| `--inspect-extensions <port>` | Allow debugging and profiling of extensions |
| `--inspect-brk-extensions <port>` | Allow debugging and profiling of extensions with the execution blocked until debugger is attached |
| `--disable-gpu` | Disable GPU hardware acceleration |
| `--max-memory` | Max memory size for a window (in Mbytes) |
| `--prof-startup` | Run CPU profiler during startup |
| `--status` | Print process usage and diagnostics information |

## Notes
- On Kali Linux, running `code` or `vscode` in the terminal will automatically trigger `code-oss`.
- Running as root: VS Code/Code-OSS generally discourages running as the root user. If required, you may need to use the `--user-data-dir` flag to specify a profile directory.
- Integrated Terminal: You can access the Kali Linux shell directly inside the editor using `Ctrl + \``.