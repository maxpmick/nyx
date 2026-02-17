---
name: zsh-autosuggestions
description: Enable fish-like fast and unobtrusive autosuggestions for the Zsh shell. Use when configuring the user environment, improving terminal productivity, or setting up a Kali Linux shell to provide command completions based on history and completions.
---

# zsh-autosuggestions

## Overview
zsh-autosuggestions is a plugin for Zsh that suggests commands as you type based on your command history and available completions. Suggestions appear in a muted gray color after the cursor and can be accepted with specific keybindings. Category: Shell Configuration / Productivity.

## Installation (if not already installed)

The tool is typically pre-installed in Kali Linux. If it is missing or you receive errors when sourcing the script:

```bash
sudo apt update && sudo apt install zsh-autosuggestions
```

To enable it in your current session:
```bash
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

To enable it persistently, add the above line to your `~/.zshrc`.

## Common Workflows

### Basic Usage
1. Type the beginning of a command (e.g., `sudo ap`).
2. A suggestion appears in gray (e.g., `sudo apt update`).
3. Press the **Right Arrow** key or **End** key to accept the full suggestion.
4. Press **Alt + F** (or the `forward-word` widget) to accept only the next word of the suggestion.

### Customizing Suggestion Highlight Style
To change the appearance of the suggestions (e.g., bold and blue):
```bash
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue,bold'
```

### Changing Suggestion Strategy
To suggest based on both history and completion engine:
```bash
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
```

## Complete Command Reference

### Configuration Variables
These variables should be set before sourcing the `zsh-autosuggestions.zsh` script in your `.zshrc`.

| Variable | Description | Default |
|----------|-------------|---------|
| `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE` | Highlight style for the suggestion. | `fg=8` (gray) |
| `ZSH_AUTOSUGGEST_STRATEGY` | List of strategies to find a suggestion. Options: `history`, `completion`, `match_prev_cmd`. | `(history)` |
| `ZSH_AUTOSUGGEST_CLEAR_WIDGETS` | Widgets that should clear the current suggestion. | (Standard editing widgets) |
| `ZSH_AUTOSUGGEST_ACCEPT_WIDGETS` | Widgets that should accept the entire suggestion. | `forward-char`, `end-of-line` |
| `ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS` | Widgets that should accept the suggestion up to the new cursor position. | `forward-word`, `emacs-forward-word` |
| `ZSH_AUTOSUGGEST_IGNORE_WIDGETS` | Widgets that should be ignored by the plugin. | (Standard completion widgets) |
| `ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE` | Max size of the buffer for which to fetch a suggestion. | (Unset) |
| `ZSH_AUTOSUGGEST_USE_ASYNC` | Fetch suggestions asynchronously. | (Unset) |
| `ZSH_AUTOSUGGEST_MANUAL_REBIND` | Disable automatic widget rebinding. | (Unset) |

### Widgets
You can bind keys to these internal widgets for custom behavior:

| Widget | Description |
|--------|-------------|
| `autosuggest-accept` | Accepts the entire current suggestion. |
| `autosuggest-execute` | Accepts and immediately executes the current suggestion. |
| `autosuggest-clear` | Clears the current suggestion. |
| `autosuggest-fetch` | Fetches a suggestion (useful if `ZSH_AUTOSUGGEST_MANUAL_REBIND` is set). |
| `autosuggest-toggle` | Toggles suggestions on/off. |

### Keybinding Example
To bind `Ctrl + Space` to accept the suggestion:
```bash
bindkey '^ ' autosuggest-accept
```

## Notes
- **Performance**: If the terminal feels slow, set `ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20` to prevent suggestions on very long lines.
- **Async**: For large histories, enabling `ZSH_AUTOSUGGEST_USE_ASYNC=true` can prevent the UI from locking up while searching.
- **Compatibility**: Works best with modern terminal emulators that support 256 colors (for the default gray text).