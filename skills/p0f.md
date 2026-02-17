---
name: p0f
description: Perform passive OS fingerprinting and network reconnaissance by analyzing SYN packets without sending any data. Use when you need to identify remote operating systems, determine network distances, or gather host statistics silently during the information gathering phase of a penetration test or for IDS enhancement.
---

# p0f

## Overview
p0f is a passive reconnaissance tool that identifies remote operating systems and network architectures by analyzing network traffic (specifically SYN packets). Unlike active scanners like Nmap, p0f sends no packets to the target, making it completely invisible to the remote host. It can determine OS versions, uptime, distance (TTL), and connection types. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume p0f is already installed. If the command is missing:

```bash
sudo apt install p0f
```

## Common Workflows

### Passive Monitoring on an Interface
Listen on `eth0` in promiscuous mode to capture all reachable traffic and log results:
```bash
p0f -i eth0 -p -o p0f_results.log
```

### Analyzing Offline Traffic
Analyze a previously captured pcap file to identify hosts:
```bash
p0f -r capture.pcap
```

### Targeted Monitoring with Filters
Monitor only traffic directed at a specific web server using tcpdump-style filters:
```bash
p0f -i eth0 'dst port 80 or dst port 443'
```

### Running as a Daemon with API Socket
Run in the background and provide an API socket for other tools to query:
```bash
p0f -i eth0 -s /var/run/p0f.sock -d -o /var/log/p0f.log
```

## Complete Command Reference

```
p0f [ ...options... ] [ 'filter rule' ]
```

### Network Interface Options

| Flag | Description |
|------|-------------|
| `-i iface` | Listen on the specified network interface (e.g., eth0, wlan0) |
| `-r file` | Read offline pcap data from a given file |
| `-p` | Put the listening interface in promiscuous mode |
| `-L` | List all available network interfaces |

### Operating Mode and Output Settings

| Flag | Description |
|------|-------------|
| `-f file` | Read fingerprint database from 'file' (Default: `/etc/p0f/p0f.fp`) |
| `-o file` | Write information to the specified log file |
| `-s name` | Answer to API queries at a named unix socket |
| `-u user` | Switch to the specified unprivileged account and chroot for security |
| `-d` | Fork into background (daemon mode). Requires `-o` or `-s` |

### Performance-Related Options

| Flag | Description |
|------|-------------|
| `-S limit` | Limit number of parallel API connections (Default: 20) |
| `-t c,h` | Set connection / host cache age limits (Default: 30s, 120m) |
| `-m c,h` | Cap the number of active connections / hosts (Default: 1000, 10000) |

### Filter Expressions
p0f supports standard BPF (Berkeley Packet Filter) expressions, the same syntax used by `tcpdump` or `wireshark`.
Example: `'tcp and port 80'`, `'src host 192.168.1.1'`.

## Notes
- **Stealth**: Because p0f is passive, it cannot be detected by the target. It is ideal for engagements where stealth is a priority.
- **Accuracy**: Passive fingerprinting relies on observed traffic; if a host does not initiate or respond to a connection while p0f is running, it will not be detected.
- **API**: The `-s` socket option allows integration with other security tools or custom scripts to query p0f's findings in real-time.