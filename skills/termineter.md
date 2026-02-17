---
name: termineter
description: A Python framework for security testing smart meters using C12.18 and C12.19 protocols over optical interfaces. Use when performing smart grid security audits, testing smart meter vulnerabilities, or interacting with ANSI type-2 optical probes to read/write meter tables and execute procedures.
---

# termineter

## Overview
Termineter is a smart meter testing framework that implements the C12.18 and C12.19 protocols. It is designed for communication over an optical interface (ANSI type-2 optical probe) and primarily supports meters using C12.19-2007 with 7-bit character sets, common in North America. Category: Exploitation / Hardware Hacking.

## Installation (if not already installed)
Assume termineter is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install termineter
```

## Common Workflows

### Starting the Framework
Launch the interactive console:
```bash
termineter
```

### Basic Information Gathering
After launching, identify the connected meter and its basic configuration:
```text
termineter > use get_identification
termineter > run
termineter > use get_info
termineter > run
```

### Enumerating Tables
Discover which C12.19 tables are readable on the device:
```text
termineter > use enum_tables
termineter > run
```

### Brute Forcing Credentials
Attempt to find valid login credentials for the meter:
```text
termineter > use brute_force_login
termineter > run
```

### Executing a Resource File
Automate commands by loading a predefined script:
```bash
termineter -r commands.rc
```

## Complete Command Reference

### CLI Arguments
```
usage: termineter [-h] [-v] [-L {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [-r RESOURCE_FILE]
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-v`, `--version` | Show program's version number and exit |
| `-L`, `--log` | Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL) |
| `-r`, `--rc-file` | Execute a resource file containing termineter commands |

### Framework Modules
Once inside the `termineter >` prompt, use `show modules` to see available tools. Use `use <module_name>` to select one and `run` to execute it.

| Module Name | Description |
|-------------|-------------|
| `brute_force_login` | Brute Force Credentials |
| `diff_tables` | Check C12.19 Tables For Differences |
| `dump_tables` | Write Readable C12.19 Tables To A CSV File |
| `enum_tables` | Enumerate Readable C12.19 Tables From The Device |
| `enum_user_ids` | Enumerate Valid User IDs From The Device |
| `get_identification` | Read And Parse The Identification Information |
| `get_info` | Get Basic Meter Information By Reading Tables |
| `get_local_display_info` | Get Information From The Local Display Tables |
| `get_log_info` | Get Information About The Meter's Logs |
| `get_modem_info` | Get Information About The Integrated Modem |
| `get_security_info` | Get Information About The Meter's Access Control |
| `read_table` | Read Data From A C12.19 Table |
| `remote_reset` | Initiate A Reset Procedure |
| `run_procedure` | Initiate A Custom Procedure |
| `set_meter_id` | Set The Meter's I.D. |
| `set_meter_mode` | Change the Meter's Operating Mode |
| `write_table` | Write Data To A C12.19 Table |

## Notes
- Requires an ANSI type-2 optical probe with a serial interface to communicate with physical meters.
- Ensure the serial port permissions are correct (e.g., `sudo usermod -aG dialout $USER`).
- Most North American meters use 7-bit character sets; ensure your configuration matches the target meter's specifications.