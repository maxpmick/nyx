---
name: libewf
description: Acquire, verify, export, and mount Expert Witness Compression Format (EWF) files, including EnCase (E01) and SMART (S01) formats. Use when performing digital forensics, disk imaging, evidence verification, or mounting forensic images for analysis.
---

# libewf (ewf-tools)

## Overview
A collection of tools for reading and writing the Expert Witness Compression Format (EWF). It supports various formats used by EnCase, FTK Imager, and SMART. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume the tools are installed. If missing:

```bash
sudo apt install ewf-tools
```

## Common Workflows

### Acquire a physical drive to E01 format
```bash
sudo ewfacquire -t evidence_image -c best -D "Suspect Drive" -e "Investigator Name" /dev/sdb
```

### Verify the integrity of an EWF image
```bash
ewfverify image.E01
```

### Mount an E01 image to access the raw data
```bash
mkdir /mnt/ewf
ewfmount image.E01 /mnt/ewf
# The raw image is now available at /mnt/ewf/ewf1
```

### Export an EWF image to a raw (dd) file
```bash
ewfexport -t raw_image -f raw image.E01
```

## Complete Command Reference

### ewfacquire
Acquires data from a file or device and stores it in EWF format.

| Flag | Description |
|------|-------------|
| `-A <codepage>` | Codepage of header: ascii (default), windows-874, 932, 936, 949, 950, 1250-1258 |
| `-b <sectors>` | Sectors to read at once: 16, 32, 64 (default), 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768 |
| `-B <bytes>` | Number of bytes to acquire (default: all) |
| `-c <values>` | Compression: `level` or `method:level`. Method: deflate. Level: none, empty-block, fast, best |
| `-C <case>` | Case number (default: case_number) |
| `-d <type>` | Additional digest: sha1, sha256 (md5 is default) |
| `-D <desc>` | Description (default: description) |
| `-e <name>` | Examiner name (default: examiner_name) |
| `-E <num>` | Evidence number (default: evidence_number) |
| `-f <format>` | EWF format: ewf, smart, ftk, encase2-6 (default 6), encase7, encase7-v2, linen5-7, ewfx |
| `-g <sectors>` | Number of sectors to be used as error granularity |
| `-h` | Show help |
| `-l <file>` | Log errors and digest to file |
| `-m <type>` | Media type: fixed (default), removable, optical, memory |
| `-M <flags>` | Media flags: logical, physical (default) |
| `-N <notes>` | Notes (default: notes) |
| `-o <offset>` | Offset to start acquire (default: 0) |
| `-p <size>` | Process buffer size (default: chunk size) |
| `-P <bytes>` | Bytes per sector (default: 512) |
| `-q` | Quiet mode |
| `-r <retries>` | Number of retries on read error (default: 2) |
| `-R` | Resume acquiry at a safe point |
| `-s` | Swap byte pairs (AB to BA) |
| `-S <size>` | Segment file size in bytes (default: 1.4 GiB) |
| `-t <target>` | Target file (without extension) |
| `-T <file>` | TOC file for optical discs (CUE format) |
| `-u` | Unattended mode |
| `-v` | Verbose output |
| `-V` | Print version |
| `-w` | Zero sectors on read error (EnCase behavior) |
| `-x` | Use chunk data instead of buffered read/write |
| `-2 <target>` | Secondary target file |

### ewfacquirestream
Acquires data from stdin/pipe and stores it in EWF format.
*Supports flags: `-A, -b, -B, -c, -C, -d, -D, -e, -E, -f, -h, -l, -m, -M, -N, -o, -p, -P, -q, -s, -S, -t, -v, -V, -x, -2` (Same definitions as ewfacquire).*

### ewfdebug
Analyze EWF files for debugging.
*Flags: `-A <codepage>, -h, -q, -v, -V`*

### ewfexport
Exports media data from EWF to raw or another EWF format.

| Flag | Description |
|------|-------------|
| `-A <codepage>` | Codepage of header section |
| `-b <sectors>` | Sectors per chunk (not for raw/files) |
| `-B <bytes>` | Number of bytes to export |
| `-c <values>` | Compression values (for EWF output) |
| `-d <type>` | Additional digest: sha1, sha256 |
| `-f <format>` | Output format: raw (default), files, ewf, smart, encase1-7, linen5-7, ewfx |
| `-h` | Show help |
| `-l <file>` | Log export errors and digest |
| `-o <offset>` | Offset to start export |
| `-p <size>` | Process buffer size |
| `-q` | Quiet mode |
| `-s` | Swap byte pairs |
| `-S <size>` | Segment file size |
| `-t <target>` | Target file (use `-` for stdout, raw only) |
| `-u` | Unattended mode |
| `-v` | Verbose output |
| `-V` | Print version |
| `-w` | Zero sectors on checksum error |
| `-x` | Use chunk data instead of buffered read/write |

### ewfinfo
Show metadata stored in EWF files.

| Flag | Description |
|------|-------------|
| `-A <codepage>` | Codepage of header section |
| `-d <format>` | Date format: ctime (default), dm, md, iso8601 |
| `-e` | Only show EWF read error information |
| `-f <format>` | Output format: text (default), dfxml |
| `-h` | Show help |
| `-i` | Only show EWF acquiry information |
| `-m` | Only show EWF media information |
| `-v` | Verbose output |
| `-V` | Print version |

### ewfmount
Mount EWF images as FUSE filesystems.

| Flag | Description |
|------|-------------|
| `-f <format>` | Input format: raw (default), files |
| `-h` | Show help |
| `-v` | Verbose output (remains in foreground) |
| `-V` | Print version |
| `-X <options>` | Extended options to pass to FUSE |

### ewfrecover
Recover data from corrupt EWF files.
*Flags: `-A, -h, -l, -p, -q, -t, -u, -v, -V, -x`*

### ewfverify
Verify the integrity of data in EWF files.
*Flags: `-A, -d, -f, -h, -l, -p, -q, -v, -V, -w, -x`*

## Notes
- When using `ewfmount`, the mounted directory will contain a virtual file (usually named `ewf1`) representing the raw data.
- The default segment size is 1.4 GiB to maintain compatibility with older media/filesystems.
- Use `-u` (unattended) in scripts to prevent the tool from prompting for metadata.