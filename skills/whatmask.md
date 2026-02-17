---
name: whatmask
description: Convert between various subnet mask notations and calculate network range details. Use when performing network reconnaissance, planning IP address schemes, or identifying network boundaries, broadcast addresses, and usable IP ranges from CIDR, hex, or wildcard notations.
---

# whatmask

## Overview
Whatmask is a C-based utility for network configuration and subnet mask conversion. It helps security professionals and administrators translate between different subnet mask formats and calculate essential network parameters like network/broadcast addresses and usable host ranges. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume whatmask is already installed. If you get a "command not found" error:

```bash
sudo apt install whatmask
```

## Common Workflows

### Convert a subnet mask notation
Quickly see the equivalent CIDR, dotted-decimal, hex, and wildcard notations for a mask.
```bash
whatmask 255.255.255.224
```

### Calculate network details from an IP and CIDR
Identify the network address, broadcast address, and usable range for a specific host.
```bash
whatmask 192.168.1.45/27
```

### Calculate network details using hex mask
Useful when analyzing output from tools like `ifconfig` that may provide masks in hexadecimal.
```bash
whatmask 10.0.0.15/0xffffff00
```

### Determine usable hosts from wildcard bits
Commonly used for interpreting Cisco ACLs or OSPF configurations.
```bash
whatmask 0.0.0.63
```

## Complete Command Reference

### Usage
```bash
whatmask <netmask or ip/netmask>
```

### Operation Modes

#### Mode 1: Subnet Mask Conversion
Invoke with only a subnet mask as the argument. Whatmask will return the mask in four formats plus the number of usable addresses.
Supported input formats:
- **CIDR**: e.g., `/24` or `24`
- **Netmask (Dotted Decimal)**: e.g., `255.255.255.0`
- **Netmask (Hex)**: e.g., `0xffffff00`
- **Wildcard Bits**: e.g., `0.0.0.255`

#### Mode 2: Network Information Calculation
Invoke with an IP address followed by a slash (`/`) and a subnet mask in any of the formats listed above.
**Note:** Do not include spaces in the argument.

**Output provided in Mode 2:**
- **CIDR notation**
- **Netmask** (Dotted Decimal)
- **Netmask (Hex)**
- **Wildcard Bits**
- **Network Address**
- **Broadcast Address**
- **Number of Usable IP Addresses**
- **First Usable IP Address**
- **Last Usable IP Address**

## Notes
- **Broadcast Assumption**: Whatmask assumes the broadcast address is the highest address in the subnet (the standard configuration).
- **Usable IPs**: The count of usable IP addresses excludes the network and broadcast addresses.
- **No Flags**: This tool does not use traditional command-line flags (like `-v` or `-h`); it relies entirely on the positional argument provided.