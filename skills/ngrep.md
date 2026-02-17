---
name: ngrep
description: Network grep tool that applies GNU grep features to the network layer. Matches extended regular expressions against data payloads of packets across TCP, UDP, and ICMP. Use when sniffing network traffic for specific strings, patterns, or credentials, and when filtering traffic using BPF logic during reconnaissance or network analysis.
---

# ngrep

## Overview
ngrep is a pcap-aware tool that allows users to specify extended regular expressions to match against the data payloads of network packets. It supports TCP, UDP, and ICMP over various interfaces and understands BPF (Berkeley Packet Filter) logic similar to tcpdump. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume ngrep is already installed. If the command is missing:

```bash
sudo apt install ngrep
```

## Common Workflows

### Search for "GET" or "POST" in HTTP traffic
```bash
ngrep -q -W byline "^(GET|POST) " tcp port 80
```

### Monitor all traffic for a specific string on a specific interface
```bash
ngrep -d eth0 'password'
```

### Match hexadecimal patterns (e.g., searching for a specific byte sequence)
```bash
ngrep -X '0x414243'
```

### Read from a pcap file and filter for a specific host
```bash
ngrep -I traffic.pcap '' host 192.168.1.10
```

## Complete Command Reference

```
ngrep <-hNXViwqpevxlDtTRM> <-IO pcap_dump> <-n num> <-d dev> <-A num>
      <-s snaplen> <-S limitlen> <-W normal|byline|single|none> <-c cols>
      <-P char> <-F file> <-K count>
      <match expression> <bpf filter>
```

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display help/usage information |
| `-V` | Display version information |
| `-q` | Quiet mode (don't print packet reception hash marks) |
| `-e` | Show empty packets |
| `-i` | Ignore case in match expression |
| `-v` | Invert match (show packets that do NOT match) |
| `-R` | Don't do privilege revocation logic |
| `-x` | Print in alternate hexdump format |
| `-X` | Interpret match expression as hexadecimal |
| `-w` | Word-regex (expression must match as a whole word) |
| `-p` | Don't go into promiscuous mode |
| `-l` | Make stdout line buffered |
| `-D` | Replay pcap_dumps with their recorded time intervals |
| `-t` | Print timestamp every time a packet is matched |
| `-T` | Print delta timestamp every time a packet is matched (specify twice for delta from first match) |
| `-M` | Don't do multi-line match (perform single-line match instead) |
| `-I` | Read packet stream from pcap format file `pcap_dump` |
| `-O` | Dump matched packets in pcap format to `pcap_dump` |
| `-n` | Look at only `num` packets total |
| `-A` | Dump `num` packets after a match occurs |
| `-s` | Set the BPF caplen (snaplen) |
| `-S` | Set the limitlen on matched packets |
| `-W` | Set the dump format (`normal`, `byline`, `single`, `none`) |
| `-c` | Force the column width to the specified size |
| `-P` | Set the non-printable display character to the one specified |
| `-F` | Read the BPF filter from the specified file |
| `-N` | Show sub-protocol number |
| `-d` | Use specified device instead of the pcap default |
| `-K` | Send `N` packets to kill observed connections (TCP RST or ICMP Unreachable) |

## Notes
- The `<match expression>` is a regular expression used to match against the payload.
- The `<bpf filter>` uses standard BPF syntax (e.g., `tcp port 80`, `host 10.0.0.1`).
- Using `-W byline` is highly recommended for human-readable protocols like HTTP or SMTP to preserve line breaks.
- Use `-q` in scripts or when redirecting output to avoid filling the buffer with progress marks (`#`).