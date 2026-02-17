---
name: ligolo-ng
description: Establish high-performance tunnels and perform pivoting using a TUN interface instead of SOCKS proxies. Use when you need to route entire network subnets through a compromised host, perform lateral movement, or use tools that do not natively support SOCKS (like ICMP or UDP-based scanners) during penetration testing.
---

# ligolo-ng

## Overview
Ligolo-ng is an advanced, lightweight, and fast tunneling/pivoting tool. Unlike traditional SOCKS proxies, it uses a TUN interface on the operator's machine, allowing for a more "VPN-like" experience where all tools (nmap, impacket, etc.) work seamlessly against the target network. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)

Assume ligolo-ng is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install ligolo-ng
```

## Common Workflows

### Basic Pivot Setup (Operator Side)
1. Create a TUN interface:
```bash
sudo ip tuntap add user $(whoami) mode tun ligolo
sudo ip link set ligolo up
```
2. Start the proxy server:
```bash
ligolo-proxy -selfcert -laddr 0.0.0.0:11601
```
3. Once an agent connects, select the session in the CLI and start the tunnel:
```text
session
1
start
```
4. Route traffic to the target subnet (in a new terminal):
```bash
sudo ip route add 10.10.10.0/24 dev ligolo
```

### Agent Connection (Target Side)
Connect back to the operator's machine:
```bash
./ligolo-agent -connect <operator-ip>:11601 -ignore-cert
```

### Persistent Agent with Auto-Retry
```bash
./ligolo-agent -connect <operator-domain>:443 -retry -ua "Mozilla/5.0..."
```

## Complete Command Reference

### ligolo-proxy
The proxy runs on the attacker/operator machine and receives connections from agents.

| Flag | Description |
|------|-------------|
| `-allow-domains <string>` | Autocert authorised domains; if empty, allow all. Comma-separated |
| `-autocert` | Automatically request Let's Encrypt certificates (requires port 80) |
| `-certfile <string>` | Path to TLS server certificate (default "certs/cert.pem") |
| `-config <string>` | The config file to use |
| `-cpuprofile <file>` | Write CPU profile to file |
| `-daemon` | Run in daemon mode (no interactive CLI) |
| `-keyfile <string>` | Path to TLS server key (default "certs/key.pem") |
| `-laddr <string>` | Listening address. Prefix with `https://` for websocket (default "0.0.0.0:11601") |
| `-memprofile <file>` | Write memory profile to file |
| `-nobanner` | Do not show banner on startup |
| `-selfcert` | Dynamically generate self-signed certificates |
| `-selfcert-domain <string>` | The self-signed TLS domain to use (default "ligolo") |
| `-v` | Enable verbose mode |
| `-version` | Show the current version |

### ligolo-agent
The agent runs on the compromised/target machine and connects back to the proxy.

| Flag | Description |
|------|-------------|
| `-accept-fingerprint <string>` | Accept certificates matching the specified SHA256 fingerprint (hex) |
| `-bind <string>` | Bind to specific ip:port |
| `-connect <string>` | Connect to proxy (domain:port) |
| `-ignore-cert` | Ignore TLS certificate validation (dangerous, use for debug/self-signed) |
| `-proxy <string>` | Proxy URL address (e.g., `http://user:pass@127.0.0.1:8080` or `socks://...`) |
| `-retry` | Auto-retry connection on error |
| `-ua <string>` | HTTP User-Agent (default is a Chrome/Windows string) |
| `-v` | Enable verbose mode |
| `-version` | Show the current version |

## Notes
- **TUN Interface**: You must manually create and bring up the TUN interface on the proxy host before starting the tunnel in the interactive CLI.
- **Routing**: Remember to add OS-level routes (e.g., `ip route add`) pointing to the TUN interface to reach the internal network.
- **Security**: Using `-ignore-cert` is common in CTFs but exposes the connection to MITM in real engagements; use `-accept-fingerprint` or valid certificates for better security.