---
name: scapy
description: Create, sniff, dissect, and forge network packets for a wide range of protocols. Use for network reconnaissance, scanning, fingerprinting, traffic analysis, and exploitation. It is a versatile tool that can replace or augment nmap, hping, arpspoof, and tcpdump during penetration testing, wireless auditing, or protocol analysis.
---

# scapy

## Overview
Scapy is a powerful Python-based interactive packet manipulation program and library. It can forge or decode packets of a wide number of protocols, send them on the wire, capture them, match requests and replies, and much more. It handles most classical tasks like scanning, tracerouting, probing, unit tests, attacks, or network discovery. Category: Reconnaissance / Information Gathering, Sniffing & Spoofing, Wireless Attacks, Vulnerability Analysis.

## Installation (if not already installed)
Scapy is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install python3-scapy
```

## Common Workflows

### Interactive Shell and Simple Packet Creation
Start the interactive shell and create an IP packet:
```python
# Start scapy
sudo scapy
# Create a packet
pkt = IP(dst="8.8.8.8")/ICMP()
# Send and receive one answer
reply = sr1(pkt)
reply.show()
```

### Sniffing Traffic
Sniff 10 packets and display a summary:
```python
pkts = sniff(count=10, filter="tcp and port 80")
pkts.summary()
```

### ARP Ping (Discovery)
Discover hosts on a local network using ARP:
```python
ans, unans = srp(Ether(dst="ff:ff:ff:ff:ff:ff")/ARP(pdst="192.168.1.0/24"), timeout=2)
ans.summary(lambda s,r: r.sprintf("%Ether.src% %ARP.psrc%"))
```

### Syn Scanning
Perform a TCP SYN scan on a specific port:
```python
res = sr1(IP(dst="192.168.1.1")/TCP(dport=80, flags="S"))
if res.haslayer(TCP) and res.getlayer(TCP).flags == 0x12:
    print("Port 80 is open")
```

## Complete Command Reference

### CLI Arguments
The `scapy` (or `scapy3`) executable supports the following command-line arguments:

| Flag | Description |
|------|-------------|
| `-H` | Header-less start (suppresses the startup banner) |
| `-C` | Do not read the startup file |
| `-P` | Do not read the pre-startup file |
| `-s <sessionfile>` | Use a specific session file to load/save variables |
| `-c <startup_file>` | Load a specific startup file (Python script) |
| `-p <prestart_file>` | Load a specific pre-startup file |

### Core Interactive Functions
Once inside the Scapy shell, these are the primary functions used:

| Function | Description |
|----------|-------------|
| `ls()` | List all supported protocols/layers |
| `ls(protocol)` | List fields for a specific protocol (e.g., `ls(IP)`) |
| `lsc()` | List all available Scapy commands/functions |
| `send(pkt)` | Send packets at layer 3 |
| `sendp(pkt)` | Send packets at layer 2 |
| `sr(pkt)` | Send and receive packets at layer 3 |
| `srp(pkt)` | Send and receive packets at layer 2 |
| `sr1(pkt)` | Send at layer 3 and return only the first answer |
| `srp1(pkt)` | Send at layer 2 and return only the first answer |
| `sniff()` | Sniff packets from the network |
| `wrpcap("file.pcap", pkts)` | Write packets to a PCAP file |
| `rdpcap("file.pcap")` | Read packets from a PCAP file |
| `explore()` | Graphical browser for protocols (requires additional dependencies) |

## Notes
- **Root Privileges**: Scapy requires root privileges to send and sniff raw packets. Always run with `sudo`.
- **Performance**: While extremely flexible, Scapy is written in Python and may be slower than C-based tools like `tcpdump` for high-volume traffic analysis.
- **Layering**: Packets are built by stacking layers using the `/` operator (e.g., `Ether()/IP()/TCP()`).
- **Help**: Use `help(function_name)` inside the Scapy shell for detailed documentation on any function.