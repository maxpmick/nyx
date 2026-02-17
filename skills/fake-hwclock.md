---
name: fake-hwclock
description: Manage a persistent fake hardware clock on systems lacking a functional Real Time Clock (RTC), such as many ARM-based embedded devices. Use when system time resets to 1970 after reboot, causing filesystem check (fsck) errors or SSL certificate issues, and when NTP is unavailable or not yet synchronized.
---

# fake-hwclock

## Overview
`fake-hwclock` is a utility designed for embedded Linux systems that lack a battery-backed hardware clock. It saves the system time to a file during shutdown and restores it during boot to ensure the system clock remains monotonic (only moves forward) and relatively close to real-time. This prevents issues where the system believes it has traveled back to 1970. Category: System Administration / ARM Utilities.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux ARM images. If missing:

```bash
sudo apt install fake-hwclock
```

## Common Workflows

### Manually saving the current time
Force an immediate save of the current system time to the persistent storage file.
```bash
sudo fake-hwclock save
```

### Restoring time at boot (Manual)
Restores the time from the saved file. By default, it will only move the clock forward.
```bash
sudo fake-hwclock load
```

### Forcing a clock reset
If you need to set the clock to a saved state that is actually earlier than the current system time, use the `force` modifier.
```bash
sudo fake-hwclock load force
```

## Complete Command Reference

```bash
fake-hwclock [command] [force]
```

### Commands

| Command | Description |
|:--------|:------------|
| `save`  | Saves the current system time to `/etc/fake-hwclock.data`. Includes a sanity check to prevent saving a date earlier than the software release date (unless `force` is used). This is the default action if no command is provided. |
| `load`  | Loads the time from the data file. By default, it will **only** move the clock forward. Use `force` to allow the clock to move backward. |

### Arguments

| Argument | Description |
|:---------|:------------|
| `force`  | Overrides sanity checks. For `save`, allows saving dates older than the tool's release. For `load`, allows the system clock to be set backwards. |

### Files and Environment

| Path | Description |
|:-----|:------------|
| `/etc/fake-hwclock.data` | The default storage file for the timestamp. |
| `/etc/default/fake-hwclock` | Configuration file for the init script and service. |
| `/etc/cron.hourly/fake-hwclock` | Cron job that ensures the time is saved every hour. |
| `FILE` (Env Var) | Environment variable used to override the default data file path. |

## Notes
- **NTP Recommended**: This tool is a stop-gap for early boot. Use NTP (Network Time Protocol) to ensure high accuracy once networking is available.
- **Drift**: The clock will "drift" while the hardware is powered off, as no actual hardware timer is running. The time restored at boot will be the time the system was last shut down (or the last hourly cron save).
- **Filesystem Safety**: By ensuring the time is at least as recent as the last shutdown, `fake-hwclock` prevents `fsck` from triggering unnecessary "last mount time is in the future" errors.