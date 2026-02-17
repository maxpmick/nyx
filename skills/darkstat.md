---
name: darkstat
description: Monitor network traffic and generate usage statistics via a web interface. It captures traffic to analyze IP addresses, ports, and protocols, providing graphical reports for minute, hourly, daily, and monthly periods. Use when performing network traffic analysis, bandwidth monitoring, or identifying active hosts and services on a network segment during sniffing and spoofing operations.
---

# darkstat

## Overview
A lightweight, stable network traffic analyzer that runs as a background process (daemon). It sniffs packets and serves statistics—including input/output traffic by host, port, and protocol—to a built-in web server. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume darkstat is already installed. If the command is missing:

```bash
sudo apt install darkstat
```

## Common Workflows

### Basic monitoring on a specific interface
Starts darkstat on eth0 and binds the web interface to port 667.
```bash
sudo darkstat -i eth0 -p 667
```

### Analyzing a capture file (pcap)
Processes an existing capture file instead of live sniffing and prevents the process from backgrounding.
```bash
darkstat -r traffic.pcap --no-daemon
```

### Stealthy/Local-only monitoring
Runs without promiscuous mode and restricts the web interface to localhost.
```bash
sudo darkstat -i eth0 --local-only --no-promisc --no-dns
```

### Persistent statistics with export/import
Saves state to a file on exit and reloads it on start to maintain long-term statistics.
```bash
sudo darkstat -i eth0 --import darkstat.stats --export darkstat.stats
```

## Complete Command Reference

```
darkstat [ -i interface ] [ options ]
```

### Capture Options

| Flag | Description |
|------|-------------|
| `-i interface` | Capture traffic from the specified network interface. |
| `-f filter` | Use a specific bpf-style capture filter (e.g., "port 80"). |
| `-r capfile` | Read traffic from a pcap file instead of a live interface. |
| `--snaplen bytes` | Set the number of bytes to capture per packet (default: 65535). |
| `--pppoe` | Parse PPPoE encapsulation. |
| `--no-promisc` | Do not put the interface into promiscuous mode. |

### Web Interface Options

| Flag | Description |
|------|-------------|
| `-p port` | Bind the web server to the specified port (default: 667). |
| `-b bindaddr` | Bind the web server to a specific IP address. |
| `--base path` | Serve the web interface from a specific URL base path. |
| `--local-only` | Make the web server only accessible from localhost (127.0.0.1). |

### Analysis & Display Options

| Flag | Description |
|------|-------------|
| `-l network/netmask` | Define the "local" network for traffic accounting. |
| `--no-dns` | Disable reverse DNS resolution of IP addresses. |
| `--no-macs` | Do not display MAC addresses in the statistics. |
| `--no-lastseen` | Do not track/display the "last seen" time for hosts. |
| `--hexdump` | Dump packet data to stdout in hex format (for debugging). |

### Process & Security Options

| Flag | Description |
|------|-------------|
| `--no-daemon` | Do not fork into the background; stay in the foreground. |
| `--syslog` | Send error and status messages to syslog. |
| `--verbose` | Enable verbose output. |
| `--chroot dir` | Chroot to the specified directory for security. |
| `--user username` | Drop privileges and run as the specified user. |
| `--pidfile filename` | Write the process ID to the specified file. |
| `--wait secs` | Wait specified seconds for the interface to come up. |
| `--version` | Print version information and exit. |
| `--help` | Print the help message and exit. |

### Data Management Options

| Flag | Description |
|------|-------------|
| `--daylog filename` | Log daily traffic statistics to the specified file. |
| `--import filename` | Load previously exported statistics on startup. |
| `--export filename` | Save statistics to the specified file on shutdown. |
| `--hosts-max count` | Maximum number of hosts to track in memory. |
| `--hosts-keep count` | Number of hosts to keep when purging the cache. |
| `--ports-max count` | Maximum number of ports to track in memory. |
| `--ports-keep count` | Number of ports to keep when purging the cache. |
| `--highest-port port` | Do not track ports higher than this value. |

## Notes
- **Privileges**: Running on a live interface usually requires `sudo` or CAP_NET_RAW capabilities.
- **Persistence**: Statistics are kept in memory. Use `--export` and `--import` to persist data across reboots.
- **Performance**: `darkstat` is designed to be very low-impact compared to tools like `ntopng`.