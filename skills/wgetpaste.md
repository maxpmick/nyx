---
name: wgetpaste
description: Command-line interface to automate pasting text, code, or command output to various online pastebin services. Use when sharing logs, configuration files, or terminal output during penetration testing, troubleshooting, or collaborative debugging from a headless or CLI-only environment.
---

# wgetpaste

## Overview
wgetpaste is a bash script that automates the process of uploading text to pastebin services (like dpaste, gists, or snippets) directly from the command line. It supports multiple services, syntax highlighting for various languages, and can capture command output or clipboard content. Category: Information Gathering / Utility.

## Installation (if not already installed)
Assume wgetpaste is already installed. If the command is missing:

```bash
sudo apt install wgetpaste
```
Note: Some features like `--xcut` or `--xpaste` require `xclip`.

## Common Workflows

### Paste a file with specific language highlighting
```bash
wgetpaste -l python script.py
```

### Paste the output of a command
```bash
wgetpaste -c "ip a"
```

### Paste from stdin and set an expiration
```bash
cat /var/log/apache2/error.log | wgetpaste -e "1 day"
```

### Paste from the X11 clipboard
```bash
wgetpaste -x
```

## Complete Command Reference

```bash
wgetpaste [options] [file[s]]
```

### General Options

| Flag | Description |
|------|-------------|
| `-l, --language LANG` | Set language for syntax highlighting (defaults to "Plain Text") |
| `-d, --description DESC` | Set description (defaults to "stdin" or filename) |
| `-n, --nick NICK` | Set nick (defaults to your local username) |
| `-s, --service SERVICE` | Set pastebin service to use (defaults to "dpaste") |
| `-e, --expiration EXP` | Set when the paste should expire (defaults to "30 days") |
| `-h, --help` | Show help message |
| `-g, --ignore-configs` | Ignore system and user configuration files |
| `--version` | Show version information |

### Listing Options

| Flag | Description |
|------|-------------|
| `-S, --list-services` | List all supported pastebin services |
| `-L, --list-languages` | List languages supported by the specified service |
| `-E, --list-expiration` | List expiration settings supported by the specified service |
| `--completions` | Emit output suitable for shell completions (affects `--list-*`) |

### Input/Output Options

| Flag | Description |
|------|-------------|
| `-u, --tinyurl URL` | Convert the provided input URL to a tinyurl |
| `-c, --command CMD` | Paste the COMMAND string followed by the output of the COMMAND |
| `-i, --info` | Append the output of `emerge --info` to the paste |
| `-I, --info-only` | Paste ONLY the output of `emerge --info` |
| `-x, --xcut` | Read input from the X11 clipboard (requires `xclip`) |
| `-X, --xpaste` | Write resulting URL to the X primary selection buffer (requires `xclip`) |
| `-C, --xclippaste` | Write resulting URL to the X clipboard selection buffer (requires `xclip`) |
| `-r, --raw` | Show the URL for the raw paste (no HTML/syntax highlighting) |
| `-t, --tee` | Use `tee` to show the content being pasted in the terminal |
| `-v, --verbose` | Show wget stderr output if no URL is received |
| `--debug` | Extremely verbose output (implies `-v`) |

## Notes
- **Configuration**: Defaults can be overridden in `/etc/wgetpaste.conf`, `~/.wgetpaste.conf`, or files within `/etc/wgetpaste.d/` and `~/.wgetpaste.d/`.
- **Authentication**: You can pass custom headers (e.g., for GitHub Gists or GitLab Snippets) by setting `HEADER_${SERVICE}` in the config files.
  - Example: `HEADER_gists="Authorization: token <token>"`
- **Privacy**: For GitHub Gists, set `PUBLIC_gists='false'` in config for secret gists. For GitLab, use `VISIBILITY_snippets='private'`.
- **Custom Endpoints**: You can change the API URL for GitLab by setting `URL_snippets='https://gitlab.custom.com/api/v4/snippets'`.