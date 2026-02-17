---
name: unicornscan
description: Perform asynchronous stateless TCP/UDP scanning, banner grabbing, and remote OS identification. Use when high-speed network discovery, port scanning, or vulnerability analysis is required, especially in scenarios where speed and scalability are prioritized over stateful connection tracking.
---

# unicornscan

## Overview
Unicornscan is a high-performance, userland distributed TCP/IP stack designed for information gathering and correlation. It excels at asynchronous stateless scanning, allowing it to send stimuli and measure responses from network devices with extreme efficiency. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume unicornscan is already installed. If not:
```bash
sudo apt update
sudo apt install unicornscan
```

## Common Workflows

### Standard TCP SYN Scan
Scan a single host for all 65535 ports at a rate of 1000 packets per second with immediate output:
```bash
unicornscan -mTs -Iv -r 1000 192.168.1.100:a
```

### UDP Protocol Scan
Scan a network range for common UDP services:
```bash
unicornscan -mU -Iv 192.168.1.0/24:p
```

### TCP Connect Scan (Banner Grabbing)
Perform a TCP connect scan to elicit banners from open services:
```bash
unicornscan -msf -Iv 192.168.1.50:1-1024
```

### Advanced TCP Flag Manipulation
Send TCP packets with specific flags (e.g., SYN and FIN) to bypass or test firewall rules:
```bash
unicornscan -mTsF -Iv 192.168.1.10:80,443
```

## Complete Command Reference

### unicornscan / us
The main scanning engine. `us` is an alias for `unicornscan`.

**Usage:** `unicornscan [options] X.X.X.X/YY:S-E`

| Flag | Description |
|------|-------------|
| `-b, --broken-crc` | Set broken CRC sums on [T]ransport layer, [N]etwork layer, or both [TN] |
| `-B, --source-port` | Set source port or value expected by scan module |
| `-c, --proc-duplicates` | Process duplicate replies |
| `-d, --delay-type` | Set delay type: `1:tsc`, `2:gtod`, `3:sleep` |
| `-D, --no-defpayload` | No default payload; only probe known protocols |
| `-e, --enable-module` | Enable modules (e.g., output and report) |
| `-E, --proc-errors` | Process 'non-open' responses (ICMP errors, TCP RSTs, etc.) |
| `-F, --try-frags` | Try fragmented packets |
| `-G, --payload-group` | Payload group (numeric) for TCP/UDP selection (default: all) |
| `-h, --help` | Display help |
| `-H, --do-dns` | Resolve hostnames during the reporting phase |
| `-i, --interface` | Interface name (e.g., eth0) |
| `-I, --immediate` | Immediate mode; display results as they are found |
| `-j, --ignore-seq` | Ignore [A]ll or [R]eset sequence numbers for TCP validation |
| `-l, --logfile` | Write output to a file instead of the terminal |
| `-L, --packet-timeout` | Wait time for packets to return (default: 7s) |
| `-m, --mode` | Scan mode: `U` (UDP), `T` (TCP), `sf` (TCP Connect), `A` (ARP). TCP flags can follow `T` (e.g., `-mTsFpU`) |
| `-M, --module-dir` | Directory for modules (default: `/usr/lib/unicornscan/modules`) |
| `-o, --format` | Format specification for reply display |
| `-p, --ports` | Global ports to scan if not specified in target string |
| `-P, --pcap-filter` | Extra PCAP filter string for the receiver |
| `-q, --covertness` | Covertness value from 0 to 255 |
| `-Q, --quiet` | Disable screen output (useful for database logging) |
| `-r, --pps` | Packets per second (total across all hosts) |
| `-R, --repeats` | Repeat the packet scan N times |
| `-s, --source-addr` | Source address for packets; use `r` for random |
| `-S, --no-shuffle` | Do not shuffle ports |
| `-t, --ip-ttl` | Set TTL (e.g., 64, 6-16, or r64-128 for random) |
| `-T, --ip-tos` | Set IP Type of Service |
| `-u, --debug` | Debug mask |
| `-U, --no-openclosed` | Do not display "open" or "closed" status |
| `-w, --safefile` | Write PCAP file of received packets |
| `-W, --fingerprint` | OS Fingerprint: 0:Cisco, 1:OpenBSD, 2:WinXP, 3:p0fsendsyn, 4:FreeBSD, 5:Nmap, 6:Linux, 7:strangetcp |
| `-v, --verbose` | Increase verbosity (e.g., -vvv) |
| `-V, --version` | Display version |
| `-z, --sniff` | Sniffer-like mode |
| `-Z, --drone-str` | Drone string |

**Target Specification:**
- **IP Ranges:** CIDR notation (e.g., `1.2.3.4/24`). `/32` is implied if omitted.
- **Port Ranges:** `1-4096`, `53` (single port), `a` (all 65535), `p` (1-1024).

---

### fantaip
Tool for hardware address spoofing and daemonization.

**Usage:** `fantaip (options) IP`

| Flag | Description |
|------|-------------|
| `-d` | Detach from terminal and daemonize |
| `-H` | Hardware address (XX:XX:XX:XX:XX:XX) |
| `-h` | Display help |
| `-i` | Interface (Required) |
| `-v` | Verbose operation |

---

### unibrow
PCAP file reader and filter tool.

**Usage:** `unibrow -i <file.pcap> [options] [filter]`

| Flag | Description |
|------|-------------|
| `-i` | PCAP file to read (Required) |
| `-o` | Output file (append mode) |
| `-v` | Verbose operation |
| `-h` | Display help |

---

## Notes
- **Performance:** High PPS rates (`-r`) can saturate network bandwidth or overwhelm local resources, leading to inaccurate results.
- **Privileges:** Unicornscan requires raw socket access; run with `sudo`.
- **Statelessness:** Because it is stateless, it is significantly faster than Nmap for large-scale scans but may require tuning (`-L`, `-R`) for reliability.