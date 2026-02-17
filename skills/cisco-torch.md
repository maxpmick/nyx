---
name: cisco-torch
description: Scan and fingerprint Cisco devices to identify running services including Telnet, SSH, Web, NTP, TFTP, and SNMP. Use when performing vulnerability analysis, network discovery, or password auditing specifically targeting Cisco infrastructure to find open services, exploit IOS HTTP vulnerabilities, or launch dictionary attacks.
---

# cisco-torch

## Overview
Cisco Torch is a mass scanner and fingerprinting tool designed to discover remote Cisco hosts. It uses forking for high efficiency and employs multiple application-layer fingerprinting methods simultaneously. It can identify services, perform dictionary attacks, and automatically retrieve configuration files if SNMP RW communities are discovered. Category: Vulnerability Analysis.

## Installation (if not already installed)
Assume cisco-torch is already installed. If missing:

```bash
sudo apt install cisco-torch
```

Dependencies: libnet-snmp-perl, libnet-ssh2-perl, libnet-telnet-perl, perl.

## Common Workflows

### Comprehensive Scan
Run all fingerprinting scan types against a network range:
```bash
cisco-torch -A 10.10.0.0/16
```

### SSH Password Auditing
Perform an SSH scan and launch a dictionary attack against a list of hosts:
```bash
cisco-torch -s -b -F sshtocheck.txt
```

### Web Vulnerability Scanning
Scan for Cisco webservers and check for the Cisco IOS HTTP Authorization Vulnerability:
```bash
cisco-torch -w -z 192.168.1.0/24
```

### TFTP Leeching
Scan for TFTP services, perform a dictionary attack to find valid filenames, and attempt to download configuration files:
```bash
cisco-torch -j -b -g -F tftptocheck.txt
```

## Complete Command Reference

```bash
cisco-torch <options> <IP,hostname,network>
# OR
cisco-torch <options> -F <hostlist>
```

### Options

| Flag | Description |
|------|-------------|
| `-A` | All fingerprint scan types combined |
| `-b` | Password dictionary attack (use with `-s`, `-u`, `-c`, `-w`, `-j`, or `-t` only) |
| `-c` | Cisco Webserver with SSL support scan |
| `-F <file>` | Read list of target hosts/networks from a file |
| `-g` | Cisco config or TFTP file download (requires successful SNMP/TFTP access) |
| `-j` | Cisco TFTP fingerprinting scan |
| `-l <type>` | Set loglevel: `c` (critical, default), `v` (verbose), `d` (debug) |
| `-n` | Cisco NTP fingerprinting scan |
| `-O <file>` | Write output to specified file |
| `-s` | Cisco SSHd scan |
| `-t` | Cisco Telnetd scan |
| `-u` | Cisco SNMP scan |
| `-V` | Print tool version and exit |
| `-w` | Cisco Webserver scan |
| `-z` | Cisco IOS HTTP Authorization Vulnerability Scan |

## Notes
- The tool uses a configuration file `torch.conf` for default settings and plugin loading.
- Dictionary attacks (`-b`) rely on internal wordlists (e.g., `community.txt` for SNMP).
- The tool is highly efficient due to its forking architecture, making it suitable for large network ranges.
- Ensure you have the necessary Perl library dependencies installed if running on a non-standard Kali environment.