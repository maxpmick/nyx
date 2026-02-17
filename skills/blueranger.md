---
name: blueranger
description: Locate Bluetooth devices by monitoring Link Quality (LQ) through L2CAP pings. Use when performing physical proximity tracking of Bluetooth-enabled devices, signal strength analysis, or site surveys during wireless security assessments.
---

# blueranger

## Overview
BlueRanger is a simple Bash script that uses Bluetooth Link Quality to locate device radios. It sends L2CAP pings to create a connection between interfaces, as most devices allow these pings without authentication. The higher the link quality (max 255), the closer the device is theoretically located. Category: Wireless Attacks / Bluetooth.

## Installation (if not already installed)
Assume blueranger is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install blueranger
```

## Common Workflows

### Locate a specific device
Identify the local interface (usually `hci0`) and the target MAC address to begin tracking:
```bash
blueranger hci0 00:11:22:33:44:55
```

### Tracking with a secondary adapter
If using an external high-power Class 1 adapter for better range:
```bash
blueranger hci1 20:C9:D0:43:4B:D8
```

## Complete Command Reference

```bash
blueranger <hciX> <bdaddr>
```

### Arguments

| Argument | Description |
|----------|-------------|
| `<hciX>` | Local Bluetooth interface (e.g., hci0, hci1) |
| `<bdaddr>` | Remote Device Bluetooth Address (e.g., 00:11:22:33:44:55) |

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help/usage information |

## Notes
- **Hardware Selection**: Use a Bluetooth Class 1 adapter for long-range detection. Switch to a Class 3 adapter for more precise short-range locating.
- **Accuracy**: Precision depends on adapter build quality, environmental interference, and the response from the remote device. Fluctuations in Link Quality can occur even if neither device is moving.
- **Termination**: To stop the tracking process, use `Ctrl+C` twice.
- **Mechanism**: The tool relies on the fact that most Bluetooth devices respond to L2CAP pings without requiring pairing or authorization.