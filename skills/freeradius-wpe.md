---
name: freeradius-wpe
description: FreeRadius Wireless Pawn Edition (WPE) is a modified version of FreeRADIUS designed to facilitate "Evil Twin" attacks by capturing RADIUS authentication credentials. Use when performing wireless penetration testing, specifically targeting WPA2-Enterprise networks to intercept PEAP, EAP-TTLS, and EAP-MD5 hashes for offline cracking.
---

# freeradius-wpe

## Overview
FreeRadius Wireless Pawn Edition (WPE) is a patch for the open-source FreeRADIUS server. It is specifically designed to capture usernames and hashed passwords (MSCHAPv2, MD5, etc.) from wireless clients attempting to authenticate against a rogue access point. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install freeradius-wpe
```

## Common Workflows

### Standard Rogue RADIUS Setup
Run the server in the foreground with full debugging to monitor incoming authentication attempts and capture hashes in real-time:
```bash
freeradius-wpe -X
```

### Logging to a Specific File
Run the server and redirect the captured credential output to a specific log file for later analysis:
```bash
freeradius-wpe -f -l /root/captured_hashes.log
```

### Configuration Check
Verify that the configuration files (usually located in `/etc/freeradius-wpe/3.0/`) are valid before starting the attack:
```bash
freeradius-wpe -C
```

### Targeted Interface Listening
Force the RADIUS server to listen only on a specific IP address (e.g., the bridge interface connected to your rogue AP):
```bash
freeradius-wpe -f -i 192.168.1.1 -p 1812
```

## Complete Command Reference

```
freeradius-wpe [options]
```

| Flag | Description |
|------|-------------|
| `-C` | Check configuration and exit. |
| `-f` | Run as a foreground process, not a daemon. |
| `-h` | Print help message. |
| `-i <ipaddr>` | Listen on ipaddr ONLY. |
| `-l <log_file>` | Logging output will be written to this file. |
| `-m` | On SIGINT or SIGQUIT clean up all used memory instead of just exiting. |
| `-n <name>` | Read raddb/name.conf instead of raddb/radiusd.conf. |
| `-p <port>` | Listen on port ONLY. |
| `-P` | Always write out PID, even with -f. |
| `-s` | Do not spawn child processes to handle requests (same as -ft). |
| `-t` | Disable threads. |
| `-v` | Print server version information. |
| `-X` | Turn on full debugging (similar to -tfxxl stdout). |
| `-x` | Turn on additional debugging (-xx gives more debugging). |

## Notes
- **Supported EAP Types**: PEAP/PAP (OTP), PEAP/MSCHAPv2, EAP-TTLS/PAP, EAP-TTLS/MSCHAPv1, EAP-TTLS/MSCHAPv2, and EAP-MD5.
- **Log Location**: Captured hashes are typically stored in `/var/log/freeradius/freeradius-wpe.log` unless specified otherwise with the `-l` flag.
- **Cracking**: Captured MSCHAPv2 hashes can be cracked using tools like `asleap` or `john` (John the Ripper).
- **Configuration**: Ensure your certificates (in the `certs` directory of the config) are generated or updated to appear legitimate to target clients.