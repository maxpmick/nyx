---
name: mfterm
description: A terminal interface for working with Mifare Classic 1-4k RFID tags. Use when performing RFID security assessments, reading/writing Mifare Classic tags, managing tag keys, or analyzing tag data structures. It provides an interactive shell with tab completion and command history for streamlined tag manipulation.
---

# mfterm

## Overview
mfterm is a specialized terminal interface for interacting with Mifare Classic tags (1k, 2k, and 4k). It provides a user-friendly environment for reading, writing, and managing tag data and keys using libnfc-compatible hardware. Category: Wireless Attacks / RFID.

## Installation (if not already installed)
Assume mfterm is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install mfterm
```

## Common Workflows

### Starting mfterm with a specific key file
```bash
mfterm --keys=mykeys.mfd
```

### Loading a tag dump for offline analysis
```bash
mfterm --tag=dump.mfd
```

### Interactive Session
Once inside the mfterm shell, you can use commands like:
- `scan`: To find nearby tags.
- `load <file>`: To load tag data.
- `save <file>`: To save current tag data to a file.
- `print`: To display the current tag content.
- `help`: To see all available interactive commands.

## Complete Command Reference

```
mfterm [Options]
```

### Options

| Flag | Long Flag | Description |
|------|-----------|-------------|
| `-h` | `--help` | Show the help message and exit. |
| `-v` | `--version` | Display version information. |
| `-t <file>` | `--tag=<file>` | Load a tag from the specified file (usually .mfd or .bin). |
| `-k <file>` | `--keys=<file>` | Load keys from the specified file for authentication. |
| `-d <file>` | `--dict=<file>` | Load a dictionary of keys from the specified file. |

## Notes
- mfterm requires a libnfc-compatible reader (e.g., ACR122U, PN532) to interact with physical tags.
- The tool supports tab completion for both internal commands and filesystem paths.
- Mifare Classic security relies on the CRYPTO1 algorithm; you must have the correct keys to read or write protected sectors.