---
name: siparmyknife
description: Perform vulnerability fuzzing against SIP (Session Initiation Protocol) devices and services. Use when testing VoIP infrastructure for vulnerabilities such as cross-site scripting (XSS), SQL injection, log injection, format strings, and buffer overflows during vulnerability analysis or penetration testing.
---

# siparmyknife

## Overview
SIP Army Knife is a specialized fuzzer designed to identify security vulnerabilities in SIP-based systems. It targets common flaw categories including injection attacks and memory corruption issues. Category: Vulnerability Analysis / VoIP.

## Installation (if not already installed)
Assume siparmyknife is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install siparmyknife
```

Dependencies: libdigest-crc-perl, libdigest-md4-perl, libio-socket-ip-perl, libsocket-perl, perl.

## Common Workflows

### Basic Fuzzing against a SIP Proxy
```bash
siparmyknife -s 192.168.1.100 -p 5060
```

### Targeted Fuzzing with a specific User-Agent
```bash
siparmyknife -s 192.168.1.100 -u "Cisco-CP7960G"
```

### Fuzzing a specific SIP Extension/User
```bash
siparmyknife -s 192.168.1.100 -e 1001
```

## Complete Command Reference

```
siparmyknife [Options]
```

| Flag | Description |
|------|-------------|
| `-s <ip>` | Target SIP server IP address |
| `-p <port>` | Target SIP server port (default is 5060) |
| `-u <string>` | Specify a custom User-Agent string to use in requests |
| `-e <extension>` | Specify a target extension or username |
| `-v` | Enable verbose output for debugging |
| `--help` | Display the help reference and usage information |

## Notes
- This tool is designed for security testing and can cause SIP services to crash or become unresponsive during fuzzing.
- Ensure you have authorization before testing VoIP infrastructure, as fuzzing can disrupt active telecommunications.
- The tool searches for:
    - Cross-Site Scripting (XSS)
    - SQL Injection
    - Log Injection
    - Format Strings
    - Buffer Overflows