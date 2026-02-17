---
name: dc3dd
description: A patched version of GNU dd designed for computer forensics. It features on-the-fly hashing, progress reporting, error logging, and the ability to split output files. Use when creating forensic images of drives or files, wiping devices with patterns, or performing verified data duplication where integrity (MD5/SHA) is critical.
---

# dc3dd

## Overview
dc3dd is a forensic-enhanced version of the standard `dd` tool. It provides essential features for digital forensics and incident response, including simultaneous hashing (MD5, SHA-1, SHA-256, SHA-512), verification of written data, and flexible output options like file splitting. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume dc3dd is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install dc3dd
```

## Common Workflows

### Create a Forensic Image with Hashing
Create an image of a drive while calculating a SHA256 hash and logging the results.
```bash
dc3dd if=/dev/sdb of=evidence.img hash=sha256 log=evidence.log
```

### Verified Image with Split Files
Create a verified image split into 2GB segments with numerical extensions.
```bash
dc3dd if=/dev/sdb hofs=evidence.img.0000 ofsz=2G hash=md5
```

### Securely Wipe a Device
Wipe a device by writing a specific hex pattern and verifying the write.
```bash
dc3dd pat=00 hwipe=/dev/sdb
```

### Clone to Multiple Destinations
Write the input to two different physical disks simultaneously.
```bash
dc3dd if=/dev/sdb of=/dev/sdc of=/dev/sdd
```

## Complete Command Reference

### Basic Options

| Option | Description |
|------|-------------|
| `if=DEVICE/FILE` | Read input from device or file. Cannot combine with `ifs=`, `pat=`, or `tpat=`. |
| `ifs=BASE.FMT` | Read input from a set of files with base name and format specifier (e.g., `image.000`). |
| `of=FILE/DEVICE` | Write output to file or device. Can be used multiple times. |
| `hof=FILE/DEVICE` | Write output, hash output bytes, and verify against input hash. |
| `ofs=BASE.FMT` | Write output to a set of split files. Use `ofsz=` to set size. |
| `hofs=BASE.FMT` | Write output to split files, hash them, and verify against input hash. |
| `ofsz=BYTES` | Set max size for each file in a split set (used with `ofs=` or `hofs=`). |
| `hash=ALGORITHM` | Compute hash of input/output. Algorithms: `md5`, `sha1`, `sha256`, `sha512`. |
| `log=FILE` | Log statistics, diagnostics, and total hashes to FILE. |
| `hlog=FILE` | Log total hashes and piecewise hashes to FILE. |
| `mlog=FILE` | Create a machine-readable hash log. |

### Advanced Options

| Option | Description |
|------|-------------|
| `fhod=DEVICE` | Same as `hof=`, but hashes the entire output device after writing. |
| `rec=off` | Exit on bad sectors instead of writing zeros (default behavior is to write zeros). |
| `wipe=DEVICE` | Wipe device with zeros or pattern specified by `pat=` or `tpat=`. |
| `hwipe=DEVICE` | Wipe device and verify by hashing and comparing to input hash. |
| `pat=HEX` | Use hex pattern as input (e.g., `pat=FF`). |
| `tpat=TEXT` | Use text string as input pattern. |
| `cnt=SECTORS` | Read only specified number of input sectors. |
| `iskip=SECTORS` | Skip sectors at the start of the input. |
| `oskip=SECTORS` | Skip sectors at the start of the output (sets `app=on`). |
| `app=on` | Append to output file instead of overwriting. |
| `ssz=BYTES` | Force specific sector size (default is probed or 512 bytes). |
| `bufsz=BYTES` | Set internal buffer size (must be multiple of sector size). |
| `verb=on` | Activate verbose reporting for file sets. |
| `nwspc=on` | Compact reporting (suppress white space in logs). |
| `b10=on` | Use base 10 (1000 bytes = 1KB) for progress reporting. |
| `corruptoutput=on` | Intentionally corrupt output for verification testing. |

### Help Options
- `--help`: Display help and exit.
- `--version`: Output version information.
- `--flags`: Display compile-time flags.

## Notes

### Input/Output Handling
- **Standard Input**: To read from stdin, do not specify `if=`, `ifs=`, `pat=`, or `tpat=`.
- **Standard Output**: To write to stdout, do not specify `of=`, `hof=`, `ofs=`, `hofs=`, `fhod=`, `wipe=`, or `hwipe=`.
- **Multiple Outputs**: Specify multiple `of=`, `hof=`, etc., to write to several destinations at once.

### Format Specifiers (FMT)
Used for split files (`000`, `001` or `aaa`, `aab`).
- `0000`: Four-character numerical starting at 0000.
- `111`: Three-character numerical starting at 001.
- `aaa`: Three-character alphabetical starting at aaa.

### Byte Suffixes
Values for `ofsz`, `ssz`, and `bufsz` can use:
- `c` (1), `w` (2), `b` (512)
- `kB` (1000), `K` (1024)
- `MB` (1000^2), `M` (1024^2)
- `GB` (1000^3), `G` (1024^3)
- Suffixes continue for T, P, E, Z, Y.

### Recovery
If error recovery fails, use `cnt=`, `iskip=`, and `oskip=` to manually bypass unreadable sectors. Pressing `CTRL+C` will trigger a final report of work completed before exiting.