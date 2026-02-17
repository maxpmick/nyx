---
name: pwnat
description: Establish direct client-to-server communication between hosts located behind separate NATs without port forwarding or DMZ configuration. Use during post-exploitation or lateral movement to bypass NAT restrictions, create tunnels, or establish proxy connections when traditional port forwarding is unavailable.
---

# pwnat

## Overview
pwnat (pronounced "poe-nat") is a unique tool that enables NAT-to-NAT communication. It allows a server behind a NAT to accept connections from clients behind different NATs without any manual configuration on the routers. It works by using ICMP "Time Exceeded" packets to punch holes through NAT devices. Category: Post-Exploitation.

## Installation (if not already installed)
Assume pwnat is already installed. If the command is missing:

```bash
sudo apt install pwnat
```

## Common Workflows

### Basic Server Setup
Start the pwnat server listening on a specific UDP port (e.g., 2222) to allow incoming client tunnels.
```bash
pwnat -s 2222
```

### Client Tunneling to a Remote Target
Connect from a client behind NAT to a server behind NAT (192.168.1.202), and tunnel local port 8000 to a remote destination (google.com:80).
```bash
pwnat -c 8000 192.168.1.202 2222 google.com 80
```
After running this, browsing to `localhost:8000` on the client machine will tunnel the traffic to `google.com:80` via the pwnat server.

### Restricting Server Access
Start the server but only allow connections destined for a specific internal host and port.
```bash
pwnat -s 2222 10.0.0.5:22
```

### IPv6 Communication
Enable IPv6 support for the NAT-to-NAT tunnel.
```bash
pwnat -6 -s 2222
```

## Complete Command Reference

```bash
pwnat <-s | -c> [options] <args>
```

### Modes

| Flag | Mode | Description |
|------|------|-------------|
| `-c` | Client | **Default.** Initiates the connection to the pwnat server. |
| `-s` | Server | Runs in server mode to listen for incoming client hole-punching attempts. |

### Arguments for Client Mode (`-c`)
Usage: `pwnat -c [local ip] <local port> <proxy host> [proxy port] <remote host> <remote port>`

| Argument | Description |
|----------|-------------|
| `[local ip]` | Optional: Local IP to bind the listener to. |
| `<local port>` | The local TCP port to open on the client machine. |
| `<proxy host>` | The public/reachable IP address of the pwnat server. |
| `[proxy port]` | The UDP port the pwnat server is listening on (default: 2222). |
| `<remote host>` | The final destination host the server should connect to. |
| `<remote port>` | The final destination port the server should connect to. |

### Arguments for Server Mode (`-s`)
Usage: `pwnat -s [local ip] [proxy port] [[allowed host]:[allowed port] ...]`

| Argument | Description |
|----------|-------------|
| `[local ip]` | Optional: Local IP to bind the UDP listener to. |
| `[proxy port]` | The UDP port to listen on for client pings (default: 2222). |
| `[[allowed host]:[allowed port]]` | Optional: Restrict the server to only proxy to specific targets. |

### General Options

| Flag | Description |
|------|-------------|
| `-6` | Use IPv6 instead of IPv4. |
| `-v` | Show debug output. Use twice (`-vv`) for increased verbosity (up to level 2). |
| `-a` | Reuse address (`SO_REUSEADDR`). |
| `-p` | Reuse port (`SO_REUSEPORT`). |
| `-h` | Show the help message and exit. |

## Notes
- pwnat does not require any configuration on the NAT/Router (no UPnP or STUN required).
- It relies on the server sending ICMP packets to a fixed address and the client "faking" ICMP "Time Exceeded" messages to trick the NAT into opening a path.
- Ensure that ICMP traffic is not completely blocked by local host firewalls (iptables/nftables) on either end.