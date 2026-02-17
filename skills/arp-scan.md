---
name: arp-scan
description: Discover and fingerprint IP hosts on a local network using the ARP protocol. Use when performing local network reconnaissance, identifying live hosts, mapping MAC addresses to IP addresses, or fingerprinting operating systems during the information gathering phase of a penetration test.
---

# arp-scan

## Overview
arp-scan is a command-line tool that sends ARP requests to target hosts and displays responses. It is used for host discovery and fingerprinting on local Ethernet networks. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume arp-scan is already installed. If you encounter an error:
```bash
sudo apt install arp-scan
```

## Common Workflows

### Scan the local network
Automatically generates targets based on the interface's IP and netmask.
```bash
sudo arp-scan --localnet
```

### Scan a specific subnet with custom source MAC
Useful for bypassing MAC filters or testing security controls.
```bash
sudo arp-scan -I eth0 --srcaddr=DE:AD:BE:EF:CA:FE 192.168.1.0/24
```

### Fingerprint a specific target
Attempts to identify the OS of a target based on ARP response characteristics.
```bash
sudo arp-fingerprint 192.168.1.50
```

### High-speed scan with custom output
Scans a range and outputs only IP and MAC in a tab-separated format.
```bash
sudo arp-scan --bandwidth=10M --plain --format='${ip}\t${mac}' 10.0.0.0/16
```

## Complete Command Reference

### arp-scan Options
`Usage: arp-scan [options] [hosts...]`

#### General Options
| Flag | Description |
|------|-------------|
| `--help`, `-h` | Display usage message and exit |
| `--verbose`, `-v` | Verbose progress (use up to 3 times for more detail) |
| `--version`, `-V` | Display version and license details |
| `--interface=<s>`, `-I <s>` | Use network interface `<s>` |

#### Host Selection
| Flag | Description |
|------|-------------|
| `--file=<s>`, `-f <s>` | Read hostnames/addresses from file (use "-" for stdin) |
| `--localnet`, `-l` | Generate addresses from interface configuration |

#### MAC/Vendor Mapping Files
| Flag | Description |
|------|-------------|
| `--ouifile=<s>`, `-O <s>` | Use IEEE registry vendor mapping file `<s>` |
| `--macfile=<s>`, `-m <s>` | Use custom vendor mapping file `<s>` |

#### Output Format Control
| Flag | Description |
|------|-------------|
| `--quiet`, `-q` | Display minimal output (IP and MAC only, saves memory) |
| `--plain`, `-x` | Suppress header and footer text |
| `--ignoredups`, `-g` | Don't display duplicate packets |
| `--rtt`, `-D` | Calculate and display packet round-trip time |
| `--format=<s>`, `-F <s>` | Specify output format string (Fields: IP, Name, MAC, HdrMAC, Vendor, Padding, Framing, VLAN, Proto, DUP, RTT) |

#### Host List Randomisation
| Flag | Description |
|------|-------------|
| `--random`, `-R` | Randomise the target host list |
| `--randomseed=<i>` | Seed the pseudo random number generator |

#### Output Timing and Retry
| Flag | Description |
|------|-------------|
| `--retry=<i>`, `-r <i>` | Total attempts per host (default=2) |
| `--backoff=<f>`, `-b <f>` | Timeout backoff factor (default=1.50) |
| `--timeout=<i>`, `-t <i>` | Initial per host timeout in ms (default=500) |
| `--interval=<x>`, `-i <x>` | Minimum packet interval (ms, or 'u' for microseconds) |
| `--bandwidth=<x>`, `-B <x>` | Set outbound bandwidth in bps (e.g., 256K, 1M) |

#### DNS Resolution
| Flag | Description |
|------|-------------|
| `--numeric`, `-N` | Targets must be IP addresses (skips DNS lookup) |
| `--resolve`, `-d` | Resolve responding addresses to hostnames |

#### Output ARP Packet
| Flag | Description |
|------|-------------|
| `--arpsha=<m>`, `-u <m>` | Set ARP source Ethernet address (ar$sha field) |
| `--arptha=<m>`, `-w <m>` | Set ARP target Ethernet address (ar$tha field) |
| `--arphrd=<i>`, `-H <i>` | Set ARP hardware type (default=1) |
| `--arppro=<i>`, `-p <i>` | Set ARP protocol type (default=0x0800) |
| `--arphln=<i>`, `-a <i>` | Set hardware address length (default=6) |
| `--arppln=<i>`, `-P <i>` | Set protocol address length (default=4) |
| `--arpop=<i>`, `-o <i>` | Specify ARP operation (default=1) |
| `--arpspa=<a>`, `-s <a>` | Set source IPv4 address (or "dest") |

#### Output Ethernet Header
| Flag | Description |
|------|-------------|
| `--srcaddr=<m>`, `-S <m>` | Set source Ethernet MAC address in header |
| `--destaddr=<m>`, `-T <m>` | Set destination MAC address (default=ff:ff:ff:ff:ff:ff) |
| `--prototype=<i>`, `-y <i>` | Set Ethernet protocol type (default=0x0806) |
| `--llc`, `-L` | Use RFC 1042 LLC/SNAP encapsulation |
| `--vlan=<i>`, `-Q <i>` | Use 802.1Q tagging with VLAN id `<i>` |

#### Misc Options
| Flag | Description |
|------|-------------|
| `--limit=<i>`, `-M <i>` | Exit after `<i>` hosts have responded |
| `--pcapsavefile=<s>`, `-W <s>` | Write received packets to pcap file |
| `--snap=<i>`, `-n <i>` | Set pcap snap length (default=64) |
| `--retry-send=<i>`, `-Y <i>` | Number of send attempts (default=20) |
| `--retry-send-interval=<i>`, `-E <i>` | Interval between send attempts (default=5ms) |
| `--padding=<h>`, `-A <h>` | Specify padding after packet data in hex |

### arp-fingerprint Options
`Usage: arp-fingerprint [options] <target>`

| Flag | Description |
|------|-------------|
| `-h` | Display usage message |
| `-v` | Verbose progress messages |
| `-o <option-string>` | Pass specified options to arp-scan |
| `-l` | Fingerprint all targets in the local net |

### get-oui Options
`Usage: get-oui [-f <file>] [-u <url>] [-h] [-v]`

| Flag | Description |
|------|-------------|
| `-f` | Specify output file |
| `-u` | Specify URL to fetch OUI data from |
| `-h` | Display help |
| `-v` | Verbose output |

## Notes
- **Privileges**: Requires root or `CAP_NET_RAW` capabilities to use raw sockets.
- **Targeting**: Supports CIDR (10.0.0.0/24), ranges (10.0.0.1-10.0.0.10), and network:mask (10.0.0.0:255.255.255.0).
- **Duplicates**: Responses from the same IP with different MACs or multiple responses are flagged as `(DUP)`.
- **Performance**: Adjust `--bandwidth` or `--interval` to avoid saturating slow links or triggering network alarms.