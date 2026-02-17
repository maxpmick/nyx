---
name: autopsy
description: A graphical interface to The Sleuth Kit (TSK) command-line digital forensic tools. Use when performing digital forensic analysis on Windows and UNIX file systems (NTFS, FAT, FFS, EXT2FS, EXT3FS) to investigate disk images, recover deleted files, and analyze file system metadata.
---

# autopsy

## Overview
The Autopsy Forensic Browser is a web-based graphical interface for the command-line digital forensic analysis tools in The Sleuth Kit. It allows for the analysis of disk images and live systems, providing features similar to commercial forensic suites for investigating file systems. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume autopsy is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install autopsy
```

Dependencies: binutils, perl, sleuthkit.

## Common Workflows

### Start Autopsy with default settings
```bash
autopsy
```
Starts the server on `localhost:9999`. Open the provided URL in a web browser to begin the investigation.

### Specify a custom evidence locker and port
```bash
autopsy -d /media/usb/evidence -p 8080
```
Sets the directory where cases and hosts are stored and changes the listening port.

### Allow remote access from a specific IP
```bash
autopsy 192.168.1.50
```
Starts the server and allows a browser on the specified remote IP address to connect.

### Live analysis of a local partition
```bash
autopsy -i /dev/sdb1 ext4 /mnt/analysis
```
Configures Autopsy for live analysis of a specific device and filesystem.

## Complete Command Reference

```
autopsy [-c] [-C] [-d evid_locker] [-i device filesystem mnt] [-p port] [remoteaddr]
```

| Flag | Description |
|------|-------------|
| `-c` | Force a cookie in the URL for session management. |
| `-C` | Force NO cookie in the URL. |
| `-d dir` | Specify the evidence locker directory (where case data is stored). |
| `-i device filesystem mnt` | Specify information for live analysis (device path, filesystem type, and mount point). |
| `-p port` | Specify the server port (default: 9999). |
| `remoteaddr` | Specify the IP address of the host with the browser (default: localhost). |

## Notes
- Autopsy 2 (this version) acts as a local web server. After running the command, you must use a web browser to access the interface.
- For security, by default, Autopsy only allows connections from `localhost`. If you need to access it from another machine, you must specify the `remoteaddr`.
- Ensure you have sufficient permissions (often requires `sudo`) to read raw disk devices or images.