---
name: rtpflood
description: Flood any device processing Real-time Transport Protocol (RTP) traffic. Use when performing VoIP security testing, stress testing RTP endpoints, or simulating denial-of-service (DoS) conditions against media gateways and SIP devices.
---

# rtpflood

## Overview
rtpflood is a command-line utility designed to flood any device that processes RTP traffic. It allows for the manual specification of RTP header parameters, making it useful for testing the resilience of VoIP infrastructure. Category: Vulnerability Analysis / Sniffing & Spoofing.

## Installation (if not already installed)
Assume rtpflood is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install rtpflood
```

## Common Workflows

### Basic RTP Flood
Flood a target device with 1000 RTP packets using specific port configurations and header values:
```bash
rtpflood 192.168.1.202 192.168.1.1 5060 5061 1000 3 123456789 0
```

### High Volume Stress Test
To test the impact of a larger volume of traffic, increase the packet count:
```bash
rtpflood 192.168.1.202 192.168.1.1 5060 5061 100000 1 1000 0
```

## Complete Command Reference

The tool uses positional arguments rather than named flags.

```bash
rtpflood sourcename destinationname srcport destport numpackets seqno timestamp SSID
```

### Arguments

| Argument | Description |
|----------|-------------|
| `sourcename` | The source IP address to spoof or send from |
| `destinationname` | The target IP address of the RTP device |
| `srcport` | The source UDP port |
| `destport` | The destination UDP port (where the device is listening for RTP) |
| `numpackets` | Total number of RTP packets to send |
| `seqno` | The starting RTP Sequence Number for the header |
| `timestamp` | The RTP Timestamp value for the header |
| `SSID` | The Synchronization Source (SSRC) identifier |

## Notes
- This tool requires root privileges to craft raw packets (IP_HDRINCL).
- The `SSID` argument in the usage string refers to the RTP **SSRC** (Synchronization Source identifier), not a wireless network SSID.
- Use with caution: flooding RTP ports can disrupt active voice calls and crash poorly implemented VoIP stacks.