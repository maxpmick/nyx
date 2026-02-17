---
name: netbase
description: Manage and reference basic TCP/IP networking configuration files including service ports, protocols, RPC numbers, and Ethernet types. Use when troubleshooting network connectivity, identifying unknown port numbers, verifying protocol IDs, or investigating low-level network traffic during reconnaissance and sniffing operations.
---

# netbase

## Overview
The netbase package provides the fundamental infrastructure for TCP/IP networking on Linux. It maintains the standard mapping files that translate human-readable names to numerical IDs for services, protocols, and hardware types. It is a core component across all security domains, particularly useful for Reconnaissance, Sniffing & Spoofing, and Vulnerability Analysis.

## Installation (if not already installed)
The package is a core dependency and is almost always pre-installed. If missing:

```bash
sudo apt update && sudo apt install netbase
```

## Common Workflows

### Identify a service by port number
Search the services database to identify what application typically runs on a specific port (e.g., port 445).
```bash
grep -w "445" /etc/services
```

### Identify a protocol ID
Find the protocol number for a specific protocol (e.g., ICMP) for use in raw socket programming or firewall rules.
```bash
grep -i "icmp" /etc/protocols
```

### Lookup an EtherType
Identify the hardware protocol associated with a hex code found in a packet capture.
```bash
grep -i "0806" /etc/ethertypes
```

### Verify RPC program numbers
Identify RPC services when performing NFS or portmapper enumeration.
```bash
cat /etc/rpc
```

## Complete Command Reference

Netbase does not provide a standalone binary command; it provides the essential configuration files used by networking tools (like `nmap`, `tcpdump`, and `netstat`) and the C library.

### Configuration Files

| File | Description |
|------|-------------|
| `/etc/services` | Maps friendly service names to port numbers and protocols (TCP/UDP). Used by `netstat`, `lsof`, and `nmap`. |
| `/etc/protocols` | Maps protocol names to their IP protocol numbers (e.g., TCP=6, UDP=17, ICMP=1). |
| `/etc/rpc` | Maps Remote Procedure Call (RPC) program names to their numerical identifiers. |
| `/etc/ethertypes` | Maps Ethernet protocol hex codes to names (e.g., 0800 = IPv4, 0806 = ARP). |

### File Formats

#### /etc/services
Format: `<service-name> <port>/<protocol> [aliases...]`
Example: `ssh 22/tcp`

#### /etc/protocols
Format: `<protocol-name> <number> [aliases...]`
Example: `icmp 1 ICMP`

#### /etc/rpc
Format: `<name> <number> [aliases...]`
Example: `nfs 100003`

#### /etc/ethertypes
Format: `<name> <hex-number> [aliases...]`
Example: `IPv4 0800`

## Notes
- These files are the "source of truth" for many networking utilities. If a tool shows "unknown" for a common port, ensure `/etc/services` is intact.
- Modifications to these files affect how tools display information but do not change how the kernel handles traffic.
- During forensics or incident response, check these files for unauthorized modifications (e.g., a backdoor service added to `/etc/services` to mask its presence).