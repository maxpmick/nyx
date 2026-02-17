---
name: ssldump
description: Analyze and decode SSLv3/TLS network traffic on a live interface or from a pcap file. Use when performing network reconnaissance, web application security testing, or troubleshooting encrypted connections. It can decrypt application data when provided with the appropriate RSA private keys or SSLKEYLOGFILE.
---

# ssldump

## Overview
ssldump is an SSLv3/TLS network protocol analyzer that identifies, decodes, and optionally decrypts encrypted traffic. Based on tcpdump, it acts as a specialized sniffer for security professionals to inspect handshake messages and application data. Category: Reconnaissance / Information Gathering, Web Application Testing.

## Installation (if not already installed)
Assume ssldump is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install ssldump
```

## Common Workflows

### Monitor live SSL traffic on an interface
```bash
ssldump -i eth0
```

### Decrypt traffic using a private key
```bash
ssldump -r traffic.pcap -k server.key
```

### Decrypt using an SSLKEYLOGFILE (modern TLS)
```bash
ssldump -r traffic.pcap -l sslkeylog.txt
```

### Display decoded application data and certificates
```bash
ssldump -Ad -n -i wlan0
```

## Complete Command Reference

```
ssldump [-r dumpfile] [-i interface] [-l sslkeylogfile] [-w outpcapfile]
        [-k keyfile] [-p password] [-vtaTznsAxVNde]
        [filter]
```

### Primary Input/Output Options

| Flag | Description |
|------|-------------|
| `-i <interface>` | Listen on the specified network interface (e.g., eth0). |
| `-r <dumpfile>` | Read data from a pcap file instead of a live interface. |
| `-l <sslkeylogfile>` | Use an SSLKEYLOGFILE (NSS key log format) to decrypt TLS traffic. |
| `-w <outpcapfile>` | Write the captured packets to a pcap file. |
| `-k <keyfile>` | Specify the RSA private key file (PEM format) for decryption. |
| `-p <password>` | Provide the password for an encrypted RSA private key file. |

### Display and Decoding Options

| Flag | Description |
|------|-------------|
| `-v` | Verbose output; display the entire certificate and handshake details. |
| `-t` | Print a timestamp at the beginning of each line. |
| `-a` | Flag TCP ACK and FIN packets (useful for tracking connection state). |
| `-T` | Print the TCP banners. |
| `-z` | Print the TCP timestamps. |
| `-n` | Do not resolve hostnames (show IP addresses instead). |
| `-s` | Print the SSL session state (Session IDs, etc.). |
| `-A` | Print all record fields (not just the interesting ones). |
| `-x` | Print each record in hex format. |
| `-V` | Print version information and exit. |
| `-N` | Attempt to parse and display certificates. |
| `-d` | Decrypt and display the application data (requires `-k` or `-l`). |
| `-e` | Print absolute timestamps. |

### Filter
The `[filter]` argument follows the standard `tcpdump` (BPF) filter syntax. For example, `port 443` or `host 192.168.1.1`.

## Notes
- Decryption only works for RSA key exchanges unless an `SSLKEYLOGFILE` is provided. Diffie-Hellman (PFS) suites require the session secrets from the key log file.
- ssldump must be run with sufficient privileges (e.g., `sudo`) to capture live traffic from a network interface.
- If the tool is used on a high-traffic interface, use BPF filters to limit the scope to specific IPs or ports to avoid packet loss.