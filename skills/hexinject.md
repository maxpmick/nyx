---
name: hexinject
description: A versatile packet injector and sniffer that provides a command-line framework for raw network access. Use to sniff, intercept, modify, and inject custom network packets. It is designed to integrate with other shell utilities for transparent traffic manipulation during penetration testing or network analysis.
---

# hexinject

## Overview
HexInject is a powerful tool for raw network access, allowing users to sniff and inject packets in hexadecimal or raw formats. It includes helper utilities like `hex2raw` for data conversion, `prettypacket` for packet disassembly, and `packets.tcl` for generating complex packets using an APD-like format. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install hexinject
```

## Common Workflows

### Sniffing traffic on a specific interface
```bash
hexinject -s -i eth0
```

### Injecting a packet from a hex string
```bash
echo "FF FF FF FF FF FF 00 11 22 33 44 55 08 00 ..." | hexinject -p -i eth0
```

### Sniffing, modifying, and re-injecting (Bridge/MITM)
```bash
hexinject -s -i eth0 | sed 's/OLD_HEX/NEW_HEX/g' | hexinject -p -i eth1
```

### Disassembling a captured packet for readability
```bash
hexinject -s -i eth0 -c 1 | prettypacket
```

## Complete Command Reference

### hexinject
The main tool for sniffing and injection.

```
hexinject <mode> <options>
```

| Flag | Description |
|------|-------------|
| `-s` | Sniff mode |
| `-p` | Inject mode |
| `-r` | Raw mode (instead of the default hexadecimal mode) |
| `-f <filter>` | Custom pcap filter (e.g., "tcp port 80") |
| `-i <device>` | Network device to use |
| `-F <file>` | pcap file to use as device (sniff mode only) |
| `-c <count>` | Number of packets to capture |
| `-t <time>` | Sleep time in microseconds (default 100) |
| `-I` | List all available network devices |
| `-C` | Injection: disable automatic packet checksum |
| `-S` | Injection: disable automatic packet size fields |
| `-P` | Interface: disable promiscuous mode |
| `-M` | Interface: put the wireless interface in monitor mode (experimental) |
| `-h` | Show help screen |

### hex2raw
Converts hexstrings on stdin to raw data on stdout.

```
hex2raw [-r|-h]
```

| Flag | Description |
|------|-------------|
| `-r` | Reverse mode (raw to hexstring) |
| `-h` | Show help screen |

### prettypacket
Disassembler for raw network packets to make them human-readable.

```
prettypacket [-x|-d|-h]
```

| Flag | Description |
|------|-------------|
| `-x <type>` | Print example packet to see its structure |
| `-d <type>` | Dump example packet as hexstring |
| `-h` | Show help screen |

**Supported Types for -x and -d:** `tcp`, `udp`, `icmp`, `igmp`, `arp`, `stp`, `ipv6_tcp`, `ipv6_icmp`, `ipv6_in_ipv4`.

### packets.tcl
Generates binary packets specified using an APD-like data format.

```
packets.tcl 'APD packet description'
```

**Example APD Format:**
```bash
packets.tcl 'ethernet(dst=ff:ff:ff:ff:ee:ee,src=aa:aa:ee:ff:ff:ff,type=0x0800)+ip(ihl=5,ver=4,tos=0xc0,totlen=58,id=62912,fragoff=0,mf=0,df=0,rf=0,ttl=64,proto=1,cksum=0xe500,saddr=192.168.1.7,daddr=192.168.1.6)+icmp(type=3,code=3,unused=0)+data(str=aaaa)'
```

## Notes
- For wireless monitor mode, the documentation recommends using `airmon-ng` instead of the experimental `-M` flag.
- When injecting, ensure you have the correct permissions (usually requires `sudo`).
- Use `hex2raw -r` to convert binary captures into a format `hexinject` can read if you didn't use hex mode initially.