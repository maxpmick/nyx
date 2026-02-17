---
name: doona
description: Network fuzzer forked from BED (Bruteforce Exploit Detector) designed to check daemons for potential buffer overflows, format string bugs, and other vulnerabilities. Use when performing protocol fuzzing, vulnerability research, or stress testing network services like HTTP, FTP, SMTP, and IMAP.
---

# doona

## Overview
Doona is a network fuzzer designed to identify security vulnerabilities in network daemons. It sends malformed data to targets to trigger crashes or unexpected behavior, helping to identify buffer overflows and format string bugs. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume doona is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install doona
```

## Common Workflows

### Fuzz an HTTP server with a limit
Fuzz the target web server and stop after 100 test cases to check for initial stability.
```bash
doona -m HTTP -t 192.168.1.15 -M 100
```

### Resume a crashed fuzzing session
If the target service crashed at index 540, resume testing from that point after restarting the service.
```bash
doona -m FTP -t 192.168.1.15 -r 540
```

### Fuzz with frequent health checks
Perform a health check after every 5 fuzz cases and keep trying until the server responds.
```bash
doona -m SMTP -t 192.168.1.15 -c 5 -k
```

### Debug a specific test case
Dump the content of a specific test case index to stdout to analyze the payload.
```bash
doona -m HTTP -r 125 -d
```

## Complete Command Reference

```bash
doona -m [module] <options>
```

### Global Options

| Flag | Description |
|------|-------------|
| `-m <module>` | **Mandatory.** Select the protocol module to use (see Modules list) |
| `-c <int>` | Execute a health check after every `<int>` fuzz cases |
| `-t <target>` | Host to check (default: localhost) |
| `-p <port>` | Port to connect to (default: module specific standard port) |
| `-o <timeout>`| Seconds to wait after each test (default: 2 seconds) |
| `-r <index>` | Resumes fuzzing at the specified test case index |
| `-k` | Keep trying until server passes a health check |
| `-d` | Dump test case to stdout (use in combination with `-r`) |
| `-M <num>` | Exit after executing `<num>` number of fuzz cases |
| `-h` | Display help text |

### Available Modules (`-m`)
*   `DICT`
*   `FINGER`
*   `FTP`
*   `HTTP`
*   `HTTP_MORE`
*   `HTTP_SP`
*   `HTTP_WEBDAV`
*   `IMAP`
*   `IRC`
*   `LPD`
*   `NNTP`
*   `PJL`
*   `POP`
*   `PROXY`
*   `RTSP`
*   `SMTP`
*   `SOCKS4`
*   `SOCKS5`
*   `TFTP`
*   `WHOIS`

### Module Specific Help
To see options specific to a protocol (such as authentication credentials or specific paths):
```bash
doona -m [module] -h
```

## Notes
- Doona is a fork of the Bruteforce Exploit Detector (BED).
- Fuzzing is inherently intrusive and can cause service denial or system instability. Always use in authorized testing environments.
- Use the `-o` (timeout) flag to slow down the fuzzer if the target service is struggling to keep up with the request volume.