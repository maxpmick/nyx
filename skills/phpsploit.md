---
name: phpsploit
description: A stealthy post-exploitation framework that provides a persistent, interactive shell-like connection over HTTP between a client and a compromised web server. Use it to maintain access, perform privilege escalation, and execute remote commands on a web server after an initial PHP-based compromise.
---

# phpsploit

## Overview
phpsploit is a remote control framework designed for stealthy post-exploitation. It establishes an interactive communication channel over HTTP, allowing attackers to maintain access to a compromised web server. It is specifically built to bypass security measures and provide a robust environment for further exploitation. Category: Post-Exploitation.

## Installation (if not already installed)
Assume phpsploit is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install phpsploit
```

Dependencies: php, python3, python3-extproxy, python3-phpserialize, python3-pygments, python3-pyparsing, python3-socks.

## Common Workflows

### Start an interactive session with a target
```bash
phpsploit -t http://example.com/uploads/backdoor.php
```

### Run a specific command and exit
```bash
phpsploit -t http://example.com/shell.php -e "ls -la"
```

### Load a previously saved session
```bash
phpsploit -l my_saved_session
```

### Execute a script of phpsploit commands
```bash
phpsploit -t http://example.com/shell.php -s commands.txt
```

## Complete Command Reference

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show the help message and exit |
| `-v`, `--version` | Output version information and exit |
| `-c <FILE>`, `--config <FILE>` | Use an alternative configuration file instead of the default |
| `-l <SESSION>`, `--load <SESSION>` | Load a specific session file |
| `-t <URL>`, `--target <URL>` | Set the remote TARGET URL where the PHP payload is located |
| `-s <FILE>`, `--source <FILE>` | Run phpsploit commands from a file (disables interactive mode) |
| `-e <CMD>`, `--eval <CMD>` | Run a single phpsploit command (disables interactive mode) |
| `-i`, `--interactive` | Force interactive mode even if `-e` or `-s` is used |

## Notes
- phpsploit requires a compatible PHP payload to be present on the target server to establish the connection.
- The framework is designed for stealth; it often uses obfuscated HTTP headers or body data to transmit commands and receive output.
- Use the `help` command inside the interactive shell to see available post-exploitation modules and internal commands.