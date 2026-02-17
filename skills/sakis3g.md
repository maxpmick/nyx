---
name: sakis3g
description: Establish 3G/UMTS/GPRS connections using USB or Bluetooth modems. Use when performing wireless security audits, mobile network testing, or establishing out-of-band management channels via cellular networks when standard networking is unavailable.
---

# sakis3g

## Overview
Sakis3G is a comprehensive shell script designed to simplify the process of establishing 3G connections. It automates the configuration of USB and Bluetooth modems, handles operator settings, and manages PPP connections. Category: Wireless Attacks / Network Connectivity.

## Installation (if not already installed)
Sakis3G is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install sakis3g
```
Dependencies: `bzip2`, `libusb-1.0-0`.

## Common Workflows

### Interactive Connection Setup
Launch the interactive UI to select modem and operator settings:
```bash
sudo sakis3g --interactive connect
```

### Quick Disconnect
Terminate all active PPP connections established by the script:
```bash
sudo sakis3g disconnect
```

### Connection Status Check
Check if a cellular connection is currently active:
```bash
sudo sakis3g status
```
Returns exit code 0 if connected, 6 if disconnected.

### Headless Reconnect
Force a disconnection and immediate reconnection (useful for scripts):
```bash
sudo sakis3g reconnect
```

## Complete Command Reference

```bash
sakis3g [actors] [switches] [variables]
```

### Actors (Primary Commands)

| Actor | Description |
|-------|-------------|
| `connect` | Attempts to establish a 3G connection. |
| `disconnect` | Stops all active PPP connections. |
| `toggle` | Connects if offline; disconnects if already connected. |
| `reconnect` | Disconnects the current session and attempts a new connection. |
| `start` | Alias for `connect` (used for init.d compatibility). |
| `stop` | Alias for `disconnect` (used for init.d compatibility). |
| `reload` | Alias for `reconnect`. |
| `force-reload`| Alias for `reconnect`. |
| `restart` | Alias for `reconnect`. |
| `desktop` | Creates a desktop shortcut for the Sakis3G script. |
| `status` | Prints connection status. Exit code 0 (connected) or 6 (not connected). |
| `help` | Prints the help screen and exits. |
| `man` | Displays the manual page. |

### Switches and Variables

While the primary interface is actor-based, the script supports several switches and environment variables for automation:

| Option | Description |
|--------|-------------|
| `--interactive` | Forces the script to use a visual/interactive interface (Zenity, Whiptail, or Select). |
| `--console` | Forces the script to run in console mode. |
| `APN="<apn>"` | Manually specify the Access Point Name. |
| `APN_USER="<user>"` | Manually specify the APN username. |
| `APN_PASS="<pass>"` | Manually specify the APN password. |
| `MODEM="<type>"` | Specify modem type (e.g., USB, Bluetooth). |
| `BAUD="<speed>"` | Specify the baud rate for the connection. |

## Notes
- **Root Privileges**: This tool requires root privileges. If run as a standard user, it will attempt to acquire them via `sudo` or `su`.
- **Reliability**: Sakis3G is often considered a "last resort" tool when standard NetworkManager or `wvdial` configurations fail to initialize a specific 3G modem.
- **Hardware Support**: It includes many modeswitch configurations for USB dongles that do not natively present as modems when first plugged in.