---
name: myrescue
description: Rescue data from damaged storage media including hard disks, CD-ROMs, DVDs, and flash drives. It prioritizes readable data by quickly skipping damaged areas and returning to them later. Use during digital forensics, data recovery, or incident response when dealing with failing hardware or corrupted partitions.
---

# myrescue

## Overview
myrescue is a data recovery tool designed to extract data from damaged block devices. Unlike standard `dd`, it employs an "exponential-step" skipping strategy to move past damaged sectors quickly, ensuring the healthy parts of the disk are imaged first before attempting intensive recovery on failing sectors. Category: Digital Forensics / Recovery.

## Installation (if not already installed)
Assume the tool is installed. If not, use:

```bash
sudo apt install myrescue
```

## Common Workflows

### Basic Recovery
Perform a standard recovery from a damaged partition to an image file.
```bash
myrescue /dev/sdb1 recovery.img
```

### Aggressive Skipping
Skip damaged areas quickly to map out the healthy parts of the drive first.
```bash
myrescue -S -f 1 /dev/sdb1 recovery.img
```

### Check Recovery Progress
View statistics on how many blocks have been successfully copied, failed, or are yet to be processed.
```bash
myrescue-stat recovery.img.bitmap
```

### Visualizing Damage
Generate a PPM image to visually inspect the location of bad sectors on the disk.
```bash
myrescue-bitmap2ppm recovery.img.bitmap 1024 1024 > disk_map.ppm
```

## Complete Command Reference

### myrescue
Main utility for copying data from damaged media.

```
myrescue [<options>] <input-file> <output-file>
```

| Flag | Description |
|------|-------------|
| `-b <block-size>` | Block size in bytes (default: 4096) |
| `-B <bitmap-file>` | Path to bitmap file (default: `<output-file>.bitmap`) |
| `-A` | Abort on error |
| `-S` | Skip errors using exponential-step strategy |
| `-f <number>` | Skip blocks that have reached `<number>` or more failures |
| `-r <retry-count>` | Number of read attempts per block (default: 1) |
| `-s <start-block>` | Starting block number (default: 0) |
| `-e <end-block>` | Ending block number, exclusive (default: size of input) |
| `-G <range>` | Only read `<range>` blocks around known good ones |
| `-F <range>` | Skip `<range>` blocks around failed ones |
| `-J <number>` | Randomly jump after reading a few sectors |
| `-T` | Make `-A`, `-S`, and `-F` avoid blocks that took a long time to read |
| `-R` | Reverse copy direction (read from end to start) |
| `-U <dev-file>` | Reset USB device after read error (e.g., `/dev/bus/usb/001/002`) |
| `-h`, `-?` | Display usage information |

### myrescue-stat
Displays statistics based on the bitmap file generated during recovery.

```
myrescue-stat <bitmap-file>
```

**Condition Codes in Output:**
- `0`: Block not yet handled.
- `1`: Block successfully copied.
- `2`: Block successfully copied but slow (indicates near-failure).
- `Negative`: Number of failed read attempts for that block.

### myrescue-bitmap2ppm
Converts the block bitmap into a PPM image for visualization.

```
myrescue-bitmap2ppm <bitmap-file> <width> <rows> <width> ...
```

## Notes
- **Bitmap Files**: Always keep the `.bitmap` file associated with your output image. It allows you to stop and resume recovery at any time.
- **USB Reset**: The `-U` flag is particularly useful for external drives that "hang" the USB bus when encountering a physical media error.
- **Safety**: When dealing with failing hardware, always image the drive to a healthy disk before attempting file-level recovery.