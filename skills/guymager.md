---
name: guymager
description: Perform forensic imaging of storage media to create bit-stream copies in EWF, AFF, or raw (dd) formats. Use when conducting digital forensics, incident response, or evidence preservation to ensure data integrity through multi-threaded hash calculation (MD5/SHA256) and parallel compression.
---

# guymager

## Overview
Guymager is a Qt-based forensic imager designed for high-speed acquisition of storage media. It supports EWF (Expert Witness Format), AFF (Advanced Forensic Format), and raw dd images. It utilizes a multi-threaded engine for reading, hashing, and compression, making it highly efficient on multi-core systems. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)

Guymager is typically pre-installed in Kali Linux. If missing, install it using:

```bash
sudo apt update
sudo apt install guymager
```

Note: Guymager requires root privileges to access physical devices.

## Common Workflows

### Launch the GUI with default settings
```bash
sudo guymager
```

### Use a custom log file location
```bash
sudo guymager log=/home/kali/case_001/guymager.log
```

### Generate a template configuration file
Use this to see all available internal parameters that can be tuned.
```bash
guymager cfg=template.cfg
```

### Run with specific performance tuning
Override the configuration file to use a specific number of compression threads.
```bash
sudo guymager CompressionThreads=8
```

## Complete Command Reference

### Basic Syntax
```bash
guymager [log=log_file] [cfg=configuration_file] [option=value] ...
```

### Primary Options

| Option | Description |
|------|-------------|
| `log=<file>` | Path to the log file. Default: `/var/log/guymager.log` |
| `cfg=<file>` | Path to the configuration file. Default: `/etc/guymager/guymager.cfg` |
| `cfg=template.cfg` | Special command to create a template configuration file with default values |

### Configuration Overrides
Any parameter found in `/etc/guymager/guymager.cfg` can be passed as a command-line argument. Common parameters include:

| Parameter | Description |
|-----------|-------------|
| `CompressionThreads=<n>` | Number of threads used for parallelized compression |
| `HashThreads=<n>` | Number of threads used for hash calculation |
| `AutoExit=<0\|1>` | If set to 1, Guymager terminates automatically when all tasks are finished |

*Note: For a full list of over 50+ configurable parameters (UI colors, buffer sizes, default paths, etc.), refer to the `/etc/guymager/guymager.cfg` file.*

## Exit Codes
- `0`: Normal termination.
- `1`: Terminated via the `AutoExit` function.
- `Other`: Internal Guymager or Qt framework errors.

## Notes
- **Root Privileges**: You must run Guymager as root (e.g., `sudo guymager`) to see and acquire physical drives.
- **Write Blocking**: While Guymager is designed for forensic use, it is best practice to use a hardware write-blocker whenever possible.
- **Performance**: Increasing `CompressionThreads` can significantly speed up EWF/AFF imaging on modern CPUs but increases memory usage.