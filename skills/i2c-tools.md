---
name: i2c-tools
description: Enumerate, debug, and manipulate I2C and SMBus devices on Linux systems. Use when performing hardware security audits, dumping EEPROMs (like DIMM SPD or Sony Vaio identification), probing I2C buses for connected chips, or interacting with hardware registers at the low level.
---

# i2c-tools

## Overview
A heterogeneous set of I2C tools for Linux including bus probing, chip dumping, register-level access helpers, and EEPROM decoding scripts. These tools are essential for hardware reconnaissance and exploitation involving I2C/SMBus interfaces. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume i2c-tools is already installed. If you get a "command not found" error:

```bash
sudo apt install i2c-tools
```

## Common Workflows

### List all available I2C buses
```bash
i2cdetect -l
```

### Scan a specific I2C bus for devices
```bash
i2cdetect -y 1
```
Scans bus 1 and automatically confirms the interactive prompt.

### Dump the contents of an EEPROM at address 0x50
```bash
i2cdump -y 1 0x50
```

### Read a single byte from register 0x10 of a device at 0x2d
```bash
i2cget -y 1 0x2d 0x10
```

### Write a value to a register and verify
```bash
i2cset -y 1 0x2d 0x10 0x3f
```

### Complex transfer: Write offset then read data
```bash
i2ctransfer -y 0 w1@0x50 0x64 r8
```
Writes 1 byte (0x64) to device 0x50 on bus 0, then reads 8 bytes.

## Complete Command Reference

### i2cdetect
Detect I2C chips and list buses.
- `i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]`: Probe a bus.
- `i2cdetect -F I2CBUS`: Show bus capabilities.
- `i2cdetect -l`: List installed buses.

| Flag | Description |
|------|-------------|
| `-y` | Disable interactive mode (auto-confirm) |
| `-a` | Force scanning of non-regular addresses (0x00-0x07 and 0x78-0x7f) |
| `-q` | Use SMBus "Quick Write" commands for probing (default) |
| `-r` | Use SMBus "Receive Byte" commands for probing |

### i2cdump
Examine I2C registers.
`i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]`

| Flag/Arg | Description |
|------|-------------|
| `-f` | Force access even if device is busy |
| `-y` | Disable interactive mode |
| `-r` | Limit the range of registers to dump (e.g., 0x00-0x0f) |
| `-a` | Allow addresses 0x00-0x7f |
| `MODE` | `b` (byte), `w` (word), `W` (word on even addr), `i` (I2C block), `c` (consecutive). Append `p` for PEC |

### i2cget
Read from I2C/SMBus chip registers.
`i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE [LENGTH]]]`

| Flag/Arg | Description |
|------|-------------|
| `-f` | Force access |
| `-y` | Disable interactive mode |
| `-a` | Allow addresses 0x00-0x7f |
| `MODE` | `b` (read byte), `w` (read word), `c` (write byte/read byte), `s` (SMBus block), `i` (I2C block). Append `p` for PEC |
| `LENGTH` | I2C block data length (1-32, default 32) |

### i2cset
Set I2C registers.
`i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]`

| Flag/Arg | Description |
|------|-------------|
| `-f` | Force access |
| `-y` | Disable interactive mode |
| `-m MASK` | Mask to apply to the value |
| `-r` | Read back the value after writing to verify |
| `-a` | Allow addresses 0x00-0x7f |
| `MODE` | `c` (byte, no value), `b` (byte data), `w` (word data), `i` (I2C block), `s` (SMBus block). Append `p` for PEC |

### i2ctransfer
Send user-defined I2C messages in one transfer.
`i2ctransfer [OPTIONS] I2CBUS DESC [DATA] [DESC [DATA]]...`

| Option | Description |
|------|-------------|
| `-a` | Allow even reserved addresses |
| `-b` | Print read data as binary (disables -v) |
| `-f` | Force access even if address is marked used |
| `-v` | Verbose mode |
| `-y` | Yes to all confirmations |
| `DESC` | `{r|w}LENGTH[@address]` (e.g., `w1@0x50`) |
| `DATA` | Bytes for write. Suffixes: `=` (constant), `+` (inc), `-` (dec), `p` (pseudo-random) |

### decode-dimms
Decode memory module SPD EEPROMs.
`decode-dimms [-c] [-f [-b]] [-x|-X file [files..]]`

| Flag | Description |
|------|-------------|
| `-f`, `--format` | Print nice HTML output |
| `-b`, `--bodyonly` | Don't print HTML header |
| `--side-by-side` | Display all DIMMs side-by-side |
| `--merge-cells` | Merge neighbor cells with identical values |
| `--no-merge-cells`| Don't merge neighbor cells |
| `-c`, `--checksum` | Decode even if checksum fails |
| `-x` | Read data from hexdump files |
| `-X` | Read data from hexdump files (treat multibyte as little endian) |

### i2c-stub-from-dump
Feed i2c-stub with dump files for emulation.
`i2c-stub-from-dump <addr>[,<addr>,...] <dump file> [<dump file> ...]`

### decode-vaio
Decode Sony Vaio laptop identification EEPROMs. Requires `at24` or `eeprom` kernel module.

## Notes
- **Safety**: Writing to I2C registers (`i2cset`, `i2ctransfer`) can be dangerous and may cause hardware instability or permanent damage if incorrect values are written to sensitive components (like power controllers).
- **Kernel Modules**: Ensure the `i2c-dev` module is loaded (`modprobe i2c-dev`) if no I2C buses appear.
- **Permissions**: Most tools require root privileges to access `/dev/i2c-*` nodes.