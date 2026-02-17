---
name: iaxflood
description: Perform UDP Inter-Asterisk eXchange (IAX) flooding attacks against VoIP infrastructure. Use when testing the resilience of Asterisk IP PBX systems to DoS conditions or evaluating how VoIP gateways handle malformed or high-volume IAX traffic.
---

# iaxflood

## Overview
iaxflood is a specialized VoIP stress-testing tool that sends a stream of UDP packets containing a captured IAX payload. Because the payload resembles legitimate Inter-Asterisk eXchange traffic, it can force an Asterisk PBX to perform more intensive processing than a generic UDP flood, potentially leading to resource exhaustion. Category: Vulnerability Analysis / VoIP Testing.

## Installation (if not already installed)
Assume iaxflood is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install iaxflood
```

## Common Workflows

### Basic DoS Test
Flood a target PBX with a specific number of packets to test its handling of IAX traffic spikes.
```bash
iaxflood 192.168.1.202 192.168.1.1 500
```

### High Volume Stress Test
Send a large volume of packets to evaluate the impact on call quality or system availability.
```bash
iaxflood 10.0.0.5 10.0.0.10 1000000
```

## Complete Command Reference

```bash
iaxflood <sourcename> <destinationname> <numpackets>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `sourcename` | The source IP address to spoof or use for the attack. |
| `destinationname` | The target IP address (typically an Asterisk PBX). |
| `numpackets` | The total number of IAX packets to send. |

## Notes
- **Port Usage**: The tool defaults to flooding port **4569** (the standard IAX port) from source port **4569**.
- **Payload**: The tool uses a static payload captured from a real IAX channel between two Asterisk servers.
- **Privileges**: This tool requires raw socket access to craft IP headers; it must typically be run as `root` or with `sudo`.
- **Effectiveness**: While the IAX header might not perfectly match the specific version or configuration of the target PBX, the payload structure is designed to trigger deeper packet inspection/processing than a null-payload UDP flood.