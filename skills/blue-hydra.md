---
name: blue-hydra
description: Bluetooth device discovery service that tracks both Classic and Low Energy (LE) Bluetooth devices using bluez and Ubertooth. Use when performing Bluetooth reconnaissance, device tracking, signal strength (RSSI) monitoring, or "fox hunting" during wireless security assessments.
---

# blue-hydra

## Overview
BlueHydra is a Bluetooth device discovery service built on top of the bluez library. It attempts to track both classic and Low Energy (LE) Bluetooth devices over time, leveraging Ubertooth hardware if available to enhance discovery capabilities. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume blue-hydra is already installed. If you encounter errors, ensure Bluetooth services are active and dependencies are met.

```bash
sudo apt update
sudo apt install blue-hydra
```

Dependencies: bluez-test-scripts, libc6, libruby, libsqlite3-0, python3, ruby.

## Common Workflows

### Standard Device Discovery
Run the service in the foreground to see discovered devices and their properties in real-time.
```bash
blue_hydra
```

### Stealthy/Demo Mode
Hide MAC addresses in the CLI UI, useful for presentations or public demonstrations.
```bash
blue_hydra --demo
```

### High-Speed Tracking (Fox Hunting)
Disable info scanning to minimize gaps in tracking, focusing purely on presence and signal strength.
```bash
blue_hydra --no-info
```

### Headless Operation
Run as a daemon to collect data in the background without terminal output.
```bash
blue_hydra --daemonize
```

## Complete Command Reference

### blue_hydra
The main discovery service.

| Flag | Description |
|------|-------------|
| `-d`, `--daemonize` | Suppress output and run in daemon mode |
| `-z`, `--demo` | Hide MAC addresses in the CLI UI |
| `-p`, `--pulse` | Send results to Hermes |
| `--pulse-debug` | Store results in a file for review |
| `--no-db` | Keep the database in RAM only (data lost on exit) |
| `--rssi-api` | Open 127.0.0.1:1124 to allow other processes to poll for seen devices and RSSI |
| `--no-info` | Skip info scanning (useful for fox hunting to reduce tracking gaps) |
| `--mohawk-api` | Output the UI as JSON at `/dev/shm/blue_hydra.json` |
| `-v`, `--version` | Show version and quit |
| `-h`, `--help` | Show help message |

### test-discovery
A helper utility for testing Bluetooth discovery on specific interfaces.

| Flag | Description |
|------|-------------|
| `-i DEV_ID`, `--device=DEV_ID` | Specify the device ID (e.g., hci0) |
| `-t TIMEOUT`, `--timeout=TIMEOUT` | Set discovery timeout |
| `-h`, `--help` | Show help message |

## Notes
- **Hardware**: While it works with standard Bluetooth adapters, using an **Ubertooth One** significantly improves the detection of "non-discoverable" classic devices and LE advertising packets.
- **Database**: By default, BlueHydra stores discovered device data in a local SQLite database. Use `--no-db` if you do not want to persist data to the disk.
- **RFKill**: If the tool fails to initialize the adapter, ensure the Bluetooth radio is not blocked using `rfkill list` and `rfkill unblock bluetooth`.