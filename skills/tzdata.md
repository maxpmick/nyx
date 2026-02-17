---
name: tzdata
description: Configure and manage system time zone and daylight-saving time data. Use when synchronizing system clocks, adjusting local time settings for logs and timestamps, or reconfiguring regional settings during forensics or post-exploitation setup.
---

# tzdata

## Overview
The `tzdata` package contains the database of time zones, UTC offsets, and daylight-saving rules used by the system to determine local time. It is a core component for ensuring accurate timestamping across all security domains, including forensics, logging, and scheduled tasks. Category: System Configuration / Forensics.

## Installation (if not already installed)
The package is typically pre-installed on all Kali Linux variants. If missing or corrupted:

```bash
sudo apt update
sudo apt install tzdata
```

For legacy IBM mainframe offsets (TAI-10s) or non-standard geographical symlinks:
```bash
sudo apt install tzdata-legacy
```

## Common Workflows

### Reconfigure System Time Zone Interactively
The most common way to change the system time zone via a GUI-like menu in the terminal.
```bash
sudo dpkg-reconfigure tzdata
```

### Set Time Zone Non-Interactively
Useful for automated scripts or remote shell environments.
```bash
sudo ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
echo "America/New_York" | sudo tee /etc/timezone
```

### Check Current Time and Zone Status
Verify the current configuration and hardware clock status.
```bash
timedatectl status
```

### List Available Time Zones
Browse the database of available regions and cities.
```bash
timedatectl list-timezones
```

## Complete Command Reference

### dpkg-reconfigure tzdata
Triggers the debconf frontend to update `/etc/localtime` and `/etc/timezone`.

| Option | Description |
|------|-------------|
| `-f <frontend>` | Choose the interface (e.g., `noninteractive`, `readline`, `dialog`) |
| `-p <priority>` | Specify the minimum priority of questions to be displayed |

### Files and Directories

| Path | Description |
|------|-------------|
| `/usr/share/zoneinfo/` | Compiled time zone data files organized by Continent/City |
| `/usr/share/zoneinfo/right/` | (tzdata-legacy) Time zones based on TAI minus 10 seconds |
| `/usr/share/zoneinfo/posix/` | Time zones based on UTC (standard) |
| `/etc/localtime` | Symlink to the active zoneinfo file |
| `/etc/timezone` | Plain text file containing the name of the current time zone |

### tzdata-legacy specific
The `tzdata-legacy` package provides:
- **TAI-10s support**: Located in `/usr/share/zoneinfo/right`. This matches IBM mainframe hardware clock settings.
- **Legacy Symlinks**: Includes older time zone naming conventions that do not follow the modern `Region/City` format.

## Notes
- **Log Accuracy**: Always ensure `tzdata` is correctly configured before starting a penetration test or forensic investigation to ensure all logs have accurate, correlated timestamps.
- **Hardware Clock**: Changing the time zone via `tzdata` affects how the system interprets the Hardware Clock (RTC), but does not necessarily change the RTC itself.
- **Environment Variables**: The `TZ` environment variable can override the system-wide `tzdata` setting for a specific user session or command (e.g., `TZ=UTC date`).