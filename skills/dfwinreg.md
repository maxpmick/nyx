---
name: dfwinreg
description: Access and parse Windows Registry files (hives) using a Python library and command-line utilities. Use when performing digital forensics, incident response, or registry analysis to explore keys and values in a way that resembles a live Windows system hierarchy.
---

# dfwinreg

## Overview
dfWinReg (Digital Forensics Windows Registry) is a Python library and set of tools providing read-only access to Windows Registry objects. It provides a generic interface for accessing Registry keys and values from offline hive files, mimicking the hierarchy seen on a live system. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume dfwinreg is already installed. If you encounter errors, install the Python 3 package:

```bash
sudo apt update
sudo apt install python3-dfwinreg
```

## Common Workflows

### Basic Registry Hive Exploration
Since `dfwinreg` is primarily a library, it is often used via scripts. However, it includes utility scripts like `reg_explorer.py` (if available in the path) or is called via other log2timeline tools.

### Python Scripting Example
To use the library in a forensic script to open a hive and list subkeys:
```python
from dfwinreg import registry

# Initialize the registry and hive
reg = registry.WinRegistry()
with open('SYSTEM', 'rb') as file_object:
    win_registry_hive = reg.OpenFile(file_object)
    key = win_registry_hive.GetRootKey()
    for subkey in key.GetSubkeys():
        print(subkey.name)
```

## Complete Command Reference

The package `python3-dfwinreg` is primarily a library for other tools (like Plaso/log2timeline). While it does not provide a single monolithic binary, the following components and capabilities are included:

### Library Capabilities
The library supports the following Registry abstractions:
- **Registry Hives**: Support for NT (Windows NT 4.0 and later) registry files.
- **Registry Keys**: Access to key names, timestamps (Last Written Time), and subkeys.
- **Registry Values**: Access to value names, data types (REG_SZ, REG_DWORD, REG_BINARY, etc.), and raw data.

### Supported Data Types
| Type | Description |
|------|-------------|
| `REG_NONE` | No defined value type |
| `REG_SZ` | A null-terminated string |
| `REG_EXPAND_SZ` | A null-terminated string with unexpanded environment variables |
| `REG_BINARY` | Binary data in any form |
| `REG_DWORD` | A 32-bit number |
| `REG_DWORD_LITTLE_ENDIAN` | A 32-bit number in little-endian format |
| `REG_DWORD_BIG_ENDIAN` | A 32-bit number in big-endian format |
| `REG_LINK` | A Unicode symbolic link |
| `REG_MULTI_SZ` | An array of null-terminated strings |
| `REG_RESOURCE_LIST` | A device-driver resource list |
| `REG_FULL_RESOURCE_DESCRIPTOR` | A hardware setting |
| `REG_RESOURCE_REQUIREMENTS_LIST` | A hardware resource list |
| `REG_QWORD` | A 64-bit number |

### Utility Scripts
Depending on the specific version installed, the following scripts may be available in `/usr/bin/` or as part of the python module:

- `reg_explorer.py`: A command-line tool to browse a Windows Registry file.
- `hive_info.py`: Displays information about a specific Registry hive file.

#### General Arguments (Common to dfwinreg utilities)
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-d`, `--debug` | Enable debug output |
| `-v`, `--verbose` | Enable verbose output |

## Notes
- **Read-Only**: This tool is designed for forensics and does not support writing to or modifying Registry hives.
- **Dependencies**: Relies heavily on `python3-libregf` for the underlying parsing of the Windows NT Registry File (REGF) format.
- **Virtual Registry**: The library can create a "Virtual Registry" by mapping multiple hive files (SYSTEM, SOFTWARE, SAM, etc.) into a single tree structure to resolve symbolic links and paths like `HKEY_LOCAL_MACHINE`.