---
name: hostapd-wpe
description: Modified hostapd to facilitate Access Point (AP) impersonation attacks. It implements IEEE 802.1x Authenticator and Authentication Server impersonation to obtain client credentials (EAP-FAST, PEAP, EAP-TTLS), establish connectivity, and perform Karma-style probe response attacks. Use during wireless penetration testing to capture WPA-Enterprise credentials or perform man-in-the-middle attacks.
---

# hostapd-wpe

## Overview
hostapd-wpe (Wireless Pwnage Edition) is a modified version of hostapd designed for security auditing. It targets 802.11 and 802.1x clients by impersonating legitimate networks and capturing authentication hashes (MSCHAPv2, PAP, etc.) for offline cracking. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume hostapd-wpe is already installed. If missing:

```bash
sudo apt update
sudo apt install hostapd-wpe
```

## Common Workflows

### Basic Credential Harvesting
1. Prepare the interface (kill conflicting processes):
   ```bash
   sudo airmon-ng check kill
   ```
2. Edit the configuration file (SSID, interface, etc.):
   ```bash
   sudo nano /etc/hostapd-wpe/hostapd-wpe.conf
   ```
3. Launch the rogue AP:
   ```bash
   sudo hostapd-wpe /etc/hostapd-wpe/hostapd-wpe.conf
   ```

### Karma Attack (Respond to all Probes)
Launch with the `-k` flag to respond to any client probe request, regardless of the SSID in the config:
```bash
sudo hostapd-wpe -k /etc/hostapd-wpe/hostapd-wpe.conf
```

### Cupid Mode (Heartbleed)
Target vulnerable clients using the Heartbleed exploit during the TLS handshake:
```bash
sudo hostapd-wpe -c /etc/hostapd-wpe/hostapd-wpe.conf
```

## Complete Command Reference

### hostapd-wpe Options
```
usage: hostapd-wpe [-hdBKtvrkc] [-P <PID file>] [-e <entropy file>] \
         [-g <global ctrl_iface>] [-G <group>]\
         [-i <comma-separated list of interface names>]\
         <configuration file(s)>
```

| Flag | Description |
|------|-------------|
| `-h` | Show usage |
| `-d` | Show debug messages (`-dd` for more) |
| `-B` | Run daemon in the background |
| `-e` | Specify entropy file |
| `-g` | Global control interface path |
| `-G` | Group for control interfaces |
| `-P` | PID file |
| `-K` | Include key data in debug messages |
| `-f` | Log output to debug file instead of stdout |
| `-T` | Record to Linux tracing in addition to logging |
| `-i` | List of interface names to use |
| `-s` | Log output to syslog instead of stdout |
| `-S` | Start all interfaces synchronously |
| `-t` | Include timestamps in debug messages |
| `-v` | Show version |
| `-r` | **WPE:** Return Success where possible (tricks client into thinking auth passed) |
| `-c` | **WPE:** Cupid Mode (Heartbleed against clients) |
| `-k` | **WPE:** Karma Mode (Respond to all probe requests) |

### hostapd-wpe_cli Options
Control tool for the running hostapd-wpe daemon.
```
usage: hostapd_cli [-p<path>] [-i<ifname>] [-hvBr] [-a<path>] [-P<pid file>] [-G<ping interval>] [command..]
```

| Flag | Description |
|------|-------------|
| `-h` | Help |
| `-v` | Version information |
| `-p<path>` | Path to find control sockets (default: `/var/run/hostapd-wpe`) |
| `-s<dir>` | Dir path to open client sockets (default: `/var/run/hostapd-wpe`) |
| `-a<file>` | Run in daemon mode executing action file based on events |
| `-r` | Reconnect when client socket is disconnected (use with `-a`) |
| `-B` | Run daemon in background |
| `-i<ifname>`| Interface to listen on |

### hostapd-wpe_cli Commands
- `ping`: Pings hostapd
- `mib`: Get MIB variables (dot1x, dot11, radius)
- `relog`: Reload/truncate debug log output file
- `status`: Show interface status info
- `sta <addr>`: Get MIB variables for one station
- `all_sta`: Get MIB variables for all stations
- `list_sta`: List all stations
- `new_sta <addr>`: Add a new station
- `deauthenticate <addr>`: Deauthenticate a station
- `disassociate <addr>`: Disassociate a station
- `signature <addr>`: Get taxonomy signature for a station
- `sa_query <addr>`: Send SA Query to a station
- `wps_pbc`: Initiate WPS PBC
- `wps_pin <uuid> <pin>`: Add WPS Enrollee PIN
- `get_config`: Show current configuration
- `interface [ifname]`: Show/select interface
- `level <debug level>`: Change debug level
- `enable`/`disable`: Enable/disable hostapd on current interface
- `reload`: Reload configuration
- `chan_switch <count> <freq>`: Initiate channel switch announcement
- `accept_acl`/`deny_acl`: Manage MAC ACLs (Add/Delete/Show/Clear)

## Notes
- **Logging**: Credentials are automatically logged to `stdout` and `hostapd-wpe.log`.
- **Cracking**: Captured MSCHAPv2 hashes are displayed in a format ready for `asleap` or `John the Ripper` (`$NETNTLM$...`).
- **Supported EAP Types**: EAP-FAST/MSCHAPv2, PEAP/MSCHAPv2, EAP-TTLS/MSCHAPv2, EAP-TTLS/MSCHAP, EAP-TTLS/CHAP, EAP-TTLS/PAP.