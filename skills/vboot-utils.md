---
name: vboot-utils
description: Manipulate Chrome OS verified boot structures, GPT partitions, and firmware images. Use when performing security audits on Chromebooks, signing custom kernels for Chrome OS devices, modifying GPT partition priorities, or interacting with TPM and GBB (Google Binary Block) components.
---

# vboot-utils

## Overview
A collection of utilities for Chrome OS verified boot, firmware manipulation, and GPT management. It includes `cgpt` for partition tables and `futility` (which encompasses `vbutil_*` tools) for signing and verifying firmware and kernels. Category: Exploitation / Hardware Hacking.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install vboot-utils vboot-kernel-utils cgpt
```

## Common Workflows

### Create a bootable Chrome OS kernel partition
```bash
futility vbutil_kernel --pack signed_kernel.bin \
  --keyblock /path/to/recovery.keyblock \
  --signprivate /path/to/recovery.vbprivk \
  --version 1 \
  --vmlinuz bzImage \
  --bootloader bootloader.bin \
  --config cmdline.txt \
  --arch x86
```

### Modify GPT partition priority (Chromebook specific)
```bash
sudo cgpt add -i 2 -P 5 -T 1 -S 1 /dev/sdX
```
Sets partition 2 to priority 5, tries 1, and successful 1.

### Read Chrome OS system parameters
```bash
crossystem dev_boot_usb dev_boot_altfw
```
Checks if USB booting or legacy BIOS booting is enabled.

### Extract FMAP sections from BIOS
```bash
futility dump_fmap -x bios.bin GBB VBLOCK_A
```

## Complete Command Reference

### cgpt (GPT Manipulation)
`cgpt COMMAND [OPTIONS] DRIVE`

| Command | Description |
|---------|-------------|
| `create` | Create or reset GPT headers and tables |
| `add` | Add, edit or remove a partition entry |
| `show` | Show partition table and entries |
| `repair` | Repair damaged GPT headers and tables |
| `boot` | Edit the PMBR sector for legacy BIOSes |
| `find` | Locate a partition by its GUID |
| `edit` | Edit a drive entry |
| `prioritize` | Reorder the priority of all kernel partitions |
| `legacy` | Switch between GPT and Legacy GPT |

### futility (Unified Firmware Utility)
`futility [options] COMMAND [args...]`

**Global Options:**
- `--vb1`: Use only vboot v1.0 binary formats
- `--vb21`: Use only vboot v2.1 binary formats
- `--debug`: Verbose output

**Subcommands:**
- `create`: Create keypair from RSA .pem
- `dump_fmap`: Display FMAP contents
- `dump_kernel_config`: Print kernel command line
- `gbb`: Manipulate Google Binary Block
- `load_fmap`: Replace FMAP area contents
- `pcr`: Simulate TPM PCR extension
- `show`: Display binary component content
- `sign`: Sign/resign binary components
- `update`: Update system firmware
- `vbutil_kernel`: Create/sign/verify kernel partitions
- `vbutil_key`: Wrap RSA keys with vboot headers
- `vbutil_keyblock`: Create/sign/verify keyblocks

### vbutil_kernel
`futility vbutil_kernel --pack|--repack|--verify|--get-vmlinuz <file> [PARAMS]`

| Flag | Description |
|------|-------------|
| `--keyblock <file>` | Keyblock in .keyblock format |
| `--signprivate <file>` | Private key (.vbprivk) |
| `--version <num>` | Kernel version |
| `--vmlinuz <file>` | Linux kernel bzImage |
| `--bootloader <file>` | Bootloader stub |
| `--config <file>` | Kernel command line file |
| `--arch <arch>` | CPU architecture (default x86) |
| `--oldblob <file>` | (Repack only) Previous kernel blob |
| `--signpubkey <file>` | (Verify only) Public key (.vbpubk) |
| `--vmlinuz-out <file>` | (Get-vmlinuz only) Output file |

### crossystem (System Interface)
`crossystem [--all] [param[=/?]value]`

| Option | Description |
|--------|-------------|
| `--all` | Print all parameters including hidden ones |
| `param=value` | Set a parameter |
| `param?value` | Check if parameter matches value |

**Common Parameters:**
- `dev_boot_usb`: Enable/disable USB boot (RW)
- `dev_boot_altfw`: Enable/disable legacy boot (RW)
- `wpsw_cur`: Physical write-protect switch status (RO)
- `hwid`: Hardware ID (RO)
- `fwid`: Active firmware ID (RO)

### gbb_utility
`futility gbb_utility [-g|-s|-c] [OPTIONS] bios_file [output_file]`

| Flag | Mode | Description |
|------|------|-------------|
| `-g`, `--get` | GET | Read HWID, flags, or keys from BIOS |
| `-s`, `--set` | SET | Write HWID, flags, or keys to BIOS |
| `-c`, `--create` | CREATE | Create GBB blob (requires size list) |
| `--hwid` | - | Hardware ID string |
| `--flags` | - | Numeric GBB flags |
| `-k`, `--rootkey` | - | Root Key file |

### Other Utilities
- **dev_debug_vboot**: Logs verified boot process. Options: `-b` (BIOS), `-i` (Image), `-k` (Kernel), `-v` (Verbose).
- **dumpRSAPublicKey**: `<-cert | -pub> <file>`.
- **vbutil_firmware**: `--vblock|--verify` for firmware volumes.
- **vbutil_key**: `--pack|--unpack` RSA keys.
- **vbutil_keyblock**: `--pack|--unpack` keyblocks.

## Notes
- `cgpt` is essential for Chromebooks because they use specific GPT attributes (Priority, Tries, Successful) to determine which kernel partition to boot.
- Most `vbutil_*` commands are now subcommands of `futility`.
- Modifying `crossystem` parameters often requires Developer Mode to be enabled on the target device.