---
name: snmp-check
description: Enumerate SNMP devices to extract system information, network configurations, interfaces, routing tables, and active network connections. Use when performing reconnaissance or information gathering against targets with SNMP enabled (typically port 161) to identify host details and internal network topology.
---

# snmp-check

## Overview
snmp-check is an SNMP service enumeration tool that queries SNMP-enabled devices and outputs the gathered data in a human-readable format. It is more structured than standard snmpwalk, making it ideal for penetration testing and systems monitoring. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume snmp-check is already installed. If you encounter a "command not found" error:

```bash
sudo apt install snmpcheck
```

## Common Workflows

### Basic Enumeration
Scan a target using the default community string ("public") and SNMP version 1:
```bash
snmp-check 192.168.1.2
```

### Enumeration with Custom Community and Version
Use a specific community string and SNMP version 2c:
```bash
snmp-check -c private -v 2c 192.168.1.2
```

### Detect Write Access
Check if the community string allows write access to the device:
```bash
snmp-check -w 192.168.1.2
```

### Fast Scan (Disable TCP Enumeration)
Speed up the scan by skipping the enumeration of TCP connections and listening ports:
```bash
snmp-check -d 192.168.1.2
```

## Complete Command Reference

```
Usage: snmp-check [OPTIONS] <target IP address>
```

### Options

| Flag | Description |
|------|-------------|
| `-p`, `--port` | SNMP port. Default port is 161 |
| `-c`, `--community` | SNMP community string. Default is `public` |
| `-v`, `--version` | SNMP version to use (`1`, `2c`). Default is `1` |
| `-w`, `--write` | Detect write access (performs a separate action from enumeration) |
| `-d`, `--disable_tcp` | Disable TCP connections enumeration |
| `-t`, `--timeout` | Timeout in seconds. Default is 5 |
| `-r`, `--retries` | Number of request retries. Default is 1 |
| `-i`, `--info` | Show script version |
| `-h`, `--help` | Show help menu |

## Notes
- SNMP version 3 is not supported by this tool; use `snmpwalk` for v3 requirements.
- The tool extracts a wide variety of data including:
    - System information (Hostname, Description, Uptime)
    - Network interfaces and IP addresses
    - Routing information
    - TCP connections and listening ports
    - Listening UDP ports
- If no community string is provided, it defaults to `public`, which is a common security misconfiguration.