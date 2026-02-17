---
name: netmask
description: Generate and convert network masks, IP ranges, and CIDR notations. Use when calculating network boundaries, converting between IP formats (CIDR, Cisco wildcard, hex, binary), or determining the smallest set of masks for a range of hosts during network reconnaissance or firewall configuration.
---

# netmask

## Overview
A utility for address netmask generation and conversion. It helps determine the smallest set of network masks to specify a range of hosts and converts between various IP address and netmask formats. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume netmask is already installed. If you get a "command not found" error:

```bash
sudo apt install netmask
```

## Common Workflows

### Convert a range to CIDR notation
```bash
netmask -c 192.168.1.0:192.168.1.100
```

### Convert CIDR to Cisco-style wildcard masks
```bash
netmask -i 10.0.0.0/24
```

### Get the IP range from a subnet
```bash
netmask -r 172.16.0.0/12
```

### Convert a hostname to binary representation
```bash
netmask -b google.com
```

## Complete Command Reference

```
netmask [options] spec [spec ...]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print a summary of the options |
| `-v`, `--version` | Print the version number |
| `-d`, `--debug` | Print status/progress information |
| `-s`, `--standard` | Output address/netmask pairs (default) |
| `-c`, `--cidr` | Output CIDR format address lists |
| `-i`, `--cisco` | Output Cisco style address lists (wildcard masks) |
| `-r`, `--range` | Output IP address ranges |
| `-x`, `--hex` | Output address/netmask pairs in hex |
| `-o`, `--octal` | Output address/netmask pairs in octal |
| `-b`, `--binary` | Output address/netmask pairs in binary |
| `-n`, `--nodns` | Disable DNS lookups for addresses |
| `-f`, `--files` | Treat arguments as input files containing specs |

### Definitions

#### Spec Formats
A `spec` can be any of the following:
- `address`: A single host or network
- `address:address`: A range from the first address to the second address
- `address:+address`: A range starting at the first address and extending for the number of hosts specified by the second address
- `address/mask`: An address with a specific bitmask

#### Address Formats
An `address` can be any of the following:
- `N`: Decimal number
- `0N`: Octal number
- `0xN`: Hex number
- `N.N.N.N`: Dotted quad (standard IP notation)
- `hostname`: DNS domain name (resolved unless `-n` is used)

#### Mask Format
- A `mask` is the number of bits set to one from the left (e.g., `24` for `255.255.255.0`).

## Notes
- The tool is particularly useful for shell scripting when automating firewall rule generation.
- When using ranges (`address:address`), netmask will find the most efficient (smallest) set of CIDR blocks to cover that exact range.