---
name: vopono
description: Run applications through VPN tunnels using temporary network namespaces. This tool allows specific applications to be routed through different VPN connections simultaneously while keeping the main system connection unaffected. Use when performing privacy-sensitive tasks, testing geo-blocked web applications, or isolating network traffic for specific tools during penetration testing.
---

# vopono

## Overview
vopono is a tool to run applications through VPN tunnels via temporary network namespaces. It enables granular control over network routing by allowing individual applications to use different VPN providers or servers without changing the system-wide network configuration. Category: Sniffing & Spoofing / Privacy.

## Installation (if not already installed)
Assume vopono is already installed. If you get a "command not found" error:

```bash
sudo apt install vopono
```
Dependencies: libc6, libgcc-s1, nftables.

## Common Workflows

### Synchronize VPN server lists
Before first use, sync the local configuration with your VPN provider's server list.
```bash
vopono sync
```

### Execute a browser through a specific VPN
Run Firefox through a Wireguard connection to a Swiss server using Mullvad.
```bash
vopono exec --provider mullvad --protocol wireguard --country CH firefox
```

### List active namespaces
View all currently running vopono namespaces and the applications within them.
```bash
vopono list
```

### Run a command with a custom OpenVPN config
```bash
vopono exec --custom /path/to/config.ovpn curl ifconfig.me
```

## Complete Command Reference

```
vopono [OPTIONS] [COMMAND]
```

### Global Options
| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | Verbose output |
| `--silent` | Suppress all output including application output |
| `-A`, `--askpass` | Read sudo password from program specified in SUDO_ASKPASS environment variable |
| `-h`, `--help` | Print help |
| `-V`, `--version` | Print version |

### Subcommands

#### `daemon`
Run the vopono daemon.
*Requires root privileges.*

#### `exec`
Execute an application with the given VPN connection.

**Usage:** `vopono exec [OPTIONS] <COMMAND>`

| Flag | Description |
|------|-------------|
| `-p`, `--provider <PROVIDER>` | VPN Provider (e.g., mullvad, protonvpn, ivpn) |
| `-c`, `--country <COUNTRY>` | Country code (ISO 3166-1 alpha-2) |
| `-s`, `--server <SERVER>` | Specific server name |
| `--protocol <PROTOCOL>` | Protocol to use: `openvpn` or `wireguard` |
| `--custom <PATH>` | Path to a custom OpenVPN or Wireguard configuration file |
| `--interface <IFACE>` | Use a specific network interface |
| `--dns <DNS>` | Set a custom DNS server for the namespace |
| `--port-forward` | Enable port forwarding (if supported by provider) |
| `--killswitch` | Enable killswitch to prevent traffic leaks if VPN drops |

#### `list`
List running vopono namespaces and applications.

#### `sync`
Synchronise local server lists with VPN providers. Use this to update the available server locations and configurations.

#### `servers`
List possible server configurations for a VPN provider, beginning with a prefix.

**Usage:** `vopono servers <PROVIDER> [PREFIX]`

#### `help`
Print the help message or the help of the given subcommand(s).

## Notes
- vopono requires `root` or `sudo` privileges because it manages network namespaces and firewall rules (via nftables).
- It is highly recommended to run `vopono sync` periodically to ensure server lists are up to date.
- The tool creates a temporary bridge and namespace which are automatically cleaned up when the application exits.