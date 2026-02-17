---
name: ipv6-toolkit
description: A comprehensive security assessment and troubleshooting suite for the IPv6 protocol. It includes tools for address manipulation, scanning, packet crafting (ICMPv6, TCP, UDP), and testing IPv6 extension headers or fragmentation vulnerabilities. Use when performing IPv6 reconnaissance, security auditing of IPv6 stacks, or troubleshooting IPv6 connectivity and blackholes.
---

# ipv6-toolkit

## Overview
The IPv6 Toolkit is a set of security assessment and troubleshooting tools for the IPv6 protocols. It allows for the generation of arbitrary IPv6 packets, including those with extension headers, and provides specialized tools for scanning, address manipulation, and protocol-specific attacks (ICMPv6, TCP, UDP). Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume the toolkit is installed. If not:
```bash
sudo apt install ipv6-toolkit
```

## Common Workflows

### Local Network Scanning
Scan the local subnet for alive hosts and print their MAC addresses:
```bash
scan6 -i eth0 -L -e -v
```

### IPv6 Address Analysis
Decode and analyze a specific IPv6 address to understand its type and structure:
```bash
addr6 -a 2001:db8::1 -d
```

### Testing IPv6 Fragmentation Handling
Assess how a target handles fragmented IPv6 packets (Fragment Reassembly Policy):
```bash
frag6 -d 2001:db8::1 --frag-reass-policy
```

### Finding IPv6 Blackholes
Identify where packets with Extension Headers are being dropped in the path to a destination:
```bash
blackhole6 2001:db8::1
```

## Complete Command Reference

### addr6: Address Analysis & Manipulation
```bash
addr6 (-i | -a) [-c | -d | -r | -s | -q] [-v] [-h]
```
| Flag | Description |
|------|-------------|
| `--address, -a` | IPv6 address to be decoded |
| `--gen-addr, -A` | Generate a randomized address for the specified prefix |
| `--stdin, -i` | Read IPv6 addresses from stdin |
| `--print-fixed, -f` | Print addresses in expanded/fixed format |
| `--print-canonic, -c` | Print IPv6 addresses in canonic form |
| `--print-reverse, -r` | Print reversed IPv6 address |
| `--print-decode, -d` | Decode IPv6 addresses |
| `--print-stats, -s` | Print statistics about IPv6 addresses |
| `--print-response, -R` | Print result of address filters |
| `--print-pattern, -x` | Analyze addresses pattern |
| `--print-uni-preflen, -P` | Print unique prefixes of a specified length |
| `--block-dup, -q` | Discard duplicate IPv6 addresses |
| `--block-dup-preflen, -p` | Discard duplicate prefixes of specified length |
| `--accept, -j` | Accept IPv6 addresses from specified IPv6 prefix |
| `--accept-type, -b` | Accept IPv6 addresses of specified type |
| `--accept-scope, -k` | Accept IPv6 addresses of specified scope |
| `--accept-utype, -w` | Accept IPv6 unicast addresses of specified type |
| `--accept-iid, -g` | Accept IPv6 addresses with IIDs of specified type |
| `--block, -J` | Block IPv6 addresses from specified IPv6 prefix |
| `--block-type, -B` | Block IPv6 addresses of specified type |
| `--block-scope, -K` | Block IPv6 addresses of specified scope |
| `--block-utype, -W` | Block IPv6 unicast addresses of specified type |
| `--block-iid, -G` | Block IPv6 addresses with IIDs of specified type |
| `--verbose, -v` | Be verbose |
| `--help, -h` | Print help |

### scan6: Advanced IPv6 Scanner
```bash
scan6 (-L | -d) [Options]
```
| Flag | Description |
|------|-------------|
| `--interface, -i` | Network interface |
| `--src-addr, -s` | IPv6 Source Address |
| `--dst-addr, -d` | IPv6 Destination Range or Prefix |
| `--prefixes-file, -m` | Prefixes file |
| `--link-src-addr, -S` | Link-layer Destination Address |
| `--probe-type, -p` | Probe type: {echo, unrec, all} |
| `--port-scan, -j` | Port scan type/range: {tcp,udp}:port_low[-port_hi] |
| `--tcp-scan-type, -G` | TCP scan type: {syn,fin,null,xmas,ack} |
| `--payload-size, -Z` | TCP/UDP Payload Size |
| `--src-port, -o` | TCP/UDP Source Port |
| `--dst-port, -a` | TCP/UDP Destination Port |
| `--tcp-flags, -X` | TCP Flags |
| `--print-type, -P` | Print address type: {local, global, all} |
| `--print-unique, -q` | Print only one IPv6 address per Ethernet address |
| `--print-link-addr, -e` | Print link-layer addresses |
| `--print-timestamp, -t` | Print timestamp for each alive node |
| `--retrans, -x` | Number of retransmissions |
| `--timeout, -O` | Timeout in seconds (default: 1) |
| `--local-scan, -L` | Scan the local subnet |
| `--rand-src-addr, -f` | Randomize the IPv6 Source Address |
| `--rand-link-src-addr, -F` | Randomize the Ethernet Source Address |
| `--tgt-virtual-machines, -V` | Target virtual machines |
| `--tgt-low-byte, -b` | Target low-byte addresses |
| `--tgt-ipv4, -B` | Target embedded-IPv4 addresses |
| `--tgt-port, -g` | Target embedded-port addresses |
| `--tgt-ieee-oui, -k` | Target IPv6 addresses embedding IEEE OUI |
| `--tgt-vendor, -K` | Target IPv6 addresses for vendor's IEEE OUIs |
| `--tgt-iids-file, -w` | Target Interface IDs (IIDs) in specified file |
| `--tgt-iid, -W` | Target Interface IDs (IIDs) |
| `--ipv4-host, -Q` | Host IPv4 Address/Prefix |
| `--sort-ouis, -T` | Sort IEEE OUIs |
| `--inc-size, -I` | Increments size |
| `--rate-limit, -r` | Rate limit (bps or pps) |
| `--loop, -l` | Send periodic probes |
| `--sleep, -z` | Pause between periodic probes |

### frag6: Fragmentation Assessment
```bash
frag6 -d DST_ADDR [Options]
```
| Flag | Description |
|------|-------------|
| `--frag-reass-policy, -p` | Assess fragment reassembly policy |
| `--frag-id-policy, -W` | Assess the Fragment ID generation policy |
| `--pod-attack, -X` | Perform a 'Ping of Death' attack |
| `--flood-frags, -F` | Flood target with IPv6 fragments |
| `--frag-size, -P` | IPv6 fragment payload size |
| `--frag-type, -O` | IPv6 Fragment Type {first, last, middle, atomic} |
| `--frag-offset, -o` | IPv6 Fragment Offset |
| `--frag-id, -I` | IPv6 Fragment Identification |

### icmp6: ICMPv6 Error Message Tool
```bash
icmp6 [-i INTERFACE] [-s SRC_ADDR] [-d DST_ADDR] [Options]
```
| Flag | Description |
|------|-------------|
| `--icmp6, -t` | ICMPv6 Type:Code |
| `--icmp6-dest-unreach, -e` | ICMPv6 Destination Unreachable |
| `--icmp6-packet-too-big, -E` | ICMPv6 Packet Too Big |
| `--mtu, -m` | Next-Hop MTU (for Packet Too Big) |
| `--pointer, -O` | Pointer (for Parameter Problem) |
| `--listen, -L` | Listen to incoming traffic |

### tcp6: TCP/IPv6 Assessment
```bash
tcp6 [-i INTERFACE] -d DST_ADDR [Options]
```
| Flag | Description |
|------|-------------|
| `--tcp-flags, -X` | TCP Flags |
| `--open-mode, -c` | Open mode {simultaneous,passive,abort,active} |
| `--close-mode, -C` | Close mode {simultaneous,passive,abort,active,FIN-WAIT-1,FIN-WAIT-2,LAST-ACK} |
| `--window-mode, -W` | TCP Window mode {close,modulate} |
| `--flood-sources, -F` | Flood from multiple IPv6 Source Addresses |

### script6: Complex Task Automation
| Subcommand | Description |
|------------|-------------|
| `get-aaaa` | Obtain AAAA records from domain list via stdin |
| `get-mx` | Obtain MX records from domain list via stdin |
| `get-ns` | Obtain NS records from domain list via stdin |
| `get-asn6` | Obtain Origin AS number for an address |
| `get-as6` | Obtain detailed AS information for an address |
| `trace` | Isolate IPv6 blackholes (internal path6 wrapper) |
| `get-trace-stats` | Produce statistics from `script6 trace` output |

### Other Tools
- **flow6**: Assess IPv6 Flow Label generation policy (`--flow-label-policy, -W`).
- **jumbo6**: Assess handling of IPv6 Jumbograms.
- **na6 / ns6**: Send arbitrary Neighbor Advertisements / Solicitations.
- **ra6 / rs6**: Send arbitrary Router Advertisements / Solicitations.
- **rd6**: Send arbitrary ICMPv6 Redirect messages.
- **ni6**: Send arbitrary ICMPv6 Node Information messages.
- **mldq6**: Security assessment of MLD Query messages.
- **path6**: Versatile IPv6 traceroute supporting various probe types (icmp, tcp, udp, ah, esp).

## Notes
- **Safety**: Many tools in this toolkit (like `frag6` or `tcp6` with flooding flags) can cause Denial of Service. Use with caution in production environments.
- **Privileges**: Most tools require root privileges to craft raw packets.
- **Blackholes**: If packets with Extension Headers are dropped, `blackhole6` or `script6 trace` are the primary tools for isolation.