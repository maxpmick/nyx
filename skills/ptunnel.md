---
name: ptunnel
description: Tunnel TCP connections over ICMP echo request and reply packets (ping). Use this tool during post-exploitation or lateral movement to bypass restrictive firewalls that block standard TCP/UDP traffic but allow ICMP. It functions in a client-proxy architecture to encapsulate TCP traffic within ICMP payloads.
---

# ptunnel

## Overview
ptunnel (PingTunnel) is a network tool that allows reliably tunneling TCP connections over ICMP packets. It is particularly useful in environments where outbound TCP/UDP is heavily restricted but ICMP is permitted. It supports multiple concurrent tunnels, password authentication, and can optionally use UDP port 53. Category: Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume ptunnel is already installed. If the command is missing:

```bash
sudo apt install ptunnel
```

## Common Workflows

### 1. Start the Proxy (Server)
On the remote/compromised host that has unrestricted access to the target destination:
```bash
sudo ptunnel
```
*Note: Must be run as root to handle raw ICMP packets.*

### 2. Start the Client (Local)
On your local machine, forward a local port (e.g., 8000) through the proxy to a specific destination (e.g., SSH on a target server):
```bash
sudo ptunnel -p <proxy_ip> -lp 8000 -da <target_destination_ip> -dp 22
```

### 3. Connect Through the Tunnel
Once the client is running, connect to the local port:
```bash
ssh -p 8000 user@localhost
```

### 4. Secure Tunnel with Password
Server side:
```bash
sudo ptunnel -x MySecretPass
```
Client side:
```bash
sudo ptunnel -p <proxy_ip> -lp 8000 -da <target_ip> -dp 22 -x MySecretPass
```

## Complete Command Reference

### Basic Usage
```bash
ptunnel -p <addr> -lp <port> -da <dest_addr> -dp <dest_port> [Options]
```

### Core Options

| Flag | Description |
|------|-------------|
| `-p <addr>` | **Forwarding Mode:** Set address of the peer running the packet forwarder (proxy). If omitted, ptunnel runs in **Proxy Mode**. |
| `-lp <port>` | Set TCP listening port (Client/Forward mode only). |
| `-da <addr>` | **Client:** Set remote proxy destination address. **Server:** Restrict proxy to only this destination address. |
| `-dp <port>` | **Client:** Set remote proxy destination port. **Server:** Restrict proxy to only this destination port. |
| `-m <count>` | Set maximum number of concurrent tunnels. |
| `-v <level>` | Verbosity level (-1 to 4). -1 is silent, 4 is highly verbose. |
| `-c <device>` | Enable libpcap on the given network interface (e.g., eth0). |
| `-f <file>` | Specify a file to log to instead of stdout. |
| `-s` | **Client only:** Enable continuous output of statistics (packet loss, etc.). |
| `-daemon <file>` | Run in background; writes PID to the supplied filename. |
| `-syslog` | Output debug information to syslog instead of stdout. |
| `-udp` | Toggle use of UDP instead of ICMP. Proxy will listen on port 53 (requires root). |

### Security & Privilege Options

| Flag | Description |
|------|-------------|
| `-x <password>` | Set password (must match on both client and proxy). |
| `-u` | Run proxy in unprivileged mode. Uses standard echo requests instead of custom replies. Less reliable. |
| `-setuid <user>` | Drop privileges to the specified user after starting. |
| `-setgid <group>` | Drop privileges to the specified group after starting. |
| `-chroot <dir>` | Restrict file access to the specified directory. |
| `-setcon <ctx>` | Set SELinux context for network I/O operations. |

## Notes
- **Root Requirements:** ptunnel requires root privileges to create raw ICMP packets.
- **Performance:** ICMP tunneling is inherently slower than native TCP due to encapsulation overhead and ICMP rate-limiting on some network devices.
- **SELinux:** If using `-setcon` with `-chroot`, you must mount proc inside the jail: `mount --bind /proc /chrootdir/proc`.
- **Detection:** High volumes of ICMP traffic between two hosts can be easily detected by IDS/IPS or basic traffic analysis.