---
name: safecopy
description: Data recovery tool designed to extract maximum data from damaged or problematic media like floppy disks, hard drives, CDs, and DVDs. Use during digital forensics, disaster recovery, or when standard tools like 'dd' fail due to I/O errors, allowing for incremental passes and low-level device resets to bypass bad sectors.
---

# safecopy

## Overview
Safecopy is a data recovery tool that identifies damaged areas on storage media, skips over them, and continues reading to create a disk image. It uses an incremental algorithm to find the exact boundaries of bad sectors and can perform low-level operations (like device resets or raw mode reads) to resurrect data that standard OS calls cannot reach. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume safecopy is already installed. If the command is missing:

```bash
sudo apt install safecopy
```

## Common Workflows

### Stage 1: Fast Rescue
Quickly recover the bulk of healthy data by skipping large chunks when errors are encountered and not performing retries.
```bash
safecopy --stage1 /dev/sdb1 recovery.img
```

### Stage 2: Detailed Search
Use the badblocks file from Stage 1 to focus on the damaged areas and find the exact edges of readable data.
```bash
safecopy --stage2 /dev/sdb1 recovery.img
```

### Stage 3: Aggressive Recovery
Perform maximum retries and use low-level device resets to attempt recovery of the most stubborn sectors.
```bash
safecopy --stage3 /dev/sdb1 recovery.img
```

### Manual Incremental Recovery
Continue a previous interrupted run without a specific badblocks list.
```bash
safecopy -I /dev/null /dev/sdb1 recovery.img
```

## Complete Command Reference

```bash
safecopy [options] <source> <target>
```

### Preset Stages
| Flag | Description |
|------|-------------|
| `--stage1` | Preset for fast rescue. (Sets: `-f 10% -r 10% -R 1 -Z 0 -L 2 -M BaDbLoCk -o stage1.badblocks`) |
| `--stage2` | Preset for more data, searching for exact ends of bad areas. (Sets: `-f 128* -r 1* -R 1 -Z 0 -L 2 -I stage1.badblocks -o stage2.badblocks`) |
| `--stage3` | Preset for maximum rescue using retries and low-level tricks. (Sets: `-f 1* -r 1* -R 4 -Z 1 -L 2 -I stage2.badblocks -o stage3.badblocks`) |

### Performance & Strategy Options
| Flag | Description |
|------|-------------|
| `-b <size>` | Blocksize for default read operations. Default: 1* (Hardware size or 4096). |
| `-f <size>` | Blocksize when skipping over badblocks. Higher values reduce hardware strain. Default: 16*. |
| `-r <size>` | Resolution in bytes when searching for edges of bad areas. Default: 1*. |
| `-R <number>` | Number of read attempts on the first bad block of a damaged area. Default: 3. |
| `-Z <number>` | Number of times to force seek the head from start to end on error (head realignment). Default: 1. |
| `--sync` | Use synchronized read calls (O_DIRECT or O_SYNC) to disable driver buffering. |
| `--forceopen` | Keep trying to reopen source after read errors (useful for flaky USB drives). |

### Low Level & Device Options
| Flag | Description |
|------|-------------|
| `-L <mode>` | Low level device calls: `0` (None), `1` (Error recovery only), `2` (Always). |
| `-S <script>` | Use external script for seeking (takes blocks, blocksize, and current pos as args). |

### Position & Range Options
| Flag | Description |
|------|-------------|
| `-s <blocks>` | Start position in source. |
| `-l <blocks>` | Maximum length of data to be read. |
| `-c <blocks>` | Continue copying at this position (useful for fixed-size block devices). |

### Incremental & Exclusion Options
| Flag | Description |
|------|-------------|
| `-I <file>` | Incremental mode. Use existing target and only attempt blocks listed in badblockfile. |
| `-i <bytes>` | Blocksize to interpret the `-I` badblockfile. |
| `-X <file>` | Exclusion mode. Do not read/write areas covered by this badblockfile. |
| `-x <bytes>` | Blocksize to interpret the `-X` badblockfile. |
| `-o <file>` | Write a badblocks/e2fsck compatible bad block file. |

### Output & Debugging
| Flag | Description |
|------|-------------|
| `-M <string>` | Mark unrecovered data with this string instead of zeros. |
| `--debug <lvl>`| Enable debug bitfield: 1 (flow), 2 (IO), 4 (marking), 8 (seeking), 16 (inc), 32 (exc). 255 for all. |
| `-T <file>` | Write sector read timing information to file. |
| `-h`, `--help` | Show help text. |

### Parameter Units
- `<integer>`: Bytes (e.g., `1024`)
- `<percentage>%`: Percentage of total size (e.g., `10%`)
- `<number>*`: For `-b`, multiplier of OS blocksize. For `-f`/`-r`, multiplier of `-b` value.

## Notes
- **Output Symbols**:
    - `.` : Successful read.
    - `X` : Unrecoverable error, block skipped/padded.
    - `<` / `>` : Backtracking or reducing blocksize to find readable data.
    - `!` : Low level retry.
- **Warning**: Using `-I` without `-c` or a valid file will empty the destination file unless specified otherwise. Use `-I /dev/null` to safely resume a previous run without a badblock list.
- **Hardware Strain**: Aggressive settings (`-R`, `-Z`, small `-r`) can further damage failing mechanical drives. Use Stage 1 first.