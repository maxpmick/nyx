---
name: firewalk
description: Determine which Layer 4 protocols (TCP/UDP) an IP forwarding device or firewall will pass. It uses a traceroute-like TTL ramping technique to discover the hop count to a gateway and then sends packets with a TTL one hop greater to see if they are forwarded or dropped. Use during reconnaissance and vulnerability analysis to map firewall rules and ACLs.
---

# firewalk

## Overview
Firewalk is an active reconnaissance network security tool that attempts to determine what layer 4 protocols a given IP forwarding device will pass. It works by sending out TCP or UDP packets with a TTL one hop greater than the targeted gateway. If the gateway allows the traffic, it forwards the packet, which then expires at the next hop and elicits an `ICMP_TIME_EXCEEDED` message. If the gateway drops the traffic, no response is received. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume firewalk is already installed. If the command is missing:

```bash
sudo apt install firewalk
```

## Common Workflows

### Basic TCP Scan
Scan a range of ports through a gateway to a destination metric host without resolving hostnames:
```bash
firewalk -n -pTCP -S80,443,8080 192.168.1.1 192.168.0.1
```

### UDP Scan via Specific Interface
Scan UDP ports 53 and 161 using the `eth0` interface:
```bash
firewalk -i eth0 -pUDP -S53,161 192.168.1.1 192.168.0.1
```

### Advanced Ramping
Specify a custom destination port for the initial ramping phase and a specific source port for the scan:
```bash
firewalk -d 33434 -s 53 -pTCP -S21-25 10.0.0.1 10.0.0.20
```

## Complete Command Reference

```bash
firewalk [options] target_gateway metric
```
*   **target_gateway**: The IP address of the gateway/firewall you are testing.
*   **metric**: An IP address located behind the gateway (does not need to be reached, just downstream).

### Options

| Flag | Description |
|------|-------------|
| `-d <0-65535>` | Destination port to use during the ramping phase (default is typically traceroute ports) |
| `-h` | Display program help and usage |
| `-i <device>` | Specify the network interface to use (e.g., eth0, wlan0) |
| `-n` | Do not resolve IP addresses into hostnames (faster) |
| `-p <TCP \| UDP>` | Specify the protocol to use for the firewalk scan |
| `-r` | Strict RFC adherence |
| `-S <x-y, z>` | Port range to scan. Can be a range (80-100) or comma-separated list (22,80,443) |
| `-s <0-65535>` | Specify the source port for the scan packets |
| `-T <1-1000>` | Packet read timeout in milliseconds |
| `-t <1-25>` | Initial IP time to live (TTL) |
| `-v` | Display program version |
| `-x <1-8>` | Expire vector |

## Notes
- **Metric Host**: The "metric" host must be physically located on the other side of the gateway being tested. It does not need to be the final destination, just a point further down the network path.
- **Ramping Phase**: Firewalk first performs a "ramping phase" (similar to traceroute) to find the exact hop count to the gateway.
- **Scanning Phase**: Once the hop count is known (the scan is "bound"), it sends packets with `TTL = (gateway_hop + 1)`.
- **Results**: 
    - `expired`: The packet passed the firewall (Port is OPEN/Passed).
    - `*no response*`: The packet was likely dropped by the firewall (Port is CLOSED/Filtered).
    - `A! open (port not listen)`: The packet reached the destination host itself.