---
name: naabu
description: Fast and reliable port scanner written in Go that performs SYN/CONNECT scans to enumerate open ports. Use when performing network reconnaissance, infrastructure auditing, or rapid port discovery across large IP ranges or CIDR blocks. It features Nmap integration, CDN detection, and passive discovery via Shodan's InternetDB.
---

# naabu

## Overview
Naabu is a high-performance port scanner designed for speed and simplicity. It supports various scan types (SYN/CONNECT), handles duplicate hosts automatically, and integrates with Nmap for service discovery. It is particularly effective in bug bounty and large-scale network mapping due to its lightweight resource usage and piped input/output support. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume naabu is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install naabu
```

## Common Workflows

### Basic scan of a single host
```bash
naabu -host scanme.sh
```

### Scan top 1000 ports with SYN scan (requires root)
```bash
sudo naabu -host 192.168.1.1 -top-ports 1000 -scan-type s
```

### Scan a list of hosts and pipe to Nmap for service versioning
```bash
naabu -list hosts.txt -nmap-cli 'nmap -sV -oN nmap_results.txt'
```

### Passive port discovery using Shodan InternetDB
```bash
naabu -host example.com -passive
```

### High-speed CIDR scan excluding CDNs
```bash
naabu -host 10.0.0.0/24 -rate 5000 -exclude-cdn -silent
```

## Complete Command Reference

### INPUT
| Flag | Description |
|------|-------------|
| `-host string[]` | Hosts to scan ports for (comma-separated) |
| `-list, -l string` | List of hosts to scan ports (file) |
| `-exclude-hosts, -eh string` | Hosts to exclude from the scan (comma-separated) |
| `-exclude-file, -ef string` | List of hosts to exclude from scan (file) |

### PORT
| Flag | Description |
|------|-------------|
| `-port, -p string` | Ports to scan (e.g., 80,443, 100-200) |
| `-top-ports, -tp string` | Top ports to scan (default 100) [full, 100, 1000] |
| `-exclude-ports, -ep string` | Ports to exclude from scan (comma-separated) |
| `-ports-file, -pf string` | List of ports to scan (file) |
| `-port-threshold, -pts int` | Port threshold to skip port scan for the host |
| `-exclude-cdn, -ec` | Skip full port scans for CDN/WAF (only scan for port 80,443) |
| `-display-cdn, -cdn` | Display CDN in use |

### RATE-LIMIT
| Flag | Description |
|------|-------------|
| `-c int` | General internal worker threads (default 25) |
| `-rate int` | Packets to send per second (default 1000) |

### OUTPUT
| Flag | Description |
|------|-------------|
| `-o, -output string` | File to write output to (optional) |
| `-j, -json` | Write output in JSON lines format |
| `-csv` | Write output in CSV format |

### CONFIGURATION
| Flag | Description |
|------|-------------|
| `-config string` | Path to configuration file (default `$HOME/.config/naabu/config.yaml`) |
| `-scan-all-ips, -sa` | Scan all the IPs associated with DNS record |
| `-ip-version, -iv string[]` | IP version to scan (4, 6) (default ["4"]) |
| `-scan-type, -s string` | Type of port scan (SYN/CONNECT) (default "s") |
| `-source-ip string` | Source IP and port (x.x.x.x:yyy) |
| `-interface-list, -il` | List available interfaces and public IP |
| `-interface, -i string` | Network Interface to use for port scan |
| `-nmap` | Invoke nmap scan on targets (Deprecated) |
| `-nmap-cli string` | Nmap command to run on found results (e.g., `-nmap-cli 'nmap -sV'`) |
| `-r string` | List of custom resolver DNS (comma separated or file) |
| `-proxy string` | Socks5 proxy (ip[:port] / fqdn[:port]) |
| `-proxy-auth string` | Socks5 proxy authentication (username:password) |
| `-resume` | Resume scan using resume.cfg |
| `-stream` | Stream mode (disables resume, nmap, verify, retries, shuffling, etc) |
| `-passive` | Display passive open ports using Shodan InternetDB API |
| `-irt, -input-read-timeout value` | Timeout on input read (default 3m0s) |
| `-no-stdin` | Disable Stdin processing |

### HOST-DISCOVERY
| Flag | Description |
|------|-------------|
| `-sn, -host-discovery` | Perform Only Host Discovery |
| `-Pn, -skip-host-discovery` | Skip Host discovery |
| `-ps, -probe-tcp-syn string[]` | TCP SYN Ping |
| `-pa, -probe-tcp-ack string[]` | TCP ACK Ping |
| `-pe, -probe-icmp-echo` | ICMP echo request Ping |
| `-pp, -probe-icmp-timestamp` | ICMP timestamp request Ping |
| `-pm, -probe-icmp-address-mask` | ICMP address mask request Ping |
| `-arp, -arp-ping` | ARP ping |
| `-nd, -nd-ping` | IPv6 Neighbor Discovery |
| `-rev-ptr` | Reverse PTR lookup for input IPs |

### SERVICES-DISCOVERY
| Flag | Description |
|------|-------------|
| `-sD, -service-discovery` | Service Discovery |
| `-sV, -service-version` | Service Version |

### OPTIMIZATION
| Flag | Description |
|------|-------------|
| `-retries int` | Number of retries for the port scan (default 3) |
| `-timeout int` | Millisecond to wait before timing out (default 1000) |
| `-warm-up-time int` | Time in seconds between scan phases (default 2) |
| `-ping` | Ping probes for verification of host |
| `-verify` | Validate the ports again with TCP verification |

### DEBUG / UPDATE
| Flag | Description |
|------|-------------|
| `-up, -update` | Update naabu to latest version |
| `-duc, -disable-update-check` | Disable automatic update check |
| `-health-check, -hc` | Run diagnostic check up |
| `-debug` | Display debugging information |
| `-verbose, -v` | Display verbose output |
| `-no-color, -nc` | Disable colors in CLI output |
| `-silent` | Display only results in output |
| `-version` | Display version of naabu |
| `-stats` | Display stats of the running scan (deprecated) |
| `-si, -stats-interval int` | Seconds between stats updates (deprecated) (default 5) |
| `-mp, -metrics-port int` | Port to expose naabu metrics on (default 63636) |

## Notes
- **Root Privileges**: SYN scans (`-s s`) usually require root/sudo privileges to create raw sockets.
- **CDN Handling**: Using `-ec` (exclude-cdn) is highly recommended when scanning large ranges to avoid wasting time on WAF/CDN nodes that only expose 80/443.
- **Nmap Integration**: When using `-nmap-cli`, Naabu passes the discovered open ports to Nmap automatically.