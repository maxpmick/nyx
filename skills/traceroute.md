---
name: traceroute
description: Trace the path taken by packets across an IPv4/IPv6 network to identify hop-by-hop routing and network latency. Use when diagnosing connectivity issues, mapping network topology, identifying firewall filtering points, or performing network reconnaissance.
---

# traceroute

## Overview
Traceroute tracks the route packets take to a destination host by using the TTL (Time To Live) field of the IP header and eliciting ICMP TIME_EXCEEDED responses from each gateway along the path. It supports various protocols including UDP, TCP, and ICMP. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume traceroute is already installed. If missing:
```bash
sudo apt install traceroute
```

## Common Workflows

### Standard UDP Traceroute
```bash
traceroute example.com
```

### TCP SYN Traceroute (Bypass firewalls blocking UDP/ICMP)
```bash
traceroute -T -p 443 example.com
```

### ICMP Echo Traceroute
```bash
traceroute -I example.com
```

### Trace without DNS resolution for speed
```bash
traceroute -n 8.8.8.8
```

### Specify interface and source IP
```bash
traceroute -i eth0 -s 192.168.1.50 example.com
```

## Complete Command Reference

### traceroute.db / traceroute6.db
```
traceroute [options] host [packetlen]
```

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-4` | | Use IPv4 |
| `-6` | | Use IPv6 |
| `-d` | `--debug` | Enable socket level debugging |
| `-F` | `--dont-fragment` | Do not fragment packets |
| `-f <ttl>` | `--first=<ttl>` | Start from the first_ttl hop (default 1) |
| `-g <gate>` | `--gateway=<gate>` | Route through specified gateway (max 8 IPv4, 127 IPv6) |
| `-I` | `--icmp` | Use ICMP ECHO for tracerouting |
| `-T` | `--tcp` | Use TCP SYN for tracerouting (default port 80) |
| `-i <dev>` | `--interface=<dev>` | Specify network interface |
| `-m <hops>` | `--max-hops=<hops>` | Set max number of hops (default 30) |
| `-N <num>` | `--sim-queries=<num>` | Number of probes tried simultaneously (default 16) |
| `-n` | | Do not resolve IP addresses to domain names |
| `-p <port>` | `--port=<port>` | Set destination port (UDP default 33434+, TCP 80, ICMP 1) |
| `-t <tos>` | `--tos=<tos>` | Set TOS (IPv4) or TC (IPv6) value |
| `-l <label>` | `--flowlabel=<label>` | Use specified flow_label for IPv6 |
| `-w <m,h,n>` | `--wait=<m,h,n>` | Wait times: MAX (sec), HERE (multiplier), NEAR (multiplier) |
| `-q <num>` | `--queries=<num>` | Number of probes per hop (default 3) |
| `-r` | | Bypass normal routing, send directly to host on attached network |
| `-s <addr>` | `--source=<addr>` | Use source address for outgoing packets |
| `-z <wait>` | `--sendwait=<wait>` | Interval between probes (seconds, or ms if > 10) |
| `-e` | `--extensions` | Show ICMP extensions (e.g., MPLS) |
| `-A` | `--as-path-lookups` | Perform AS path lookups in routing registries |
| `-M <name>` | `--module=<name>` | Use specified module (icmp, tcp, udp, etc.) |
| `-O <opts>` | `--options=<opts>` | Use module-specific options |
| | `--sport=<num>` | Use source port `num`. Implies `-N 1` |
| | `--fwmark=<num>` | Set firewall mark for outgoing packets |
| `-U` | `--udp` | Use UDP to a constant port (default 53) |
| `-UL` | | Use UDPLITE (default port 53) |
| `-D` | `--dccp` | Use DCCP Request (default port 33434) |
| `-P <prot>` | `--protocol=<prot>` | Use raw packet of specified protocol |
| | `--mtu` | Discover MTU along the path. Implies `-F -N 1` |
| | `--back` | Guess number of hops in backward path |
| `-V` | `--version` | Print version info |
| | `--help` | Read help and exit |

### lft.db (Layer 4 Traceroute)
```
lft.db [-ACEFINRSTUVbehinpruvz] [-d dport] [-s sport] [-m retry min] [-M retry max] [-a ahead] [-c scatter ms] [-t timeout ms] [-l min ttl] [-H max ttl] [-L length] [-q ISN] [-D device] [gateway ...] target:dport
```

### tcptraceroute.db
```
tcptraceroute.db [-hvnFSAE] [-i dev] [-f first_ttl] [-l length] [-q nqueries] [-t tos] [-m max_ttl] [-p src_port] [-s src_addr] [-w wait_time] host [dest_port] [length]
```

### traceproto.db
```
traceproto.db [-cCTfAhvR] [-p protocol] [-d dst_port] [-D max_dst_port] [-s src_port] [-S max_src_port] [-m min_ttl] [-M max_ttl] [-w response_timeout] [-W send_delay] [-a account_level] [-P payload_size] [-F interface] [-k skips] [-I consecutive_trace_count] [-H packets_per_hop] [-i incr_pattern] [-o output_style] [-t tcp_flags] target
```

### traceroute-nanog
```
traceroute-nanog [-adnruvAMOPQU$] [-w wait] [-S start_ttl] [-m max_ttl] [-p port] [-q nqueries] [-g gateway] [-t tos] [-s src_addr] [-I proto] host [data_size]
```

## Notes
- **Privileges**: Many traceroute methods (TCP, ICMP, Raw) require root privileges to create raw sockets.
- **Firewalls**: If a standard UDP trace shows only `* * *`, try `-T` (TCP) or `-I` (ICMP) as many networks filter high-port UDP traffic.
- **Performance**: Use `-n` to skip DNS resolution if you only need IP addresses; this significantly speeds up the trace.