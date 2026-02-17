---
name: openocd
description: Debug, program, and test embedded target devices using JTAG or SWD interfaces. Use when performing hardware security audits, extracting firmware, debugging ARM/MIPS/RISC-V microcontrollers, or performing boundary-scan testing on embedded systems.
---

# openocd

## Overview
The Open On-Chip Debugger (OpenOCD) provides debugging, in-system programming, and boundary-scan testing for embedded target devices. It supports various architectures including ARM, MIPS, RISC-V, and Intel, interfacing via JTAG or SWD. It acts as a bridge between a hardware programmer and software tools like GDB. Category: Hardware Attacks / Hardware Security.

## Installation (if not already installed)
Assume openocd is already installed. If you get a "command not found" error:

```bash
sudo apt install openocd
```

## Common Workflows

### Start OpenOCD with specific interface and target configs
```bash
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg
```

### Run a single command and exit (e.g., flashing firmware)
```bash
openocd -f interface/jlink.cfg -f target/nrf52.cfg -c "program firmware.bin verify reset exit 0x08000000"
```

### Connect with custom search path for scripts
```bash
openocd -s /home/user/custom_scripts -f my_device.cfg
```

### Increase verbosity for troubleshooting connection issues
```bash
openocd -d3 -f interface/ftdi/olimex-arm-usb-ocd-h.cfg -f target/lpc1768.cfg
```

## Complete Command Reference

```
openocd [Options]
```

### Options

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-h` | `--help` | Display the help message and exit |
| `-v` | `--version` | Display OpenOCD version information |
| `-f <name>` | `--file <name>` | Use the specified configuration file. Can be used multiple times to chain configs (e.g., interface then target) |
| `-s <dir>` | `--search <dir>` | Add a directory to the search path for configuration files and scripts |
| `-d` | `--debug` | Set debug level to 3 (highest verbosity) |
| `-d<n>` | | Set debug level to a specific level `<n>` (0-3) |
| `-l <name>` | `--log_output <name>` | Redirect log output to the specified file |
| `-c <command>` | `--command <command>` | Run the specified OpenOCD/Tcl command |

## Notes
- OpenOCD typically runs as a daemon. Once started, you can interact with it via:
    - **GDB**: Default port `3333`
    - **Telnet**: Default port `4444`
    - **RPC**: Default port `6666`
- Configuration files for common interfaces and targets are usually located in `/usr/share/openocd/scripts/`.
- When using `-f`, OpenOCD searches the current directory first, then the paths specified by `-s`, then the standard system library paths.