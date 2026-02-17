---
name: sippts
description: Audit SIP-based VoIP systems and devices. Use for SIP scanning, extension enumeration, password cracking, SIP digest leak exploitation, RTPBleed vulnerability testing, and SIP flooding. Essential for VoIP security assessments and penetration testing of PBX systems like Asterisk.
---

# sippts

## Overview
Sippts is a comprehensive suite of tools programmed in Python for auditing VoIP servers and devices using the SIP protocol. It covers the entire attack lifecycle from reconnaissance (scanning/enumeration) to exploitation (cracking/vulnerability testing) and DoS (flooding). Category: Sniffing & Spoofing / Vulnerability Analysis.

## Installation (if not already installed)
Assume sippts is already installed. If missing:

```bash
sudo apt update
sudo apt install sippts
```

## Common Workflows

### Fast SIP Network Scan
Scan a network range to identify active SIP servers:
```bash
sippts scan -i 192.168.1.0/24
```

### Enumerate Extensions
Search for valid extensions on a specific PBX:
```bash
sippts exten -i 192.168.1.100 -e 100-500
```

### Remote Password Cracking
Brute-force SIP extension passwords:
```bash
sippts rcrack -i 192.168.1.100 -e 101 -w /usr/share/wordlists/rockyou.txt
```

### Test for RTPBleed
Check if a VoIP server is vulnerable to RTP stream redirection:
```bash
sippts rtpbleed -i 192.168.1.100 -p 10000-20000
```

## Complete Command Reference

### Global Usage
```bash
sippts [-h] {command} [options]
```

### Subcommands

| Command | Description |
|:---|:---|
| `scan` | Fast SIP scanner to find active hosts |
| `exten` | Search for SIP extensions on a PBX |
| `rcrack` | Remote password cracker (online brute force) |
| `enumerate` | Enumerate allowed methods of a SIP server (OPTIONS) |
| `leak` | Exploit SIP Digest Leak vulnerability |
| `ping` | Send SIP OPTIONS pings to a target |
| `invite` | Attempt to make unauthorized calls through a PBX |
| `dump` | Extract SIP digest authentications from a PCAP file |
| `dcrack` | Offline SIP digest authentication cracking |
| `flood` | Flood a SIP server with packets (DoS) |
| `sniff` | Passive SIP network sniffing |
| `spoof` | ARP Spoofing tool for Man-in-the-Middle |
| `pcapdump` | Extract specific data/streams from a PCAP file |
| `rtpbleed` | Detect RTPBleed vulnerability (sends RTP streams) |
| `rtcpbleed` | Detect RTPBleed vulnerability (sends RTCP streams) |
| `rtpbleedflood` | Exploit RTPBleed by flooding RTP ports |
| `rtpbleedinject` | Exploit RTPBleed by injecting a WAV file into a stream |
| `send` | Send a customized SIP message |
| `wssend` | Send a customized SIP message over WebSockets (WS) |
| `astami` | Asterisk Manager Interface (AMI) pentesting tool |
| `video` | Displays animated help/ASCII art |

### Command-Specific Help
To see all flags for a specific subcommand, use:
```bash
sippts <command> -h
```

### Interactive Console
Sippts also includes an interactive shell environment:
```bash
sippts-gui
```

## Notes
- **RTPBleed**: This vulnerability allows an attacker to receive or inject audio into an ongoing call by sending packets to the RTP ports of a vulnerable PBX.
- **SIP Digest Leak**: Some implementations leak authentication hashes in response to specific malformed requests; use the `leak` command to test this.
- **Dependencies**: Requires `python3-pyshark` and `python3-scapy` for sniffing and packet manipulation features.