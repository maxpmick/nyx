---
name: dcfldd
description: Enhanced version of the dd tool developed by the Department of Defense Computer Forensics Lab (DCFL). It features on-the-fly hashing, status progress bars, flexible disk wiping, image verification, and multiple/split outputs. Use when performing forensic imaging, secure data wiping, integrity verification, or duplicating drives during digital forensics and incident response.
---

# dcfldd

## Overview
dcfldd is a forensic-focused enhancement of the standard `dd` command. It is designed specifically for security professionals to ensure data integrity during the imaging process through simultaneous hashing and verification. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume dcfldd is already installed. If the command is missing:

```bash
sudo apt install dcfldd
```

## Common Workflows

### Forensic Imaging with MD5 Hashing
```bash
dcfldd if=/dev/sdb hash=md5 of=evidence_drive.img hashlog=evidence_drive.md5
```
Reads from a physical drive, calculates MD5 on-the-fly, saves the image, and writes the hash to a log file.

### Secure Disk Wipe with Pattern
```bash
dcfldd pattern=00 of=/dev/sdb status=on
```
Wipes the target drive by writing zeros and displays a progress status.

### Split Image into 2GB Chunks
```bash
dcfldd if=/dev/sdb split=2G splitformat=MAC of=evidence.img
```
Creates multiple files (evidence.img.aa, evidence.img.ab, etc.) each 2GB in size.

### Verify Image Against Source
```bash
dcfldd if=evidence_drive.img vf=/dev/sdb
```
Compares the image file against the physical device to ensure a bit-for-bit match.

## Complete Command Reference

### Standard dd-Compatible Options

| Flag | Description |
|------|-------------|
| `bs=BYTES` | Force `ibs=BYTES` and `obs=BYTES` (default: 32768) |
| `cbs=BYTES` | Convert BYTES bytes at a time |
| `conv=KEYWORDS` | Convert the file as per comma separated keyword list |
| `count=BLOCKS` | Copy only BLOCKS input blocks |
| `ibs=BYTES` | Read BYTES bytes at a time |
| `if=FILE` | Read from FILE instead of stdin |
| `obs=BYTES` | Write BYTES bytes at a time |
| `of=FILE` | Write to FILE instead of stdout |
| `seek=BLOCKS` | Skip BLOCKS obs-sized blocks at start of output |
| `skip=BLOCKS` | Skip BLOCKS ibs-sized blocks at start of input |

### Enhanced Forensic & Output Options

| Flag | Description |
|------|-------------|
| `limit=BYTES` | Similar to `count` but uses BYTES instead of BLOCKS |
| `of:=COMMAND` | Exec and write output to process COMMAND |
| `pattern=HEX` | Use the specified binary pattern as input |
| `textpattern=TEXT` | Use repeating TEXT as input |
| `errlog=FILE` | Send error messages to FILE as well as stderr |
| `status=[on\|off]` | Display a continual status message on stderr |
| `statusinterval=N` | Update the status message every N blocks |
| `sizeprobe=[if\|of\|BYTES]` | Source for the percentage indicator value |
| `split=BYTES` | Write every BYTES amount of data to a new file |
| `splitformat=[TEXT\|MAC\|WIN]` | File extension format for split operation |
| `diffwr=[on\|off]` | Only write to output if destination block content differs |

### Hashing Options

| Flag | Description |
|------|-------------|
| `hash=NAME` | Hash calculation: `md5`, `sha1`, `sha256`, `sha384`, or `sha512` |
| `hashlog=FILE` | Send hash output to FILE instead of stderr |
| `hashwindow=BYTES` | Perform a hash on every BYTES amount of data |
| `hashlog:=COMMAND` | Exec and write hashlog to process COMMAND |
| `ALGORITHMlog:=COMMAND` | Works same as `hashlog:=COMMAND` (e.g., `md5log:=`) |
| `hashconv=[before\|after]` | Perform hashing before or after conversions |
| `hashformat=FORMAT` | Display each hashwindow according to FORMAT |
| `totalhashformat=FORMAT` | Display the total hash value according to FORMAT |

### Verification Options

| Flag | Description |
|------|-------------|
| `vf=FILE` | Verify that FILE matches the specified input |
| `verifylog=FILE` | Send verify results to FILE instead of stderr |
| `verifylog:=COMMAND` | Exec and write verify results to process COMMAND |

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Display help and exit |
| `--version` | Output version information and exit |

## Notes
- **Performance**: dcfldd uses a default block size (bs) of 32 KiB, which is significantly faster than the 512 bytes used by standard `dd`.
- **Integrity**: Always use the `hash` and `hashlog` options when creating forensic images to maintain a chain of custody.
- **Verification**: The `vf` (verify file) flag is critical for confirming that an image was written correctly to media without corruption.