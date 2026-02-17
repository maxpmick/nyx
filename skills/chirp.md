---
name: chirp
description: Program and configure amateur (ham) radios by interfacing with hardware via serial ports or managing memory map files. Use when performing hardware reconnaissance on radio equipment, cloning radio configurations, or auditing/modifying frequency memories and settings for SDR and wireless security assessments.
---

# chirp

## Overview
CHIRP is an open-source tool for programming amateur radios. It supports a vast array of manufacturers and models, allowing users to download, edit, and upload radio configurations. It includes a GUI (`chirpw`), a command-line interface (`chirpc`), and a specialized tuning utility (`experttune`). Category: Wireless Attacks / SDR.

## Installation (if not already installed)
Assume CHIRP is already installed. If not:
```bash
sudo apt update && sudo apt install chirp
```

## Common Workflows

### List Supported Radios
Identify the correct model string for use in CLI commands.
```bash
chirpc --list-radios
```

### Download Radio Configuration to File
Save the entire memory map of a radio to a local file for backup or analysis.
```bash
chirpc -r <model> -s /dev/ttyUSB0 --download-mmap --mmap backup.img
```

### Quick Memory Inspection
List all programmed channels and frequencies from a saved memory map file.
```bash
chirpc --mmap backup.img --list-mem
```

### Modify a Specific Channel
Update the frequency and name of a specific memory slot in a file.
```bash
chirpc --mmap backup.img --set-mem-freq 146.520 --set-mem-name "CALL" 1
```

## Complete Command Reference

### chirpc (Command Line Interface)
```
usage: chirpc [-h] [--version] [-s SERIAL] [--list-settings] [-i] [--list-mem]
              [--list-special-mem] [--raw] [--get-mem] [--copy-mem]
              [--clear-mem] [--set-mem-name SET_MEM_NAME]
              [--set-mem-freq SET_MEM_FREQ] [--set-mem-tencon]
              [--set-mem-tencoff] [--set-mem-tsqlon] [--set-mem-tsqloff]
              [--set-mem-dtcson] [--set-mem-dtcsoff]
              [--set-mem-tenc SET_MEM_TENC] [--set-mem-tsql SET_MEM_TSQL]
              [--set-mem-dtcs SET_MEM_DTCS]
              [--set-mem-dtcspol SET_MEM_DTCSPOL] [--set-mem-dup SET_MEM_DUP]
              [--set-mem-offset SET_MEM_OFFSET] [--set-mem-mode SET_MEM_MODE]
              [-r RADIO] [--list-radios] [--mmap MMAP] [--download-mmap]
              [--upload-mmap] [-q] [-v] [--log LOG_FILE]
              [--log-level LOG_LEVEL] [arg ...]
```

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message and exit |
| `--version` | Print version and exit |
| `-s, --serial SERIAL` | Serial port (default: mmap) |
| `--list-settings` | List radio settings |
| `-i, --id` | Request radio ID string |
| `-r, --radio RADIO` | Radio model (see `--list-radios`) |
| `--list-radios` | List supported radio models |
| `--mmap MMAP` | Radio memory map file location |
| `--download-mmap` | Download memory map from radio to file |
| `--upload-mmap` | Upload memory map from file to radio |
| `-q, --quiet` | Decrease verbosity |
| `-v, --verbose` | Increase verbosity |
| `--log LOG_FILE` | Log messages to a file |
| `--log-level LOG_LEVEL` | Log level (critical, error, warn, info, debug) |

**Memory/Channel Options:**
| Option | Description |
|--------|-------------|
| `--list-mem` | List all memory locations |
| `--list-special-mem` | List all special memory locations |
| `--raw` | Dump raw memory location |
| `--get-mem` | Get and print memory location |
| `--copy-mem` | Copy memory location |
| `--clear-mem` | Clear memory location |
| `--set-mem-name NAME` | Set memory name |
| `--set-mem-freq FREQ` | Set memory frequency |
| `--set-mem-tencon` | Set tone encode enabled flag |
| `--set-mem-tencoff` | Set tone decode disabled flag |
| `--set-mem-tsqlon` | Set tone squelch enabled flag |
| `--set-mem-tsqloff` | Set tone squelch disabled flag |
| `--set-mem-dtcson` | Set DTCS enabled flag |
| `--set-mem-dtcsoff` | Set DTCS disabled flag |
| `--set-mem-tenc TONE` | Set memory encode tone |
| `--set-mem-tsql TONE` | Set memory squelch tone |
| `--set-mem-dtcs CODE` | Set memory DTCS code |
| `--set-mem-dtcspol POL` | Set memory DTCS polarity (NN, NR, RN, RR) |
| `--set-mem-dup DUP` | Set memory duplex (+, -, or blank) |
| `--set-mem-offset OFF` | Set memory duplex offset (in MHz) |
| `--set-mem-mode MODE` | Set mode (WFM, FM, NFM, AM, NAM, DV, USB, LSB, CW, RTTY, DIG, PKT, NCW, NCWR, CWR, P25, Auto, RTTYR, FSK, FSKR, DMR, DN) |

---

### chirpw (Graphical User Interface)
```
usage: chirpw [-h] [--module module] [--version] [--profile]
              [--onlydriver ONLYDRIVER [ONLYDRIVER ...]] [--inspect]
              [--page PAGE]
              [--action {upload,download,query_rr,query_mg,query_rb,query_dm,new}]
              [--restore] [--force-language FORCE_LANGUAGE]
              [--config-dir CONFIG_DIR] [--no-linux-gdk-backend]
              [--install-desktop-app | --no-install-desktop-app] [-q] [-v]
              [--log LOG_FILE] [--log-level LOG_LEVEL] [file ...]
```

| Option | Description |
|--------|-------------|
| `--module module` | Load module on startup |
| `--profile` | Enable profiling |
| `--onlydriver DRIVER` | Include specific driver while loading |
| `--inspect` | Show wxPython inspector |
| `--page PAGE` | Select specific page of default editor at start |
| `--action ACTION` | Start UI action immediately (upload, download, etc.) |
| `--restore` | Restore previous tabs |
| `--force-language LANG` | Force locale to ISO language code |
| `--config-dir DIR` | Use alternate directory for config/profile data |
| `--no-linux-gdk-backend`| Do not force GDK_BACKEND=x11 |
| `--install-desktop-app` | Install desktop icon |

---

### experttune (Linear Tuning Tool)
```
usage: experttune [-h] [--bands BANDS] [--call CALL]
                  [--next {interactive,auto}] [--debug]
                  {7200,7300,7610,Demo} port
```

| Option | Description |
|--------|-------------|
| `{7200,7300,7610,Demo}` | Radio model |
| `port` | Serial port for CAT control |
| `--bands BANDS` | Comma-separated list of bands to tune (160, 80, etc.) |
| `--call CALL` | Callsign for CW ID after each step |
| `--next STRATEGY` | Next step strategy: `interactive` or `auto` |
| `--debug` | Enable verbose debugging |

## Notes
- **Supported Formats**: CHIRP can import/export `.csv`, `.eve` (Yaesu), `.hmk`/`.itm` (Kenwood), `.icf` (Icom), `.tpe` (ARRL), and `.vx5`/`.vx7` (Commander).
- **Hardware Access**: Ensure the user is in the `dialout` group or use `sudo` to access serial ports (e.g., `/dev/ttyUSB0`).
- **Safety**: Always download and save a backup of the original radio memory map before attempting to upload modifications.