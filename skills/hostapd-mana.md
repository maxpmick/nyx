---
name: hostapd-mana
description: Create featureful rogue access points to perform MANA (Loud/Karma) attacks, EAP credential harvesting (WPE), and Sycophant relay attacks. Use when performing wireless security assessments, rogue AP simulation, Evil Twin attacks, or intercepting enterprise (802.1X) credentials.
---

# hostapd-mana

## Overview
`hostapd-mana` is a modified version of hostapd designed for wireless security auditing. It implements the MANA attack, which improves upon the classic Karma attack by responding to directed probe requests for networks the AP doesn't know, as well as "Loud" mode for broader discovery. It also includes WPE (Wireless Password Eater) for harvesting EAP credentials and Sycophant for relaying EAP authentication. Category: Wireless Attacks.

## Installation (if not already installed)
Assume the tool is installed. If not, use:
```bash
sudo apt install hostapd-mana
```

## Common Workflows

### Basic Rogue AP with MANA
Create a configuration file `mana.conf` and run:
```bash
hostapd-mana mana.conf
```

### EAP Credential Harvesting (WPE)
Configure `hostapd-mana` with an EAP-enabled configuration and run in the background to capture hashes:
```bash
hostapd-mana -B -t wpe.conf
```

### Interactive Control
Use the CLI tool to enable or disable features on a running instance:
```bash
hostapd-mana_cli mana_enable
hostapd-mana_cli mana_loud_on
```

## Complete Command Reference

### hostapd-mana (Daemon)
```
usage: hostapd [-hdBKtv] [-P <PID file>] [-e <entropy file>] \
         [-g <global ctrl_iface>] [-G <group>]\
         [-i <comma-separated list of interface names>]\
         <configuration file(s)>
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
| `-K` | Include key data in debug messages |
| `-i` | List of interface names to use |
| `-S` | Start all interfaces synchronously |
| `-t` | Include timestamps in debug messages |
| `-v` | Show version |

### hostapd-mana_cli (Control Tool)
```
usage: hostapd_cli [-p<path>] [-i<ifname>] [-hvB] [-a<path>] \
                   [-P<pid file>] [-G<ping interval>] [command..]
```

| Flag | Description |
|------|-------------|
| `-h` | Help (show usage text) |
| `-v` | Show version information |
| `-p<path>` | Path to find control sockets (default: `/var/run/hostapd-mana`) |
| `-s<dir_path>` | Dir path to open client sockets (default: `/var/run/hostapd-mana`) |
| `-a<file>` | Run in daemon mode executing the action file based on events |
| `-B` | Run as a daemon in the background |
| `-i<ifname>` | Interface to listen on |

#### CLI Commands
| Command | Description |
|---------|-------------|
| `ping` | Pings hostapd |
| `mib` | Get MIB variables (dot1x, dot11, radius) |
| `sta <addr>` | Get MIB variables for one station |
| `all_sta` | Get MIB variables for all stations |
| `new_sta <addr>` | Add a new station |
| `deauthenticate <addr>` | Deauthenticate a station |
| `disassociate <addr>` | Disassociate a station |
| `signature <addr>` | Get taxonomy signature for a station |
| `sa_query <addr>` | Send SA Query to a station |
| `get_config` | Show current configuration |
| `help` | Show usage help |
| `interface [ifname]` | Show interfaces/select interface |
| `level <debug level>` | Change debug level |
| `license` | Show full license |
| `quit` | Exit hostapd_cli |
| `mana_change_ssid` | Change the default SSID for when mana is off |
| `mana_get_ssid` | Get the default SSID for when mana is off |
| `mana_get_state` | Get whether mana is enabled or not |
| `mana_disable` | Disable mana |
| `mana_enable` | Enable mana |
| `mana_loud_off` | Disable mana's loud mode |
| `mana_loud_on` | Enable mana's loud mode |
| `mana_loud_state` | Check mana's loud mode |
| `mana_macacl_off` | Disable MAC ACLs at management frame level |
| `mana_macacl_on` | Enable MAC ACLs at management frame level |
| `mana_macacl_state` | Check mana's MAC ACL mode |
| `mana_wpe_off` | Disable mana's wpe mode |
| `mana_wpe_on` | Enable mana's wpe mode |
| `mana_wpe_state` | Check mana's wpe mode |
| `mana_eapsuccess_off` | Disable mana's eapsuccess mode |
| `mana_eapsuccess_on` | Enable mana's eapsuccess mode |
| `mana_eapsuccess_state` | Check mana's eapsuccess mode |
| `mana_eaptls_off` | Disable mana's eaptls mode |
| `mana_eaptls_on` | Enable mana's eaptls mode |
| `mana_eaptls_state` | Check mana's eaptls mode |
| `sycophant_get_state` | Get whether sycophant is enabled or not |
| `sycophant_disable` | Disable sycophant |
| `sycophant_enable` | Enable sycophant |

## Notes
- Requires a wireless card that supports AP mode.
- Configuration files are highly complex; ensure `mana_wpe` and `mana_loud` parameters are correctly set within the `.conf` file to utilize specific features.
- Captured EAP hashes are typically logged to the console or a specified log file in the configuration.