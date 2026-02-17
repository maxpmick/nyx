---
name: secure-socket-funneling
description: Establish secure TLS tunnels to forward TCP/UDP traffic, create SOCKS proxies, and spawn remote shells. Use when performing pivoting, lateral movement, or bypassing network restrictions during penetration testing and post-exploitation.
---

# Secure Socket Funneling (SSF)

## Overview
Secure Socket Funneling (SSF) is a network tool designed to forward data from multiple sockets (TCP or UDP) through a single secure TLS link. It supports local/remote port forwarding, SOCKS proxying, and remote shell access. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing:

```bash
sudo apt install secure-socket-funneling-windows-binaries
```
Note: This package specifically provides the Windows binaries for deployment on target systems. The Linux binaries are usually available via the `ssf` package.

## Common Workflows

### Start a Relay Server
```bash
ssfs -p 8080
```
Starts the SSF server listening on port 8080.

### Local Port Forwarding
```bash
ssf -L 4444:127.0.0.1:4444 -p 8080 <server_ip>
```
Forwards local port 4444 to the server's port 4444 through the secure tunnel.

### Remote SOCKS Proxy
```bash
ssf -D 1080 -p 8080 <server_ip>
```
Sets up a SOCKS proxy on the client side that tunnels traffic through the SSF server.

### Remote Shell
```bash
ssf -X 9001 -p 8080 <server_ip>
```
Provides a shell on the remote server accessible via the specified port.

## Complete Command Reference

### ssfs (Server) Options
The server component that receives connections.

| Flag | Description |
|------|-------------|
| `-p, --port <port>` | Port to listen on (default: 8011) |
| `-c, --config <file>` | Path to configuration file |
| `-S, --set <option=value>` | Set a configuration option directly |
| `-v, --verbose` | Enable verbose output |
| `-h, --help` | Display help message |

### ssf (Client) Options
The client component used to initiate tunnels.

| Flag | Description |
|------|-------------|
| `-p, --port <port>` | Remote server port to connect to |
| `-c, --config <file>` | Path to configuration file |
| `-S, --set <option=value>` | Set a configuration option directly |
| `-L, --local-forward <[bind_addr:]port:remote_addr:remote_port>` | Local TCP port forwarding |
| `-R, --remote-forward <[bind_addr:]port:remote_addr:remote_port>` | Remote TCP port forwarding |
| `-U, --local-udp-forward <[bind_addr:]port:remote_addr:remote_port>` | Local UDP port forwarding |
| `-V, --remote-udp-forward <[bind_addr:]port:remote_addr:remote_port>` | Remote UDP port forwarding |
| `-D, --dynamic-forward <[bind_addr:]port>` | Local SOCKS server (Dynamic port forwarding) |
| `-F, --remote-dynamic-forward <[bind_addr:]port>` | Remote SOCKS server |
| `-X, --shell <[bind_addr:]port>` | Local shell through socket |
| `-Y, --remote-shell <[bind_addr:]port>` | Remote shell through socket |
| `-b, --relay <[host:]port>` | Connect to server through a relay |
| `-v, --verbose` | Enable verbose output |
| `-h, --help` | Display help message |

## Notes
- **Security**: SSF uses TLS with strong cipher suites to encrypt all tunneled traffic.
- **Pivoting**: SSF is highly effective for multi-hop pivoting by chaining relays.
- **Windows Binaries**: In Kali, Windows-specific binaries are located in `/usr/share/windows-resources/secure-socket-funneling/`.
- **Architecture**: Supports both 32-bit and 64-bit architectures for cross-platform compatibility during engagements.