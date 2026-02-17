---
name: afflib
description: Manage and manipulate Advanced Forensic Format (AFF) files, an open on-disk format for storing computer forensic information including disk images and metadata. Use when performing digital forensics, disk image acquisition, format conversion (RAW to AFF), image verification, or managing encrypted forensic evidence.
---

# afflib

## Overview
The AFF Toolkit is a set of programs for working with computer forensic information stored in the Advanced Forensic Format. It supports disk image interconversion, digital signatures for chain-of-custody, on-the-fly encryption/decryption, and metadata management. Category: Digital Forensics.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install afflib-tools
```

## Common Workflows

### Convert RAW Image to AFF
```bash
affconvert image.dd
```
Converts a raw `dd` image to an AFF container.

### View Image Metadata and Segment Info
```bash
affinfo evidence.aff
```
Displays general information and metadata segments of the AFF file.

### Encrypt an Existing AFF File
```bash
affcopy file.aff file://:mypassword@/file-encrypted.aff
```
Copies an unencrypted AFF file to a new encrypted destination using a passphrase.

### Mount an AFF Image
```bash
mkdir /mnt/aff_image
affuse evidence.aff /mnt/aff_image
```
Mounts the AFF container to a mount point to access the raw image within.

## Complete Command Reference

### affcat
Output contents of an image file to stdout.
- `-s name`: Just output segment name
- `-p ###`: Just output data page number ###
- `-S ###`: Just output data sector ### (assumes 512-byte sectors)
- `-q`: Quiet; don't print to STDERR if a page is skipped
- `-n`: Noisy; tell when pages are skipped
- `-l`: List all of the segment names
- `-L`: List segment names, lengths, and args
- `-d`: Debug. Print page numbers to stderr
- `-b`: Output `BADFLAG` for bad blocks (default is NULLs)
- `-v`: Print version and exit
- `-r offset:count`: Seek to offset and output count characters

### affcompare
Compare the contents of images.
- `-p`: Report results of preening
- `-e`: Just report about existence (use with `-r`)
- `-s`: Check if segments are present without validating contents (S3 optimized)
- `-V`: Print version and exit
- `-v`: Verbose; each file as it is compared
- `-q`: Quiet; no output except errors
- `-a`: Print what is the same
- `-b`: Print numbers of differing sectors
- `-c`: Print contents of differing sectors
- `-m`: Just report about data (ignore metadata)
- `-P ###`: Just examine differences on page ###
- `-r dir1 dir2`: Recursively compare directories

### affconvert
Convert files between RAW and AFF formats.
- Usage: `affconvert [options] file1 [... files]`

### affcopy
Reorder and recompress AFF files.
- `-v`: Verbose
- `-vv`: Very verbose (segment level)
- `-d`: Debug information
- `-x`: Don't verify hashes on reads
- `-y`: Don't verify writes
- `-Xn`: Recompress pages with zlib level `n`
- `-L`: Recompress pages with LZMA
- `-z`: Zap; copy even if destination exists
- `-m`: Just copy missing segments
- `-k <key>`: Private key for signing
- `-c <cert>`: X.509 certificate for signing
- `-n`: Read notes from stdin

### affcrypto
Handle encryption issues.
- `-x`: Output in XML
- `-j`: Print number of encrypted segments
- `-J`: Print number of unencrypted segments
- `-e`: Encrypt unencrypted non-signature segments
- `-d`: Decrypt encrypted non-signature segments
- `-r`: Change passphrase (from stdin)
- `-O <old>`: Specify old passphrase
- `-N <new>`: Specify new passphrase
- `-K <key>`: Private key for unsealing
- `-C <cert>`: Certificate for sealing
- `-S`: Add symmetric encryption to public-key encrypted file
- `-A`: Add asymmetric encryption to passphrase encrypted file
- `-p <pass>`: Check if passphrase is correct
- `-k`: Crack passwords using `~/.affpassphrase`
- `-f <file>`: Crack passwords using specified file
- `-l`: List installed hash/encryption algorithms

### affdiskprint
Create/verify a diskprint AFF structure.
- `-x <XML>`: Verify the diskprint
- `-V`: Print version and exit

### affinfo
Print information about an AFF file.
- `-a`: Print ALL segments
- `-b`: Print bad blocks in each segment
- `-i`: Identify files only
- `-w`: Wide output
- `-s <seg>`: Info about specific segment
- `-m`: Validate MD5 of entire image
- `-S`: Validate SHA1 of entire image
- `-v`: Validate hash of each page
- `-y`: Don't print short segments as hex
- `-p <pass>`: Specify passphrase
- `-l`: Just print segment names
- `-X`: No data preview
- `-x`: Print binary values in hex
- `-A`: Print device sector info in XML

### affix
Fix a corrupted AFF file.
- `-y`: Actually modify the files (repair)
- `-v`: Print version and exit

### affrecover
Recover broken pages of an AFF file.
- Usage: `affrecover filename`

### affsegment
Segment manipulation tool.
- `-c`: Create AFF if it doesn't exist
- `-s<segval>`: Set segment value (e.g., `-sname=val`, `-sname=<file`, `-sname/-`)
- `-p<name>`: Print contents of segment
- `-d<name>`: Delete segment
- `-Q`: Interpret 8-byte segments as 64-bit value
- `-A`: Print 32-bit arg instead of value
- `-x`: Print segment as hex string

### affsign
Sign an existing AFF file.
- `-k <key>`: Private key for signing
- `-c <cert>`: X.509 certificate
- `-Z`: Zap (remove) all signature segments
- `-n`: Ask for chain-of-custody note

### affstats
Print statistics about AFF files.
- `-m`: Print output in megabytes
- `-V`: Print version and exit

### affuse
Provide FUSE access to AFF containers.
- Usage: `affuse [FUSE options] af_image mount_point`
- Unmount: `fusermount3 -u mount_point`

### affverify
Verify digital signatures.
- `-a`: Print all segments
- `-v`: Verbose
- `-V`: Print version and exit

### affxml
Print AFF information as XML.
- `-x`: Don't include filename in output
- `-j <seg>`: Just info about specific segment
- `-s`: Output stats for file data (slow)

## Notes
- AFF files can be split (AFD) or used to annotate raw files (AFM).
- Encryption can be specified via URI: `file://:passphrase@/path/to/file.aff`.
- Use `affuse` for easy access to image contents without full extraction.