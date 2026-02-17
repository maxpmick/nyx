---
name: ddrescue
description: Recover data from damaged or corrupted storage devices, partitions, or files. Unlike standard copy tools, it does not abort on I/O errors, instead using adaptive block sizes to bypass bad sectors and maximize data retrieval. Use during digital forensics, incident response, or data recovery operations when dealing with failing hardware or corrupted filesystems.
---

# ddrescue

## Overview
`dd_rescue` is a data recovery tool designed to copy data from one file or block device to another while handling I/O errors gracefully. It optimizes the recovery process by using large block sizes for healthy areas and falling back to smaller blocks when encountering errors. It supports reverse copying, sparse writes, and secure data wiping. Category: Digital Forensics / Recovery.

## Installation (if not already installed)
Assume `dd_rescue` is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install ddrescue
```

## Common Workflows

### Basic Recovery
Copy a failing partition to an image file, continuing past errors:
```bash
dd_rescue /dev/sdb1 recovery_image.img
```

### Resume/Partial Recovery
Start copying from a specific offset (e.g., 100MB into the source):
```bash
dd_rescue -s 100M /dev/sdb1 recovery_image.img
```

### Reverse Recovery
Approach a bad spot from the end of the disk to the beginning (useful if the drive hangs at a specific forward sector):
```bash
dd_rescue -r /dev/sdb1 recovery_image.img
```

### Secure Data Wiping
Overwrite a disk with 3 passes of random data and a final pass of zeros (BSI M7.15 standard):
```bash
dd_rescue -3 0 /dev/sdb1
```

## Complete Command Reference

```bash
dd_rescue [options] infile outfile
```

### Positioning and Size Options
| Flag | Description |
|------|-------------|
| `-s ipos` | Start position in input file (default=0) |
| `-S opos` | Start position in output file (default=ipos) |
| `-m maxxfer` | Maximum amount of data to be transferred (default=0/infinite) |
| `-x` | Count `opos` from the end of outfile (eXtend) |

### Block Size and Performance Options
| Flag | Description |
|------|-------------|
| `-b softbs` | Block size for copy operation (default=131072; 1048576 for `-d`) |
| `-B hardbs` | Fallback block size in case of errors (default=4096; 512 for `-d`) |
| `-y syncsz` | Frequency of `fsync` calls in bytes (default=512*softbs) |
| `-d` | Use `O_DIRECT` for input (bypasses kernel pagecache) |
| `-D` | Use `O_DIRECT` for output (bypasses kernel pagecache) |
| `-k` | Use efficient in-kernel zerocopy `splice` |
| `-C limit` | Rate control: avoid transferring data faster than `limit` B/s |

### Error and Flow Control Options
| Flag | Description |
|------|-------------|
| `-e maxerr` | Exit after `maxerr` errors (default=0/infinite) |
| `-r` | Reverse direction copy (default=forward) |
| `-w` | Abort on Write errors (default=no) |
| `-f` | Force: skip some sanity checks |
| `-i` | Interactive: ask before overwriting data |

### Output and File Handling Options
| Flag | Description |
|------|-------------|
| `-M` | Avoid extending outfile |
| `-t` | Truncate output file at start |
| `-T` | Truncate output file at last position reached |
| `-u` | Undo writes by deleting outfile and issuing `fstrim` |
| `-P` | Use `fallocate` to preallocate target space |
| `-a` | Detect zero-filled blocks and write sparsely |
| `-A` | Always write blocks, even if zeroed due to error |
| `-p` | Preserve: ownership, permissions, times, and attributes |
| `-Y oname` | Secondary output file (multiple instances allowed) |

### Logging and Plugins
| Flag | Description |
|------|-------------|
| `-l logfile` | Name of a file to log errors and summary to |
| `-o bbfile` | Name of a file to log bad block numbers |
| `-L plugins` | Load plugins (e.g., `-L plug1=par1,plug2`). Supports compression, hashing, encryption |

### Data Protection (Wiping) Options
Instead of `infile`, use these to generate data:
| Flag | Description |
|------|-------------|
| `-z SEED` | Use PRNG from libc or frandom as input. `0` = time-based seed |
| `-Z SEEDFILE` | Use a file (e.g., `/dev/urandom`) as the seed for PRNG |
| `-2 SEED/FILE` | Overwrite 2 times (random pass, then 0) |
| `-3 SEED/FILE` | Overwrite 3 times (random, inverse random, 0) |
| `-4 SEED/FILE` | Overwrite 4 times (random, inverse random, random2, 0) |
| `-R` | Repeatedly write the same block (default if infile is `/dev/zero`) |

### General Options
| Flag | Description |
|------|-------------|
| `-q` | Quiet operation |
| `-v` | Verbose operation |
| `-c 0/1` | Switch off/on colors (default=auto) |
| `-V` | Display version and exit |
| `-h` | Display help and exit |

## Notes
- **Units**: Sizes can be suffixed with `b` (512), `k` (1024), `M` (1024^2), or `G` (1024^3).
- **Plugins**: The `ddr_hash` plugin can calculate SHA256 or HMAC during the copy process.
- **Safety**: Always double-check `infile` and `outfile` paths, especially when using the force (`-f`) flag or wiping modes.