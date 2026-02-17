---
name: arping
description: Send ARP and/or ICMP requests to a specified host to discover MAC addresses, detect IP conflicts, or test reachability on the local network. Use when performing local network reconnaissance, identifying live hosts, detecting duplicate IP addresses, or troubleshooting Layer 2 connectivity during penetration testing.
---

# arping

## Overview
The arping utility sends ARP and/or ICMP requests to a specified host and displays the replies. The host may be specified by its hostname, IP address, or MAC address. It is particularly useful for identifying hosts that may block ICMP (standard ping) but must respond to ARP requests to communicate on the local segment. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume arping is already installed. If you get a "command not found" error:

```bash
sudo apt install arping
```

## Common Workflows

### Basic ARP ping to an IP
```bash
arping -i eth0 192.168.1.1
```

### Detect duplicate IP addresses on the network
```bash
arping -d -i eth0 192.168.1.50
```
Exits with 1 if answers are received from two different MAC addresses.

### Find the IP address of a specific MAC
```bash
arping -i eth0 -r 00:11:22:33:44:55
```

### Send unsolicited ARP (Gratuitous ARP)
```bash
arping -U -i eth0 -S 192.168.1.100 192.168.1.100
```
Useful for updating the ARP caches of neighbors after an IP change.

## Complete Command Reference

```
arping [ -0aAbdDeFpPqrRuUvzZ ] [ -w <sec> ] [ -W <sec> ] [ -S <host/ip> ] [ -T <host/ip ] [ -s <MAC> ] [ -t <MAC> ] [ -c <count> ] [ -C <count> ] [ -i <interface> ] [ -m <type> ] [ -g <group> ] [ -V <vlan> ] [ -Q <priority> ] <host/ip/MAC | -B>
```

### Options

| Flag | Description |
|------|-------------|
| `-0` | Ping with source IP 0.0.0.0. Use when interface is not yet configured. Alias for `-S 0.0.0.0`. |
| `-a` | Audible ping (beep on reply). |
| `-A` | Only count addresses matching requested address. |
| `-b` | Use source broadcast address (255.255.255.255). |
| `-B` | Use instead of host to address 255.255.255.255. |
| `-c <count>` | Only send `count` requests. |
| `-C <count>` | Only wait for `count` replies, regardless of `-c` or `-w`. |
| `-d` | Find duplicate replies. Exit with 1 if answers come from two different MACs. |
| `-D` | Display answers as exclamation points (`!`) and missing packets as dots (`.`). |
| `-e` | Like `-a` but beep when there is NO reply. |
| `-F` | Don't try to be smart about the interface name. |
| `-g <group>` | `setgid()` to this group instead of the `nobody` group. |
| `-h` | Displays help message and exits. |
| `-i <interface>` | Use the specified network interface. |
| `-m <type>` | Type of timestamp to use for incoming packets. Use `-vv` to list available types. |
| `-p` | Turn on promiscuous mode on the interface. |
| `-P` | Send ARP replies instead of requests. Useful with `-U`. |
| `-q` | Quiet mode. Does not display messages except errors. |
| `-Q <pri>` | 802.1p priority to set (0-7). Should be used with `-V`. |
| `-r` | Raw output: only the MAC/IP address is displayed for each reply. |
| `-R` | Raw output: shows "the other one" (if pinging IP, shows MAC; if MAC, shows IP). |
| `-s <MAC>` | Set source MAC address. May require `-p`. |
| `-S <IP>` | Set source IP address. Target must have routing to this IP. |
| `-t <MAC>` | Set target MAC address to use when pinging an IP address. |
| `-T <IP>` | Use as target address when pinging MACs that won't respond to broadcast. |
| `-u` | Show `index=received/sent` instead of just `index=received` when pinging MACs. |
| `-U` | Send unsolicited ARP. |
| `-v` | Verbose output. Use twice (`-vv`) for more detail. |
| `-V <num>` | 802.1Q VLAN tag to add. |
| `-w <sec>` | Specify a timeout before ping exits. |
| `-W <sec>` | Time to wait between pings. |
| `-z` | Enable seccomp. |
| `-Z` | Disable seccomp (default). |

## Notes
- Arping operates at Layer 2; it cannot ping hosts behind a router/gateway unless they are on the same local subnet.
- If you use a source IP (`-S`) that you do not "own," you likely need to enable promiscuous mode (`-p`).
- This version of `arping` is maintained by Thomas Habets; it differs slightly in flags from the `iputils-arping` version often found on other Linux distributions.