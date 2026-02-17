---
name: net-tools
description: A collection of essential networking utilities for controlling the Linux kernel network subsystem. Includes tools for interface configuration (ifconfig), ARP cache manipulation (arp), routing table management (route), and network connection monitoring (netstat). Use during reconnaissance, post-exploitation, or general system administration to enumerate network interfaces, active connections, routing paths, and neighbor tables.
---

# net-tools

## Overview
The NET-3 networking toolkit provides fundamental utilities for Linux networking. It is essential for identifying network topology, active services, and hardware configurations. Categories: Reconnaissance, Sniffing & Spoofing, Post-Exploitation.

## Installation (if not already installed)
Assume net-tools is already installed. If a command is missing:
```bash
sudo apt install net-tools
```

## Common Workflows

### Enumerate Network Interfaces and IP Addresses
```bash
ifconfig -a
```

### View Active TCP/UDP Connections with Process IDs
```bash
netstat -tunapl
```

### View and Manipulate the ARP Cache
```bash
arp -n          # View cache without DNS resolution
arp -d 192.168.1.1  # Delete a specific entry
```

### Check and Modify Routing Tables
```bash
route -n                    # View routing table
route add default gw 192.168.1.1 eth0  # Set default gateway
```

## Complete Command Reference

### arp
Manipulate the system ARP cache.

| Flag | Description |
|------|-------------|
| `-a` | Display (all) hosts in alternative (BSD) style |
| `-e` | Display (all) hosts in default (Linux) style |
| `-s`, `--set` | Set a new ARP entry |
| `-d`, `--delete` | Delete a specified entry |
| `-v`, `--verbose` | Be verbose |
| `-n`, `--numeric` | Don't resolve names |
| `-i`, `--device` | Specify network interface (e.g. eth0) |
| `-D`, `--use-device` | Read `<hwaddr>` from given device |
| `-A`, `-p`, `--protocol` | Specify protocol family |
| `-f`, `--file` | Read new entries from file or from `/etc/ethers` |
| `-H <hw>` | Specify hardware address type (Default: ether) |

### ifconfig
Configure a network interface.

**Usage:** `ifconfig [-a] [-v] [-s] <interface> [[<AF>] <address>]`

| Option | Description |
|--------|-------------|
| `-a` | Display all interfaces, even those that are down |
| `-s` | Display a short list (like netstat -i) |
| `-v` | Be verbose |
| `up` | Activate the interface |
| `down` | Shut down the interface |
| `[-]arp` | Enable or disable the use of the ARP protocol |
| `[-]promisc` | Enable or disable promiscuous mode |
| `[-]allmulti` | Enable or disable all-multicast mode |
| `netmask <addr>` | Set the IP network mask |
| `broadcast <addr>` | Set the broadcast address |
| `hw <HW> <addr>` | Set the hardware address (MAC) |
| `mtu <NN>` | Set the Maximum Transfer Unit |
| `txqueuelen <NN>` | Set the length of the transmit queue |

### netstat
Print network connections, routing tables, and statistics.

| Flag | Description |
|------|-------------|
| `-r`, `--route` | Display routing table |
| `-i`, `--interfaces` | Display interface table |
| `-g`, `--groups` | Display multicast group memberships |
| `-s`, `--statistics` | Display networking statistics |
| `-M`, `--masquerade` | Display masqueraded connections |
| `-v`, `--verbose` | Be verbose |
| `-W`, `--wide` | Don't truncate IP addresses |
| `-n`, `--numeric` | Don't resolve names |
| `--numeric-hosts` | Don't resolve host names |
| `--numeric-ports` | Don't resolve port names |
| `--numeric-users` | Don't resolve user names |
| `-N`, `--symbolic` | Resolve hardware names |
| `-e`, `--extend` | Display other/more information |
| `-p`, `--programs` | Display PID/Program name for sockets |
| `-o`, `--timers` | Display timers |
| `-c`, `--continuous` | Continuous listing |
| `-l`, `--listening` | Display listening server sockets |
| `-a`, `--all` | Display all sockets (default: connected) |
| `-F`, `--fib` | Display Forwarding Information Base (default) |
| `-C`, `--cache` | Display routing cache instead of FIB |
| `-Z`, `--context` | Display SELinux security context |
| `-t`, `-u`, `-w`, `-x` | Filter by TCP, UDP, Raw, or Unix sockets |

### route
Show or manipulate the IP routing table.

| Flag | Description |
|------|-------------|
| `-n` | Numeric output (no DNS resolution) |
| `-e` | Use extend format |
| `-v` | Verbose |
| `-F` | Display Forwarding Information Base (default) |
| `-C` | Display routing cache |
| `add` | Add a new route |
| `del` | Delete a route |
| `gw <addr>` | Route packets via a Gateway |
| `dev <if>` | Force the route to be associated with the specified device |

### ipmaddr
Adds, changes, deletes, and displays multicast addresses.
- `ipmaddr [ add | del ] MULTIADDR dev STRING`
- `ipmaddr show [ dev STRING ] [ ipv4 | ipv6 | link | all ]`

### iptunnel
Create and manage IP tunnels.
- `iptunnel { add | change | del | show } [ NAME ] [ mode { ipip | gre | sit } ] [ remote ADDR ] [ local ADDR ] [ ttl TTL ] [ dev PHYS_DEV ]`

### mii-tool
View or manipulate media-independent interface status (Ethernet link status).

| Flag | Description |
|------|-------------|
| `-v`, `--verbose` | More verbose output |
| `-R`, `--reset` | Reset MII to poweron state |
| `-r`, `--restart` | Restart autonegotiation |
| `-w`, `--watch` | Monitor for link status changes |
| `-A`, `--advertise` | Advertise only specified media |
| `-F`, `--force` | Force specified media technology |

### nameif
Name network interfaces based on MAC addresses.
- `nameif [-c configurationfile] [-s] {ifname macaddress}`

### rarp
Manipulate the system RARP (Reverse ARP) table.
- `rarp -a`: List entries.
- `rarp -d <host>`: Delete entry.
- `rarp -s <host> <hwaddr>`: Add entry.

### slattach / plipconfig
- `slattach`: Attach a network interface to a serial line (SLIP/CSLIP).
- `plipconfig`: Fine tune PLIP (Parallel Line IP) device parameters.

## Notes
- Many `net-tools` commands are considered deprecated in favor of the `iproute2` suite (`ip addr`, `ip link`, `ip route`), but they remain standard in Kali for compatibility and specific output formats.
- Running these tools often requires `sudo` for administrative changes (e.g., changing IP, clearing ARP).