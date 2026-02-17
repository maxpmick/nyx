---
name: intrace
description: Enumerate IP hops by piggybacking on existing TCP connections. Use when performing network reconnaissance, tracerouting through firewalls that block standard ICMP/UDP probes, or identifying the path of established local or remote TCP sessions.
---

# intrace

## Overview
InTrace is a traceroute-like application that enables users to enumerate IP hops by exploiting existing TCP connections. It can leverage connections initiated from the local system or from remote hosts, making it highly effective for network reconnaissance and bypassing firewalls that filter traditional traceroute traffic. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume intrace is already installed. If the command is missing:

```bash
sudo apt install intrace
```

## Common Workflows

### Trace an active web connection
Identify the network path to a web server by piggybacking on an existing HTTP/HTTPS session.
```bash
intrace -h www.example.com -p 80 -s 4
```

### IPv6 Network Reconnaissance
Perform a trace over an established IPv6 connection with verbose debugging.
```bash
intrace -6 -h ipv6.google.com -p 443 -d 2
```

### Remote Connection Enumeration
If a remote host has an established connection to your machine, you can use intrace to map the return path by specifying the target hostname and the port being used.

## Complete Command Reference

```bash
intrace <-h hostname> [-p <port>] [-d <debuglevel>] [-s <payloadsize>] [-4] [-6]
```

### Options

| Flag | Description |
|------|-------------|
| `-h <hostname>` | **Required.** Target hostname or IP address of the existing TCP connection. |
| `-p <port>` | Destination port of the existing TCP connection (default: 80). |
| `-d <debuglevel>` | Set the debug level for troubleshooting and detailed output. |
| `-s <payloadsize>` | Size of the TCP payload to send in bytes. |
| `-4` | Force the use of IPv4. |
| `-6` | Force the use of IPv6. |

## Notes
- **Existing Connection Required**: Unlike standard traceroute, `intrace` requires an actual TCP connection to be active between the hosts to function.
- **Firewall Bypassing**: Because it uses valid TCP segments belonging to an established session, it often passes through firewalls that would otherwise drop ICMP `Time Exceeded` messages or UDP probes.
- **Root Privileges**: This tool typically requires root privileges to sniff and inject packets into existing streams.