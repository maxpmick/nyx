---
name: redsocks
description: Transparently redirect any TCP connection or UDP packet to a remote SOCKS4, SOCKS5, or HTTP proxy server using system firewall redirection. Use when performing web application testing, bypassing restrictive firewalls, or forcing system-wide traffic through a proxy without relying on LD_PRELOAD or application-specific proxy settings.
---

# redsocks

## Overview
Redsocks is a daemon that intercepts TCP connections at the network level using the system firewall's redirection facility (like iptables or nftables) and tunnels them through a remote proxy. It supports SOCKS4, SOCKS5, and HTTP proxies with authentication. It also includes a small DNS server that forces resolvers to use TCP by returning truncated flags for UDP queries. Category: Web Application Testing / Sniffing & Spoofing.

## Installation (if not already installed)
Assume redsocks is already installed. If the command is missing:

```bash
sudo apt install redsocks
```

## Common Workflows

### Testing Configuration Syntax
Before running the daemon, verify that the configuration file (usually `/etc/redsocks.conf`) is syntactically correct.
```bash
redsocks -t -c /etc/redsocks.conf
```

### Running the Daemon with a Custom Config
Start the redirection service using a specific configuration file and track the process ID.
```bash
sudo redsocks -c /tmp/my_redsocks.conf -p /var/run/redsocks.pid
```

### Typical Transparent Proxy Setup (Iptables)
After starting the redsocks daemon (configured to listen on 127.0.0.1:12345), use iptables to redirect outgoing HTTP traffic:
```bash
# Create a new chain
iptables -t nat -N REDSOCKS

# Ignore traffic to the proxy server itself to avoid loops
iptables -t nat -A REDSOCKS -d <PROXY_IP> -j RETURN

# Redirect all other TCP traffic to the redsocks port
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345

# Apply the chain to outgoing traffic
iptables -t nat -A OUTPUT -p tcp -j REDSOCKS
```

## Complete Command Reference

```
redsocks [-?hvt] [-c config] [-p pidfile]
```

| Flag | Description |
|------|-------------|
| `-h`, `-?` | Display the help message and usage information. |
| `-v` | Print the version information. |
| `-t` | Test configuration syntax and exit. |
| `-c <config>` | Path to the configuration file (e.g., `/etc/redsocks.conf`). |
| `-p <pidfile>` | Write the process ID (PID) to the specified pidfile. |

## Notes
- **Configuration**: The core functionality is defined in the configuration file, where you specify the `local_ip`, `local_port`, `proxy_ip`, `proxy_port`, and `proxy_type` (socks4, socks5, http-connect, or http-relay).
- **Firewall Integration**: Redsocks does not automatically redirect traffic; you must configure `iptables` or `nftables` to redirect packets to the `local_port` defined in the redsocks config.
- **DNS**: If you need to tunnel DNS, use the included `dnstc` feature or the redsocks DNS section to force DNS over TCP, as most proxies do not support UDP.
- **Privileges**: Running as root is typically required to bind to certain ports or to manage the PID file in protected directories.