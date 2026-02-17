---
name: sctpscan
description: Discover and security scan SCTP (Stream Control Transmission Protocol) network services. Use when performing reconnaissance on VoIP infrastructure, telecommunications equipment, or any environment utilizing SCTP for transport. It supports network discovery, port mapping, fuzzing, and SCTP-to-TCP bridging.
---

# sctpscan

## Overview
SCTPscan is a specialized network scanner designed for the discovery and security analysis of SCTP-aware devices. It can identify active SCTP hosts, map open ports, and perform basic fuzzing of protocol stacks. Category: Vulnerability Analysis / VoIP.

## Installation (if not already installed)
Assume sctpscan is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install sctpscan
```

## Common Workflows

### Scan a specific port on a target host
```bash
sctpscan -l 192.168.1.2 -r 192.168.1.24 -p 9999
```

### Network discovery and automatic port scanning
Scans for SCTP availability on a subnet and automatically portscans any responsive host.
```bash
sctpscan -s -l 172.22.1.96 -r 172.17.8
```

### Scan frequently used SCTP ports across a network
```bash
sctpscan -s -F -l 172.22.1.96 -r 172.17.8
```

### Local verification (Dummy Server)
Start a listener and scan it locally to verify tool functionality.
```bash
sctpscan -d &
sctpscan -s -l 127.0.0.1 -r 127.0.0.1 -p 10000
```

## Complete Command Reference

```
sctpscan [options]
```

### Connection Options

| Flag | Description |
|------|-------------|
| `-p`, `--port <port>` | Remote port number (default: 10000) |
| `-P`, `--loc_port <port>` | Local port number (default: 10000) |
| `-l`, `--loc_host <host>` | Local (bind) host for the SCTP stream (default: 127.0.0.1) |
| `-r`, `--rem_host <host>` | Remote (sendto) address for the SCTP stream (default: 127.0.0.2) |

### Scanning Modes

| Flag | Description |
|------|-------------|
| `-s`, `--scan` | Scan all machines within a network (requires `-r` with network prefix) |
| `-m`, `--map` | Map all SCTP ports from 0 to 65535 (full portscan) |
| `-F`, `--Frequent` | Portscans frequently used SCTP ports (see list in Notes) |
| `-a`, `--autoportscan` | Automatically portscan any host found with an SCTP-aware stack |
| `-i`, `--linein` | Receive IP addresses to scan from stdin |

### Protocol & Fuzzing Options

| Flag | Description |
|------|-------------|
| `-f`, `--fuzz` | Fuzz test the remote protocol stack |
| `-B`, `--bothpackets` | Send packets with INIT chunk for one, and SHUTDOWN_ACK for the other |
| `-b`, `--both_checksum` | Send both checksums: new CRC32 and old legacy Adler32 |
| `-C`, `--crc32` | Calculate checksums with the new CRC32 (default) |
| `-A`, `--adler32` | Calculate checksums with the old Adler32 |
| `-S`, `--streams <num>` | Tries to establish association with specified number of streams |

### Utility & Integration Options

| Flag | Description |
|------|-------------|
| `-Z`, `--zombie` | Disable reporting to the SCTP Collaboration platform |
| `-d`, `--dummyserver` | Starts a dummy SCTP server on port 10000 for testing |
| `-E`, `--exec <script>` | Execute `<script_name> host_ip sctp_port` for every open port found |
| `-t`, `--tcpbridge <port>` | Bridge connections from a local TCP port to the remote SCTP port |

## Notes

### Frequent Ports List
The `-F` flag scans the following ports: 1, 7, 9, 20, 21, 22, 80, 100, 128, 179, 260, 250, 443, 1167, 1812, 2097, 2000, 2001, 2010, 2011, 2020, 2021, 2100, 2110, 2120, 2225, 2427, 2477, 2577, 2904, 2905, 2906, 2907, 2908, 2909, 2944, 2945, 3000, 3097, 3565, 3740, 3863, 3864, 3868, 4000, 4739, 4740, 5000, 5001, 5060, 5061, 5090, 5091, 5672, 5675, 6000, 6100, 6110, 6120, 6130, 6140, 6150, 6160, 6170, 6180, 6190, 6529, 6700, 6701, 6702, 6789, 6790, 7000, 7001, 7102, 7103, 7105, 7551, 7626, 7701, 7800, 8000, 8001, 8471, 8787, 9006, 9084, 9899, 9911, 9900, 9901, 9902, 10000, 10001, 11146, 11997, 11998, 11999, 12205, 12235, 13000, 13001, 14000, 14001, 20049, 29118, 29168, 30000, 32905, 32931, 32768.

### NAT Limitations
This tool generally **does not work behind NAT**. Most routers and firewalls cannot properly translate SCTP packets. It is recommended to run this tool from a host with a public IP address or within the same local network segment as the target.