---
name: proxmark3
description: Interface with Proxmark3 hardware for RFID analysis, emulation, and cloning. Use when performing low-frequency (LF) or high-frequency (HF) RFID reconnaissance, credential sniffing, tag emulation, or firmware management. Supports various hardware revisions including RDV4.0.
---

# proxmark3

## Overview
The Proxmark3 is a powerful general-purpose tool for RFID analysis. This skill covers the client software, flashing utilities, and helper scripts used to interact with the device. Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume the tool is installed. If commands are missing:
```bash
sudo apt install proxmark3 proxmark3-common proxmark3-firmwares
```

## Common Workflows

### Basic Device Connection
Automatically detect the port and connect to the device:
```bash
pm3
```

### Execute Specific Commands
Run a command (e.g., search for HF tags) and exit:
```bash
proxmark3 /dev/ttyACM0 -c "hf search"
```

### Run Script and Stay Interactive
Execute a Lua script and then drop into the interactive shell:
```bash
pm3 -l hf_read -i
```

### Flash Firmware
Flash both the bootloader and the main image to a detected device:
```bash
pm3-flash -b bootrom.elf fullimage.elf
```

## Complete Command Reference

### proxmark3 (Main Client)
```
proxmark3 [[-p] <port>] [Options]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help |
| `-v`, `--version` | Print client version |
| `-p`, `--port <port>` | Serial port to connect to |
| `-w`, `--wait` | Wait 20 seconds for the serial port to appear |
| `-f`, `--flush` | Flush output after every print |
| `-d`, `--debug <0\|1\|2>` | Set debug mode level |
| `-t`, `--text` | Dump all interactive command list at once |
| `--fulltext` | Dump all interactive command help at once |
| `-m`, `--markdown` | Dump command list in markdown syntax |
| `-b`, `--baud` | Serial port speed (UART only) |
| `-c`, `--command <cmd>` | Execute command(s) (separate multiple with `;`) |
| `-l`, `--lua <file>` | Execute Lua script |
| `-y`, `--py <file>` | Execute Python script |
| `-s`, `--script-file <file>` | Execute file containing one command per line |
| `-i`, `--interactive` | Enter interactive mode after script/command |
| `--incognito` | Disable history, prefs, and log files |
| `--ncpu <num>` | Override number of CPU cores |

**Flasher Options (via `proxmark3 --flash`)**
| Flag | Description |
|------|-------------|
| `--flash` | Enter flashing mode (requires `--image`) |
| `--reboot-to-bootloader` | Reboot device into bootloader mode |
| `--unlock-bootloader` | Enable flashing of bootloader area (DANGEROUS) |
| `--force` | Force flash even if firmware version mismatch |
| `--image <file>` | Image to flash (can be specified multiple times) |

**Memory Dump Options**
| Flag | Description |
|------|-------------|
| `--dumpmem <file>` | Dump Proxmark3 flash memory to file |
| `--dumpaddr <addr>` | Starting address (default 0) |
| `--dumplen <len>` | Number of bytes to dump (default 512KB) |
| `--dumpraw` | Raw address mode: dump from anywhere, not just flash |

### pm3 (Helper Script)
A wrapper that auto-guesses ports and waits for connection.
```
pm3 [-n <N>] [proxmark3 options]
```
| Flag | Description |
|------|-------------|
| `--list` | List all detected COM ports |
| `-n <N>` | Connect to the Nth device in the list |
| `-o`, `--offline` | Use client without port guessing |
| `-hh`, `--helpclient` | Show the main proxmark3 client help |

### Flashing Helpers
These scripts automate the flashing process for specific components.

**pm3-flash**
```bash
pm3-flash [-n <N>] [-b] image.elf [image.elf...]
```
- `-b`: Enable flashing of bootloader area (DANGEROUS).

**Standard Flashers**
- `pm3-flash-all [-n <N>]`: Flash stock bootloader and firmware.
- `pm3-flash-bootrom [-n <N>]`: Flash stock bootloader only.
- `pm3-flash-fullimage [-n <N>]`: Flash stock firmware image only.
- `--list`: All flashers support this to show detected ports.

## Notes
- **ModemManager Conflict**: If the device is not detected or the flasher hangs, you may need to disable or blacklist the Proxmark3 in `ModemManager`.
- **Safety**: Flashing the bootloader (`-b` or `--unlock-bootloader`) carries a risk of bricking the device if interrupted.
- **Offline Mode**: You can run the client without hardware using the `-o` or `--offline` flag to practice commands or analyze saved data.