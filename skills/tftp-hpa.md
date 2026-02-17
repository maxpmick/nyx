---
name: tftp-hpa
description: Transfer files to and from remote systems using the Trivial File Transfer Protocol (TFTP). Use when interacting with network devices, PXE boot environments, or embedded systems that lack more secure transfer protocols. Includes both a client for manual transfers and a server for hosting boot images or receiving configuration backups.
---

# tftp-hpa

## Overview
tftp-hpa is an enhanced version of the BSD Trivial File Transfer Protocol (TFTP) client and server. It is commonly used for serving boot images (PXE), transferring configuration files to/from network hardware (routers/switches), and interacting with low-resource embedded devices. Category: Sniffing & Spoofing / Information Gathering.

## Installation (if not already installed)
Assume the tools are installed. If missing:

```bash
sudo apt install tftp-hpa tftpd-hpa
```

## Common Workflows

### Client: Download a file from a remote server
```bash
tftp 192.168.1.1 -c get config.bin
```

### Client: Upload a file to a remote server
```bash
tftp 192.168.1.1 -c put local_firmware.bin
```

### Server: Start a standalone TFTP server
```bash
sudo in.tftpd --daemon --user tftp --group tftp /srv/tftp
```

### Server: Test PCRE pattern replacements
```bash
in.tftpd --pcre-test /etc/tftpd.pcre
```

## Complete Command Reference

### tftp (Client)
IPv4/IPv6 Trivial File Transfer Protocol client.

**Usage:** `tftp [-4][-6][-v][-l][-m mode] [host [port]] [-c command]`

| Flag | Description |
|------|-------------|
| `-4` | Force IPv4 |
| `-6` | Force IPv6 |
| `-v` | Verbose mode |
| `-l` | Logging mode |
| `-m mode` | Set default transfer mode (e.g., `netascii` or `octet`) |
| `-c command` | Execute a specific command and exit (e.g., `get`, `put`) |

---

### in.tftpd (Server)
Trivial File Transfer Protocol Server.

**Usage:** `in.tftpd [options] [directory]`

| Flag | Description |
|------|-------------|
| `-t, --tftpd-timeout <value>` | Seconds of inactivity before exiting |
| `-r, --retry-timeout <value>` | Time to wait for a reply before retransmission |
| `-m, --maxthread <value>` | Number of concurrent threads allowed |
| `-v, --verbose [value]` | Increase or set the level of output messages |
| `--trace` | Log all sent and received packets |
| `--no-timeout` | Disable 'timeout' option from RFC2349 |
| `--no-tsize` | Disable 'tsize' option from RFC2349 |
| `--no-blksize` | Disable 'blksize' option from RFC2348 |
| `--no-windowsize` | Disable 'windowsize' option from RFC7440 |
| `--no-multicast` | Disable 'multicast' option from RFC2090 |
| `--logfile <file>` | Log to specified file (use `-` for stdout) |
| `--pidfile <file>` | Write PID to this file |
| `--listen-local` | Force listen on local network address |
| `--daemon` | Run atftpd standalone (no inetd) |
| `--no-fork` | Run as a daemon, but don't fork |
| `--prevent-sas` | Prevent Sorcerer's Apprentice Syndrome |
| `--user <user[.group]>` | Set running user (default: `nobody`) |
| `--group <group>` | Set running group (default: `nogroup`) |
| `--port <port>` | Port on which atftp listens |
| `--bind-address <IP>` | Local address atftpd listens to |
| `--mcast-ttl` | TTL to use for multicast |
| `--mcast-addr <addr list>` | List/range of IP addresses to use for multicast |
| `--mcast-port <port range>` | Ports to use for multicast transfer |
| `--pcre <file>` | Use this file for pattern replacement |
| `--pcre-test <file>` | Just test pattern file, do not start server |
| `--mtftp <file>` | mtftp configuration file |
| `--mtftp-port <port>` | Port mtftp will listen on |
| `--no-source-port-checking` | Violate RFC (see man page) |
| `--mcast-switch-client` | Switch client on first timeout |
| `-V, --version` | Print version information |
| `-h, --help` | Print help message |

## Notes
- **Directory Permissions**: The `[directory]` argument for the server must be world-readable (for downloads) or world-writable (for uploads). By default, `/tftpboot` is assumed.
- **Security**: TFTP has no authentication or encryption. Use with caution and only on trusted networks.
- **Sorcerer's Apprentice Syndrome**: A known TFTP flaw where an acknowledgement packet is lost, leading to duplicate data packets; the `--prevent-sas` flag mitigates this.