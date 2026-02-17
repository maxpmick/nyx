---
name: miredo
description: Provide IPv6 connectivity to hosts behind NAT devices by encapsulating IPv6 packets into UDP/IPv4 datagrams using the Teredo protocol (RFC 4380). Use when performing post-exploitation tasks that require IPv6 access on an IPv4-only network, bypassing NAT restrictions, or setting up a Teredo relay/server to facilitate communication between Teredo clients.
---

# miredo

## Overview
Miredo is an open-source Teredo IPv6 tunneling software. It includes a client, a relay, and a server. It allows dual-stack IPv6/IPv4 hosts behind NATs to reach the IPv6 Internet by tunneling traffic over UDP. Category: Post-Exploitation / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install miredo miredo-server
```

## Common Workflows

### Start Teredo Client
Start the client to obtain an IPv6 address through a NAT.
```bash
sudo miredo
```

### Run Client in Foreground
Useful for debugging or monitoring connection status.
```bash
miredo -f
```

### Validate Configuration
Check the syntax of a custom configuration file before applying it.
```bash
miredo-checkconf /etc/miredo/miredo.conf
```

### Start Teredo Server
Deploy a Teredo server to help other clients determine NAT types and perform hole punching.
```bash
sudo miredo-server -c /etc/miredo/miredo-server.conf
```

## Complete Command Reference

### miredo (Client/Relay)
Creates a Teredo tunneling interface for encapsulation of IPv6 over UDP.

```bash
miredo [OPTIONS] [SERVER_NAME]
```

| Flag | Description |
|------|-------------|
| `-c, --config` | Specify a configuration file (default: `/etc/miredo/miredo.conf`) |
| `-f, --foreground` | Run in the foreground instead of daemonizing |
| `-h, --help` | Display help message and exit |
| `-p, --pidfile` | Override the location of the PID file |
| `-u, --user` | Override the user to set UID to (drops privileges) |
| `-V, --version` | Display program version and exit |

### miredo-checkconf
Tool to check the syntax of Miredo configuration files.

```bash
miredo-checkconf [CONF_FILE]
```

### teredo-mire
Stateless Teredo IPv6 responder.

```bash
teredo-mire
```

### miredo-server
Provides Teredo server functionality to assist clients with NAT traversal.

```bash
miredo-server [OPTIONS] [SERVER_NAME]
```

| Flag | Description |
|------|-------------|
| `-c, --config` | Specify a configuration file (default: `/etc/miredo/miredo-server.conf`) |
| `-f, --foreground` | Run in the foreground |
| `-h, --help` | Display help message and exit |
| `-p, --pidfile` | Override the location of the PID file |
| `-u, --user` | Override the user to set UID to |
| `-V, --version` | Display program version and exit |

## Notes
- Miredo requires a functional TUN/TAP device driver in the kernel.
- When running as a client, it will create a new network interface (usually `teredo`) with a global IPv6 address.
- Ensure that UDP port 3544 is allowed through local firewalls for Teredo traffic.