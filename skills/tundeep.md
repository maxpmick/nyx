---
name: tundeep
description: Establish a Layer 2 VPN tunnel or perform packet injection using a user-space tool that leverages pcap. Use when needing to tunnel traffic through a victim machine, bypass network restrictions via Layer 2 encapsulation, or create a virtual tap interface for network pivoting and sniffing during penetration testing.
---

# tundeep

## Overview
tundeep is a Layer 2 VPN and packet injection tool that operates primarily in user space. It utilizes libpcap to capture and inject frames, allowing for the creation of virtual TAP interfaces to tunnel traffic between a client and a server. Category: Sniffing & Spoofing / Exploitation.

## Installation (if not already installed)
Assume tundeep is already installed. If the command is missing, install it via:

```bash
sudo apt install tundeep
```

Dependencies: libc6, libpcap0.8t64, zlib1g.

## Common Workflows

### Starting a Server
To listen for an incoming tunnel connection on a specific interface and port:
```bash
sudo tundeep -s -i eth0 -h 192.168.1.10 -p 4444 -t tap0 -x 10.0.0.1 -y 255.255.255.0
```

### Connecting as a Client
To connect to a remote tundeep server and establish a local tap interface:
```bash
sudo tundeep -c -i eth0 -h 192.168.1.10 -p 4444 -t tap0 -x 10.0.0.2 -y 255.255.255.0
```

### IPv6 Tunnel with Compression
Establish an IPv6 tunnel with zlib compression enabled:
```bash
sudo tundeep -c -C -6 -i eth0 -h 2001:db8::1 -p 4444 -T tap0 -x 2001:db8:1::2 -y 64
```

## Complete Command Reference

```
tundeep <-i iface|[-t|-T] tapiface> <-h ip> <-p port> [-6] [-C] <-c|-s> [-x tapip] [-y tapmask] [-u tapmac] [-b bpf] [-d udp mode] [-e udp remote] [-K]
```

### Mode Selection (Required)
| Flag | Description |
|------|-------------|
| `-c` | Client mode: Connect to a remote server |
| `-s` | Server mode: Bind and wait for incoming connections |

### Connection Options
| Flag | Description |
|------|-------------|
| `-i <iface>` | Physical interface to bind to (e.g., eth0, wlan0) |
| `-h <ip>` | IP address to bind to (server) or connect to (client) |
| `-p <port>` | Port to bind to (server) or connect to (client) |
| `-6` | Enable IPv6 mode |
| `-d` | Enable UDP mode |
| `-e <peer>` | Specify UDP remote peer address |

### Tunnel Interface Options
| Flag | Description |
|------|-------------|
| `-t <tapiface>` | Create/use a TAP interface (IPv4) |
| `-T <tapiface>` | Create/use an IPv6 TAP interface |
| `-x <tapip>` | Set the IP address for the TAP interface (IPv4 or IPv6 depending on `-t`/`-T`) |
| `-y <mask/len>` | Set the subnet mask (if `-t`) or IPv6 prefix length (if `-T`) |
| `-u <mac>` | Set a custom MAC address for the TAP interface |

### Advanced Options
| Flag | Description |
|------|-------------|
| `-C` | Enable compression mode (zlib) |
| `-K` | Disable checksum calculations |
| `-a` | Print all available pcap devices and exit |
| `-b "bpf"` | Apply a Berkeley Packet Filter (BPF) string to the capture |

## Notes
- The tool requires root privileges (sudo) to interact with pcap and create TAP interfaces.
- Ensure that the firewall on both ends allows the specified port and protocol (TCP by default, UDP if `-d` is used).
- Compression (`-C`) must be enabled on both the client and the server to function correctly.