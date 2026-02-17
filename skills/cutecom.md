---
name: cutecom
description: A graphical serial terminal used for communicating with hardware devices via serial ports. It features a line-oriented interface, hexadecimal input/output, and support for file transfer protocols like Xmodem, Ymodem, and Zmodem. Use when performing hardware hacking, firmware debugging, interacting with embedded systems, or communicating with network equipment via console cables.
---

# cutecom

## Overview
CuteCom is a graphical serial terminal similar to minicom, primarily designed for hardware developers. It provides a user-friendly interface for interacting with devices over serial connections, supporting both ASCII and hexadecimal data formats. Category: Hardware Attacks / Reconnaissance.

## Installation (if not already installed)
Assume cutecom is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install cutecom
```

Note: For Xmodem, Ymodem, and Zmodem support, the `lrzsz` package must also be installed.

## Common Workflows

### Launch the GUI
Simply run the command to open the graphical interface:
```bash
cutecom
```

### Open a specific saved session
Launch CuteCom with settings (baud rate, device path, etc.) predefined in a specific session:
```bash
cutecom --session "Switch-Console"
```

### Create a new session from command line
If the session name does not exist, CuteCom opens with default parameters under that name:
```bash
cutecom -s "NewDevice"
```

## Complete Command Reference

```
cutecom [Options]
```

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Prints a short help message and exits. |
| `-s`, `--session <session_name>` | Opens a previously defined session. If the session name is not found in the configuration file, a new session with default connection parameters is created. |

### Files
*   `~/.config/CuteCom/CuteCom5.conf`: Personal configuration file where sessions and global settings are stored.

## Notes
*   **Line-oriented vs Character-oriented**: Unlike minicom, CuteCom is line-oriented, meaning it typically sends data after you press enter rather than character-by-character, which is often preferred for AT commands or structured data.
*   **Hexadecimal Mode**: Useful for debugging binary protocols where non-printable characters are transmitted.
*   **Permissions**: Ensure your user is part of the `dialout` group (or equivalent) to access serial device files like `/dev/ttyUSB0` or `/dev/ttyS0` without root privileges.
*   **Dependencies**: Requires `lrzsz` for file transfers (X/Y/Zmodem).