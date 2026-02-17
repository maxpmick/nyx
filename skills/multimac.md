---
name: multimac
description: Create and manage multiple virtual ethernet tap interfaces with unique MAC addresses on a single physical network adapter. Use when performing network testing, emulating multiple hosts on a LAN, bypassing MAC-based filtering, or conducting security research that requires multiple distinct network identities from one machine.
---

# multimac

## Overview
Multimac is a Linux virtual ethernet tap allocator designed to emulate and use multiple virtual interfaces on a LAN using a single physical network adapter. Each tap interface is assigned a different MAC address, allowing a single machine to appear as multiple distinct devices on the network. Category: Sniffing & Spoofing / Network Testing.

## Installation (if not already installed)
Assume multimac is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install multimac
```

## Common Workflows

### Create multiple virtual interfaces
To create 5 virtual tap interfaces on the current system:
```bash
sudo multimac 5
```

### Verify created interfaces
After running multimac, check the newly created `tap` interfaces using `ip` or `ifconfig`:
```bash
ip link show
```

### Configure a specific tap interface
Once the taps are created, you can bring them up and assign IP addresses like any other interface:
```bash
sudo ip link set tap0 up
sudo dhclient tap0
```

## Complete Command Reference

```bash
multimac <number of taps>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<number of taps>` | The integer number of virtual ethernet tap interfaces to allocate and create. |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the usage help message. |

## Notes
- This tool requires root privileges to create and manage network interfaces.
- The created interfaces are typically named `tap0`, `tap1`, etc.
- This is particularly useful for testing DHCP server exhaustion, VLAN tagging across multiple virtual hosts, or simulating a populated network environment for IDS/IPS testing.
- Ensure your physical network adapter is in a state that supports multiple MAC addresses (promiscuous mode may be required depending on the environment).