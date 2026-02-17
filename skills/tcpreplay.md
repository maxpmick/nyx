---
name: tcpreplay
description: Replay, edit, and bridge saved pcap files at arbitrary speeds to test NIDS, firewalls, and network performance. Use when performing traffic simulation, stress testing network appliances, reproducing security incidents, or validating IDS/IPS rules with real-world traffic patterns.
---

# tcpreplay

## Overview
A suite of utilities for replaying and manipulating network traffic captured in pcap files. It allows for exact replication of real-world traffic anomalies (bursts, fragmentation, etc.) to test network infrastructure. Categories: Sniffing & Spoofing, Digital Forensics, Respond.

## Installation (if not already installed)
Assume the tool is installed. If missing:
```bash
sudo apt install tcpreplay
```

## Common Workflows

### Replay traffic at 2x speed
```bash
sudo tcpreplay -i eth0 -x 2.0 capture.pcap
```

### Replay traffic at a specific rate (10 Mbps)
```bash
sudo tcpreplay -i eth0 -M 10 capture.pcap
```

### Rewrite IP addresses and replay
```bash
tcprewrite --pnat=10.0.0.0/8:192.168.1.0/24 --infile=input.pcap --outfile=output.pcap
sudo tcpreplay -i eth0 output.pcap
```

### Bridge two interfaces with port mapping
```bash
sudo tcpbridge -i eth0 -I eth1 --portmap=80:8080
```

## Complete Command Reference

### tcpreplay
Replay pcap files to a network interface.

| Flag | Description |
|------|-------------|
| `-d, --dbug=num` | Enable debugging output (0-5) |
| `-q, --quiet` | Quiet mode |
| `-T, --timer=str` | Select timing mode: `select`, `ioport`, `gtod`, `nano` |
| `--maxsleep=num` | Max sleep between packets (ms) |
| `-v, --verbose` | Print decoded packets via tcpdump |
| `-A, --decode=str` | Arguments passed to tcpdump (requires -v) |
| `-K, --preload-pcap` | Preload packets into RAM |
| `-c, --cachefile=str` | Split traffic via tcpprep cache file (requires -I) |
| `-2, --dualfile` | Replay two files from a network tap (requires -I) |
| `-i, --intf1=str` | Primary output interface |
| `-I, --intf2=str` | Secondary output interface |
| `-w, --write=str` | Write traffic to pcap file instead of interface |
| `--include=str` | Send only selected packet numbers |
| `--exclude=str` | Send all but selected packet numbers |
| `--listnics` | List available interfaces |
| `-l, --loop=num` | Loop through capture X times (0 for infinite) |
| `--loopdelay-ms=num` | Delay between loops (ms) |
| `--loopdelay-ns=num` | Delay between loops (ns) |
| `--pktlen` | Use actual packet length instead of snaplen |
| `-L, --limit=num` | Limit number of packets to send |
| `--duration=num` | Limit number of seconds to replay |
| `-x, --multiplier=str` | Speed multiplier (e.g., 2.0) |
| `-p, --pps=str` | Replay at fixed packets/sec |
| `-M, --mbps=str` | Replay at fixed Mbps |
| `-t, --topspeed` | Replay as fast as possible |
| `-o, --oneatatime` | Replay one packet per user input |
| `--pps-multi=num` | Packets per time interval (requires --pps) |
| `--unique-ip` | Modify IPs each loop for unique flows (requires --loop) |
| `--unique-ip-loops=str` | Loops before assigning new unique IP |
| `--no-flow-stats` | Suppress flow statistics |
| `--flow-expiry=num` | Inactive seconds before flow expires |
| `-P, --pid` | Print PID at startup |
| `--stats=num` | Print stats every X seconds |
| `-W, --suppress-warnings` | Suppress warning messages |
| `-V, --version` | Print version |

### tcprewrite
Rewrite headers of a pcap file.

| Flag | Description |
|------|-------------|
| `-r, --portmap=str` | Rewrite TCP/UDP ports (e.g., 80:8080) |
| `-s, --seed=num` | Randomize IP addresses with seed |
| `-N, --pnat=str` | Rewrite IPs using pseudo-NAT |
| `-S, --srcipmap=str` | Rewrite source IPs |
| `-D, --dstipmap=str` | Rewrite destination IPs |
| `-e, --endpoints=str` | Rewrite IPs between two endpoints (requires cachefile) |
| `--tcp-sequence=num` | Change TCP Sequence/ACK numbers with seed |
| `-b, --skipbroadcast` | Skip rewriting broadcast/multicast IPs |
| `-C, --fixcsum` | Force recalculation of checksums |
| `--fixhdrlen` | Alter header len to match packet length |
| `-m, --mtu=num` | Override MTU (1-262144) |
| `--mtu-trunc` | Truncate packets larger than MTU |
| `-E, --efcs` | Remove Ethernet FCS |
| `--ttl=str` | Modify IPv4/v6 TTL/Hop Limit |
| `--tos=num` | Set IPv4 TOS byte (0-255) |
| `--tclass=num` | Set IPv6 Traffic Class (0-255) |
| `--flowlabel=num` | Set IPv6 Flow Label (0-1048575) |
| `-F, --fixlen=str` | Pad or truncate packet data |
| `--fuzz-seed=num` | Fuzz 1 in X packets |
| `--fuzz-factor=num` | Fuzz ratio (default 1 in 8) |
| `--skipl2broadcast` | Skip rewriting L2 broadcast/multicast |
| `--dlt=str` | Override output DLT encapsulation |
| `--enet-dmac=str` | Override destination MAC |
| `--enet-smac=str` | Override source MAC |
| `--enet-subsmac=str` | Substitute MAC addresses |
| `--enet-mac-seed=num` | Randomize MAC addresses |
| `--enet-vlan=str` | Specify 802.1q VLAN tag mode |
| `--enet-vlan-tag=num` | New VLAN tag value (0-4095) |
| `--enet-vlan-cfi=num` | VLAN CFI value (0-1) |
| `--enet-vlan-pri=num` | VLAN priority (0-7) |
| `--enet-vlan-proto=str` | VLAN protocol (802.1q or 802.1ad) |
| `--hdlc-control=num` | Specify HDLC control value |
| `--hdlc-address=num` | Specify HDLC address |
| `--user-dlt=num` | Set output file DLT type |
| `--user-dlink=str` | Rewrite Data-Link layer with hex data |
| `-i, --infile=str` | Input pcap file |
| `-o, --outfile=str` | Output pcap file |
| `-c, --cachefile=str` | Split traffic via tcpprep cache file |
| `--fragroute=str` | Parse fragroute config file |
| `--fragdir=str` | Apply fragroute to: `c2s`, `s2c`, `both` |
| `--skip-soft-errors` | Skip packets with soft errors |

### tcpbridge
Bridge traffic between two interfaces.

| Flag | Description |
|------|-------------|
| `-i, --intf1=str` | Primary interface (listen) |
| `-I, --intf2=str` | Secondary interface (send) |
| `-u, --unidir` | Uni-directional mode |
| `-M, --mac=str` | MAC addresses of local NICs |
| `-x, --include=str` | Include packets matching rule |
| `-X, --exclude=str` | Exclude packets matching rule |
| `-P, --pid` | Print PID at startup |
| *(Includes most tcprewrite editing flags: --portmap, --seed, --pnat, --fixcsum, etc.)* | |

### tcpprep
Pre-process pcap files to create a cache file for splitting traffic.

| Flag | Description |
|------|-------------|
| `-a, --auto=str` | Auto-split mode (bridge, router, client, server) |
| `-c, --cidr=str` | CIDR-split mode |
| `-r, --regex=str` | Regex-split mode |
| `-p, --port` | Port-split mode |
| `-e, --mac=str` | Source MAC split mode |
| `--reverse` | Matches to be client instead of server |
| `-C, --comment=str` | Embedded cache file comment |
| `-o, --cachefile=str` | Output cache file |
| `-i, --pcap=str` | Input pcap file |
| `-S, --print-stats=str` | Print stats about a cache file |
| `-R, --ratio=str` | Client to server ratio (for auto mode) |
| `-m, --minmask=num` | Min network mask length |
| `-M, --maxmask=num` | Max network mask length |

### tcpliveplay
Replay payloads using new TCP connections against a remote host.

| Usage | `tcpliveplay <interface> <file.pcap> <Dest IP> <Dest MAC> <Dest Port/random>` |
|-------|-----------------------------------------------------------------------------|

### tcpcapinfo
Dissect pcap files to find corruption or differences.

| Flag | Description |
|------|-------------|
| `-d, --dbug=num` | Enable debugging output |
| `<pcap_file(s)>` | Files to analyze |

## Notes
- **Root Privileges**: Replaying to network interfaces (`-i`) usually requires `sudo`.
- **Performance**: Use `--preload-pcap` for high-speed replays to avoid disk I/O bottlenecks.
- **Editing**: `tcpreplay-edit` combines the functionality of `tcpreplay` and `tcprewrite` in one step.
- **Checksums**: When modifying packets (IPs, ports), always use `-C` or `--fixcsum` to ensure the receiving stack doesn't drop them.