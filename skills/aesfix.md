---
name: aesfix
description: Correct bit errors in AES-128 key schedules. Use this tool during digital forensics or cryptographic analysis when an AES key schedule has been recovered from memory (e.g., via cold boot attacks or RAM dumps) but contains unidirectional 1->0 bit errors. It is typically used in conjunction with the output of aeskeyfind.
---

# aesfix

## Overview
aesfix is a specialized tool designed to illustrate and apply techniques for correcting bit errors in an AES key schedule. It is specifically optimized for AES-128 and is capable of correcting unidirectional 1->0 bit errors (where bits have flipped from 1 to 0 due to memory decay). This tool is primarily used in digital forensics investigations involving memory image analysis. Category: Digital Forensics / Cryptography.

## Installation (if not already installed)
Assume aesfix is already installed. If the command is missing, install it using:

```bash
sudo apt update && sudo apt install aesfix
```

## Common Workflows

### Correcting a recovered key schedule
After locating a potential AES key schedule using a tool like `aeskeyfind`, save the hex-encoded schedule to a file and run aesfix:

```bash
aesfix recovered_schedule.hex
```

### Typical Forensics Pipeline
1. Scavenge memory for AES keys: `aeskeyfind memory.img > potential_keys.txt`
2. Isolate a specific hex-encoded schedule into a file (e.g., `key.hex`).
3. Attempt to fix bit decay:
```bash
aesfix key.hex
```

## Complete Command Reference

```bash
aesfix SCHEDULE-FILE
```

### Arguments

| Argument | Description |
|----------|-------------|
| `SCHEDULE-FILE` | Path to a file containing the hex-encoded AES key schedule to be corrected. |

### Options
This tool does not have traditional command-line flags. It accepts a single positional argument representing the input file.

## Notes
- **Limitations**: Currently limited to AES-128 key schedules.
- **Error Type**: Only corrects unidirectional 1->0 bit errors.
- **Performance**: The tool is optimized for code readability and educational purposes rather than high-speed performance.
- **Integration**: Best used with `aeskeyfind` and `biosmemimage`.