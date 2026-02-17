---
name: netkit-telnet
description: Use the TELNET protocol for interactive communication with remote hosts. While deprecated for secure remote login due to clear-text transmission, it is a vital tool for network diagnostics, manual protocol testing (SMTP, HTTP, POP3), and verifying port connectivity. Use when testing service banners, troubleshooting firewall rules, or performing manual exploitation of legacy services.
---

# netkit-telnet

## Overview
The `telnet` package provides a client and server for the DARPA TELNET interactive communication protocol. In modern security contexts, it is primarily used as a diagnostic tool to verify if a port is open and to interact manually with text-based network services. Category: Sniffing & Spoofing / Network Diagnostics.

## Installation (if not already installed)
The telnet client is usually pre-installed on Kali Linux. If missing:

```bash
sudo apt install telnet telnetd
```

## Common Workflows

### Testing Port Connectivity and Banner Grabbing
```bash
telnet 192.168.1.50 80
```
Attempts to connect to port 80. If successful, you can type HTTP methods (e.g., `GET / HTTP/1.1`) to see the server response.

### Manual SMTP Interaction
```bash
telnet mail.example.com 25
```
Used to manually test mail relaying or verify SMTP server configurations.

### Specifying a Source Address
```bash
telnet -b 192.168.1.100 target.com 443
```
Connects to the target using a specific local interface/IP address.

### Starting a Debugging Server
```bash
sudo in.telnetd -debug 2323
```
Starts the telnet daemon on a non-standard port for testing or debugging purposes.

## Complete Command Reference

### telnet (Client)
The `telnet` command (often symlinked from `telnet.netkit`) is the user interface to the protocol.

```
telnet [-4] [-6] [-8] [-E] [-L] [-a] [-d] [-e char] [-l user] [-n tracefile] [-b addr] [-r] [host-name [port]]
```

| Flag | Description |
|------|-------------|
| `-4` | Force IPv4 address resolution |
| `-6` | Force IPv6 address resolution |
| `-8` | Request 8-bit operation |
| `-E` | Disables the escape character functionality |
| `-L` | Specifies an 8-bit data path on output |
| `-a` | Attempt automatic login (sends user name via ENVIRON) |
| `-d` | Sets the initial value of the debug toggle to TRUE |
| `-e char` | Sets the initial escape character (default is `^]`) |
| `-l user` | Specify the user to log in as on the remote system |
| `-n tracefile` | Opens `tracefile` for recording trace information |
| `-b addr` | Use `bind(2)` on the local system to bind to a specific source address |
| `-r` | Emulate `rlogin(1)` behavior |
| `host-name` | The remote host to connect to |
| `port` | The port number or service name (default is 23) |

### telnetd (Server)
The `in.telnetd` program is the server-side daemon.

```
telnetd [-debug port] [-D (options|report|exercise|netdata|ptydata)] [-h] [-L login_program] [-n]
```

| Flag | Description |
|------|-------------|
| `-debug port` | Run telnetd manually on a specified port instead of via inetd |
| `-D options` | Print information about TELNET options negotiation |
| `-D report` | Print `options` plus information about what processing is occurring |
| `-D exercise` | Print information about internal telnetd processing |
| `-D netdata` | Display the data stream received by telnetd |
| `-D ptydata` | Display data written to the pty (terminal device) |
| `-h` | Disable printing host-specific information until login is complete |
| `-L login_program` | Specify a different login program to execute |
| `-n` | Disable TCP keep-alives |

## Notes
- **Security Warning**: Telnet transmits all data, including usernames and passwords, in **clear text**. Use SSH for secure remote administration.
- To exit an active telnet session, use the escape character (usually `Ctrl + ]`) and then type `quit`.
- `telnetd` is typically managed by `inetd` or `xinetd` rather than run as a standalone persistent daemon, unless using the `-debug` flag.