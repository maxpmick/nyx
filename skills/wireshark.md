---
name: wireshark
description: Capture and analyze network traffic interactively (GUI) or via command line (tshark). Use for network troubleshooting, protocol analysis, security auditing, and packet-level forensics across various domains including Wireless, VoIP, and Web.
---

# Wireshark

## Overview
Wireshark is the world’s foremost network protocol analyzer. It lets you see what’s happening on your network at a microscopic level. It includes a suite of tools for capturing, filtering, and manipulating packet data. Category: Sniffing & Spoofing / Digital Forensics.

## Installation (if not already installed)
Assume Wireshark is already installed. If not:
```bash
sudo apt update && sudo apt install wireshark tshark
```

## Common Workflows

### Live Capture with TShark
Capture HTTP traffic on eth0 and display summary:
```bash
tshark -i eth0 -f "tcp port 80"
```

### Extract Fields to CSV/Text
Extract source IP and HTTP host from a pcap file:
```bash
tshark -r capture.pcapng -T fields -e ip.src -e http.host -E separator=,
```

### Merge Multiple Captures
Combine several pcap files into one, ordered by timestamp:
```bash
mergecap -w combined.pcapng file1.pcap file2.pcap
```

### Generate Random Traffic for Testing
Create a pcap with 500 random DNS packets:
```bash
randpkt -c 500 -t dns sample_dns.pcapng
```

## Complete Command Reference

### tshark (CLI Analyzer)
```bash
tshark [options] ...
```

| Capture Interface | Description |
|-------------------|-------------|
| `-i, --interface <if>` | Interface name or index |
| `-f <filter>` | Capture filter in libpcap syntax |
| `-s, --snapshot-length <len>` | Packet snapshot length |
| `-p, --no-promiscuous-mode` | Don't capture in promiscuous mode |
| `-I, --monitor-mode` | Capture in monitor mode (wireless) |
| `-D, --list-interfaces` | Print list of interfaces and exit |
| `-L, --list-data-link-types` | List link-layer types for interface |

| Processing | Description |
|------------|-------------|
| `-r <infile>` | Read from file (or '-' for stdin) |
| `-2` | Perform two-pass analysis |
| `-R <filter>` | Read filter (Wireshark display filter syntax) |
| `-Y <filter>` | Display filter (Wireshark display filter syntax) |
| `-n` | Disable all name resolutions |
| `-d <layer>==<sel>,<proto>` | "Decode As" (e.g., `tcp.port==8888,http`) |

| Output | Description |
|--------|-------------|
| `-w <outfile>` | Write to pcapng file |
| `-V` | Add output of packet tree (Details) |
| `-x` | Add output of hex and ASCII dump |
| `-T <format>` | Output format: `pdml\|ps\|psml\|json\|jsonraw\|ek\|tabs\|text\|fields` |
| `-e <field>` | Field to print if `-T fields` selected |
| `-E <option>=<val>` | Options for `-T fields` (e.g., `header=y`, `separator=,`) |
| `-z <statistics>` | Various statistics (e.g., `http,tree`) |

---

### capinfos (Capture File Info)
```bash
capinfos [options] <infile>
```
- `-t`: Display file type
- `-c`: Number of packets
- `-d`: Total length of packets
- `-u`: Capture duration
- `-H`: SHA256 and SHA1 hashes
- `-A`: Generate all infos (default)

---

### dumpcap (Raw Capture Tool)
```bash
dumpcap [options] -i <interface> -w <outfile>
```
- `-a <cond>`: Autostop (duration:SEC, filesize:KB, files:NUM, packets:NUM)
- `-b <opt>`: Ring buffer (duration:SEC, filesize:KB, files:NUM)
- `-f <filter>`: Capture filter
- `-M`: Machine-readable output

---

### editcap (Edit/Translate Captures)
```bash
editcap [options] <infile> <outfile> [packet-range]
```
- `-r`: Keep selected packets (default is delete)
- `-A <time>`: Packets after specific time
- `-B <time>`: Packets before specific time
- `-d`: Remove duplicate packets (window 5)
- `-D <window>`: Remove duplicates within window (0-1000000)
- `-s <snaplen>`: Truncate packets
- `-t <adj>`: Adjust timestamps (e.g., -0.5)
- `-F <type>`: Set output file type

---

### mergecap (Merge Captures)
```bash
mergecap [options] -w <outfile> <infile1> <infile2> ...
```
- `-a`: Concatenate files instead of merging by timestamp
- `-s <snaplen>`: Truncate packets
- `-I <mode>`: Interface Description Block merge mode

---

### randpkt (Random Packet Generator)
```bash
randpkt [options] <outfile>
```
- `-b <bytes>`: Max bytes per packet (default 5000)
- `-c <count>`: Packet count (default 1000)
- `-t <type>`: Packet type (arp, bgp, dns, eth, icmp, ip, ipv6, tcp, udp, etc.)

---

### text2pcap (Hex to Pcap)
```bash
text2pcap [options] <infile> <outfile>
```
- `-o hex|oct|dec`: Parse offsets
- `-e <ethertype>`: Prepend dummy Ethernet header
- `-4 <src>,<dst>`: Prepend dummy IPv4 header
- `-u <srcp>,<dstp>`: Prepend dummy UDP header

---

### stratoshark (System Call Analyzer)
- `stratoshark`: Graphical interface for system call/log analysis.
- `strato`: Console interface for system call analysis (uses TShark-like flags).

## Notes
- **Permissions**: To capture as a non-root user, ensure your user is in the `wireshark` group: `sudo usermod -aG wireshark $USER`.
- **BPF JIT**: For high-speed capturing, enable BPF JIT: `echo 1 > /proc/sys/net/core/bpf_jit_enable`.
- **Performance**: Use `dumpcap` for high-volume raw capturing and `tshark` or `wireshark` for analysis.