---
name: onesixtyone
description: Fast and simple SNMP scanner used to enumerate SNMP community strings and retrieve system descriptions (sysDescr) asynchronously. Use when performing network reconnaissance, identifying SNMP-enabled devices, or brute-forcing SNMP community names during information gathering and password attacks.
---

# onesixtyone

## Overview
onesixtyone is an efficient SNMP scanner that sends requests for the `sysDescr` value asynchronously. It is designed for speed, capable of scanning a Class B network in less than 13 minutes by adjusting the timing between sent packets. Category: Reconnaissance / Information Gathering, Password Attacks.

## Installation (if not already installed)
Assume onesixtyone is already installed. If the command is missing:

```bash
sudo apt install onesixtyone
```

## Common Workflows

### Scan a network range with a specific community string
```bash
onesixtyone 192.168.1.0/24 public
```

### Brute-force community strings against a list of hosts
```bash
onesixtyone -c /usr/share/metasploit-framework/data/wordlists/snmp_default_pass.txt -i targets.txt -o snmp_results.log
```

### High-speed scan with custom timing
```bash
onesixtyone -i hosts.txt -c communities.txt -w 5
```
Wait only 5ms between packets for faster execution on high-bandwidth networks.

### Stealthy/Quiet mode with output to file
```bash
onesixtyone -i targets.txt -c public -q -o results.txt
```

## Complete Command Reference

```
onesixtyone [options] <host> <community>
```

### Options

| Flag | Description |
|------|-------------|
| `-c <communityfile>` | File containing community names to try |
| `-i <inputfile>` | File containing target host IP addresses |
| `-o <outputfile>` | Log output to the specified file |
| `-p` | Specify an alternate destination SNMP port (default is 161) |
| `-d` | Debug mode; use twice (`-dd`) for more detailed information |
| `-s` | Short mode; only print IP addresses of responding hosts |
| `-w <n>` | Wait `n` milliseconds between sending packets (default: 10) |
| `-q` | Quiet mode; do not print log to stdout (use with `-o`) |

### Usage Notes
- **Host Argument**: Can be a single IPv4 address or an IPv4 address with a netmask (e.g., `192.168.1.0/24`).
- **Default Communities**: If no community file or string is specified, it defaults to `public` and `private`.
- **Limits**:
    - Max number of hosts: 65536
    - Max community length: 32 characters
    - Max number of communities: 16384

## Notes
- The tool is extremely fast because it does not wait for a response before sending the next packet.
- On switched 100Mbps networks with 1Gbps backbones, a `-w 10` setting is generally safe to avoid dropped packets.
- If scanning over a WAN or unstable connection, increase the `-w` value to ensure reliability.