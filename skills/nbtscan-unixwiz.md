---
name: nbtscan-unixwiz
description: Scan local or remote TCP/IP networks for open NetBIOS name servers to identify Windows shares, computer names, and workgroups. Use when performing internal network reconnaissance, identifying SMB/NetBIOS services, or mapping Windows-based infrastructure during penetration testing.
---

# nbtscan-unixwiz

## Overview
A command-line tool that scans for open NetBIOS nameservers on a network. It functions similarly to the standard Windows `nbtstat` tool but is designed to operate efficiently over ranges of IP addresses. It is a primary step in discovering open SMB shares and identifying host information in Windows environments. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install nbtscan-unixwiz
```

## Common Workflows

### Scan an IP Range
Scan a specific range of addresses to identify NetBIOS-enabled hosts:
```bash
nbtscan-unixwiz 192.168.1.1-254
```

### Detailed Host Enumeration
Get full resource record responses (including service types and MAC addresses) for a specific target:
```bash
nbtscan-unixwiz -f 192.168.1.50
```

### Fast Network Discovery
Scan a CIDR range without performing inverse DNS lookups to speed up the process:
```bash
nbtscan-unixwiz -n 10.0.0.0/24
```

### Scripting Integration
Generate results in a Perl hashref format for programmatic processing:
```bash
nbtscan-unixwiz -P 192.168.1.0/24 > results.pl
```

## Complete Command Reference

```
nbtscan-unixwiz [options] target [targets...]
```

### Target Specification
Targets can be provided as:
- Individual IP addresses (e.g., `192.168.1.1`)
- DNS names (e.g., `fileserver.local`)
- CIDR notation (e.g., `192.168.12.0/24`)
- Range in the last octet (e.g., `192.168.12.64-97`)

### Options

| Flag | Description |
|------|-------------|
| `-V` | Show version information |
| `-f` | Show Full NBT resource record responses (Recommended for detailed info) |
| `-H` | Generate HTTP headers |
| `-v` | Turn on more verbose debugging |
| `-n` | No looking up inverse names of IP addresses responding |
| `-p <n>` | Bind to UDP Port `<n>` (default=0) |
| `-m` | Include MAC address in response (implied by `-f`) |
| `-T <n>` | Timeout the no-responses in `<n>` seconds (default=2 secs) |
| `-w <n>` | Wait `<n>` msecs after each write (default=10 ms) |
| `-t <n>` | Try each address `<n>` tries (default=1) |
| `-P` | Generate results in Perl hashref format |

## Notes
- NetBIOS often uses UDP port 137. If a firewall blocks this port, `nbtscan-unixwiz` will not return results.
- The `-f` flag is highly recommended as it decodes the NetBIOS suffixes (e.g., `<20>` for File Server Service), which helps identify the role of the machine.
- MAC addresses returned as `00:00:00:00:00:00` usually indicate the target is on a different subnet or the information was not provided in the NetBIOS response.