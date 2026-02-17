---
name: 0trace
description: Perform hop-by-hop network reconnaissance within an existing, active TCP connection to bypass stateful firewalls and packet filters. Use when standard ICMP or UDP traceroutes are blocked or filtered, and you have an established TCP session (e.g., HTTP, SSH, Telnet) with the target.
---

# 0trace

## Overview
0trace is a hop-by-hop network reconnaissance tool that follows an existing TCP connection. By sending probes with incrementing TTL values that match the sequence and acknowledgement numbers of an active session, it can bypass stateful firewalls that would otherwise drop unsolicited traceroute packets. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume 0trace is already installed. If you encounter an error, install it via:

```bash
sudo apt update && sudo apt install 0trace
```

Dependencies: `libc6`, `tcpdump`.

## Common Workflows

### Tracing an active HTTP connection
1. Establish a connection to the target (e.g., `curl http://192.168.1.50` or open in a browser).
2. While the connection is active or being refreshed, run 0trace:
```bash
sudo 0trace.sh eth0 192.168.1.50 80
```

### Tracing an SSH session
If you have an open SSH session to a server, you can map the path it takes:
```bash
sudo 0trace.sh wlan0 10.0.0.15 22
```

### Manual probe generation
If you need to send a specific probe manually using known TCP parameters:
```bash
sendprobe 192.168.1.5 192.168.1.50 44321 80 12345678 87654321
```

## Complete Command Reference

### 0trace.sh
The primary shell script wrapper that automates the sniffing and probing process.

```bash
0trace.sh iface target_ip [ target_port ]
```

| Argument | Description |
|----------|-------------|
| `iface` | The network interface to listen on (e.g., eth0, wlan0) |
| `target_ip` | The IP address of the target host |
| `target_port` | (Optional) The destination port of the existing TCP connection |

### sendprobe
The underlying binary used to craft and send the specific TCP probes.

```bash
sendprobe src_ip dst_ip sport dport seq ack
```

| Argument | Description |
|----------|-------------|
| `src_ip` | Source IP address |
| `dst_ip` | Destination IP address |
| `sport` | Source port of the existing connection |
| `dport` | Destination port of the existing connection |
| `seq` | Current TCP sequence number |
| `ack` | Current TCP acknowledgement number |

## Notes
- **Traffic Requirement**: 0trace requires an *active* TCP connection. You must generate traffic (e.g., refreshing a web page or typing in a shell) on that connection for 0trace to successfully pick up the parameters and send probes.
- **Permissions**: Must be run with root privileges to capture packets and send raw sockets.
- **Firewalls**: This tool is specifically designed to bypass stateful packet inspection (SPI) firewalls that allow established traffic but block unsolicited ICMP/UDP/TCP probes.