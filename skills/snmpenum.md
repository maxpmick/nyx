---
name: snmpenum
description: Enumerate information from devices running SNMP by dumping specific OID tables based on a configuration file. Use during the reconnaissance or information gathering phase to identify system details, network interfaces, running processes, and software on targets where SNMP community strings are known.
---

# snmpenum

## Overview
A simple Perl script used to enumerate information from machines running SNMP (Simple Network Management Protocol). It utilizes configuration files to map OIDs to human-readable output, allowing for the systematic dumping of SNMP tables. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume snmpenum is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install snmpenum
```

Dependencies: `libnet-snmp-perl`, `perl`.

## Common Workflows

### Enumerate a Windows Host
Using the provided Windows configuration file to gather system information, processes, and users:
```bash
snmpenum 192.168.1.50 public windows.conf
```

### Enumerate a Linux/Unix Host
Using the Linux configuration file to identify network details and system stats:
```bash
snmpenum 192.168.1.55 public linux.conf
```

### Enumerate a Cisco Device
Gathering interface and routing information from a Cisco router:
```bash
snmpenum 10.0.0.1 private cisco.conf
```

## Complete Command Reference

```bash
snmpenum <IP-address> <community> <configfile>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<IP-address>` | The target IP address of the SNMP-enabled device. |
| `<community>` | The SNMP community string (e.g., `public`, `private`). |
| `<configfile>` | The configuration file containing the OIDs to be queried. |

### Configuration Files
The tool relies on configuration files to define what data to extract. Common configuration files are typically located in `/usr/share/snmpenum/` or the current working directory, including:
- `windows.conf`: For Windows-based systems.
- `linux.conf`: For Linux-based systems.
- `cisco.conf`: For Cisco networking equipment.

## Notes
- This tool requires a valid SNMP community string to function.
- If no results are returned, ensure the community string is correct and that the target host allows SNMP queries from your IP.
- You can create custom `.conf` files by following the format of existing ones to query specific OIDs relevant to your target environment.