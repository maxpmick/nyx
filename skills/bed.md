---
name: bed
description: A network protocol fuzzer designed to check daemons for potential security vulnerabilities such as buffer overflows and format string bugs. Use when performing vulnerability analysis, protocol fuzzing, or stress testing network services like HTTP, FTP, SMTP, and IMAP during penetration testing.
---

# bed

## Overview
BED (Bruteforce Exploit Detector) is a network protocol fuzzer written in Perl. It is designed to find vulnerabilities in network daemons by sending malformed data to identify potential buffer overflows, format string vulnerabilities, and other memory corruption issues. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume bed is already installed. If you get a "command not found" error:

```bash
sudo apt install bed
```

Dependencies: perl.

## Common Workflows

### Fuzzing an HTTP server
Basic fuzzing of a web server on the default port with a 2-second timeout between tests.
```bash
bed -s HTTP -t 192.168.1.15
```

### Fuzzing an FTP server with custom port
Testing an FTP service running on a non-standard port.
```bash
bed -s FTP -t 192.168.1.15 -p 2121
```

### Discovering plugin-specific requirements
Each protocol plugin may require additional parameters (like usernames or directories). Use this to see what is needed.
```bash
bed -s IMAP
```

## Complete Command Reference

```
bed -s <plugin> -t <target> -p <port> -o <timeout> [plugin-specific options]
```

### General Options

| Flag | Description |
|------|-------------|
| `-s <plugin>` | **Mandatory.** The protocol plugin to use. Supported: FTP, SMTP, POP, HTTP, IRC, IMAP, PJL, LPD, FINGER, SOCKS4, SOCKS5 |
| `-t <target>` | Host to check (default: localhost) |
| `-p <port>` | Port to connect to (default: standard port for the selected protocol) |
| `-o <timeout>` | Seconds to wait after each test (default: 2 seconds) |
| `-h` | Display help message |

### Plugin-Specific Parameters
To see the specific requirements for a plugin, run `bed -s <plugin>`. Common requirements include:

*   **HTTP**: Requires no additional parameters, but `-u` can sometimes be used for a specific URL.
*   **FTP/POP/IMAP**: Often requires a valid username to reach specific command states.
*   **IRC**: May require a nickname or channel.

## Notes
*   BED is a "dumb" fuzzer; it sends predefined sets of malformed strings rather than generating them based on protocol state machine analysis.
*   **Warning**: This tool is designed to crash services. Do not use it on production systems without authorization, as it will likely cause a Denial of Service (DoS).
*   If a service stops responding, BED will stop. You should monitor the target daemon's logs or process status to identify exactly which string caused a crash.