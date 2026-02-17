---
name: proxychains-ng
description: Redirect TCP connections through SOCKS4, SOCKS5, or HTTP proxies using LD_PRELOAD to hook network-related libc functions. Use when anonymizing traffic, bypassing firewalls, pivoting through compromised hosts, or routing application traffic through a proxy chain during web application testing or post-exploitation.
---

# proxychains-ng

## Overview
Proxychains-ng (new generation) is a UNIX program that forces TCP connections made by any given dynamically linked executable to follow a proxy or a chain of proxies. It supports SOCKS4, SOCKS5, and HTTP CONNECT proxies. It is a successor to the original unmaintained proxychains. Category: Post-Exploitation / Web Application Testing.

## Installation (if not already installed)
Assume proxychains-ng is already installed. If you get a "command not found" error:

```bash
sudo apt install proxychains4
```

## Common Workflows

### Basic Proxying
Run a tool (e.g., nmap) through the default proxy chain defined in `/etc/proxychains4.conf`:
```bash
proxychains4 nmap -sT -Pn -p 80,443 1.1.1.1
```
*Note: Only TCP scans (-sT) work with proxychains.*

### Using a Custom Configuration
Specify a local configuration file for a specific engagement:
```bash
proxychains4 -f ./my_proxy_config.conf ssh user@internal-host
```

### Quiet Mode
Suppress the proxychains status output (useful for scripting or cleaner logs):
```bash
proxychains4 -q curl https://ifconfig.me
```

### Remote DNS Resolution
Start the proxychains daemon to handle remote DNS requests:
```bash
proxychains4-daemon -i 127.0.0.1 -p 1053
```

## Complete Command Reference

### proxychains4
The main wrapper for executing programs through a proxy chain.

```
Usage: proxychains4 -q -f config_file program_name [arguments]
```

| Flag | Description |
|------|-------------|
| `-q` | Quiet mode: makes proxychains quiet by overriding the `quiet_mode` setting in the config file. |
| `-f <config_file>` | Manually specify the path to the configuration file to use. |

### proxychains4-daemon
A daemon used for remote DNS resolution.

```
Usage: proxychains4-daemon -i listenip -p port -r remotesubnet
```

| Flag | Description |
|------|-------------|
| `-i <listenip>` | The IP address the daemon should listen on (default: 127.0.0.1). |
| `-p <port>` | The port the daemon should listen on (default: 1053). |
| `-r <remotesubnet>` | The remote subnet to use (default: 224). |

## Configuration File Modes
Proxychains-ng behavior is primarily defined in its configuration file (usually `/etc/proxychains4.conf` or `./proxychains.conf`). Key modes include:

- **dynamic_chain**: Proxies are chained in the order listed. Dead proxies are skipped.
- **strict_chain**: Proxies are chained in the order listed. All must be up.
- **round_robin_chain**: Chains are picked from the list in a round-robin fashion.
- **random_chain**: Proxies are picked randomly from the list to create a chain.

## Notes
- **TCP Only**: Proxychains-ng does not support UDP or ICMP traffic. Tools like `ping` or UDP-based scans will fail.
- **Static Binaries**: Proxychains-ng uses `LD_PRELOAD` and therefore cannot hook network calls in statically linked binaries or Go binaries (which often don't use libc).
- **DNS**: Ensure `proxy_dns` is enabled in the config file to prevent DNS leaks.
- **Search Order**: Proxychains-ng looks for config files in this order:
    1. File specified by `-f`
    2. Environment variable `PROXYCHAINS_CONF_FILE`
    3. `./proxychains4.conf`
    4. `~/.proxychains/proxychains.conf`
    5. `/etc/proxychains4.conf`