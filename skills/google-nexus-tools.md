---
name: google-nexus-tools
description: Interface with Android devices using ADB (Android Debug Bridge) and Fastboot. Use for mobile forensics, application security testing, flashing firmware, sideloading apps, and executing remote shell commands on Android-based hardware. Essential for reconnaissance and exploitation of Android devices during penetration tests.
---

# google-nexus-tools

## Overview
A suite of command-line tools (nexus-adb and nexus-fastboot) used to communicate with Android devices. It enables file transfers, shell access, log viewing, and low-level bootloader interactions. Category: Exploitation / Digital Forensics.

## Installation (if not already installed)
Assume the tools are installed. If "command not found" occurs:

```bash
sudo apt install google-nexus-tools
```

## Common Workflows

### Device Discovery and Shell Access
```bash
nexus-adb devices -l
nexus-adb shell
```

### Installing and Uninstalling Applications
```bash
nexus-adb install path/to/app.apk
nexus-adb uninstall com.example.app
```

### Data Extraction (Forensics)
```bash
nexus-adb pull /sdcard/DCIM/Camera/ ./local_backup/
nexus-adb backup -all -f full_backup.ab
```

### Bootloader Operations (Fastboot)
```bash
nexus-fastboot devices
nexus-fastboot flash recovery recovery.img
nexus-fastboot reboot
```

## Complete Command Reference

### nexus-adb
`nexus-adb [options] <command>`

#### Global Options
| Flag | Description |
|------|-------------|
| `-a` | Listen on all interfaces for a connection |
| `-d` | Direct command to the only connected USB device (errors if multiple) |
| `-e` | Direct command to the only running emulator (errors if multiple) |
| `-s <serial>` | Direct command to specific device/emulator by serial number |
| `-p <path>` | Specify product name or path to product out directory |
| `-H` | Name of adb server host (default: localhost) |
| `-P` | Port of adb server (default: 5037) |

#### General Commands
| Command | Description |
|---------|-------------|
| `devices [-l]` | List connected devices (`-l` for qualifiers) |
| `connect <host>[:<port>]` | Connect to device via TCP/IP (default port 5555) |
| `disconnect [<host>[:<port>]]` | Disconnect from TCP/IP device(s) |
| `help` | Show help message |
| `version` | Show version number |

#### Device Commands
| Command | Description |
|---------|-------------|
| `push <local> <remote>` | Copy file/dir to device |
| `pull <remote> [<local>]` | Copy file/dir from device |
| `sync [<directory>]` | Copy host->device only if changed (partitions: system, data) |
| `shell [<command>]` | Run remote shell interactively or execute a specific command |
| `emu <command>` | Run emulator console command |
| `logcat [<filter>]` | View device log |
| `forward --list` | List all forward socket connections |
| `forward <local> <remote>` | Forward socket connections (tcp, localabstract, jdwp, etc.) |
| `forward --no-rebind <l> <r>` | Forward socket but fail if local is already forwarded |
| `forward --remove <local>` | Remove a specific forward |
| `forward --remove-all` | Remove all forwards |
| `jdwp` | List PIDs of processes hosting a JDWP transport |
| `install [-l] [-r] [-s] <file>` | Install APK (`-l`: lock, `-r`: reinstall, `-s`: SD card) |
| `install --algo <n> --key <h> --iv <h>` | Install encrypted APK |
| `uninstall [-k] <package>` | Remove app (`-k`: keep data/cache) |
| `bugreport` | Return all device information for a bug report |
| `backup [options] [<pkgs>]` | Backup device data to file (Default: backup.ab) |
| `restore <file>` | Restore device contents from backup archive |

#### Scripting & Control
| Command | Description |
|---------|-------------|
| `wait-for-device` | Block until device is online |
| `start-server` | Ensure adb server is running |
| `kill-server` | Kill the adb server |
| `get-state` | Print: offline \| bootloader \| device |
| `get-serialno` | Print serial number |
| `get-devpath` | Print device path |
| `status-window` | Continuously print device status |
| `remount` | Remount /system as read-write |
| `reboot [bootloader\|recovery]` | Reboot device normally or into specific mode |
| `reboot-bootloader` | Reboot into bootloader |
| `root` | Restart adbd with root permissions |
| `usb` | Restart adbd listening on USB |
| `tcpip <port>` | Restart adbd listening on TCP on specified port |

#### Networking
| Command | Description |
|---------|-------------|
| `ppp <tty> [params]` | Run PPP over USB (e.g., `dev:/dev/omap_csmi_tty1`) |

---

### nexus-fastboot
`nexus-fastboot [options] <command>`

#### Commands
| Command | Description |
|---------|-------------|
| `update <filename>` | Reflash device from update.zip |
| `flashall` | Flash boot + recovery + system |
| `flash <partition> [<file>]` | Write a file to a flash partition |
| `erase <partition>` | Erase a flash partition |
| `format <partition>` | Format a flash partition |
| `getvar <variable>` | Display a bootloader variable |
| `boot <kernel> [<ramdisk>]` | Download and boot kernel |
| `flash:raw boot <k> [<r>]` | Create bootimage and flash it |
| `devices` | List all connected devices in bootloader mode |
| `continue` | Continue with autoboot |
| `reboot` | Reboot device normally |
| `reboot-bootloader` | Reboot device into bootloader |
| `help` | Show help message |

#### Options
| Flag | Description |
|------|-------------|
| `-w` | Erase userdata and cache (and format if supported) |
| `-u` | Do not erase partition before formatting |
| `-s <serial>` | Specify device serial number or port path |
| `-l` | List device paths (used with `devices`) |
| `-p <product>` | Specify product name |
| `-c <cmdline>` | Override kernel commandline |
| `-i <vendor_id>` | Specify a custom USB vendor ID |
| `-b <base_addr>` | Specify custom kernel base address (Default: 0x10000000) |
| `-n <page_size>` | Specify NAND page size (Default: 2048) |
| `-S <size>[K\|M\|G]` | Automatically sparse files greater than size (0 to disable) |

## Notes
- **Environment Variables**: 
  - `ADB_TRACE`: Set to `1`, `all`, `adb`, `sockets`, `packets`, `rwx`, `usb`, `sync`, `sysdeps`, `transport`, or `jdwp` for debugging.
  - `ANDROID_SERIAL`: Default serial number to connect to.
  - `ANDROID_LOG_TAGS`: Default tags for `logcat`.
- **Permissions**: Some commands like `remount` or `root` require the device to have an unlocked bootloader or a custom ROM/debug build.
- **Fastboot**: Requires the device to be in "Fastboot Mode" (usually Power + Volume Down during boot).