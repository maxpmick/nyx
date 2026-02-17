---
name: bettercap
description: A complete, modular, and portable MITM framework for reconnaissance and attacking WiFi, BLE, IPv4, and IPv6 networks. Use for ARP/DNS spoofing, network sniffing, credential harvesting, WiFi deauthentication, and MouseJacking. It is the primary tool for man-in-the-middle (MITM) attacks and network monitoring during penetration testing.
---

# bettercap

## Overview
bettercap is a powerful "Swiss Army knife" for network reconnaissance and MITM attacks. It supports 802.11 (WiFi), Bluetooth Low Energy (BLE), and Ethernet networks. It features a modular architecture with scriptable proxies (HTTP/HTTPS/TCP), a network sniffer, and a web UI. Category: Sniffing & Spoofing / Reconnaissance.

## Installation (if not already installed)
Assume bettercap is already installed. If not:
```bash
sudo apt update && sudo apt install bettercap
```

## Common Workflows

### Interactive Network Reconnaissance
Start bettercap on a specific interface to discover hosts:
```bash
bettercap -iface eth0
# Inside the interactive session:
net.probe on
net.show
```

### ARP Spoofing and Sniffing
Perform a MITM attack to sniff traffic between a target and the gateway:
```bash
bettercap -eval "set arp.spoof.targets 192.168.1.5; arp.spoof on; net.sniff on"
```

### Automated Attacks with Caplets
Run a predefined set of commands from a caplet file:
```bash
bettercap -caplet spoof_and_sniff.cap
```

### Web UI Access
Start the web-based user interface (requires `caplets` to be installed):
```bash
bettercap -eval "ui.repo.update; ui.update; q" # Update UI first if needed
sudo bettercap -caplet http-ui
```

## Complete Command Reference

### Command Line Flags

| Flag | Description |
|------|-------------|
| `-autostart <list>` | Comma separated list of modules to auto start (default: "events.stream") |
| `-caplet <file>` | Read commands from this file and execute them in the interactive session |
| `-caplets-path <path>` | Specify an alternative base path for caplets |
| `-cpu-profile <file>` | Write CPU profile to the specified file |
| `-debug` | Print debug messages |
| `-env-file <file>` | Load environment variables from this file; empty to disable persistence |
| `-eval <commands>` | Run one or more commands separated by `;` in the interactive session |
| `-gateway-override <IP>` | Use the provided IP address instead of the default gateway |
| `-iface <interface>` | Network interface to bind to (auto-selected if empty) |
| `-mem-profile <file>` | Write memory profile to the specified file |
| `-no-colors` | Disable output color effects |
| `-no-history` | Disable interactive session history file |
| `-pcap-buf-size <int>` | PCAP buffer size (default: -1) |
| `-script <file>` | Load a session script (JavaScript) |
| `-silent` | Suppress all logs which are not errors |
| `-version` | Print the version and exit |

### Core Interactive Commands

| Command | Description |
|---------|-------------|
| `help` | List available commands |
| `help <MODULE>` | Show module-specific help and parameters |
| `active` | Show information about active modules |
| `quit` | Close the session and exit |
| `sleep <SEC>` | Sleep for the given amount of seconds |
| `get <NAME>` | Get the value of a variable (supports wildcards like `*`) |
| `set <NAME> <VAL>` | Set the value of a variable |
| `read <VAR> <PROMPT>` | Ask user for input and save it into a variable |
| `clear` | Clear the screen |
| `include <CAPLET>` | Load and run a caplet in the current session |
| `! <COMMAND>` | Execute a shell command and print its output |
| `alias <MAC> <NAME>` | Assign an alias to a given endpoint MAC address |

### Available Modules

| Module | Description |
|--------|-------------|
| `any.proxy` | Transparent proxy for any TCP traffic |
| `api.rest` | REST API for remote orchestration |
| `arp.spoof` | ARP poisoning/spoofing for MITM |
| `ble.recon` | Bluetooth Low Energy device discovery and enumeration |
| `caplets` | Management of bettercap caplets |
| `dhcp6.spoof` | DHCPv6 spoofing for IPv6 MITM |
| `dns.spoof` | DNS response spoofing |
| `events.stream` | Real-time event logging (running by default) |
| `gps` | GPS coordinates tracking |
| `http.proxy` | Scriptable HTTP proxy |
| `http.server` | Simple HTTP server for hosting files/payloads |
| `https.proxy` | Scriptable HTTPS proxy |
| `mac.changer` | Change the MAC address of the interface |
| `mysql.server` | Rogue MySQL server for credential harvesting |
| `net.probe` | Active host discovery by sending dummy packets |
| `net.recon` | Passive and active network host discovery |
| `net.sniff` | Network packet sniffer and fuzzer |
| `packet.proxy` | Packet level proxy/manipulation |
| `syn.scan` | Fast port scanner |
| `tcp.proxy` | Scriptable TCP proxy |
| `ticker` | Periodic command execution |
| `wifi` | WiFi scanning, deauth, and WPA handshake capture |
| `wol` | Wake-on-LAN packet sender |

## Notes
- **Privileges**: bettercap requires root privileges to manipulate network interfaces and perform spoofing.
- **Dependencies**: Ensure `iptables` and `libpcap` are present for full functionality.
- **Safety**: MITM attacks can disrupt network stability. Always target specific IPs using `arp.spoof.targets` rather than the entire subnet when possible.