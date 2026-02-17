---
name: arpwatch
description: Monitor Ethernet/FDDI station activity and maintain a database of Ethernet MAC addresses paired with IP addresses. Use to detect ARP spoofing, new devices on a network, MAC address "flip-flops," or re-used IP addresses by receiving alerts via email or system logs.
---

# arpwatch

## Overview
Arpwatch is a network monitoring tool that tracks Ethernet/IP address pairings. It logs activity to a database and can send email alerts when changes occur, such as a new station appearing, an IP address changing its MAC address, or a MAC address being reused. Category: Sniffing & Spoofing / Reconnaissance.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install arpwatch
```

## Common Workflows

### Monitor a specific interface
```bash
sudo arpwatch -i eth0
```

### Analyze a PCAP file for ARP changes
```bash
arpwatch -r network_traffic.pcap
```

### Run in foreground with debug output (no forking)
```bash
sudo arpwatch -d -i wlan0
```

### Convert database to ethers format
```bash
arp2ethers /var/lib/arpwatch/arp.dat
```

## Complete Command Reference

### arpwatch
The main daemon for monitoring ARP traffic.

| Flag | Description |
|------|-------------|
| `-a` | Report all ARP packets, not just those from the local network |
| `-d` | Debug mode. Runs in foreground and does not fork |
| `-f <datafile>` | Set the database filename (default: `arp.dat`) |
| `-F <filter>` | Use a specific pcap filter expression |
| `-i <interface>` | Specify the network interface to monitor |
| `-m <addr>` | Specify the email address to send alerts to |
| `-n <net[/width]>` | Specify additional local networks |
| `-N` | Disable reporting of bogons |
| `-p` | Disable promiscuous mode |
| `-Q` | Quiet mode. Do not report errors via syslog |
| `-r <file>` | Read from a pcap savefile instead of the network |
| `-s <path>` | Path to the sendmail binary |
| `-u <username>` | Drop privileges and run as the specified user |
| `-z <ignorenet/mask>` | Specify networks to ignore |

### arpsnmp
Used to update the arpwatch database using SNMP data from routers.

| Flag | Description |
|------|-------------|
| `-d` | Debug mode |
| `-f <datafile>` | Set the database filename |
| `-m <addr>` | Email address for alerts |
| `-s <path>` | Path to sendmail |
| `file [...]` | One or more files containing SNMP walk output |

### arpfetch
Obtains Ethernet/IP address pairings from a specific host via SNMP.

```bash
arpfetch <host> <cname>
```
- `host`: The IP address or hostname of the SNMP-enabled device.
- `cname`: The SNMP community name (e.g., `public`).

### arp2ethers
Converts the arpwatch database into the standard `/etc/ethers` format.

```bash
arp2ethers [arp.dat file]
```
- If no file is specified, it defaults to `/var/lib/arpwatch/arp.dat`.

### bihourly
A script (often used in cron) to generate reports and cleanup. It shares the same usage flags as `arpsnmp`.

```bash
bihourly [-d] [-m addr] [-f datafile] [-s sendmail_path] file [...]
```

### massagevendor
A utility script used to convert the Ethernet vendor codes master list (IEEE OUI) into a format that `arpwatch` can understand.

## Notes
- Database files are typically stored in `/var/lib/arpwatch/`.
- `arpwatch` requires root privileges to capture traffic on a live interface.
- If monitoring multiple interfaces, Debian-based systems often use separate `arp.dat` files for each interface (e.g., `eth0.dat`).