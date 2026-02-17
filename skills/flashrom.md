---
name: flashrom
description: Identify, read, write, verify, and erase flash chips including BIOS, EFI, coreboot, and firmware images. Use when performing hardware security audits, firmware extraction, BIOS updates, or interacting with SPI/LPC/FWH/Parallel flash chips via internal or external programmers like Bus Pirate, CH341A, or Raspberry Pi.
---

# flashrom

## Overview
flashrom is a universal flash programming utility used for identifying, reading, writing, verifying, and erasing flash chips. It supports a wide range of chips (DIP, PLCC, SOIC, TSOP, BGA) and various protocols (LPC, FWH, Parallel, SPI). It can be used for in-system flashing via the mainboard or externally via supported programmers. Category: Hardware / Exploitation.

## Installation (if not already installed)
Assume flashrom is already installed. If not:
```bash
sudo apt install flashrom
```

## Common Workflows

### Identify a flash chip
Probes the system for a supported flash chip using the internal programmer.
```bash
sudo flashrom -p internal
```

### Read firmware to a file
Reads the contents of the flash chip and saves it to `backup.bin`.
```bash
sudo flashrom -p internal -r backup.bin
```

### Write new firmware
Writes `new_firmware.bin` to the chip and verifies the write.
```bash
sudo flashrom -p internal -w new_firmware.bin
```

### Use an external SPI programmer (e.g., CH341A)
Reads firmware using a CH341A USB programmer.
```bash
flashrom -p ch341a_spi -r external_dump.bin
```

### Write protect management
Check the status of write protection on the detected chip.
```bash
flashrom -p internal --wp-status
```

## Complete Command Reference

### Basic Operations
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Print help text |
| `-R`, `--version` | Print version (release) |
| `-r`, `--read [<file>]` | Read flash and save to `<file>` |
| `-w`, `--write [<file>\|-]` | Write `<file>` or stdin to flash |
| `-v`, `--verify [<file>\|-]` | Verify flash against `<file>` or stdin |
| `-E`, `--erase` | Erase flash memory |
| `-V`, `--verbose` | More verbose output (use multiple times for more: `-VV`, `-VVV`) |
| `-c`, `--chip <chipname>` | Probe only for specified flash chip |
| `-f`, `--force` | Force specific operations (bypass safety checks) |
| `-n`, `--noverify` | Don't auto-verify after writing |
| `-N`, `--noverify-all` | Verify included regions only (used with `-i`) |
| `-x`, `--extract` | Extract regions to files |
| `-o`, `--output <logfile>` | Log output to `<logfile>` |
| `-L`, `--list-supported` | Print supported devices (chips, programmers, etc.) |

### Layout and Region Options
| Flag | Description |
|------|-------------|
| `-l`, `--layout <file>` | Read ROM layout from `<layoutfile>` |
| `--fmap` | Read ROM layout from fmap embedded in ROM |
| `--fmap-file <file>` | Read ROM layout from fmap in `<fmapfile>` |
| `--ifd` | Read layout from an Intel Firmware Descriptor |
| `-i`, `--include <region>[:<file>]` | Only read/write image `<region>` from layout (optionally with data from `<file>`) |
| `--image <region>[:<file>]` | Deprecated, use `--include` |

### Write Protection Options
| Flag | Description |
|------|-------------|
| `--wp-disable` | Disable write protection |
| `--wp-enable` | Enable write protection |
| `--wp-list` | List supported write protection ranges |
| `--wp-status` | Show write protection status |
| `--wp-range=<start>,<len>` | Set write protection range (use `0,0` to unprotect entire flash) |
| `--wp-region <region>` | Set write protection region |

### Advanced Options
| Flag | Description |
|------|-------------|
| `--flash-name` | Read out the detected flash name |
| `--flash-size` | Read out the detected flash size |
| `--flash-contents <ref-file>` | Assume flash contents to be `<ref-file>` |
| `--progress` | Show progress percentage on stdout |
| `--sacrifice-ratio <ratio>` | Fraction (0-50%) of an erase block that may be erased even if unmodified. Default 0. |

### Programmer Selection
Use `-p` or `--programmer <name>[:<param>]` to specify the hardware.

**Common Programmers:**
- `internal`: Laptop/Desktop mainboards
- `dummy`: Virtual programmer for testing
- `ft2232_spi`: FTDI-based programmers (TUMPA, Bus Blaster, etc.)
- `serprog`: Arduino/AVR based programmers
- `buspirate_spi`: Bus Pirate
- `dediprog`: Dediprog SF100
- `linux_spi`: Linux `/dev/spidevX.Y` (Raspberry Pi, etc.)
- `ch341a_spi`: WCH CH341A USB programmer
- `jlink_spi`: SEGGER J-Link
- `nicintel`, `nicrealtek`, `gfxnvidia`: Network/Graphics card flash

## Notes
- **Caution**: Flashing firmware is inherently risky. Ensure you have a valid backup before writing.
- **Root Privileges**: Most programmers (especially `internal`) require `sudo`.
- **Laptop Flashing**: When using the `internal` programmer on laptops, flashrom may require specific parameters or may be blocked by hardware write protection.
- **Chip Longevity**: Using `--sacrifice-ratio` increases wear on the flash chip but can speed up programming.