---
name: portspoof
description: Enhance OS security by making all 65535 TCP ports appear open and emulating fake service banners. Use this tool during defensive operations, deception campaigns, or to frustrate and mislead attackers during the reconnaissance and scanning phases of a penetration test.
---

# portspoof

## Overview
Portspoof is a deception tool designed to enhance OS security by returning a SYN+ACK for every TCP port connection attempt, making all 65535 ports appear open. It utilizes a large database of dynamic service signatures to generate fake banners, effectively fooling port scanners and service version detection tools. Category: Sniffing & Spoofing / Defensive Security.

## Installation (if not already installed)
Assume portspoof is already installed. If you encounter errors, install it and its dependencies:

```bash
sudo apt update
sudo apt install portspoof iptables
```

## Common Workflows

### Basic Service Setup
To start portspoof, you must first configure iptables to redirect traffic to the portspoof listening port (default 4444), then run the daemon.

1. Redirect all incoming TCP traffic to port 4444:
```bash
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 1:65535 -j REDIRECT --to-ports 4444
```

2. Start the portspoof daemon:
```bash
sudo portspoof -c /etc/portspoof.conf -s /etc/portspoof_signatures
```

### Using Kali Helper Scripts
Kali provides wrapper scripts to manage the service, though they may require manual configuration of `/etc/portspoof.conf` first.

```bash
sudo portspoof-start
sudo portspoof-stop
```

### Running in Verbose Mode for Debugging
```bash
sudo portspoof -v -c /etc/portspoof.conf -s /etc/portspoof_signatures
```

## Complete Command Reference

### portspoof Options

| Flag | Description |
|------|-------------|
| `-c <file>` | Path to the configuration file (e.g., `/etc/portspoof.conf`) |
| `-s <file>` | Path to the service signature file (e.g., `/etc/portspoof_signatures`) |
| `-p <port>` | Port number to bind the portspoof daemon to (default: 4444) |
| `-1`, `--syslog` | Log attacks to syslog |
| `-v` | Verbose output (useful for debugging connection attempts) |
| `-h`, `--help` | Display help message |

### Helper Scripts

| Command | Description |
|---------|-------------|
| `portspoof-start` | Script to initialize and start the portspoof service |
| `portspoof-stop` | Script to stop the portspoof service and potentially clear iptables rules |

## Notes
- **Configuration Required**: This tool will not function correctly without an accompanying `iptables` rule to redirect traffic to the portspoof listening port.
- **Service Impact**: Be careful when applying iptables rules on production systems, as redirecting all ports (1:65535) will interfere with legitimate services running on the machine unless specific exclusions are added to the iptables chain.
- **Documentation**: Detailed Debian-specific setup instructions can be found in `/usr/share/doc/portspoof/README.Debian`.
- **Primary Use Case**: It is highly effective against `nmap -sV` scans, as it will provide a different fake banner for every port scanned, significantly slowing down the attacker's reconnaissance.