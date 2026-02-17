---
name: hivex
description: Read, write, and manipulate Windows Registry binary "hive" files. Use when performing digital forensics, incident response, or offline registry modification. Includes tools for extracting subkeys, converting hives to XML, interactive shell navigation, and merging/exporting in regedit format.
---

# hivex

## Overview
A collection of utilities for reading and writing Windows Registry "hive" binary files (e.g., SYSTEM, SOFTWARE, SAM). These tools operate directly on the binary files without requiring a running Windows system. Category: Digital Forensics / Post-Exploitation.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install libhivex-bin libwin-hivex-perl
```

## Common Workflows

### Extract a specific registry value
```bash
hivexget SYSTEM '\Select' Current
```

### Interactive hive exploration
```bash
hivexsh SOFTWARE
# Inside shell:
# ls
# cd \Microsoft\Windows\CurrentVersion
# lsval
# quit
```

### Export a hive to XML for analysis
```bash
hivexml -k SOFTWARE > software_hive.xml
```

### Export a specific key to .reg format
```bash
hivexregedit --export --prefix 'HKEY_LOCAL_MACHINE\SOFTWARE' SOFTWARE '\Microsoft\Windows' > windows_keys.reg
```

## Complete Command Reference

### hivexget
Extracts data pairs or specific values from a hive.
```bash
hivexget hivefile '\Path\To\SubKey' [name]
```
- `name`: The value name to retrieve. Use `@` for the default value.
- Paths are relative to the hive root (e.g., `\Microsoft` not `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft`).

### hivexml
Converts a binary hive into XML format.
```bash
hivexml [-dk] hivefile > output.xml
```
| Flag | Description |
|------|-------------|
| `-d` | Enable debug messages |
| `-k` | Keep going even if errors/corruption are found |
| `-u` | Use heuristics to tolerate corruption (unsafe) |

### hivexsh
Interactive shell for navigating and modifying hives.
```bash
hivexsh [-options] [hivefile]
```
**Options:**
| Flag | Description |
|------|-------------|
| `-d` | Enable debug messages |
| `-f <file>` | Read commands from a script file |
| `-u` | Use heuristics to tolerate corruption |
| `-w` | Enable write mode (requires `commit` to save) |

**Internal Commands:**
- `load <file>`: Load a hive file.
- `ls`: List subkeys of the current key.
- `lsval [key]`: List value pairs. Use `@` for default.
- `cd <path>`: Change subkey. Use `cd ..` for parent.
- `add <name>`: Add a subkey.
- `del`: Delete current node and children.
- `setval <nrvals>`: Replace values at current node. Followed by 2 * nrvals lines (Key, then Type:Value).
- `commit [newfile]`: Save changes (requires `-w`).
- `close`: Close current hive.

### hivexregedit
Merge or export registry changes using standard regedit format.

**Export Mode:**
```bash
hivexregedit --export [--prefix prefix] [--max-depth depth] hivefile key > regfile
```

**Merge Mode:**
```bash
hivexregedit --merge [--prefix prefix] [--encoding enc] hivefile [regfile]
```

**Options:**
| Flag | Description |
|------|-------------|
| `--help` | Display help |
| `--debug` | Enable library debugging |
| `--prefix <prefix>` | Specify Registry prefix (e.g., `HKEY_LOCAL_MACHINE\SOFTWARE`) |
| `--encoding <enc>` | Input encoding for merge: `UTF-16LE` (default) or `ASCII` |
| `--unsafe-printable-strings` | Export: Assume UTF-16LE and print as strings instead of hex |
| `--unsafe` | Use heuristics to tolerate corruption |
| `--max-depth <depth>` | Limit recursion depth of export (0 = no values, 1 = direct children) |

## Notes
- **Pathing**: Hive files do not store their own root prefix (like `HKEY_LOCAL_MACHINE`). You must know which hive you are editing and often provide the `--prefix` in `hivexregedit`.
- **Write Safety**: In `hivexsh`, changes are only written to disk if `-w` is used AND the `commit` command is executed.
- **Corruption**: The `-u` (unsafe) flag can help recover data from damaged hives but may produce inaccurate results.