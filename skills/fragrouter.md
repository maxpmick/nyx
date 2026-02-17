---
name: fragrouter
description: A network intrusion detection evasion toolkit used to fragment and manipulate IP/TCP traffic. Use when testing the effectiveness of Intrusion Detection Systems (IDS), firewalls, or honeypots by attempting to bypass signature-based detection through various fragmentation and packet-ordering attacks.
---

# fragrouter

## Overview
Fragrouter is a specialized toolkit designed for IDS evasion testing. It acts as a router that intercepts traffic and forwards it to a destination using various fragmentation, overlapping, and out-of-order delivery techniques. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume fragrouter is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install fragrouter
```

## Common Workflows

### Basic IP Fragmentation
To forward traffic as ordered 8-byte IP fragments on a specific interface:
```bash
fragrouter -i eth0 -F1
```

### TCP Evasion Testing
To perform a 3-way handshake followed by forwarding traffic in ordered 1-byte segments to test IDS reassembly:
```bash
fragrouter -i eth0 -T1
```

### Testing Against Specific Known Vulnerabilities
To simulate the Windows NT 4 SP2 fragmentation behavior:
```bash
fragrouter -M1
```

## Complete Command Reference

```bash
fragrouter [-i interface] [-p] [-g hop] [-G hopcount] ATTACK
```

### Global Options

| Flag | Description |
|------|-------------|
| `-i <interface>` | Specify the network interface to use (e.g., eth0). |
| `-p` | Preserve the source address in forwarded packets. |
| `-g <hop>` | Specify a gateway hop for loose source routing. |
| `-G <hopcount>` | Specify the hop count for source routing. |

### Attack Modules (ATTACK)

#### IP Fragmentation (frag)
| Flag | Description |
|------|-------------|
| `-B1` | **base-1**: Normal IP forwarding (no fragmentation). |
| `-F1` | **frag-1**: Ordered 8-byte IP fragments. |
| `-F2` | **frag-2**: Ordered 24-byte IP fragments. |
| `-F3` | **frag-3**: Ordered 8-byte IP fragments, one out of order. |
| `-F4` | **frag-4**: Ordered 8-byte IP fragments, one duplicate. |
| `-F5` | **frag-5**: Out of order 8-byte fragments, one duplicate. |
| `-F6` | **frag-6**: Ordered 8-byte fragments, marked last frag first. |
| `-F7` | **frag-7**: Ordered 16-byte fragments, forward-overwriting. |

#### TCP Evasion (tcp)
| Flag | Description |
|------|-------------|
| `-T1` | **tcp-1**: 3-whs, bad TCP checksum FIN/RST, ordered 1-byte segments. |
| `-T3` | **tcp-3**: 3-whs, ordered 1-byte segments, one duplicate. |
| `-T4` | **tcp-4**: 3-whs, ordered 1-byte segments, one overwriting. |
| `-T5` | **tcp-5**: 3-whs, ordered 2-byte segments, forward-overwriting. |
| `-T7` | **tcp-7**: 3-whs, ordered 1-byte segments, interleaved null segments. |
| `-T8` | **tcp-8**: 3-whs, ordered 1-byte segments, one out of order. |
| `-T9` | **tcp-9**: 3-whs, out of order 1-byte segments. |

#### TCP Connection Brokering (tcbc)
| Flag | Description |
|------|-------------|
| `-C2` | **tcbc-2**: 3-whs, ordered 1-byte segments, interleaved SYNs. |
| `-C3` | **tcbc-3**: Ordered 1-byte null segments, 3-whs, ordered 1-byte segments. |

#### TCP Blind Trust (tcbt)
| Flag | Description |
|------|-------------|
| `-R1` | **tcbt-1**: 3-whs, RST, 3-whs, ordered 1-byte segments. |

#### TCP Insertion (ins)
| Flag | Description |
|------|-------------|
| `-I2` | **ins-2**: 3-whs, ordered 1-byte segments, bad TCP checksums. |
| `-I3` | **ins-3**: 3-whs, ordered 1-byte segments, no ACK set. |

#### Miscellaneous (misc)
| Flag | Description |
|------|-------------|
| `-M1` | **misc-1**: Windows NT 4 SP2 evasion (ntfrag). |
| `-M2` | **misc-2**: Linux IP chains evasion. |

## Notes
- **Routing**: Fragrouter must be positioned between the attacker and the victim. You may need to enable IP forwarding on the host or configure the attacker's routing table to use the fragrouter host as the gateway to the victim.
- **Root Privileges**: This tool requires root privileges to capture and inject raw packets.
- **Scope**: Fragrouter is intended for testing and authorized security auditing only. Use in unauthorized environments is strictly prohibited.