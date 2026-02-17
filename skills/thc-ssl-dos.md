---
name: thc-ssl-dos
description: Stress test and verify the performance of SSL/TLS services by exploiting the asymmetric processing power required for handshakes. Use when performing vulnerability analysis, web application stress testing, or demonstrating Denial of Service (DoS) potential via SSL/TLS renegotiation or handshake exhaustion.
---

# thc-ssl-dos

## Overview
THC-SSL-DOS is a tool designed to verify the performance of SSL implementations. It exploits the fact that establishing a secure SSL connection requires significantly more processing power (approx. 15x) on the server side than on the client side. It can trigger thousands of renegotiations within a single TCP connection to overload the target server. Category: Vulnerability Analysis / Web Application Testing.

## Installation (if not already installed)
Assume the tool is already installed. If missing:

```bash
sudo apt install thc-ssl-dos
```

Dependencies: libc6, libpcap0.8t64, libssl3t64, openssl.

## Common Workflows

### Basic Stress Test
Flood a target web server with default settings to test SSL handshake resilience:
```bash
thc-ssl-dos 192.168.1.208 443 --accept
```

### High Concurrency Attack
Use 100 concurrent connections to increase the load on the target:
```bash
thc-ssl-dos -l 100 192.168.1.208 443 --accept
```

### Testing SMTPS (Mail Server)
Targeting SSL-enabled mail services on port 465:
```bash
thc-ssl-dos 192.168.1.208 465 --accept
```

## Complete Command Reference

```
thc-ssl-dos [options] <target> <port>
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Display the help screen and usage information. |
| `-l <count>` | Limit the number of parallel connections (default: 400). |
| `--accept` | Automatically accept the terms of use (required for non-interactive execution). |
| `--skip-renegotiation` | Do not attempt SSL renegotiation; only perform new handshakes. |

## Notes
- **Asymmetry**: The attack is effective because the server performs a heavy RSA decryption while the client performs a light RSA encryption.
- **Renegotiation**: Many modern servers have disabled client-initiated renegotiation to mitigate this specific attack. If the attack fails, try using the `--skip-renegotiation` flag to fall back to standard handshake exhaustion.
- **Legal Warning**: This tool is for testing and educational purposes only. Unauthorized use against third-party infrastructure is illegal.
- **Performance**: The tool will display real-time statistics including Handshakes per second (h/s), active Connections (Conn), and Errors (Err).