---
name: httprint
description: Fingerprint web servers to identify their make and version even when server banners are hidden or obfuscated. Use during web application testing and reconnaissance to identify underlying technologies, detect web-enabled devices (routers, switches, APs), and bypass security plugins like mod_security or ServerMask.
---

# httprint

## Overview
httprint is a specialized web server fingerprinting tool that relies on unique server characteristics rather than just the "Server" banner string. It can accurately identify web servers that have been obfuscated or have had their banners removed. It is also effective for identifying embedded web servers in hardware devices. Category: Web Application Testing / Reconnaissance.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing, use:

```bash
sudo apt update && sudo apt install httprint
```

## Common Workflows

### Basic Fingerprinting
Identify a single host using the default signature file:
```bash
httprint -h http://www.example.com -s /usr/share/httprint/signatures.txt
```

### Scanning an IP Range with HTML Output
Fingerprint a range of IP addresses and save the results to an HTML report:
```bash
httprint -h 192.168.1.1-192.168.1.254 -s signatures.txt -o report.html
```

### Importing Nmap Results
Use an Nmap XML output file as the source for targets:
```bash
httprint -x nmap_results.xml -s signatures.txt -oc results.csv
```

### Stealthy/Custom Fingerprinting
Use a custom User-Agent and disable ICMP pings to be less conspicuous:
```bash
httprint -h 10.0.0.5 -s signatures.txt -ua "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -P0
```

## Complete Command Reference

### Target Selection (One Required)

| Flag | Description |
|------|-------------|
| `-h <host>` | Target host: IP address, symbolic name, IP range, or URL. |
| `-i <input file>` | Text file containing a list of hosts (one per line). |
| `-x <nmap xml file>` | Nmap XML output file (`-oX`). Ports are filtered via `nmapportlist.txt`. |

### Required Signature Option

| Flag | Description |
|------|-------------|
| `-s <signatures>` | Path to the file containing http fingerprint signatures. |

### Output Options

| Flag | Description |
|------|-------------|
| `-o <output file>` | Save output in HTML format. |
| `-oc <output file>` | Save output in CSV format. |
| `-ox <output file>` | Save output in XML format. |

### Performance and Connection Options

| Flag | Description |
|------|-------------|
| `-noautossl` | Disable automatic detection of SSL. |
| `-tp <ping timeout>` | Ping timeout in milliseconds (Default: 4000, Max: 30000). |
| `-ct <1-100>` | Confidence threshold (Default: 75). Do not change unless necessary. |
| `-ua <User Agent>` | Set custom User Agent string. |
| `-t <timeout>` | Connection/read timeout in milliseconds (Default: 10000, Max: 100000). |
| `-r <retry>` | Number of retries (Default: 3, Max: 30). |
| `-P0` | Turn ICMP ping off (useful if ICMP is blocked). |
| `-nr` | No redirection. Do not follow 301/302 responses (Enabled by default). |
| `-th <threads>` | Number of concurrent threads (Default: 8, Max: 64). |
| `-?` | Displays the help message. |

## Notes
- The signature file is critical for accuracy. On Kali, signatures are often located in `/usr/share/httprint/` or the current working directory.
- Use `-P0` if the target environment blocks ICMP, otherwise httprint might report the host as down.
- When using `-x` (Nmap XML), httprint relies on `nmapportlist.txt` to decide which ports to probe for HTTP services.