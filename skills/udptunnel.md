---
name: udptunnel
description: Tunnel UDP packets bi-directionally over a TCP connection. Use to bypass firewalls that block UDP traffic but allow TCP, facilitate multimedia conferences through restrictive gateways, or perform security testing and post-exploitation data exfiltration over TCP-only channels.
---

# udptunnel

## Overview
UDPTunnel is a lightweight utility designed to tunnel UDP packets through a TCP connection. It is particularly useful for traversing firewalls that only permit outgoing TCP connections or for wrapping UDP-based protocols in a reliable TCP stream for security testing. Category: Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume udptunnel is already installed. If the command is missing:

```bash
sudo apt install udptunnel
```

## Common Workflows

### Server Mode (Listening)
Set up a server to wait for a TCP connection on port 4444 and forward received data to a local UDP service on 127.0.0.1:5000:
```bash
udptunnel -s 4444 127.0.0.1/5000
```

### Client Mode (Connecting)
Connect to a remote UDPTunnel server at 192.168.1.10 on TCP port 4444, relaying local UDP traffic from 127.0.0.1:6000:
```bash
udptunnel -c 192.168.1.10/4444 127.0.0.1/6000
```

### RTP Mode (Dual Port)
Tunnel RTP (Real-time Transport Protocol) which requires two adjacent ports (N and N+1) for data and control (RTCP). Note that port numbers must be even:
```bash
udptunnel -r -s 8000 127.0.0.1/7000
```

## Complete Command Reference

UDPTunnel operates in two primary modes: Server or Client.

### Usage Patterns
```
udptunnel -s TCP-port [-r] [-v] UDP-addr/UDP-port[/ttl]
udptunnel -c TCP-addr[/TCP-port] [-r] [-v] UDP-addr/UDP-port[/ttl]
```

### Options

| Flag | Description |
|------|-------------|
| `-s <TCP-port>` | **Server mode**. Wait for incoming TCP connections on the specified port. |
| `-c <TCP-addr[/TCP-port]>` | **Client mode**. Connect to the specified TCP address and optional port. |
| `-r` | **RTP mode**. Connect or listen on two adjacent ports (N and N+1) for both UDP and TCP. The base port number must be even. |
| `-v` | **Verbose mode**. Provides details on connections and packet transfers. Specify multiple times (e.g., `-vv`) for increased verbosity. |

### Argument Definitions
- **UDP-addr/UDP-port[/ttl]**: The destination UDP address and port where the tunneled traffic should be delivered. The TTL (Time To Live) is optional.
- **TCP-addr[/TCP-port]**: In client mode, the remote host to connect to. If the TCP port is omitted, it typically defaults to the same value as the UDP port.

## Notes
- **Bidirectional**: The tunnel is bi-directional; once the TCP connection is established, UDP packets can flow both ways.
- **RTP Constraint**: When using `-r`, ensure your starting port is an even number, as the tool will automatically claim the next odd-numbered port.
- **Firewall Evasion**: This tool is highly effective when a firewall performs Deep Packet Inspection (DPI) or strict filtering on UDP but allows standard TCP traffic on common ports like 80 or 443.