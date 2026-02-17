---
name: tlssled
description: Evaluate the security of a target SSL/TLS (HTTPS) web server implementation. Use when performing web application testing, infrastructure reconnaissance, or vulnerability analysis to identify weak ciphers, SSLv2 support, MD5 signatures, and renegotiation capabilities.
---

# tlssled

## Overview
TLSSLed is a Linux shell script used to evaluate the security of a target SSL/TLS (HTTPS) web server. It acts as a wrapper for `sslscan` and `openssl s_client` to automate the detection of insecure configurations. Category: Reconnaissance / Information Gathering, Web Application Testing.

## Installation (if not already installed)
Assume tlssled is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install tlssled
```

Dependencies: openssl, sslscan.

## Common Workflows

### Basic SSL/TLS Security Audit
Perform a standard security evaluation of a web server on the default HTTPS port:
```bash
tlssled 192.168.1.1 443
```

### Audit Alternative Port
Evaluate a service running SSL/TLS on a non-standard port (e.g., 8443):
```bash
tlssled example.com 8443
```

### Automated Analysis
The tool creates a timestamped output directory (e.g., `TLSSLed_1.3_hostname_port_date`) containing the raw results of the following checks:
1. SSLv2 protocol support
2. NULL cipher support
3. Weak ciphers (40 or 56 bits)
4. Strong cipher availability (e.g., AES)
5. Digital certificate signature algorithm (checking for MD5)
6. SSL/TLS renegotiation capabilities

## Complete Command Reference

```bash
tlssled <hostname or IP_address> <port>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<hostname or IP_address>` | The target server to be scanned (e.g., 10.0.0.5 or example.com) |
| `<port>` | The destination port where the SSL/TLS service is listening (e.g., 443, 8443, 465) |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help message and version information |

## Notes
- TLSSLed is a wrapper script; ensure `sslscan` is installed and functional for the script to provide full output.
- The tool automatically creates a directory in the current working directory to store the scan results.
- It relies on the local `openssl` library version; some checks may be limited by the capabilities of the installed OpenSSL version (e.g., if the library has disabled SSLv2 support entirely).