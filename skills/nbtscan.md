---
name: nbtscan
description: Scan IP networks for NetBIOS name information including computer names, logged-in users, and MAC addresses. Use when performing internal network discovery, identifying Windows hosts, conducting security checks, or gathering NetBIOS reconnaissance during penetration testing and forensic investigations.
---

# nbtscan

## Overview
NBTscan is a specialized tool for scanning IP networks for NetBIOS name information. It sends NetBIOS status queries to each address in a supplied range and lists received information (IP, NetBIOS name, User, MAC address) in a human-readable or script-friendly form. Category: Reconnaissance / Information Gathering, Vulnerability Analysis.

## Installation (if not already installed)
Assume nbtscan is already installed. If the command is missing:

```bash
sudo apt install nbtscan
```

## Common Workflows

### Scan a local subnet using local port 137
Required for identifying older Windows 95 boxes and often more reliable for internal discovery.
```bash
sudo nbtscan -r 192.168.1.0/24
```

### Verbose enumeration with human-readable services
Displays all names received from each host (including service types) instead of just the primary name.
```bash
nbtscan -v -h 192.168.1.0/24
```

### Script-friendly output for automation
Uses a custom separator (colon) and suppresses headers for easy parsing by other tools.
```bash
nbtscan -v -s : 192.168.1.50-100
```

### Scanning from a target list
```bash
nbtscan -f targets.txt
```

## Complete Command Reference

```bash
nbtscan [Options] (-f filename)|(<scan_range>)
```

### Options

| Flag | Description |
|------|-------------|
| `-v` | **Verbose output.** Print all names received from each host. |
| `-d` | **Dump packets.** Print the entire contents of the packets received. |
| `-e` | **Format output in `/etc/hosts` format.** |
| `-l` | **Format output in `lmhosts` format.** Cannot be used with `-v`, `-s`, or `-h`. |
| `-t <timeout>` | **Wait timeout.** Time in milliseconds to wait for a response (Default: 1000). |
| `-b <bandwidth>` | **Output throttling.** Limit bandwidth usage (bps). Useful for slow links to prevent dropped queries. |
| `-r` | **Use local port 137.** Required for Win95 boxes. Requires root privileges on Unix/Linux. |
| `-q` | **Quiet mode.** Suppress banners and error messages. |
| `-s <separator>` | **Script-friendly output.** Disables headers and separates fields with the specified character. |
| `-h` | **Human-readable services.** Prints descriptive names for services. Only works with `-v`. |
| `-m <retransmits>` | **Retransmits.** Number of times to re-send a query (Default: 0). |
| `-f <filename>` | **Input file.** Read IP addresses to scan from a file. Use `-f -` to read from stdin. |

### Scan Range Formats
The `<scan_range>` can be provided in two formats:
- **CIDR Notation:** `192.168.1.0/24`
- **Range Notation:** `192.168.1.25-137`

## Notes
- **Root Privileges:** The `-r` flag (using local port 137) requires `sudo` or root access.
- **Network Traffic:** While relatively lightweight, scanning large ranges with high retransmits or low timeouts can be noisy or miss hosts on congested networks. Use `-b` to throttle if necessary.
- **Service Codes:** When using `-v`, NetBIOS suffix codes (like `<00>`, `<20>`) indicate the type of service (Workstation, Server, Messenger, etc.). Use `-h` to translate these into readable text.