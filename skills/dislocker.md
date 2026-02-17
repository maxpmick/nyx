---
name: dislocker
description: Read and write BitLocker encrypted volumes on Linux, including Windows Vista through 10 and BitLocker-To-Go (USB/FAT32) partitions. Use when performing digital forensics, recovering data from encrypted Windows drives, or accessing BitLocker-protected media during penetration testing.
---

# dislocker

## Overview
Dislocker is a toolset designed to decrypt and mount BitLocker-encrypted partitions. It creates a virtual NTFS partition file (dislocker-file) which can then be mounted using standard tools to access the underlying data. Category: Digital Forensics / Cryptography.

## Installation (if not already installed)
Assume dislocker is already installed. If you get a "command not found" error:

```bash
sudo apt install dislocker
```

## Common Workflows

### Find BitLocker Partitions
```bash
sudo dislocker-find
```

### Decrypt and Mount with Recovery Password
1. Create a mount point for the dislocker file: `sudo mkdir -p /mnt/bitlocker`
2. Decrypt the volume: `sudo dislocker -V /dev/sdb1 -p123456-123456-123456-123456-123456-123456-123456-123456 -- /mnt/bitlocker`
3. Mount the virtual NTFS file: `sudo mount -o loop /mnt/bitlocker/dislocker-file /mnt/mountpoint`

### Decrypt and Mount with User Password
```bash
sudo dislocker -V /dev/sdb1 -u -- /mnt/bitlocker
# You will be prompted for the password
```

### Decrypt using a BEK file (USB Key)
```bash
sudo dislocker -V /dev/sdb1 -f /path/to/file.bek -- /mnt/bitlocker
```

## Complete Command Reference

### dislocker / dislocker-fuse / dislocker-file
These binaries share the same core decryption options.

```
dislocker [-hqrsv] [-l LOG_FILE] [-O OFFSET] [-V VOLUME DECRYPTMETHOD -F[N]] [-- ARGS...]
```

| Flag | Description |
|------|-------------|
| `-V, --volume VOLUME` | Volume to get metadata and keys from |
| `-O, --offset OFFSET` | BitLocker partition offset, in bytes (default is 0) |
| `-r, --readonly` | Do not allow writing to the BitLocker volume |
| `-s, --stateok` | Do not check the volume's state; assume it's ok to mount |
| `-F, --force-block=[N]` | Force use of metadata block number N (1, 2 or 3) |
| `-l, --logfile LOG_FILE` | Put messages into this file (stdout by default) |
| `-q, --quiet` | Do NOT display anything |
| `-v, --verbosity` | Increase verbosity (CRITICAL errors are displayed by default) |
| `-h, --help` | Print help and exit |
| `--` | End of program options, beginning of FUSE arguments (e.g., mount point) |

**Decryption Methods (DECRYPTMETHOD):**

| Flag | Description |
|------|-------------|
| `-c, --clearkey` | Decrypt volume using a clear key (default) |
| `-p, --recovery-password=[PASS]` | Decrypt volume using the recovery password method |
| `-u, --user-password=[PASS]` | Decrypt volume using the user password method |
| `-f, --bekfile BEKFILE` | Decrypt volume using the .bek file (found on USB keys) |
| `-k, --fvek FVEK_FILE` | Decrypt volume using the Full Volume Encryption Key directly |
| `-K, --vmk VMK_FILE` | Decrypt volume using the Volume Master Key directly |

### dislocker-find
Finds partitions that appear to be BitLocker-encrypted.

```
dislocker-find [-h] [files...]
```

| Argument | Description |
|----------|-------------|
| `files...` | Specific files/devices to check. If omitted, scans system partitions |
| `-h` | Print help |

### dislocker-metadata
Prints technical information about a BitLocker-encrypted volume.

```
dislocker-metadata [-hov] [-V VOLUME]
```

| Flag | Description |
|------|-------------|
| `-V VOLUME` | Volume to get metadata from |
| `-o` | Partition offset |
| `-v` | Increase verbosity to debug level |
| `-h` | Print help |

### dislocker-bek
Reads and prints information about BitLocker External Key (.BEK) files.

```
dislocker-bek [-h] [-f file.bek]
```

| Flag | Description |
|------|-------------|
| `-f file.bek` | The .BEK file to read |
| `-h` | Print help |

## Notes
- **Mounting**: Decrypting with `dislocker` only creates a virtual file (`dislocker-file`). You must perform a second `mount` command on that file to see the actual contents.
- **Permissions**: Most operations require `sudo` to access block devices.
- **Dependencies**: `dislocker-find` requires Ruby to be installed.