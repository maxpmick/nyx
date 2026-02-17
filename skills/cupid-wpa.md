---
name: cupid-wpa
description: Exploit the Heartbleed vulnerability (CVE-2014-0160) over EAP-TLS tunneled protocols (EAP-PEAP, EAP-TLS, EAP-TTLS) in wireless networks. Use when performing wireless security audits to test if clients (via fake AP) or access points (via malicious supplicant) are vulnerable to memory disclosure through heartbeat requests during the TLS handshake.
---

# cupid-wpa

## Overview
Cupid is a patched version of `hostapd` and `wpa_supplicant` that implements a "Heartbleed" attack over wireless EAP-TLS connections. It allows an attacker to request memory fragments from a vulnerable peer (client or AP) before the encrypted tunnel is fully established. Category: Wireless Attacks / Exploitation.

## Installation (if not already installed)
The tool consists of two main components. Assume they are installed; otherwise:

```bash
sudo apt install cupid-hostapd cupid-wpasupplicant
```

## Common Workflows

### Exploit Vulnerable Clients (Fake AP)
Create a configuration file `cupid.conf` with EAP-TLS/PEAP settings, then run:
```bash
cupid-hostapd -ddK cupid.conf
```
The `-ddK` flags ensure maximum debug output and key data visibility to capture the leaked memory.

### Exploit Vulnerable Access Points
Configure `wpa_supplicant.conf` to connect to the target network using EAP-TLS/PEAP, then run:
```bash
cupid-wpa_supplicant -i wlan0 -c /etc/cupid-wpa_supplicant.conf -D nl80211 -ddK
```

### Generate WPA PSK
```bash
cupid-wpa_passphrase MySSID MySecretPassword
```

## Complete Command Reference

### cupid-hostapd
User space daemon for AP management and RADIUS authentication, patched for Heartbleed.

```
cupid-hostapd [-hdBKtv] [-P <PID file>] [-e <entropy file>] [-g <global ctrl_iface>] [-G <group>] <configuration file(s)>
```

| Flag | Description |
|------|-------------|
| `-h` | Show usage |
| `-d` | Show debug messages (`-dd` for more) |
| `-B` | Run daemon in the background |
| `-e` | Entropy file |
| `-g` | Global control interface path |
| `-G` | Group for control interfaces |
| `-P` | PID file |
| `-K` | Include key data in debug messages (Crucial for seeing Heartbleed leaks) |
| `-t` | Include timestamps in debug messages |
| `-v` | Show version |

### cupid-hostapd_cli
Command-line interface for interacting with `cupid-hostapd`.

```
cupid-hostapd_cli [-p<path>] [-i<ifname>] [-hvB] [-a<path>] [-G<ping interval>] [command..]
```

**Options:** `-h` (help), `-v` (version), `-p<path>` (socket path), `-a<file>` (daemon mode action file), `-B` (background), `-i<ifname>` (interface).

**Commands:** `mib`, `sta <addr>`, `all_sta`, `new_sta <addr>`, `deauthenticate <addr>`, `disassociate <addr>`, `get_config`, `help`, `interface`, `level`, `license`, `quit`.

### cupid-wpa_supplicant
Patched WPA supplicant to attack Access Points.

```
cupid-wpa_supplicant [-BddhKLqqstuvW] [-P<pid file>] [-g<global ctrl>] [-G<group>] -i<ifname> -c<config file> [-C<ctrl>] [-D<driver>] [-p<driver_param>] [-b<br_ifname>] [-e<entropy file>] [-f<debug file>] [-o<override driver>] [-O<override ctrl>] [-N ...]
```

| Flag | Description |
|------|-------------|
| `-b` | Optional bridge interface name |
| `-B` | Run daemon in the background |
| `-c` | Configuration file (Required) |
| `-C` | Control interface parameter |
| `-i` | Interface name (e.g., wlan0) |
| `-I` | Additional configuration file |
| `-d` | Increase debugging verbosity (`-dd` recommended) |
| `-D` | Driver name (e.g., `nl80211`, `wext`, `wired`) |
| `-e` | Entropy file |
| `-f` | Log output to file instead of stdout |
| `-g` | Global control interface |
| `-G` | Global control interface group |
| `-K` | Include keys/passwords in debug output |
| `-s` | Log output to syslog |
| `-T` | Record to Linux tracing |
| `-t` | Include timestamps |
| `-h` | Show help |
| `-L` | Show license |
| `-o` | Override driver parameter |
| `-O` | Override control interface |
| `-p` | Driver parameters |
| `-P` | PID file |
| `-q` | Decrease debugging verbosity |
| `-u` | Enable DBus control interface |
| `-v` | Show version |
| `-W` | Wait for control interface monitor |
| `-N` | Start describing new interface |

### cupid-wpa_cli
Interactive tool for `cupid-wpa_supplicant`. Supports standard `wpa_cli` commands including `status`, `scan`, `scan_results`, `add_network`, `set_network`, `enable_network`, `authenticate`, and `p2p_*` operations.

### cupid-wpa_passphrase
Generates a 256-bit PSK from an ASCII passphrase.
```
cupid-wpa_passphrase [ssid] [passphrase]
```

## Notes
- **Heartbleed Mechanism**: The exploit triggers during the TLS handshake of EAP methods. It does not require a valid password/certificate if the target's OpenSSL implementation is vulnerable.
- **Drivers**: Use `-Dnl80211` for most modern Linux wireless drivers.
- **Debug Mode**: Always use `-ddK` when testing for Heartbleed to see the hex dump of the returned heartbeat responses.