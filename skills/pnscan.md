---
name: pnscan
description: Perform high-speed multithreaded TCP port scanning and service banner grabbing across large networks. Use when rapid port discovery is required, or when searching for specific service strings/banners across CIDR ranges or host lists where nmap might be too slow.
---

# pnscan

## Overview
Pnscan is a specialized multithreaded TCP port scanner designed for speed. While it lacks the extensive feature set of nmap, it excels at scanning large network ranges very quickly to identify open ports and verify service responses using string or hex matching. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume pnscan is already installed. If the command is missing:

```bash
sudo apt install pnscan
```

## Common Workflows

### Scan a CIDR range for a specific port
```bash
pnscan 192.168.1.0/24 80
```

### Search for a specific banner (e.g., SSH version)
```bash
pnscan -r "SSH-2.0" 10.0.0.0/16 22
```

### Send a request and wait for a specific hex response
```bash
pnscan -W "50494e47" -R "504f4e47" 172.16.0.0/24 1234
```

### High-concurrency scan with hostnames and line-oriented output
```bash
pnscan -s -l -n 1000 192.168.0.0/16 443
```

## Complete Command Reference

```
pnscan [<options>] [{<CIDR>|<host-range> <port-range>} | <service>]
```

### Command Line Options

| Flag | Description |
|------|-------------|
| `-h` | Display help information |
| `-V` | Print version |
| `-v` | Be verbose |
| `-d` | Print debugging info |
| `-s` | Lookup and print hostnames for discovered IPs |
| `-i` | Ignore case when scanning/matching responses |
| `-S` | Enable shutdown mode |
| `-l` | Line oriented output (easier for parsing with grep/awk) |
| `-w<string>` | Request string to send to the port upon connection |
| `-W<hex list>` | Hex coded request string to send (e.g., `-W"48656c6c6f"`) |
| `-r<string>` | Response string to look for in the service banner |
| `-R<hex list>` | Hex coded response string to look for |
| `-L<length>` | Max bytes of the response to print |
| `-t<msecs>` | Connect/Write/Read timeout in milliseconds |
| `-n<workers>` | Concurrent worker threads limit (default varies by system) |

### Argument Formats
- **CIDR**: `192.168.1.0/24`
- **Host Range**: `192.168.1.1 192.168.1.254`
- **Port Range**: A single port (e.g., `80`) or a service name from `/etc/services`.

## Notes
- Pnscan is significantly faster than nmap for simple "port open" checks but does not perform OS fingerprinting or complex script scanning.
- Use the `-n` flag to increase concurrency for very large networks, but be mindful of local system resources and network congestion.
- The `-S` (shutdown mode) is useful for certain protocols that require the client to close the write-half of the connection before sending a response.