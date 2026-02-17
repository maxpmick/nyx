---
name: minicom
description: A menu-driven serial communication program used to connect to and manage devices via serial ports (RS-232). Use when configuring network switches, routers, embedded systems, or performing hardware hacking and console-based debugging. It supports terminal emulation (ANSI/VT102), file transfers (Zmodem, ASCII), and scripting for automated logins.
---

# minicom

## Overview
Minicom is a terminal-based serial communication program for Linux, similar to the MS-DOS "Telix". It is primarily used for interacting with hardware via serial device files (e.g., `/dev/ttyUSB0` or `/dev/ttyS0`). Category: Hardware / Wireless / Exploitation.

## Installation (if not already installed)
Assume minicom is already installed. If not:
```bash
sudo apt install minicom
```

## Common Workflows

### Initial Configuration
Before first use, configure the serial port, baud rate, and flow control:
```bash
sudo minicom -s
```
Navigate to "Serial port setup", set the device (e.g., `/dev/ttyUSB0`) and Bps/Par/Bits (e.g., 115200 8N1). Save as `dfl` (default).

### Connect to a Specific Device
Connect to a serial device with a specific baud rate:
```bash
minicom -D /dev/ttyUSB0 -b 115200
```

### Capture Session to File
Log all terminal output to a file for later analysis:
```bash
minicom -C session_log.txt
```

### Run in Hex Mode
Useful for debugging binary protocols or non-printable characters:
```bash
minicom -H
```

## Complete Command Reference

### minicom Options
```
minicom [OPTION]... [configuration]
```

| Flag | Description |
|------|-------------|
| `-b, --baudrate` | Set baudrate (overrides config) |
| `-D, --device` | Set device name (overrides config) |
| `-s, --setup` | Enter setup mode |
| `-o, --noinit` | Do not initialize modem & lockfiles at startup |
| `-m, --metakey` | Use meta or alt key for commands |
| `-M, --metakey8` | Use 8bit meta key for commands |
| `-l, --ansi` | Literal; assume screen uses non IBM-PC character set |
| `-L, --iso` | Don't assume screen uses ISO8859 |
| `-w, --wrap` | Linewrap on |
| `-H, --displayhex` | Display output in hex |
| `-z, --statline` | Try to use terminal's status line |
| `-7, --7bit` | Force 7bit mode |
| `-8, --8bit` | Force 8bit mode |
| `-c, --color=on/off` | ANSI style color usage on or off |
| `-a, --attrib=on/off` | Use reverse or highlight attributes on or off |
| `-t, --term=TERM` | Override TERM environment variable |
| `-S, --script=SCRIPT` | Run SCRIPT at startup |
| `-d, --dial=ENTRY` | Dial ENTRY from the dialing directory |
| `-p, --ptty=TTYP` | Connect to pseudo terminal |
| `-C, --capturefile=FILE` | Start capturing to FILE |
| `--capturefile-buffer-mode=MODE` | Set buffering mode of capture file |
| `-F, --statlinefmt` | Format of status line |
| `-R, --remotecharset` | Character set of communication partner |
| `-v, --version` | Output version information and exit |
| `-h, --help` | Show help |

### ascii-xfr (File Transfer)
Used for uploading/downloading files using the ASCII protocol.
```
ascii-xfr -s|-r [-dvn] [-l linedelay] [-c character delay] filename
```
| Flag | Description |
|------|-------------|
| `-s` | Send file |
| `-r` | Receive file |
| `-e` | Send the End Of File character (default is not to) |
| `-d` | Set End Of File character to Control-D (instead of Control-Z) |
| `-v` | Verbose (statistics on stderr output) |
| `-n` | Do not translate CRLF <--> LF |
| `-l` | Line delay in milliseconds |
| `-c` | Character delay in milliseconds |

### runscript (Script Interpreter)
Automates tasks like logins.
```
runscript scriptname [logfile [homedir]]
```

**Keywords:**
- `expect { pattern [statement] ... }`: Wait for a string from the modem.
- `send <string>`: Send string to modem (followed by `\r`).
- `goto <label>` / `gosub <label>` / `return`: Flow control.
- `! <command>`: Run shell command.
- `!< <command>`: Run shell command and send its stdout to the modem.
- `exit [value]`: Exit script.
- `set <var> <val>` / `inc <var>` / `dec <var>`: Variable manipulation (a-z).
- `if <val> <op> <val> <statement>`: Conditional (ops: `<`, `>`, `!=`, `=`).
- `timeout <value>`: Set global timeout (default 120s).
- `verbose <on|off>`: Echo modem input to screen.
- `sleep <value>`: Pause execution.
- `call <script>`: Run another script.
- `log <text>`: Write to logfile.

### xminicom
A script wrapper that runs `minicom -c` in a new color-capable xterm/rxvt window. Accepts the same options as `minicom`.

## Notes
- **Escape Sequence**: Once inside minicom, use `Ctrl-A` followed by a key to access menus (e.g., `Ctrl-A` then `Z` for the main menu, `Ctrl-A` then `X` to exit).
- **Permissions**: You often need to be in the `dialout` group or use `sudo` to access `/dev/ttyUSB` or `/dev/ttyS` devices.
- **Environment**: Options can be stored in the `MINICOM` environment variable.