---
name: xspy
description: Sniff keystrokes on local or remote X-Windows servers. Use when performing post-exploitation, lateral movement, or sniffing and spoofing within an X11 environment to capture user input, credentials, or commands in real-time.
---

# xspy

## Overview
xspy is a utility that monitors and logs keystrokes on an X-Windows server. It can be used to capture input from both local and remote displays, provided the attacker has the necessary permissions to connect to the X server. Category: Sniffing & Spoofing / Post-Exploitation.

## Installation (if not already installed)
Assume xspy is already installed. If the command is missing:

```bash
sudo apt install xspy
```

Dependencies: libc6, libx11-6.

## Common Workflows

### Sniff the default local display
```bash
xspy
```
By default, this attempts to open `:0.0` for snooping and prints captured keystrokes to standard output.

### Sniff a specific local display
```bash
xspy -display :0
```

### Sniff a remote X server
```bash
xspy -display 192.168.1.50:0.0
```
Note: This requires the remote X server to be configured to allow remote connections (e.g., via `xhost +`).

### Log keystrokes to a file
```bash
xspy > keystrokes.txt
```

## Complete Command Reference

```
xspy [options]
```

| Flag | Description |
|------|-------------|
| `-display <displayname>` | Specify the X server to contact (e.g., `localhost:0.0` or `192.168.1.10:0`). If not specified, it uses the `DISPLAY` environment variable. |
| `-delay <microseconds>` | Set the polling delay in microseconds (default is usually sufficient for real-time capture). |

*Note: While the tool's help output is minimal, it follows standard X11 toolkit argument conventions for display selection.*

## Notes
- **Permissions**: To sniff a local display, you generally need to be the user who started the X session or have root privileges.
- **X11 Security**: Modern X11 configurations often disable remote TCP connections by default (`-nolisten tcp`).
- **Output Format**: Special keys like Backspace or Enter are often printed as literal strings (e.g., `BackSpace`) or represented by their functional behavior in the output stream.
- **Stealth**: This tool is active and requires a connection to the X server; it may be visible in process lists or detected by security monitoring that audits X11 connections.