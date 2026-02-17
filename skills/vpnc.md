---
name: vpnc
description: Connect to Cisco VPN 3000 Concentrators, IOS, and PIX devices. This tool is a Cisco-compatible VPN client that runs in userspace. Use it to establish secure tunnels, decrypt Cisco VPN passwords, or convert proprietary .pcf configuration files into standard vpnc formats during network penetration testing or infrastructure access tasks.
---

# vpnc

## Overview
vpnc is a VPN client compatible with Cisco 3000 VPN Concentrators (EasyVPN). It supports MD5/SHA1 hashes, 3DES/AES ciphers, PFS, and various IKE DH groups. It operates in userspace using the tun driver. Category: Sniffing & Spoofing / Network Access.

## Installation (if not already installed)
Assume vpnc is already installed. If missing:

```bash
sudo apt install vpnc
```

## Common Workflows

### Connect using command line arguments
```bash
sudo vpnc --gateway vpn.example.com --id mygroup --secret grouppass --username myuser
```

### Convert a Cisco .pcf file and connect
```bash
pcf2vpnc connection.pcf myvpn.conf
sudo vpnc ./myvpn.conf
```

### Decrypt an obfuscated Cisco password
```bash
cisco-decrypt 7D13011C0D1E10162E20045E
```

### Disconnect from the active VPN
```bash
sudo vpnc-disconnect
```

## Complete Command Reference

### vpnc / vpnc-connect
Main client to initiate connections. `vpnc-connect` is a wrapper for `vpnc`.

**Usage:** `vpnc [options] [config files]`

| Flag | Description |
|------|-------------|
| `--version` | Print version information |
| `--print-config` | Print the configuration and exit |
| `--help` | Show basic help |
| `--long-help` | Show all available options (including advanced crypto settings) |
| `--gateway <ip/host>` | IP or hostname of the IPSec gateway |
| `--id <string>` | Your VPN group name (IPSec ID) |
| `--secret <string>` | Your group password in cleartext (IPSec secret) |
| `--username <string>` | Your Xauth username |
| `--password <string>` | Your Xauth password in cleartext |

### cisco-decrypt
Decrypts obfuscated Cisco VPN client pre-shared keys (found in .pcf files).

**Usage:** `cisco-decrypt <obfuscated_hex_string>`

### pcf2vpnc
Converts Cisco VPN configuration files (.pcf) to vpnc format (.conf).

**Usage:** `pcf2vpnc <pcf file> [vpnc file]`

- If `[vpnc file]` is omitted, output is printed to STDOUT.

### vpnc-disconnect
Terminates the active vpnc session.

**Usage:** `vpnc-disconnect`

## Notes
- **Privileges**: Running `vpnc` and `vpnc-disconnect` typically requires root/sudo privileges to manage network interfaces and routing tables.
- **Security**: Configuration files created by `pcf2vpnc` may contain sensitive cleartext passwords; ensure file permissions are restricted (e.g., `chmod 600`).
- **Dependencies**: Requires the `tun` kernel module to be available.