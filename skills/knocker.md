---
name: knocker
description: Perform TCP port scanning to identify open ports and network services on a target host. Use when a simple, lightweight, multithreaded TCP scanner is needed for reconnaissance or vulnerability analysis to map out available services on a specific IP or hostname.
---

# knocker

## Overview
Knocker is a simple and easy-to-use TCP security port scanner written in C using threads. It is designed to analyze hosts and the network services running on them by attempting to establish TCP connections. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume knocker is already installed. If you get a "command not found" error:

```bash
sudo apt install knocker
```

## Common Workflows

### Scan a single port
```bash
knocker --host 192.168.1.1 --port 80
```

### Scan a range of ports
```bash
knocker -H 192.168.1.1 -SP 1 -EP 1024
```

### Quiet scan with logging
```bash
knocker -H example.com -SP 1 -EP 100 -q -lf scan_results.log
```

### Repeat the last scan performed
```bash
knocker --last-scan
```

## Complete Command Reference

```
knocker --host <HOST> [OPTIONS]
```

### Required Options
One of the following must be provided to specify the target:

| Flag | Description |
|------|-------------|
| `-H`, `--host <HOST>` | Host name or numeric Internet address to scan |
| `--last-host` | Use the host name from the last performed scan |

### Port Selection Options
If `-SP` is specified, `-EP` must also be provided.

| Flag | Description |
|------|-------------|
| `-P`, `--port <PORT>` | Single port number (for one port scans only) |
| `-SP`, `--start-port <PORT>` | Port number to begin the scan from |
| `-EP`, `--end-port <PORT>` | Port number to end the scan at |
| `--last-scan` | Performs the last port scan configuration again |

### Extra Options

| Flag | Description |
|------|-------------|
| `-4`, `--ipv4` | Use only IPv4 host addressing |
| `-6`, `--ipv6` | Use only IPv6 host addressing |
| `-q`, `--quiet` | Quiet mode: suppresses console output and logs results to a file |
| `-lf`, `--logfile <file>` | Log scan results to the specified file |
| `-nf`, `--no-fency` | Disable fancy output formatting |
| `-nc`, `--no-colors` | Disable colored output |
| `--configure` | Enter the configuration wizard for knocker |

### Info Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display help message and exit |
| `-v`, `--version` | Output version information and exit |

## Notes
- Knocker is a "connect" scanner; it completes the TCP three-way handshake, which is more easily detected by firewalls and IDS compared to SYN "stealth" scans.
- The tool is multithreaded for increased performance during range scans.