---
name: regripper
description: Perform forensic analysis of Windows Registry hives by extracting and translating data/metadata using specialized Perl plugins. Use when conducting digital forensics, incident response, or malware analysis to examine Registry-formatted files like NTUSER.DAT, SYSTEM, or SOFTWARE hives for artifacts.
---

# regripper

## Overview
RegRipper is an open-source tool for surgically extracting, translating, and displaying information from Windows Registry hives. It uses a plugin-based architecture (Perl scripts) to parse specific keys and values, allowing analysts to run individual plugins or predefined profiles against a hive file. Category: Digital Forensics.

## Installation (if not already installed)
Assume regripper is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install regripper
```

## Common Workflows

### Automatically run all relevant plugins for a hive
```bash
regripper -r /path/to/NTUSER.DAT -a > ntuser_analysis.txt
```

### Run a specific plugin against a hive
```bash
regripper -r /path/to/SYSTEM -p services > services_output.txt
```

### List all available plugins in CSV format
```bash
regripper -l -c
```

### Check if a hive is "dirty" (has uncommitted transaction logs)
```bash
regripper -r /path/to/SOFTWARE -d
```

## Complete Command Reference

```bash
regripper -r [Reg hive file] [-f profile] [-p plugin] [options]
```

### Core Options

| Flag | Description |
|------|-------------|
| `-r [hive]` | Registry hive file to parse |
| `-f [profile]` | Use a specific profile (a list of plugins) |
| `-p [plugin]` | Use a single specific plugin |
| `-a` | Automatically run hive-specific plugins based on hive type |
| `-aT` | Automatically run hive-specific TLN (Timeline) plugins |
| `-d` | Check to see if the hive is dirty (requires transaction log processing) |
| `-g` | Guess the hive file type |
| `-l` | List all available plugins |
| `-c` | Output plugin list in CSV format (must be used with `-l`) |
| `-s <systemname>` | Specify system name (for TLN support) |
| `-u <username>` | Specify user name (for TLN support) |
| `-uP` | Update default profiles |
| `-h` | Print help information |

## Notes
- **Transaction Logs**: RegRipper does **NOT** automatically process Registry transaction logs (.log1, .log2). It will notify you if a hive is dirty, but you should use tools like `yarp` + `registryFlush.py` or Eric Zimmerman's `rla.exe` to merge logs before parsing with RegRipper for the most accurate data.
- **Output**: All output is sent to STDOUT. Use redirection (`>`) to save results to a file.
- **Profiles**: Profiles are text files containing lists of plugins to be run together (e.g., the "system" profile runs all plugins relevant to a SYSTEM hive).