---
name: rdesktop
description: Connect to Windows systems via the Remote Desktop Protocol (RDP) to interact with the graphical desktop. Use when performing post-exploitation lateral movement, verifying credentials, or conducting remote administration and information gathering on Windows-based targets.
---

# rdesktop

## Overview
rdesktop is an open-source client for Windows Remote Desktop Services (formerly Terminal Services), capable of natively speaking RDP to present a user's Windows desktop. It is a vital tool for interacting with compromised or authorized Windows hosts. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume rdesktop is already installed. If the command is missing:

```bash
sudo apt install rdesktop
```

## Common Workflows

### Basic Connection
Connect to a server with a specific username and prompt for a password:
```bash
rdesktop -u Administrator -p - 192.168.1.100
```

### Optimized Performance for LAN
Enable compression, 16-bit color, and LAN experience settings:
```bash
rdesktop -u user -p password -a 16 -x lan -z 192.168.1.100
```

### File and Clipboard Redirection
Map a local directory as a network drive on the remote host and enable clipboard sharing:
```bash
rdesktop -u admin -r disk:share=/home/kali/tools -r clipboard:PRIMARYCLIPBOARD 192.168.1.100
```

### Full-screen Mode with Domain
Connect to a specific domain in full-screen mode:
```bash
rdesktop -u user -d corp.local -f 192.168.1.100
```
*Note: Use `Ctrl+Alt+Enter` to toggle full-screen mode once connected.*

## Complete Command Reference

```
usage: rdesktop [options] server[:port]
```

### Connection & Authentication
| Flag | Description |
|------|-------------|
| `-u` | User name |
| `-d` | Domain |
| `-p` | Password (`-` to prompt) |
| `-i` | Enables smartcard authentication (password is used as PIN) |
| `-V` | TLS version (1.0, 1.1, 1.2, defaults to negotiation) |
| `-e` | Disable encryption (French TS) |
| `-E` | Disable encryption from client to server |
| `-4` | Use RDP version 4 |
| `-5` | Use RDP version 5 (default) |
| `-0` | Attach to console (Session 0) |

### Display & UI Options
| Flag | Description |
|------|-------------|
| `-g` | Desktop geometry (WxH[@DPI][+X[+Y]]) |
| `-f` | Full-screen mode |
| `-a` | Connection colour depth (8, 15, 16, 24) |
| `-T` | Window title |
| `-D` | Hide window manager decorations |
| `-K` | Keep window manager key bindings |
| `-b` | Force bitmap updates |
| `-B` | Use BackingStore of X-server (if available) |
| `-m` | Do not send motion events |
| `-M` | Use local mouse cursor |
| `-C` | Use private colour map |
| `-S` | Caption button size (single application mode) |

### Session & Environment
| Flag | Description |
|------|-------------|
| `-s` | Shell / seamless application to start remotely |
| `-c` | Working directory |
| `-n` | Client hostname |
| `-k` | Keyboard layout on server (e.g., en-us, de, sv) |
| `-L` | Local codepage |
| `-A` | Path to SeamlessRDP shell (enables SeamlessRDP mode) |
| `-N` | Enable numlock synchronization |
| `-X` | Embed into another window with a given ID |
| `-z` | Enable RDP compression |
| `-x` | RDP5 experience: `m` (modem), `b` (broadband), `l` (lan), or hex bitmask |
| `-P` | Use persistent bitmap caching |
| `-t` | Disable use of remote Ctrl |
| `-v` | Enable verbose logging |

### Device Redirection (`-r`)
The `-r` flag can be repeated to enable multiple redirections.

| Sub-option | Description |
|------------|-------------|
| `comport:COM1=/dev/ttyS0` | Redirect serial port |
| `disk:name=/path` | Redirect local path to remote share name |
| `clientname=<name>` | Set the client name displayed for redirected disks |
| `lptport:LPT1=/dev/lp0` | Redirect parallel port |
| `printer:name` | Redirect printer (optionally `name="Driver Name"`) |
| `sound:[local\|off\|remote]` | Sound redirection (local drivers: `alsa`) |
| `clipboard:[off\|PRIMARYCLIPBOARD\|CLIPBOARD]` | Enable clipboard redirection |
| `scard[:"LinuxName"="WinName"]` | Smartcard redirection mapping |

### Additional Options (`-o`)
Used for specific smartcard configurations:
- `sc-csp-name`: Crypto Service Provider name
- `sc-container-name`: Container name (usually username)
- `sc-reader-name`: Smartcard reader name
- `sc-card-name`: Specific card name

## Notes
- **Exit Full-screen**: Use `Ctrl+Alt+Enter` to exit full-screen mode if the window manager doesn't provide controls.
- **Security**: Be cautious when redirecting local disks (`-r disk`) to untrusted remote servers, as the server gains access to those local files.
- **Performance**: On slow links, always use `-z` (compression) and `-x m` (modem experience) to reduce bandwidth usage.