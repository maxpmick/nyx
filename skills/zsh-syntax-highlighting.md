---
name: zsh-syntax-highlighting
description: Enable fish-shell-like syntax highlighting for Zsh to catch syntax errors and visualize commands in real-time as they are typed. Use when configuring the user's shell environment, improving command-line efficiency, or troubleshooting shell script syntax during interactive sessions.
---

# zsh-syntax-highlighting

## Overview
This tool provides real-time syntax highlighting for the Zsh shell. It highlights commands, options, arguments, and paths as they are typed into an interactive terminal, helping users identify typos and syntax errors before execution. Category: Shell Customization / Productivity.

## Installation (if not already installed)

Assume the package is installed on Kali Linux by default. If missing or if the feature is not active:

```bash
sudo apt update && sudo apt install zsh-syntax-highlighting
```

To activate it for the current user, add the following line to the end of your `~/.zshrc`:

```bash
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

## Common Workflows

### Enable Highlighting in Current Session
```bash
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

### Configure Custom Styles
To change how specific elements (like aliases) are highlighted, add styles to `~/.zshrc` before the source command:
```bash
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

### Disable Specific Highlighters
By default, `main` is active. To specify exactly which highlighters to use:
```bash
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

## Complete Command Reference

The tool is primarily configured via Zsh shell variables set in `~/.zshrc`.

### Highlighters
Highlighters are the components that look for specific syntax patterns.

| Highlighter | Description |
|-------------|-------------|
| `main` | Base highlighting for commands, options, paths, and quotes (Enabled by default). |
| `brackets` | Highlights matching brackets/parentheses. |
| `pattern` | User-defined pattern matching (requires `ZSH_HIGHLIGHT_PATTERNS`). |
| `cursor` | Highlights the character under the cursor. |
| `root` | Highlights the whole command line if the user is root. |
| `line` | Highlights the entire command line based on custom logic. |

### Configuration Variables

| Variable | Description |
|----------|-------------|
| `ZSH_HIGHLIGHT_HIGHLIGHTERS` | Array defining which highlighters to run. Default: `(main)` |
| `ZSH_HIGHLIGHT_STYLES` | Associative array mapping syntax types to styles (e.g., `fg=blue`). |
| `ZSH_HIGHLIGHT_PATTERNS` | Associative array for the `pattern` highlighter (e.g., `ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')`). |
| `ZSH_HIGHLIGHT_MAXLENGTH` | Maximum length of the command line to highlight (prevents lag on huge lines). |

### Main Highlighter Categories (Styles)
These keys can be used in `ZSH_HIGHLIGHT_STYLES[key]`:

- `unknown-token`: Errors or unrecognized commands.
- `reserved-word`: Shell keywords (if, then, else).
- `alias`: Defined shell aliases.
- `suffix-alias`: Aliases triggered by file extensions.
- `builtin`: Shell built-in commands.
- `function`: Shell functions.
- `command`: External executable commands.
- `precommand`: Command modifiers (e.g., `sudo`, `noglob`).
- `commandseparator`: `;`, `&&`, `||`.
- `path`: Valid file system paths.
- `path_prefix`: Valid prefixes of paths.
- `globbing`: Wildcards (e.g., `*.txt`).
- `history-expansion`: `!` style history references.
- `single-hyphen-option`: `-o` style flags.
- `double-hyphen-option`: `--option` style flags.
- `back-quoted-argument`: `` `command` `` syntax.
- `single-quoted-argument`: `'text'`.
- `double-quoted-argument`: `"text"`.
- `dollar-double-quoted-argument`: `$VARIABLE` inside strings.
- `back-double-quoted-argument`: Escaped characters inside strings.
- `assign`: Variable assignments (`VAR=val`).

## Notes
- **Performance**: On very slow systems or with extremely long command lines, highlighting may cause input lag. Use `ZSH_HIGHLIGHT_MAXLENGTH` to limit processing.
- **Load Order**: The `source` command for `zsh-syntax-highlighting.zsh` must be at the **end** of your `.zshrc` file, after all aliases and functions have been defined.
- **Compatibility**: Requires Zsh 4.3.11 or newer.