---
name: atftp
description: Advanced TFTP client and server for transferring files via the Trivial File Transfer Protocol (RFC1350). Use when performing network reconnaissance, exfiltrating data from embedded devices, delivering payloads to PXE-booting systems, or interacting with network equipment that lacks more secure transfer protocols.
---

# atftp

## Overview
`atftp` is an advanced TFTP client and server (atftpd) that supports multithreading and various RFC extensions (multicast, block size, timeout, etc.). It is commonly used in network administration and security testing for interacting with devices like routers, switches, and IoT hardware. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)

Assume the tools are already installed. If you encounter a "command not found" error:

```bash
sudo apt update
sudo apt install atftp atftpd
```

## Common Workflows

### Download a file from a remote host
```bash
atftp -g -r config.bin -l local_config.bin 192.168.1.1
```

### Upload a payload to a target
```bash
atftp -p -l shell.elf -r /tmp/shell.elf 192.168.1.50
```

### Start a standalone TFTP server for file delivery
```bash
sudo mkdir /tmp/tftp
sudo atftpd --daemon --port 69 /tmp/tftp
```

### Interactive mode
```bash
atftp 192.168.1.1
```
Once in the interactive shell, use `get`, `put`, and `quit` commands.

## Complete Command Reference

### atftp (Client)
Usage: `atftp [options] [host] [port]`

| Flag | Description |
|------|-------------|
| `-g`, `--get` | Get file from server |
| `--mget` | Get file using mtftp (multicast) |
| `-p`, `--put` | Put file to server |
| `-l`, `--local-file <file>` | Local file name |
| `-r`, `--remote-file <file>` | Remote file name |
| `-P`, `--password <password>` | Specify password (Linksys extension) |
| `--tftp-timeout <value>` | Delay before retransmission, client side |
| `--option <"name value">` | Set RFC option name to value |
| `--mtftp <"name value">` | Set mtftp variable to value |
| `--no-source-port-checking` | Violate RFC; do not check source port of server replies |
| `--prevent-sas` | Prevent Sorcerer's Apprentice Syndrome |
| `--verbose` | Set verbose mode on |
| `--trace` | Set trace mode on (logs all packets) |
| `-V`, `--version` | Print version information |
| `-h`, `--help` | Print help message |

### atftpd / in.tftpd (Server)
Usage: `atftpd [options] [directory]`

| Flag | Description |
|------|-------------|
| `-t`, `--tftpd-timeout <value>` | Seconds of inactivity before exiting |
| `-r`, `--retry-timeout <value>` | Time to wait for a reply before retransmission |
| `-m`, `--maxthread <value>` | Number of concurrent threads allowed |
| `-v`, `--verbose [value]` | Increase or set the level of output messages |
| `--trace` | Log all sent and received packets |
| `--no-timeout` | Disable 'timeout' option (RFC2349) |
| `--no-tsize` | Disable 'tsize' option (RFC2349) |
| `--no-blksize` | Disable 'blksize' option (RFC2348) |
| `--no-windowsize` | Disable 'windowsize' option (RFC7440) |
| `--no-multicast` | Disable 'multicast' option (RFC2090) |
| `--logfile <file>` | Log to file (use `-` for stdout) |
| `--pidfile <file>` | Write PID to this file |
| `--listen-local` | Force listen on local network address |
| `--daemon` | Run atftpd standalone (no inetd) |
| `--no-fork` | Run as a daemon, but don't fork |
| `--prevent-sas` | Prevent Sorcerer's Apprentice Syndrome |
| `--user <user[.group]>` | User to run as (default: nobody) |
| `--group <group>` | Group to run as (default: nogroup) |
| `--port <port>` | Port to listen on |
| `--bind-address <IP>` | Local address to listen on |
| `--mcast-ttl` | TTL to use for multicast |
| `--mcast-addr <list>` | List/range of IP addresses to use for multicast |
| `--mcast-port <range>` | Ports to use for multicast transfer |
| `--pcre <file>` | Use file for pattern replacement (URL rewriting) |
| `--pcre-test <file>` | Test pattern file without starting server |
| `--mtftp <file>` | mtftp configuration file |
| `--mtftp-port <port>` | Port mtftp will listen on |
| `--no-source-port-checking` | Violate RFC; do not check source port of client |
| `--mcast-switch-client` | Switch client on first timeout |
| `-V`, `--version` | Print version information |
| `-h`, `--help` | Print help message |

## Notes
- TFTP is an unauthenticated and unencrypted protocol. Use with caution.
- When running `atftpd` in daemon mode, ensure the specified directory is world-readable (and world-writable if you intend to allow uploads).
- Default directory for `atftpd` is `/tftpboot`.
- Sorcerer's Apprentice Syndrome (SAS) is a known TFTP flaw where an acknowledgement packet is duplicated, leading to a loop of duplicate data packets; the `--prevent-sas` flag mitigates this.