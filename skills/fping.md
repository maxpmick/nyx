---
name: fping
description: Perform high-performance ICMP echo requests against multiple hosts simultaneously using a round-robin approach. Use when performing network discovery, host alive checks, subnet sweeping, or monitoring latency across many targets during reconnaissance and information gathering.
---

# fping

## Overview
fping is a high-performance ping utility that differs from the standard `ping` by allowing multiple targets to be specified on the command line or via a file. It uses a round-robin approach to send ICMP packets, meaning it doesn't wait for one host to timeout before moving to the next. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume fping is already installed. If you get a "command not found" error:

```bash
sudo apt install fping
```

## Common Workflows

### Subnet Sweep for Alive Hosts
Quickly identify which hosts are up in a specific CIDR range:
```bash
fping -a -g 192.168.1.0/24
```

### Ping Targets from a File
Read a list of IP addresses or hostnames from a file and show unreachable hosts:
```bash
fping -u -f targets.txt
```

### Continuous Monitoring with Stats
Loop through targets and provide a summary every 10 seconds:
```bash
fping -l -Q 10 -s 10.0.0.1 10.0.0.2 10.0.0.3
```

### Verbose Count Mode
Send exactly 3 pings to each host in a range and display results in a table format:
```bash
fping -C 3 -g 10.0.0.1 10.0.0.10
```

## Complete Command Reference

### Probing Options

| Flag | Description |
|------|-------------|
| `-4, --ipv4` | Only ping IPv4 addresses |
| `-6, --ipv6` | Only ping IPv6 addresses |
| `-b, --size=BYTES` | Amount of ping data to send, in bytes (default: 56) |
| `-B, --backoff=N` | Set exponential backoff factor to N (default: 1.5) |
| `-c, --count=N` | Count mode: send N pings to each target |
| `-f, --file=FILE` | Read list of targets from a file (`-` means stdin) |
| `-g, --generate` | Generate target list from start/end IP or CIDR (only if no `-f` specified) |
| `-H, --ttl=N` | Set the IP TTL value (Time To Live hops) |
| `-I, --iface=IFACE` | Bind to a particular interface |
| `-l, --loop` | Loop mode: send pings forever |
| `-m, --all` | Use all IPs of provided hostnames (e.g. IPv4 and IPv6), use with `-A` |
| `-M, --dontfrag` | Set the Don't Fragment flag |
| `-O, --tos=N` | Set the type of service (tos) flag on the ICMP packets |
| `-p, --period=MSEC` | Interval between ping packets to one target (default: 1000ms in loop/count modes) |
| `-r, --retry=N` | Number of retries (default: 3) |
| `-R, --random` | Random packet data (to foil link data compression) |
| `-S, --src=IP` | Set source address |
| `-t, --timeout=MSEC` | Individual target initial timeout (default: 500ms) |

### Output Options

| Flag | Description |
|------|-------------|
| `-a, --alive` | Show targets that are alive |
| `-A, --addr` | Show targets by address |
| `-C, --vcount=N` | Same as `-c`, report results in verbose format |
| `-d, --rdns` | Show targets by name (force reverse-DNS lookup) |
| `-D, --timestamp` | Print timestamp before each output line |
| `-e, --elapsed` | Show elapsed time on return packets |
| `-i, --interval=MSEC` | Interval between sending ping packets (default: 10ms) |
| `-n, --name` | Show targets by name (reverse-DNS lookup for target IPs) |
| `-N, --netdata` | Output compatible for netdata (`-l -Q` are required) |
| `-o, --outage` | Show the accumulated outage time (lost packets * packet interval) |
| `-q, --quiet` | Quiet (don't show per-target/per-ping results) |
| `-Q, --squiet=SECS` | Same as `-q`, but add interval summary every SECS seconds |
| `-s, --stats` | Print final stats |
| `-u, --unreach` | Show targets that are unreachable |
| `-v, --version` | Show version |
| `-x, --reachable=N` | Shows if >=N hosts are reachable or not |

## Notes
- `fping6` is available for backwards compatibility with versions below 4.0, but `fping -6` is the modern standard.
- When using `-g` (generate), you can provide a range: `fping -g 192.168.1.1 192.168.1.254` or CIDR: `fping -g 192.168.1.0/24`.
- The `-i` (interval) flag controls how fast packets are sent globally, while `-p` (period) controls the speed per individual target. Use caution with low intervals to avoid flooding.