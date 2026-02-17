---
name: util-linux
description: A comprehensive suite of essential Linux system utilities for low-level system management, hardware configuration, and data manipulation. Use for disk partitioning (fdisk, cfdisk), filesystem mounting (mount, lsblk), process management (renice, taskset), terminal session recording (script), and hardware clock/CPU configuration. Essential for system administration, forensics, and post-exploitation environment stabilization.
---

# util-linux

## Overview
The `util-linux` suite is a collection of fundamental system utilities for the Linux operating system. It covers a wide range of domains including Reconnaissance (information gathering about hardware/disks), Forensics (disk imaging and partition analysis), and Post-Exploitation (privilege manipulation and environment stabilization).

## Installation (if not already installed)
These tools are typically pre-installed on Kali Linux. If missing:
```bash
sudo apt update && sudo apt install util-linux bsdextrautils bsdutils eject fdisk mount rfkill util-linux-extra uuid-runtime
```

## Common Workflows

### Disk Analysis and Partitioning
```bash
# List all block devices with filesystem info
lsblk -f

# View partition table of a specific disk
sudo fdisk -l /dev/sda

# Interactive partition management
sudo cfdisk /dev/sdb
```

### Terminal Session Recording (Audit Trail)
```bash
# Start recording a session to 'session.log' with timing data
script -T session.timing session.log

# Play back the recorded session at double speed
scriptreplay -t session.timing session.log 2
```

### System Information Gathering
```bash
# Display CPU architecture details
lscpu

# View kernel ring buffer (dmesg) with human-readable timestamps
dmesg -T

# List all open file descriptors for a specific process
lsfd -p 1234
```

### Privilege and Namespace Manipulation
```bash
# Run a command in a new network namespace
sudo unshare --net /bin/bash

# Enter the namespaces of a target process
sudo nsenter -t <pid> -m -u -i -n -p
```

## Complete Command Reference

### Disk and Filesystem Utilities

#### fdisk / cfdisk / sfdisk
Manipulate disk partition tables.
- `fdisk [options] <disk>`: Standard text-mode partitioner.
- `cfdisk [options] <disk>`: Curses-based interactive partitioner.
- `sfdisk [options] <dev>`: Scriptable partition table manipulator.
  - `-l, --list`: List partitions.
  - `-d, --dump`: Dump partition table for backup/scripting.
  - `-J, --json`: JSON output.

#### lsblk
List block devices.
- `-a, --all`: Print all devices.
- `-f, --fs`: Output info about filesystems.
- `-J, --json`: JSON output.
- `-o, --output <list>`: Specify columns (NAME, SIZE, TYPE, MOUNTPOINT, etc.).

#### blkid
Locate/print block device attributes (UUID, Label).
- `-L <label>`: Convert label to device name.
- `-U <uuid>`: Convert UUID to device name.
- `-p, --probe`: Low-level probing (bypass cache).

#### mount / umount
Mount and unmount filesystems.
- `mount -a`: Mount all filesystems in fstab.
- `mount -o <options>`: Specify mount options (ro, rw, loop, etc.).
- `umount -l`: Lazy unmount (detach now, cleanup later).
- `umount -f`: Force unmount (useful for unreachable NFS).

#### wipefs
Wipe signatures (magic strings) from a device.
- `-a, --all`: Wipe all magic strings.
- `-n, --no-act`: Dry run.

### System and Process Utilities

#### dmesg
Print or control the kernel ring buffer.
- `-C, --clear`: Clear the buffer.
- `-w, --follow`: Wait for new messages.
- `-T, --ctime`: Human-readable timestamps.
- `-l, --level <list>`: Filter by level (err, warn, info, debug).

#### lscpu
Display CPU architecture information.
- `-e, --extended`: Extended readable format.
- `-J, --json`: JSON output.

#### renice
Alter priority of running processes.
- `-n <priority>`: Specify nice value (-20 to 19).
- `-p <pid>`: Interpret arguments as PIDs.
- `-u <user>`: Interpret arguments as usernames.

#### taskset
Set or retrieve a process's CPU affinity.
- `-p, --pid`: Operate on existing PID.
- `-c, --cpu-list`: Use list format (e.g., 0,2-4).

#### script / scriptreplay
Record and play back terminal sessions.
- `script [file]`: Start recording.
- `-c <command>`: Run specific command instead of shell.
- `scriptreplay <timingfile> <typescript>`: Play back recording.

### Data Manipulation Utilities

#### hexdump / hd
Display file contents in hex, decimal, octal, or ASCII.
- `-C, --canonical`: Canonical hex+ASCII display.
- `-n <length>`: Interpret only N bytes.
- `-s <offset>`: Skip N bytes.

#### column
Columnate lists into tables.
- `-t, --table`: Create a table.
- `-s, --separator <string>`: Specify input delimiters.
- `-J, --json`: JSON output.

#### rev
Reverse lines characterwise.

### Privilege and Security Utilities

#### runuser / su
Run a command with substitute user/group ID.
- `-u, --user <user>`: Specify username.
- `-l, --login`: Make the shell a login shell.
- `-c, --command <cmd>`: Pass command to shell.

#### setpriv
Run a program with different privilege settings.
- `--dump`: Show current state.
- `--no-new-privs`: Disallow granting new privileges.
- `--ruid/--euid <id>`: Set real/effective UID.

#### unshare / nsenter
Namespace manipulation.
- `unshare --net`: Run in new network namespace.
- `nsenter -t <pid> --all`: Enter all namespaces of target PID.

### Miscellaneous

#### rfkill
Enable/disable wireless devices (WLAN, Bluetooth).
- `list`: List devices.
- `block <id>`: Disable device.
- `unblock <id>`: Enable device.

#### uuidgen
Create a new UUID.
- `-r`: Random-based.
- `-t`: Time-based.

#### logger
Enter messages into the system log.
- `-t <tag>`: Mark line with tag.
- `-p <priority>`: Set priority (e.g., user.notice).

## Notes
- **Safety**: Tools like `fdisk`, `wipefs`, and `blkdiscard` are destructive. Always verify device paths (e.g., `/dev/sdX`) before execution.
- **Permissions**: Most hardware and system-level commands require `sudo`.
- **JSON Support**: Many modern `util-linux` tools support `-J` or `--json`, which is highly recommended for parsing output in automated scripts.