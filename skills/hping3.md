---
name: hping3
description: A scriptable network tool for sending custom ICMP, UDP, and TCP packets and analyzing replies. Use for firewall testing, advanced port scanning (including spoofed scans), network performance testing, path MTU discovery, traceroute-like analysis, OS fingerprinting, and TCP/IP stack auditing. It is a primary tool for reconnaissance, vulnerability analysis, and network stress testing.
---

# hping3

## Overview
hping3 is a command-line oriented TCP/IP packet assembler/analyzer. It supports TCP, UDP, ICMP, and RAW-IP protocols, features a traceroute mode, the ability to send files between a covered channel, and many other features. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume hping3 is already installed. If you get a "command not found" error:

```bash
sudo apt install hping3
```

## Common Workflows

### TCP SYN Scan (Port Scanning)
Scan a range of ports using SYN packets:
```bash
hping3 --scan 1-1024 -S 192.168.1.1
```

### ICMP Traceroute
Perform a traceroute using ICMP echo requests:
```bash
hping3 --traceroute -V -1 www.example.com
```

### Testing Firewall Rules (ACK Scan)
Send ACK packets to a specific port to check if it's filtered:
```bash
hping3 -A -p 80 192.168.1.1
```

### SYN Flood (Stress Testing)
Send SYN packets as fast as possible from random source addresses:
```bash
hping3 --flood --rand-source -S -p 80 192.168.1.1
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help |
| `-v`, `--version` | Show version |
| `-c`, `--count` | Packet count |
| `-i`, `--interval` | Wait (uX for X microseconds, e.g., `-i u1000`) |
| `--fast` | Alias for `-i u10000` (10 packets per second) |
| `--faster` | Alias for `-i u1000` (100 packets per second) |
| `--flood` | Send packets as fast as possible. Don't show replies |
| `-n`, `--numeric` | Numeric output |
| `-q`, `--quiet` | Quiet mode |
| `-I`, `--interface` | Interface name (otherwise default routing interface) |
| `-V`, `--verbose` | Verbose mode |
| `-D`, `--debug` | Debugging info |
| `-z`, `--bind` | Bind `Ctrl+Z` to TTL (defaults to destination port) |
| `-Z`, `--unbind` | Unbind `Ctrl+Z` |
| `--beep` | Beep for every matching packet received |

### Mode Selection
| Flag | Description |
|------|-------------|
| (default) | TCP mode |
| `-0`, `--rawip` | RAW IP mode |
| `-1`, `--icmp` | ICMP mode |
| `-2`, `--udp` | UDP mode |
| `-8`, `--scan` | SCAN mode (Example: `hping3 --scan 1-30,70-90 -S target`) |
| `-9`, `--listen` | Listen mode |

### IP Options
| Flag | Description |
|------|-------------|
| `-a`, `--spoof` | Spoof source address |
| `--rand-dest` | Random destination address mode |
| `--rand-source` | Random source address mode |
| `-t`, `--ttl` | Set TTL (default 64) |
| `-N`, `--id` | Set ID (default random) |
| `-W`, `--winid` | Use Windows* ID byte ordering |
| `-r`, `--rel` | Relativize ID field (to estimate host traffic) |
| `-f`, `--frag` | Split packets into more fragments (may pass weak ACLs) |
| `-x`, `--morefrag` | Set more fragments flag |
| `-y`, `--dontfrag` | Set don't fragment flag |
| `-g`, `--fragoff` | Set the fragment offset |
| `-m`, `--mtu` | Set virtual MTU; implies `--frag` if packet size > MTU |
| `-o`, `--tos` | Type of service (default 0x00), try `--tos help` |
| `-G`, `--rroute` | Includes RECORD_ROUTE option and displays route buffer |
| `--lsrr` | Loose source routing and record route |
| `--ssrr` | Strict source routing and record route |
| `-H`, `--ipproto` | Set the IP protocol field (only in RAW IP mode) |

### ICMP Options
| Flag | Description |
|------|-------------|
| `-C`, `--icmptype` | ICMP type (default echo request) |
| `-K`, `--icmpcode` | ICMP code (default 0) |
| `--force-icmp` | Send all ICMP types (default: only supported types) |
| `--icmp-gw` | Set gateway address for ICMP redirect (default 0.0.0.0) |
| `--icmp-ts` | Alias for `--icmp --icmptype 13` (Timestamp) |
| `--icmp-addr` | Alias for `--icmp --icmptype 17` (Subnet mask) |
| `--icmp-help` | Display help for other ICMP options |

### TCP/UDP Options
| Flag | Description |
|------|-------------|
| `-s`, `--baseport` | Base source port (default random) |
| `-p`, `--destport` | `[+][+]<port>` Destination port (default 0). `Ctrl+Z` inc/dec |
| `-k`, `--keep` | Keep source port constant |
| `-w`, `--win` | TCP window size (default 64) |
| `-O`, `--tcpoff` | Set fake TCP data offset |
| `-Q`, `--seqnum` | Show only TCP sequence numbers |
| `-b`, `--badcksum` | Send packets with bad IP checksum |
| `-M`, `--setseq` | Set TCP sequence number |
| `-L`, `--setack` | Set TCP ACK |
| `-F`, `--fin` | Set FIN flag |
| `-S`, `--syn` | Set SYN flag |
| `-R`, `--rst` | Set RST flag |
| `-P`, `--push` | Set PUSH flag |
| `-A`, `--ack` | Set ACK flag |
| `-U`, `--urg` | Set URG flag |
| `-X`, `--xmas` | Set X unused flag (0x40) |
| `-Y`, `--ymas` | Set Y unused flag (0x80) |
| `--tcpexitcode` | Use last `tcp->th_flags` as exit code |
| `--tcp-mss` | Enable TCP MSS option with given value |
| `--tcp-timestamp` | Enable TCP timestamp option to guess HZ/uptime |

### Common/Data Options
| Flag | Description |
|------|-------------|
| `-d`, `--data` | Data size (default 0) |
| `-E`, `--file` | Data from file |
| `-e`, `--sign` | Add 'signature' |
| `-j`, `--dump` | Dump packets in hex |
| `-J`, `--print` | Dump printable characters |
| `-B`, `--safe` | Enable 'safe' protocol |
| `-u`, `--end` | Notify when `--file` reaches EOF and prevent rewind |
| `-T`, `--traceroute` | Traceroute mode (implies `--bind` and `--ttl 1`) |
| `--tr-stop` | Exit when receiving the first non-ICMP in traceroute mode |
| `--tr-keep-ttl` | Keep source TTL fixed (monitor one hop) |
| `--tr-no-rtt` | Don't calculate/show RTT in traceroute mode |

### Advanced Options
| Flag | Description |
|------|-------------|
| `--apd-send` | Send the packet described with APD (Arbitrary Packet Description) |

## Notes
- **Privileges**: hping3 requires root privileges to create raw sockets.
- **Flooding**: Use `--flood` with caution as it can easily saturate network bandwidth or crash services.
- **Scripting**: hping3 is scriptable using Tcl for complex automation.