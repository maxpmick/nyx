---
name: sshuttle
description: Create a transparent proxy server that forwards traffic through an SSH tunnel to a remote network. It acts as a "poor man's VPN" that does not require admin privileges on the remote server (only Python). Use when you need to route local traffic to a remote subnet, bypass firewalls, or perform lateral movement during penetration testing without a full VPN infrastructure.
---

# sshuttle

## Overview
sshuttle is a transparent proxy server for VPN over SSH. It forwards all traffic through an SSH tunnel to a remote copy of sshuttle, using `iptables` or `nftables` on the local machine. It only requires Python on the remote server and does not require a dedicated VPN server installation. Category: Sniffing & Spoofing / Post-Exploitation.

## Installation (if not already installed)
Assume sshuttle is already installed. If you encounter a "command not found" error:

```bash
sudo apt install sshuttle
```

Dependencies: `iptables` or `nftables`, `openssh-client`, `python3`.

## Common Workflows

### Route all traffic for a specific remote subnet
```bash
sshuttle -r user@remote-host 192.168.1.0/24
```

### Route all traffic and forward DNS queries
```bash
sshuttle --dns -r user@remote-host 0/0
```

### Automatically determine subnets and update /etc/hosts
```bash
sshuttle -vNH -r user@remote-host
```

### Exclude a specific IP from the proxied subnet
```bash
sshuttle -r user@remote-host 192.168.1.0/24 -x 192.168.1.50
```

## Complete Command Reference

```bash
sshuttle [-l [ip:]port] -r [user@]sshserver[:port] <subnets...>
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `IP/MASK[:PORT[-PORT]]...` | Capture and forward traffic to these subnets (whitespace separated) |

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-l`, `--listen [IP:]PORT` | Transproxy to this IP address and port number |
| `-H`, `--auto-hosts` | Continuously scan for remote hostnames and update local `/etc/hosts` |
| `-N`, `--auto-nets` | Automatically determine subnets to route |
| `--method TYPE` | Select capture method: `auto`, `nft`, `nat`, `tproxy`, `pf`, `ipfw` |
| `--python PATH` | Path to python interpreter on the remote server |
| `-r`, `--remote [USER[:PASS]@]ADDR[:PORT]` | SSH hostname (and optional credentials) of remote server |
| `-v`, `--verbose` | Increase debug message verbosity (can be used multiple times) |
| `-V`, `--version` | Print version number |
| `-e`, `--ssh-cmd CMD` | The command to use to connect to the remote (default: ssh) |
| `--no-cmd-delimiter` | Do not add a double dash before the python command |
| `--remote-shell PROGRAM` | Alternate remote shell (e.g., `cmd` or `powershell` for Windows) |
| `--no-latency-control` | Sacrifice latency to improve bandwidth benchmarks |
| `--latency-buffer-size SIZE` | Size of latency control buffer |
| `--wrap NUM` | Restart counting channel numbers after this number (testing) |
| `--disable-ipv6` | Disable IPv6 support |

### DNS Options
| Flag | Description |
|------|-------------|
| `--dns` | Capture local DNS requests and forward to remote DNS server |
| `--ns-hosts IP[,IP]` | Capture and forward DNS requests made to specific servers |
| `--to-ns IP[:PORT]` | The DNS server to forward requests to (defaults to remote `/etc/resolv.conf`) |
| `--seed-hosts HOSTS` | Comma-separated list of hostnames for initial scan |

### Exclusion Options
| Flag | Description |
|------|-------------|
| `-x`, `--exclude IP/MASK` | Exclude this subnet (can be used more than once) |
| `-X`, `--exclude-from PATH` | Exclude the subnets listed in a file |

### Daemon and Logging Options
| Flag | Description |
|------|-------------|
| `-D`, `--daemon` | Run in the background as a daemon |
| `-s`, `--subnets PATH` | File where subnets are stored instead of command line |
| `--syslog` | Send log messages to syslog (default if using `--daemon`) |
| `--pidfile PATH` | PID file name (default: `./sshuttle.pid`) |

### Permission and Security Options
| Flag | Description |
|------|-------------|
| `--user USER` | Apply rules only to this local Linux user |
| `--group GROUP` | Apply rules only to this local Linux group |
| `--sudoers-no-modify` | Prints an insecure sudo configuration to STDOUT for passwordless operation |
| `--sudoers-user USER` | Set user/group for passwordless operation (used with `--sudoers-no-modify`) |
| `--no-sudo-pythonpath` | Do not set PYTHONPATH when invoking sudo |

### Advanced Networking Options
| Flag | Description |
|------|-------------|
| `--firewall` | (Internal use only) |
| `--hostwatch` | (Internal use only) |
| `-t`, `--tmark [MARK]` | Tproxy optional traffic mark (hex, default '0x01') |
| `--namespace NAME` | Run inside of a net namespace with the given name |
| `--namespace-pid PID` | Run inside the net namespace used by the process with given PID |

## Notes
- sshuttle requires root/sudo privileges on the **local** machine to modify network routing tables.
- It does **not** require root on the remote machine, only a functional Python installation.
- It is more robust than SSH port forwarding (`-L` or `-D`) because it handles entire subnets and can handle DNS.
- It uses a data-driven protocol, not a packet-driven one (like TUN/TAP), making it faster for high-latency connections but unsuitable for non-TCP traffic (unless using specific methods).