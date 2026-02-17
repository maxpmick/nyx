---
name: xprobe2
description: Perform remote active operating system fingerprinting by sending crafted packets and analyzing responses. Use when identifying the OS of a target host, detecting intermediate devices like firewalls or transparent proxies, and performing reconnaissance during the information gathering phase of a penetration test.
---

# xprobe2

## Overview
Xprobe2 is an active operating system fingerprinting tool that determines the OS of a remote host with a calculated confidence level. It utilizes a modular architecture to send various packets and analyze returned answers, remaining effective even when intermediate systems like routers or firewalls modify traffic. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume xprobe2 is already installed. If the command is missing:

```bash
sudo apt install xprobe
```

## Common Workflows

### Basic OS Fingerprinting
```bash
xprobe2 192.168.1.10
```

### Fingerprinting with Verbose Output and Traceroute
```bash
xprobe2 -v -r 192.168.1.50
```

### Targeted Port Analysis
Specify known open/closed ports to improve fingerprinting accuracy and perform analysis to detect firewalls/NIDS.
```bash
xprobe2 -p tcp:80:open -p udp:53:closed -T21-25,80,443 -A 192.168.1.100
```

### XML Output to File
```bash
xprobe2 -X -o results.xml 192.168.1.10
```

## Complete Command Reference

```
usage: xprobe2 [options] target
```

### General Options

| Flag | Description |
|------|-------------|
| `-v` | Be verbose |
| `-r` | Show route to target (traceroute) |
| `-h` | Print help message |
| `-o <fname>` | Use logfile to log everything |
| `-c <configfile>` | Specify custom configuration file to use |
| `-d <debuglv>` | Specify debugging level |
| `-L` | Display available modules |
| `-m <numofmatches>` | Specify number of matches to print |
| `-f` | Force fixed round-trip time (overrides `-t` behavior) |
| `-X` | Generate XML output (requires `-o` to specify the file) |

### Connection and Timing Options

| Flag | Description |
|------|-------------|
| `-t <time_sec>` | Set initial receive timeout or roundtrip time |
| `-s <send_delay>` | Set packet sending delay in milliseconds |

### Port and Protocol Options

| Flag | Description |
|------|-------------|
| `-p <proto:portnum:state>` | Specify port number, protocol, and state. Example: `tcp:23:open`, `UDP:53:CLOSED` |
| `-T <portspec>` | Enable TCP portscan for specified port(s). Example: `-T21-23,53,110` |
| `-U <portspec>` | Enable UDP portscan for specified port(s) |
| `-B` | Force TCP handshake module to try to guess an open TCP port |
| `-A` | Perform analysis of sample packets gathered during portscan to detect suspicious traffic (proxies, firewalls, NIDS resetting connections). Use with `-T` |

### Module Management

| Flag | Description |
|------|-------------|
| `-D <modnum>` | Disable specific module by number |
| `-M <modnum>` | Enable specific module by number |
| `-F` | Generate signature (use `-o` to save the signature to a file) |

## Notes
- Xprobe2 is particularly useful for identifying "Linux IP masquerading" and other intermediate device types.
- The tool provides a confidence score for its OS guesses, helping prioritize results when multiple signatures match.
- Use the `-A` flag in conjunction with `-T` to identify if a security appliance is interfering with the fingerprinting process.