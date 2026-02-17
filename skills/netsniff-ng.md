---
name: netsniff-ng
description: A high-performance Linux network sniffer toolkit utilizing zero-copy mechanisms for packet inspection, protocol analysis, and traffic generation. Use for high-speed packet capturing, low-level traffic generation, BPF compilation, and network performance monitoring during security audits or network debugging.
---

# netsniff-ng

## Overview
netsniff-ng is a high-performance networking toolkit that uses zero-copy mechanisms to avoid kernel-to-userspace copying overhead. It includes tools for sniffing (netsniff-ng), traffic generation (trafgen, mausezahn), BPF compilation (bpfc), and network statistics (ifpps, flowtop). Category: Sniffing & Spoofing / Reconnaissance.

## Installation (if not already installed)
Assume the toolkit is installed. If not:
```bash
sudo apt install netsniff-ng
```

## Common Workflows

### High-Speed Packet Capture
Capture traffic on `eth0` and save to a pcap file using a specific CPU core for performance:
```bash
netsniff-ng --in eth0 --out dump.pcap --silent --bind-cpu 0
```

### Traffic Generation from Config
Generate custom network traffic using a configuration file:
```bash
trafgen --dev eth0 --conf trafgen.cfg --cpus 2
```

### Autonomous System Trace Route
Trace the AS path to a host using TCP SYN probes:
```bash
astraceroute -i eth0 -N -S -H example.com
```

### Live Flow Tracking
Monitor active TCP/UDP connections with GeoIP information:
```bash
flowtop -46UT
```

## Complete Command Reference

### netsniff-ng (The Sniffer)
```
netsniff-ng [options] [filter-expression]
```
| Flag | Description |
|------|-------------|
| `-i, -d, --dev, --in <src>` | Input source: netdev, pcap file, or `-` (stdin) |
| `-o, --out <sink>` | Output: netdev, pcap, directory, trafgen cfg, or `-` (stdout) |
| `-C, --fanout-group <id>` | Join packet fanout group |
| `-K, --fanout-type <type>` | Fanout discipline: hash, lb, cpu, rnd, roll, qm |
| `-L, --fanout-opts <opts>` | Fanout options: defrag, roll |
| `-f, --filter <file\|expr>` | BPF filter from file or tcpdump-like expression |
| `-t, --type <type>` | Filter for: host, broadcast, multicast, others, outgoing |
| `-F, --interval <val>` | Dump interval for dir output: e.g., 100MiB, 1min |
| `-R, --rfraw` | Capture/inject raw 802.11 frames |
| `-n, --num <N>` | Exit after N packets (0 = infinite) |
| `-P, --prefix <name>` | Prefix for pcaps in directory mode |
| `-O, --overwrite <N>` | Limit number of pcap files to N |
| `-T, --magic <magic>` | Pcap magic number/format |
| `-w, --cooked` | Use Linux "cooked" header |
| `-D, --dump-pcap-types` | List pcap types and exit |
| `-B, --dump-bpf` | Dump generated BPF assembly |
| `-r, --rand` | Randomize packet forwarding order |
| `-M, --no-promisc` | Disable promiscuous mode |
| `-A, --no-sock-mem` | Don't tune core socket memory |
| `-N, --no-hwtimestamp` | Disable hardware time stamping |
| `-m, --mmap` | Mmap(2) pcap file I/O (for replaying) |
| `-G, --sg` | Scatter/gather pcap file I/O |
| `-c, --clrw` | Use slower read(2)/write(2) I/O |
| `-S, --ring-size <size>` | Specify ring size (KiB/MiB/GiB) |
| `-k, --kernel-pull <us>` | Kernel pull interval (default 10us) |
| `-J, --jumbo-support` | Support 64KB Super Jumbo Frames |
| `-b, --bind-cpu <cpu>` | Bind to specific CPU |
| `-u, --user <id>` | Drop privileges to user ID |
| `-g, --group <id>` | Drop privileges to group ID |
| `-H, --prio-high` | Set as high priority process |
| `-Q, --notouch-irq` | Do not touch IRQ CPU affinity |
| `-s, --silent` | Do not print captured packets |
| `-q, --less` | Less-verbose output |
| `-X, --hex` | Print packet data in hex |
| `-l, --ascii` | Print packet data in ASCII |
| `-U, --update` | Update GeoIP databases |

### trafgen (Packet Generator)
```
trafgen [options] [packet]
```
| Flag | Description |
|------|-------------|
| `-i, -c, --in, --conf <cfg>` | Packet configuration file or `-` |
| `-o, -d, --out, --dev <dev>` | Output device (eth0) or file (.cfg, .pcap) |
| `-p, --cpp` | Run config through C preprocessor |
| `-D, --define` | Add macro for C preprocessor |
| `-J, --jumbo-support` | Support 64KB jumbo frames |
| `-R, --rfraw` | Inject raw 802.11 frames |
| `-s, --smoke-test <ip>` | Probe if machine survived fuzz-test |
| `-n, --num <N>` | Number of packets to send (0 = infinite) |
| `-r, --rand` | Randomize packet selection |
| `-P, --cpus <N>` | Number of forks/CPUs to use |
| `-t, --gap <time>` | Interpacket gap (s/ms/us/ns) |
| `-b, --rate <rate>` | Traffic rate (pps, kbit, MiB, etc.) |
| `-S, --ring-size <size>` | Set mmap size |
| `-E, --seed <uint>` | Set srand seed |
| `-e, --example` | Show built-in config example |

### mausezahn (Cisco-style Generator)
```
mausezahn [options] [interface] <keyword|arg|hex>
```
| Flag | Description |
|------|-------------|
| `-x <port>` | Interactive mode (Telnet CLI) |
| `-l <ip>` | Listen address for interactive mode |
| `-4 / -6` | IPv4 (default) or IPv6 mode |
| `-c <count>` | Send packet N times |
| `-d <delay>` | Delay between transmissions (usec, msec, sec) |
| `-r` | Randomize delay |
| `-p <len>` | Pad frame to length with random bytes |
| `-a <mac>` | Source MAC (or: rand, bc, own, stp, cisco) |
| `-b <mac>` | Dest MAC (or: rand, bc, own, stp, cisco) |
| `-A <ip>` | Source IP |
| `-B <ip|dns>` | Destination IP or Domain |
| `-P <ascii>` | ASCII payload |
| `-f <file>` | Read ASCII payload from file |
| `-F <file>` | Read Hex payload from file |
| `-Q <vlan>` | 802.1Q VLAN tag [CoS:]vlan |
| `-t <type>` | Packet type: arp, bpdu, cdp, ip, icmp, udp, tcp, dns, rtp, syslog, lldp |
| `-M <label>` | Insert MPLS label |

### astraceroute (AS Trace)
| Flag | Description |
|------|-------------|
| `-H, --host <host>` | Target Host/IP |
| `-p, --port <port>` | Target Port |
| `-i, -d, --dev <dev>` | Networking device |
| `-f, --init-ttl <ttl>` | Initial TTL |
| `-m, --max-ttl <ttl>` | Max TTL (default 30) |
| `-q, --num-probes <N>` | Probes per hop (default 2) |
| `-x, --timeout <sec>` | Timeout (default 3s) |
| `-X, --payload <str>` | DPI test payload |
| `-S, -A, -F, -P, -U, -R` | TCP Flags: SYN, ACK, FIN, PSH, URG, RST |
| `-E, --ecn-syn` | Send ECN SYN packets |
| `-L, --latitude` | Show lat/long |
| `-Z, --show-packet` | Show returned packet per hop |

### flowtop (Flow Tracking)
| Flag | Description |
|------|-------------|
| `-4, -6` | IPv4 / IPv6 flows |
| `-T, -U, -D, -I, -S` | Protocols: TCP, UDP, DCCP, ICMP, SCTP |
| `-n, --no-dns` | Skip hostname lookup |
| `-G, --no-geoip` | Skip GeoIP lookup |
| `-s, --show-src` | Show source address |
| `-t, --interval <s>` | Refresh interval |

### bpfc (BPF Compiler)
| Flag | Description |
|------|-------------|
| `-i, --input <file>` | BPF source file or `-` |
| `-p, --cpp` | Use C preprocessor |
| `-f <format>` | Output: C, netsniff-ng, xt_bpf, tcpdump |
| `-b, --bypass` | Bypass filter validation |
| `-d, --dump` | Dump instruction table |

### ifpps (Statistics)
| Flag | Description |
|------|-------------|
| `-d, --dev <dev>` | Device for stats |
| `-n, --num-cpus <N>` | Top hitter CPUs to show |
| `-t, --interval <ms>` | Refresh time |
| `-c, --csv` | Gnuplot-ready CSV output |
| `-p, --promisc` | Promiscuous mode |

## Notes
- **Performance**: Use `--bind-cpu` to pin processes to specific cores for maximum throughput.
- **Root Required**: Most tools in this suite require root privileges to access raw sockets.
- **Safety**: `mausezahn` and `trafgen` can easily saturate links; use with caution in production environments.