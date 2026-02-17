---
name: oclgausscrack
description: Crack the verification hashes of the encrypted payload of the Gauss Virus using OpenCL-accelerated MD5 loops. Use when performing malware analysis, decrypting Gauss-related payloads, or conducting password recovery on specific Gauss virus verification hashes in environments with GPU acceleration.
---

# oclgausscrack

## Overview
oclgausscrack is a specialized GPU-accelerated tool designed to crack the verification hashes of the Gauss Virus encrypted payload. It utilizes OpenCL to accelerate the 10,000-iteration MD5 loop required for verification. It supports multi-GPU setups, resume functionality, and integration into distributed computing environments. Category: Password Attacks / GPU Tools.

## Installation (if not already installed)
Assume the tool is installed. If the command is missing:

```bash
sudo apt install oclgausscrack
```

## Common Workflows

### Combining Wordlists for Gauss
Use `gausscombinator` to create combinations of potential strings used in the Gauss encryption scheme.
```bash
gausscombinator wordlist1.txt wordlist2.txt > combined_list.txt
```

### Cracking a Gauss Hash
Run the main cracker against a target hash (ensure OpenCL drivers are correctly configured).
```bash
oclgausscrack [options] hashfile [wordlist/directory]
```

## Complete Command Reference

### oclgausscrack
The main engine for cracking Gauss verification hashes.

```bash
oclgausscrack [options] hashfile [wordlist/directory]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-V`, `--version` | Show version information |
| `-m`, `--hash-type` | Hash type (Gauss verification hash) |
| `-a`, `--attack-mode` | Attack mode (0 = Straight, 3 = Brute-force) |
| `--quiet` | Suppress output |
| `-o`, `--outfile` | Define output file for recovered passwords |
| `--outfile-format` | Define format for outfile |
| `-r`, `--rules-file` | Use rules file (for Straight attack) |
| `-s`, `--skip` | Skip N words from the start |
| `-l`, `--limit` | Limit to N words from the start |
| `--gpu-devices` | Explicitly select GPU devices to use |
| `--gpu-platform` | Explicitly select GPU platform to use |
| `--gpu-async` | Use non-blocking async calls |
| `--restore` | Restore a previous session |
| `--session` | Define session name |

### gausscombinator
A helper utility to combine two files for generating Gauss-specific candidates.

```bash
gausscombinator file1 file2
```

| Argument | Description |
|----------|-------------|
| `file1` | First input wordlist |
| `file2` | Second input wordlist |

### gaussfilter
A utility used to filter potential candidates or results related to Gauss cracking operations.

## Notes
- **Hardware Requirements**: Requires a functional OpenCL environment (drivers for AMD, NVIDIA, or Intel GPUs/CPUs).
- **Performance**: Optimized similarly to oclHashcat-plus for maximum throughput on the 10k MD5 loop.
- **Compatibility**: Compatible with VCL (Virtual CL) v1.18.
- **Gauss Virus**: This tool is highly specific to the Gauss malware and is not a general-purpose MD5 cracker. Use `hashcat` for general MD5 cracking.