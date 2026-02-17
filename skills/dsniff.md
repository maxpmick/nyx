---
name: dsniff
description: A collection of tools for network auditing and penetration testing, primarily focused on sniffing cleartext insecurities, performing Man-in-the-Middle (MITM) attacks, and disrupting network traffic. Use for password sniffing (FTP, Telnet, HTTP, etc.), ARP spoofing, DNS spoofing, session hijacking, and traffic analysis during the exploitation, sniffing/spoofing, or vulnerability analysis phases of an engagement.
---

# dsniff

## Overview
dsniff is a suite of powerful network auditing and penetration testing tools. It includes utilities for sniffing passwords, intercepting files/mail/messages, performing ARP and DNS spoofing, and executing Man-in-the-Middle attacks. Category: Sniffing & Spoofing / Exploitation.

## Installation (if not already installed)
Assume dsniff is already installed. If not:
```bash
sudo apt install dsniff
```

## Common Workflows

### Password Sniffing on an Interface
```bash
dsniff -i eth0 -m -C
```
Sniffs passwords on eth0, forcing Deep Packet Inspection (DPI) even on non-standard ports with color output.

### ARP Spoofing for MITM
```bash
# In one terminal, intercept traffic between target and gateway
arpspoof -i eth0 -t 192.168.1.5 192.168.1.1
# In another terminal, intercept traffic from gateway to target
arpspoof -i eth0 -t 192.168.1.1 192.168.1.5
```

### Killing Specific TCP Connections
```bash
tcpkill -i eth0 -9 port 21
```
Forcefully terminates any active FTP connections on the network.

### Sniffing URLs from a Target
```bash
urlsnarf -i eth0
```
Outputs all HTTP requests sniffed from the network in Common Log Format (CLF).

## Complete Command Reference

### dsniff (Password Sniffer)
```bash
dsniff [-cdamDNPCv] [-i interface | -p pcapfile] [-s snaplen] [-f services] [-t trigger[,...]] [pcap filter]
```
| Flag | Description |
|------|-------------|
| `-c` | Half-duplex TCP stream assembly |
| `-a` | Show duplicates |
| `-v` | Verbose. Show banners |
| `-d` | Enable debugging mode |
| `-D` | Disable DPI. Only decode known ports |
| `-m` | Force DPI also on known ports (ignore /etc/services). Detects protocols on non-standard ports |
| `-C` | Force color output even if not a TTY |
| `-N` | Resolve IP addresses to hostnames |
| `-P` | Enable promiscuous mode |
| `-t <...>` | Force a decoding method (e.g., `-t 8143/tcp=imap`) |
| `-i <link>` | Specify the interface to listen on |
| `-p <file>` | Read from pcap file |
| `-s <len>` | Analyze at most the first snaplen of each TCP connection (default: 1024) |

### arpspoof (ARP Poisoning)
```bash
arpspoof [-i interface] [-c own|host|both] [-t target] [-r] host
```
| Flag | Description |
|------|-------------|
| `-i` | Interface to use |
| `-c` | Specify hardware address to use (own, host, or both) |
| `-t` | Specify a particular host to spoof (target) |
| `-r` | Poison both hosts (host and target) to capture traffic in both directions |

### dnsspoof (DNS Forgery)
```bash
dnsspoof [-i interface] [-f hostsfile] [expression]
```
- `-f`: Specify a file in `/etc/hosts` format containing the forgeries.

### macof (MAC Flooding)
```bash
macof [-s src] [-d dst] [-e tha] [-x sport] [-y dport] [-i interface] [-n times]
```
- Used to flood switch CAM tables to force the switch into "hub mode."

### tcpkill (Connection Termination)
```bash
tcpkill [-i interface] [-1..9] expression
```
- `-1..9`: Specify the degree of brute force (default 3).

### urlsnarf (HTTP Sniffing)
```bash
urlsnarf [-n] [-i interface | -p pcapfile] [[-v] pattern [expression]]
```
- `-n`: Do not resolve IP addresses.

### sshmitm (SSH MITM)
```bash
sshmitm [-d] [-I] [-p port] host [port]
```
- Proxies and sniffs SSH traffic (supports SSHv1).

### webmitm (HTTP/HTTPS MITM)
```bash
webmitm [-d] [host]
```
- Transparently proxies HTTP and HTTPS.

### filesnarf / mailsnarf / msgsnarf
```bash
filesnarf [-i interface | -p pcapfile] [[-v] pattern [expression]]
mailsnarf [-i interface | -p pcapfile] [[-v] pattern [expression]]
msgsnarf [-i interface | -p pcapfile] [[-v] pattern [expression]]
```
- Used to extract NFS files, mbox mail, or chat messages respectively.

### sshow (SSH Analysis)
```bash
sshow [-d] [-i interface | -p pcapfile]
```

### tcpnice (Traffic Shaping)
```bash
tcpnice [-A] [-I] [-M] [-i interface] expression
```

### webspy (Browser Mirroring)
```bash
webspy [-i interface | -p pcapfile] host
```
- Sends sniffed URLs to your local browser (requires libx11-6).

## Notes
- **IP Forwarding**: When using `arpspoof`, ensure IP forwarding is enabled on your system: `echo 1 > /proc/sys/net/ipv4/ip_forward`.
- **Modern Encryption**: Many tools in this suite (like `dsniff` and `sshmitm`) are most effective against cleartext protocols or older versions of encrypted protocols (SSHv1).
- **Legal**: Use only on networks and systems you have explicit permission to test.