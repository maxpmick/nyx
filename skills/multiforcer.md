---
name: multiforcer
description: GPU-accelerated password cracking using CUDA and OpenCL for high-speed brute-forcing and rainbow table attacks. Use when performing password recovery or security auditing against hash types like MD5, SHA1, LM, and NTLM where hardware acceleration is available.
---

# multiforcer

## Overview
Multiforcer is a high-performance, GPU-accelerated password cracking tool. It supports both CUDA and OpenCL implementations for rainbow table attacks and direct brute-forcing. It is designed to handle large volumes of hashes efficiently by leveraging the parallel processing power of modern graphics cards. Category: Password Attacks.

## Installation (if not already installed)
Assume multiforcer is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install multiforcer
```

Note: Requires appropriate GPU drivers (NVIDIA for CUDA, or OpenCL-compatible drivers for other platforms) to function at full speed.

## Common Workflows

### Check OpenCL Device Compatibility
Before running attacks, verify that your hardware is recognized and supports the required OpenCL extensions.
```bash
showconfig-opencl
```

### Basic Brute Force (Conceptual)
While the tool is primarily invoked via `multiforcer`, specific flags depend on the hash type and character set. A typical usage pattern involves specifying the hash file and the target algorithm.
```bash
multiforcer -h MD5 -f hashes.txt
```

### Rainbow Table Attack
Using pre-computed tables for near-instant cracking of supported hashes.
```bash
multiforcer -t /path/to/tables -f hashes.txt
```

## Complete Command Reference

### multiforcer
The main binary for performing GPU-accelerated cracking.

| Flag | Description |
|------|-------------|
| `-h <type>` | Specify the hash algorithm (e.g., MD5, SHA1, LM, NTLM) |
| `-f <file>` | Path to the file containing hashes to crack |
| `-t <dir>` | Path to the directory containing rainbow tables |
| `-c <charset>` | Define the character set for brute-force attacks |
| `--min <len>` | Minimum password length |
| `--max <len>` | Maximum password length |
| `-v` | Enable verbose output |

### showconfig-opencl
A utility to display information about available OpenCL platforms and devices.

| Flag | Description |
|------|-------------|
| `-h` | Display help and exit |

**Output Fields Explained:**
- **Platform ID**: The index of the OpenCL platform (e.g., NVIDIA, Intel, PoCL).
- **CL_DEVICE_NAME**: The specific hardware name (CPU or GPU model).
- **CL_DEVICE_TYPE**: Indicates if the device is a CPU, GPU, or Accelerator.
- **CL_DEVICE_MAX_COMPUTE_UNITS**: Number of parallel cores available.
- **CL_DEVICE_GLOBAL_MEM_SIZE**: Total memory available on the device.

## Notes
- **Hardware Requirements**: This tool is significantly slower on CPUs. For optimal performance, ensure NVIDIA CUDA drivers or OpenCL runtimes are correctly configured.
- **Legacy Status**: Multiforcer (part of the Cryptohaze suite) is an older tool; for modern WPA2 or complex salted hashes, tools like Hashcat are often used in conjunction or as alternatives.
- **LM Hashes**: When cracking LM hashes, remember they are case-insensitive and split into two 7-character chunks.