---
name: ssdeep
description: Compute and compare Context Triggered Piecewise Hashes (CTPH), also known as fuzzy hashes, to identify similar but not identical files. Use when performing digital forensics, malware analysis, or identifying modified versions of known files where data has been inserted, deleted, or changed.
---

# ssdeep

## Overview
ssdeep is a recursive piecewise hashing tool used for fuzzy hashing. Unlike traditional cryptographic hashes (MD5/SHA1) where a single bit change results in a completely different hash, fuzzy hashes allow for the detection of similarities between files. This is essential for identifying polymorphic malware, document revisions, or partial file matches in forensic investigations. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume ssdeep is already installed. If the command is missing:

```bash
sudo apt install ssdeep
```

## Common Workflows

### Generate hashes for a directory and save to a file
```bash
ssdeep -r /path/to/directory > fingerprints.txt
```

### Match files against a known set of hashes
```bash
ssdeep -m fingerprints.txt -r /path/to/suspect/files
```

### Compare two directories for similar files (Directory Mode)
```bash
ssdeep -d /dir1 /dir2
```

### Cluster similar files together with a similarity threshold
```bash
ssdeep -g -t 50 -r /path/to/malware/samples
```
This groups files that have a similarity score of 50 or higher.

## Complete Command Reference

```
ssdeep [-m file] [-k file] [-dpgvrsblcxa] [-t val] [-h|-V] [FILES]
```

### Options

| Flag | Description |
|------|-------------|
| `-m <file>` | **Match** FILES against known hashes contained in the specified file. |
| `-k <file>` | **Match signatures** in FILES against signatures in the specified file. |
| `-d` | **Directory mode**: compare all files in a directory against each other. |
| `-p` | **Pretty matching mode**: Similar to directory mode but includes all matches found. |
| `-g` | **Cluster** matches together into groups. |
| `-v` | **Verbose mode**: Displays the filename as it is being processed. |
| `-r` | **Recursive mode**: Traverse subdirectories. |
| `-s` | **Silent mode**: All error messages are suppressed. |
| `-b` | **Bare name**: Uses only the filename; all path information is omitted from output. |
| `-l` | **Relative paths**: Uses relative paths instead of absolute paths for filenames. |
| `-c` | **CSV format**: Prints output in Comma Separated Values format. |
| `-x` | **Signature comparison**: Treat the input FILES as signature files themselves. |
| `-a` | **Display all**: Show all matches regardless of the similarity score. |
| `-t <val>` | **Threshold**: Only display matches with a score above the given value (0-100). |
| `-h` | **Help**: Display the help message. |
| `-V` | **Version**: Display version number and exit. |

## Notes
- **Fuzzy Hashing Logic**: ssdeep works by dividing a file into blocks and hashing those blocks. The resulting signature can be compared to others to produce a similarity score between 0 and 100.
- **Forensics Use Case**: Highly effective for identifying "known-distent" files or finding leaked documents that have been slightly edited.
- **Performance**: While recursive, processing very large datasets can be CPU intensive due to the piecewise calculation.