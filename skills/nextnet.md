---
name: nextnet
description: Discover potential pivot points within internal networks by probing CIDR ranges. Use when performing network reconnaissance, lateral movement planning, or identifying dual-homed hosts and accessible internal infrastructure during penetration testing.
---

# nextnet

## Overview
Nextnet is a pivot point discovery tool written in Go. It is designed to quickly probe a list of networks to identify hosts that may serve as entry points or bridges into other network segments. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume nextnet is already installed. If the command is not found, install it using:

```bash
sudo apt install nextnet
```

## Common Workflows

### Scan a single subnet for pivot points
```bash
nextnet 192.168.1.0/24
```

### Scan multiple CIDR ranges
```bash
nextnet 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16
```

### Scan targets from a file (using xargs)
```bash
cat networks.txt | xargs nextnet
```

## Complete Command Reference

```
Usage: nextnet [cidr] ... [cidr]
```

Probes a list of networks for potential pivot points.

### Options
The current version of `nextnet` primarily relies on positional CIDR arguments.

| Argument | Description |
|----------|-------------|
| `[cidr]` | One or more network ranges in CIDR notation (e.g., 192.168.1.0/24) to probe. |
| `-h`     | Show help message and usage information. |

## Notes
- This tool is particularly useful during the post-exploitation phase to identify where to move next within a compromised environment.
- As a Go-based binary, it is designed for speed and efficiency when scanning large internal address spaces.
- Ensure you have the necessary permissions to probe the target network ranges, as active scanning may be detected by Intrusion Detection Systems (IDS).