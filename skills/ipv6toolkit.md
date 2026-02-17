---
name: ipv6toolkit
description: A comprehensive suite of IPv6 security assessment and troubleshooting tools. Use to perform IPv6 address manipulation, scanning, fragmentation attacks, ICMPv6/TCP/UDP packet forging, and to identify IPv6 blackholes caused by extension headers. Essential for IPv6 network reconnaissance, vulnerability analysis, and exploitation testing.
---

# ipv6toolkit

## Overview
SI6 Networks' IPv6 Toolkit is a set of security assessment and troubleshooting tools for the IPv6 protocols. It allows for the generation of arbitrary IPv6 packets, including those with extension headers, and provides specialized tools for scanning, address analysis, and protocol-specific attacks (ICMPv6, TCP, UDP). Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
The toolkit is usually pre-installed on Kali Linux. If missing:
```bash
sudo apt install ipv6toolkit
```

## Common Workflows

### Local Network Scanning
Scan the local network for alive IPv6 hosts and print their link-layer (MAC) addresses:
```bash
scan6 -i eth0 -L -e -v
```

### IPv6 Address Analysis
Decode and analyze a specific IPv6 address to determine its type and properties:
```bash
addr6 -a 2001:db8::1 -d
```

### Identifying IPv6 Blackholes
Trace the path to a destination using packets with Extension Headers to find where they are dropped:
```bash
blackhole6 2001:db8:d::1
```

### Forging Router Advertisements
Send periodic RA messages to the local network to test client behavior:
```bash
ra6 -i eth0 -l -P 2001:db8:1::/64
```

## Complete Command Reference

### addr6
An IPv6 address analysis and conversion tool.

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

### scan6
Advanced IPv6 address scanning tool.

| Flag | Description |
|------|-------------|
| `--interface, -i` | Network interface |
| `--src-addr, -s` | IPv6 Source Address |
| `--dst-addr, -d` | IPv6 Destination Range or Prefix |
| `--prefixes-file, -m` | Prefixes file |
| `--link-src-addr, -S` | Link-layer Destination Address |
| `--probe-type, -p` | Probe type {echo, unrec, all} |
| `--port-scan, -j` | Port scan type and range {tcp,udp}:port_low[-port_hi] |
| `--tcp-scan-type, -G` | TCP port-scanning type {syn,fin,null,xmas,ack} |
| `--payload-size, -Z` | TCP/UDP Payload Size |
| `--src-port, -o` | TCP/UDP Source Port |
| `--dst-port, -a` | TCP/UDP Destination Port |
| `--tcp-flags, -X` | TCP Flags |
| `--print-type, -P` | Print address type {local, global, all} |
| `--print-unique, -q` | Print only one IPv6 addresses per Ethernet address |
| `--print-link-addr, -e` | Print link-layer addresses |
| `--print-timestamp, -t` | Print timestamp for each alive node |
| `--retrans, -x` | Number of retransmissions of each probe |
| `--timeout, -O` | Timeout in seconds (default: 1s) |
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

### frag6
Security assessment tool for IPv6 fragmentation.

| Flag | Description |
|------|-------------|
| `--dst-opt-hdr, -u` | Destination Options Header (Fragmentable Part) |
| `--dst-opt-u-hdr, -U` | Destination Options Header (Unfragmentable Part) |
| `--hbh-opt-hdr, -H` | Hop by Hop Options Header |
| `--frag-size, -P` | IPv6 fragment payload size |
| `--frag-type, -O` | IPv6 Fragment Type {first, last, middle, atomic} |
| `--frag-offset, -o` | IPv6 Fragment Offset |
| `--frag-id, -I` | IPv6 Fragment Identification |
| `--frag-reass-policy, -p` | Assess fragment reassembly policy |
| `--frag-id-policy, -W` | Assess the Fragment ID generation policy |
| `--pod-attack, -X` | Perform a 'Ping of Death' attack |
| `--flood-frags, -F` | Flood target with IPv6 fragments |

### icmp6
Security assessment tool for ICMPv6 error messages.

| Flag | Description |
|------|-------------|
| `--icmp6, -t` | ICMPv6 Type:Code |
| `--icmp6-dest-unreach, -e` | ICMPv6 Destination Unreachable |
| `--icmp6-packet-too-big, -E` | ICMPv6 Packet Too Big |
| `--icmp6-time-exceeded, -A` | ICMPv6 Time Exceeded |
| `--icmp6-param-problem, -R` | ICMPv6 Parameter Problem |
| `--mtu, -m` | Next-Hop MTU (for Packet Too Big) |
| `--pointer, -O` | Pointer (for Parameter Problem) |
| `--target-addr, -r` | ICMPv6 Payload's IPv6 Source Address |
| `--peer-addr, -x` | ICMPv6 Payload's IPv6 Destination Address |

### ra6
Security assessment tool for Router Advertisement (RA) messages.

| Flag | Description |
|------|-------------|
| `--managed, -m` | Set the Managed bit |
| `--other, -o` | Set the Other bit |
| `--home-agent, -a` | Set the Home Agent bit |
| `--prefix-opt, -P` | Prefix option (Prefix/Len#flags#valid#preferred) |
| `--route-opt, -R` | Route Information option (Prefix/Len#pref#lifetime) |
| `--rdnss-opt, -N` | Recursive DNS Server option (lifetime#IPv6addr) |
| `--flood-prefixes, -f` | Number of Prefix options to forge randomly |

### tcp6 / udp6
Tools for assessment of TCP/UDP over IPv6.

| Flag | Description |
|------|-------------|
| `--tcp-flags, -X` | TCP Flags |
| `--open-mode, -c` | Open mode {simultaneous, passive, abort, active} |
| `--close-mode, -C` | Close mode {simultaneous, passive, abort, active, etc.} |
| `--window-mode, -W` | TCP Window mode {close, modulate} |
| `--data, -Z` | Payload data |

### script6
A tool for complex IPv6 tasks via scripts.

- `get-aaaa`: Obtain AAAA records from domain list.
- `get-mx`: Obtain MX records.
- `get-ns`: Obtain NS records.
- `get-asn6`: Obtain Origin AS number.
- `trace`: Isolate IPv6 blackholes (internal use of path6).
- `get-trace-stats`: Produce statistics from trace results.

## Notes
- **Blackholes**: Many networks drop IPv6 packets containing Extension Headers (EH). Use `blackhole6` or `script6 trace` to identify where drops occur.
- **Privileges**: Most tools in this toolkit require root privileges to forge raw packets.
- **Rate Limiting**: Use the `-r` flag in `scan6` to avoid overwhelming network devices or triggering IDS.