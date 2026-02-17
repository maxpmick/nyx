---
name: dotdotpwn
description: Discover directory traversal vulnerabilities in software such as HTTP, FTP, and TFTP servers, as well as web platforms like CMSs and ERPs. Use when performing web application testing, service auditing, or vulnerability analysis to identify path traversal and local file inclusion (LFI) flaws.
---

# dotdotpwn

## Overview
DotDotPwn is a flexible, intelligent fuzzer designed to identify directory traversal vulnerabilities. It supports multiple protocols and can perform intelligent fuzzing based on operating system detection. Category: Web Application Testing / Vulnerability Analysis.

## Installation (if not already installed)
Assume dotdotpwn is already installed. If you get a "command not found" error:

```bash
sudo apt install dotdotpwn
```

## Common Workflows

### Fuzzing a Web Server (HTTP GET)
Perform a standard directory traversal attack against a web server's root.
```bash
dotdotpwn -m http -h 192.168.1.1 -M GET
```

### Fuzzing a Specific URL Parameter
Target a specific vulnerable parameter in a URL.
```bash
dotdotpwn -m http-url -u "http://example.com/view.php?file=TRAVERSAL" -k "root:"
```

### Fuzzing an FTP Server with Authentication
Test an FTP server using specific credentials and a deeper traversal depth.
```bash
dotdotpwn -m ftp -h 192.168.1.1 -U admin -P password123 -d 10
```

### Intelligent Fuzzing with OS Detection
Use nmap to detect the OS and tailor the traversal patterns accordingly.
```bash
dotdotpwn -m http -h 192.168.1.1 -O
```

## Complete Command Reference

```bash
dotdotpwn -m <module> -h <host> [OPTIONS]
```

### Required Options
| Flag | Description |
|------|-------------|
| `-m` | **Module**: [http \| http-url \| ftp \| tftp \| payload \| stdout] |
| `-h` | **Hostname**: Target IP or domain |

### Fuzzing Configuration
| Flag | Description |
|------|-------------|
| `-d` | Depth of traversals (e.g., depth 3 equals `../../../`; default: 6) |
| `-f` | Specific filename to hunt for (e.g., `/etc/passwd`; default: based on OS) |
| `-E` | Add `@Extra_files` defined in TraversalEngine.pm (e.g., web.config, httpd.conf) |
| `-e` | File extension appended to each fuzz string (e.g., ".php", ".jpg", ".inc") |
| `-X` | Use Bisection Algorithm to detect exact depth once a vulnerability is found |
| `-b` | Break after the first vulnerability is found |

### Protocol & Connection Options
| Flag | Description |
|------|-------------|
| `-x` | Port to connect (default: HTTP=80; FTP=21; TFTP=69) |
| `-S` | Use SSL for HTTP and Payload modules |
| `-u` | URL with the part to be fuzzed marked as `TRAVERSAL` |
| `-p` | Filename with the payload to be sent (mark fuzzed part with `TRAVERSAL`) |
| `-k` | Text pattern to match in the response (e.g., "root:" for /etc/passwd) |
| `-M` | HTTP Method for 'http' module: [GET \| POST \| HEAD \| COPY \| MOVE] (default: GET) |
| `-t` | Time in milliseconds between each test (default: 300) |
| `-U` | Username (default: 'anonymous') |
| `-P` | Password (default: 'dot@dot.pwn') |
| `-C` | Continue if no data was received from host |

### OS & Service Detection
| Flag | Description |
|------|-------------|
| `-O` | Operating System detection for intelligent fuzzing (uses nmap) |
| `-o` | Operating System type if known ("windows", "unix" or "generic") |
| `-s` | Service version detection (banner grabber) |

### Output & Logging
| Flag | Description |
|------|-------------|
| `-r` | Report filename (default: 'HOST_MM-DD-YYYY_HOUR-MIN.txt') |
| `-q` | Quiet mode (doesn't print each attempt) |

## Notes
- When using the `http-url` module, the `-u` flag must contain the keyword `TRAVERSAL` to indicate the injection point.
- The `stdout` module can be used to pipe generated patterns into other tools.
- Intelligent fuzzing (`-O` or `-o`) significantly reduces the number of useless attempts by focusing on patterns relevant to the target OS.