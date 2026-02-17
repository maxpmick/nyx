---
name: sparrow-wifi
description: A graphical Wi-Fi analyzer and reconnaissance tool for Linux that integrates Wi-Fi scanning, Bluetooth (Ubertooth), Software Defined Radio (SDR), and GPS tracking. Use when performing wireless site surveys, signal analysis, drone-based RF mapping, or identifying unauthorized access points and Bluetooth devices.
---

# sparrow-wifi

## Overview
Sparrow-wifi is a comprehensive graphical Wi-Fi analyzer designed as a Linux-based alternative to tools like inSSIDer. It integrates multiple RF data sources including Wi-Fi interfaces, SDR (HackRF), Bluetooth (traditional and Ubertooth), and GPS (via gpsd or Mavlink for drones/rovers) into a single solution for signal visualization and mapping. Category: Wireless Attacks / Reconnaissance.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing, install via:

```bash
sudo apt update
sudo apt install sparrow-wifi
```

## Common Workflows

### Launching the Graphical Interface
To start the main GUI for interactive analysis:
```bash
sparrow-wifi
```

### Starting a Headless Remote Agent
Run the agent on a remote sensor or drone to capture data and serve it over HTTP:
```bash
sparrowwifiagent --port 8020 --allowedips 192.168.1.5
```

### Headless Recording with Static Coordinates
Start the agent and immediately begin recording Wi-Fi data at a fixed location without a GPS lock:
```bash
sparrowwifiagent --recordinterface wlan0mon --staticcoord 40.7128,-74.0060,10
```

### Drone Integration (Mavlink)
Connect the agent to a drone's telemetry stream for GPS-tagged RF mapping:
```bash
sparrowwifiagent --mavlinkgps udp:10.1.1.10:14550
```

## Complete Command Reference

### sparrow-wifi
The primary command to launch the Graphical User Interface. It does not typically take command-line arguments as configuration is handled within the GUI.

### sparrowwifiagent
The headless backend agent used for remote data collection or automated recording.

```
usage: sparrowwifiagent.py [-h] [--port PORT] [--allowedips ALLOWEDIPS]
                           [--staticcoord STATICCOORD]
                           [--mavlinkgps MAVLINKGPS] [--sendannounce]
                           [--userpileds] [--recordinterface RECORDINTERFACE]
                           [--ignorecfg] [--cfgfile CFGFILE] [--allowcors]
                           [--delaystart DELAYSTART] [--debughttp]
```

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show the help message and exit. |
| `--port PORT` | Port for the HTTP server to listen on. Default is `8020`. |
| `--allowedips ALLOWEDIPS` | IP addresses allowed to connect to this agent. Default is any. Can be a comma-separated list. |
| `--staticcoord STATICCOORD` | Use user-defined `lat,long,altitude(m)` rather than GPS. Example: `40.1,-75.3,150`. |
| `--mavlinkgps MAVLINKGPS` | Use Mavlink (drone) for GPS. Options: `3dr` (Solo), `sitl` (local simulator), or connection string (e.g., `udp:10.1.1.10:14550`). |
| `--sendannounce` | Send a UDP broadcast packet on the specified port to announce presence to the GUI. |
| `--userpileds` | Use Raspberry Pi LEDs to signal state. Red: GPS (Off=None, Blinking=Unsynced, Solid=Synced). Green: Agent (On=Running, Blinking=Servicing request). |
| `--recordinterface RECORDINTERFACE` | Automatically start recording locally with the given wireless interface (headless mode) in a recordings directory. |
| `--ignorecfg` | Do not load any config files; useful for overriding settings or testing. |
| `--cfgfile CFGFILE` | Use the specified config file rather than the default `sparrowwifiagent.cfg`. |
| `--allowcors` | Allow Cross-Domain Resource Sharing (CORS). |
| `--delaystart DELAYSTART` | Wait the specified number of seconds before initializing. |
| `--debughttp` | Print each incoming URL request to the console for debugging. |

## Notes
- **Hardware Support**: For full functionality, specialized hardware like a HackRF (for SDR) or Ubertooth One (for advanced Bluetooth) is recommended.
- **GPS**: The tool relies on `gpsd` for traditional GPS receivers. Ensure the `gpsd` service is running if using a local USB GPS dongle.
- **Permissions**: Running wireless interfaces in monitor mode or accessing raw USB devices (SDR/Ubertooth) usually requires `sudo` or membership in the `plugdev` group.