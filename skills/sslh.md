---
name: sslh
description: Applicative protocol multiplexer that allows multiple services (HTTPS, SSH, OpenVPN, etc.) to share a single port, typically 443. Use when bypassing restrictive firewalls that only allow traffic on port 443, or when performing post-exploitation to maintain access via common ports.
---

# sslh

## Overview
sslh is a protocol demultiplexer that accepts connections on a single port and forwards them to different servers based on the protocol detected in the first packet. It supports HTTPS, SSH, OpenVPN, tinc, XMPP, and more. This is particularly useful for bypassing corporate firewalls that block all ports except 443. Category: Reconnaissance / Information Gathering, Post-Exploitation, Web Application Testing.

## Installation (if not already installed)
Assume sslh is already installed. If not:
```bash
sudo apt install sslh
```

## Common Workflows

### Basic Multiplexing (SSH and HTTPS)
Listen on port 443 and forward SSH to localhost:22 and HTTPS to localhost:4433:
```bash
sslh -f -p 0.0.0.0:443 --ssh 127.0.0.1:22 --ssl 127.0.0.1:4433
```

### Bypassing Firewalls with Multiple Protocols
Forward SSH, OpenVPN, and HTTPS through a single entry point:
```bash
sslh -p 0.0.0.0:443 --ssh 127.0.0.1:22 --openvpn 127.0.0.1:1194 --ssl 127.0.0.1:443
```

### Using a Configuration File
Run sslh as a daemon using a specific configuration file:
```bash
sslh -F /etc/sslh.cfg
```

## Complete Command Reference

The following options apply to `sslh`, `sslh-ev`, and `sslh-select`.

### General Options
| Flag | Description |
|------|-------------|
| `-F, --config=<file>` | Specify configuration file |
| `-V, --version` | Print version information and exit |
| `-f, --foreground` | Run in foreground instead of as a daemon |
| `-i, --inetd` | Run in inetd mode: use stdin/stdout instead of network listen |
| `-n, --numeric` | Print IP addresses and ports as numbers |
| `--transparent` | Set up as a transparent proxy |
| `-t, --timeout=<n>` | Set up timeout before connecting to default target |
| `--udp-max-connections=<n>` | Number of concurrent UDP connections |
| `-u, --user=<str>` | Username to change to after set-up |
| `-P, --pidfile=<file>` | Path to file to store PID of current instance |
| `-C, --chroot=<path>` | Root to change to after set-up |
| `--syslog-facility=<str>` | Facility to syslog to |
| `--logfile=<str>` | Log messages to a file |
| `--on-timeout=<str>` | Target to connect to when timing out |
| `--prefix=<str>` | Reserved for testing |
| `-p, --listen=<host:port>` | Listen on host:port |

### Protocol Targets
| Flag | Description |
|------|-------------|
| `--ssh=<host:port>` | Set up SSH target |
| `--tls=<host:port>` | Set up TLS/SSL target |
| `--ssl=<host:port>` | Set up TLS/SSL target |
| `--openvpn=<host:port>` | Set up OpenVPN target |
| `--tinc=<host:port>` | Set up tinc target |
| `--wireguard=<host:port>` | Set up WireGuard target |
| `--xmpp=<host:port>` | Set up XMPP target |
| `--http=<host:port>` | Set up HTTP (plain) target |
| `--adb=<host:port>` | Set up ADB (Android Debug) target |
| `--socks5=<host:port>` | Set up SOCKS5 target |
| `--syslog=<host:port>` | Set up syslog target |
| `--msrdp=<host:port>` | Set up MSRDP target |
| `--anyprot=<host:port>` | Set up default target (if no other protocol matches) |

### Verbosity and Debugging
| Flag | Description |
|------|-------------|
| `--verbose-config=<n>` | Print configuration at startup |
| `--verbose-config-error=<n>` | Print configuration errors |
| `--verbose-connections=<n>` | Trace established incoming address to forward address |
| `--verbose-connections-try=<n>` | Connection errors |
| `--verbose-connections-error=<n>` | Connection attempts towards targets |
| `--verbose-fd=<n>` | File descriptor activity (open/close) |
| `--verbose-packets=<n>` | Hexdump packets on which probing is done |
| `--verbose-probe-info=<n>` | Trace the probe process |
| `--verbose-probe-error=<n>` | Failures and problems during probing |
| `--verbose-system-error=<n>` | System call failures |
| `--verbose-int-error=<n>` | Internal errors |

## Notes
- **sslh-ev**: Uses the `libev` event loop for better performance with many connections.
- **sslh-select**: Uses the traditional `select(2)` system call.
- When using `--transparent`, you must configure `iptables` or `nftables` to route the return traffic back through sslh.
- Ensure the local services (like SSH or Apache) are listening on the ports specified in the sslh command.