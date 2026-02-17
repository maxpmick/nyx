---
name: msitools
description: Inspect, create, extract, and manipulate Windows Installer (.msi) files. Use when performing reconnaissance on Windows installers, extracting embedded payloads or configuration files, auditing MSI database tables, or building custom MSI packages for deployment or exploitation.
---

# msitools

## Overview
A suite of programs to create, inspect, and extract Windows Installer (.msi) files. It includes tools for building packages from scratch (wixl), extracting files (msiextract), and querying internal MSI databases (msiinfo/msidump). Category: Reconnaissance / Information Gathering, Exploitation.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install msitools wixl
```

## Common Workflows

### Extracting files from an MSI
```bash
msiextract -C ./output_dir setup.msi
```

### Inspecting MSI Summary Information
```bash
msiinfo suminfo setup.msi
```

### Dumping all tables and streams to a directory
```bash
msidump -t -s -d ./dump_output setup.msi
```

### Building an MSI from a WiX XML file
```bash
wixl -o output.msi input.wxs
```

## Complete Command Reference

### msibuild
Build or modify Windows Installer packages.
```
msibuild MSIFILE [OPTION]...
```
| Flag | Description |
|------|-------------|
| `-s name [author] [template] [uuid]` | Set summary information |
| `-q query` | Execute SQL query/queries |
| `-i table1.idt` | Import one table into the database |
| `-a stream file` | Add 'stream' to storage with contents of 'file' |

### msidiff
Compare the contents of two MSI files.
```
msidiff [OPTION]... [DIFF-OPTIONS] FROM-MSI TO-MSI
```
| Flag | Description |
|------|-------------|
| `-t, --tables` | Diff MSI tables as text (Default) |
| `-l, --list` | Diff lists of files |
| `-L, --long-list` | Diff long lists (akin to 'find -ls') of files |
| `-h, --help` | Print help message |
| `-v, --version` | Print version information |

### msidump
Dump tables and streams contained in MSI packages.
```
msidump [OPTION]... MSI-FILE
```
| Flag | Description |
|------|-------------|
| `-t, --tables` | Dump tables (Default) |
| `-s, --streams` | Dump streams |
| `-S, --signature` | Dump asn1parse of digital signature |
| `-d, --directory DIR` | Dump to given directory DIR |
| `-h, --help` | Print help message |
| `-v, --version` | Print version information |

### msiextract
Extract files contained in MSI packages.
```
msiextract [OPTION…] MSI_FILE...
```
| Flag | Description |
|------|-------------|
| `-C, --directory` | Extract to specific directory |
| `-l, --list` | List files only (do not extract) |
| `-h, --help` | Show help options |
| `--version` | Display version number |

### msiinfo
Display and extract information from MSI packages.
```
msiinfo SUBCOMMAND COMMAND-OPTIONS...
```
**Subcommands:**
- `help`: Show program or subcommand usage
- `streams`: List streams in a .msi file
- `tables`: List tables in a .msi file
- `extract`: Extract a binary stream from an .msi file
- `export`: Export a table in text form from an .msi file
- `suminfo`: Print summary information

### wixl
Build MSI packages from XML documents (WiX-like).
```
wixl [OPTION…] INPUT_FILE1 [INPUT_FILE2]...
```
| Flag | Description |
|------|-------------|
| `-o, --output` | Output file name |
| `-v, --verbose` | Verbose output |
| `-D, --define` | Define variable |
| `-a, --arch` | Target architecture |
| `-I, --includedir` | Include directory |
| `--extdir` | System extension directory |
| `--wxidir` | System include directory |
| `-E, --only-preproc` | Stop after the preprocessing stage |
| `--ext` | Specify an extension |
| `-h, --help` | Show help options |

### wixl-heat
Builds WiX XML fragments from a list of files and directories.
```
wixl-heat [OPTION…]
```
| Flag | Description |
|------|-------------|
| `--directory-ref` | Directory Reference |
| `--component-group` | Component Group |
| `--var` | Variable for source directory |
| `-p, --prefix` | Prefix |
| `-x, --exclude` | Exclude prefix |
| `--win64` | Add Win64 Component |
| `-h, --help` | Show help options |

## Notes
- `msibuild` will create a new file with an empty database if the target MSI does not exist.
- `msidiff` passes options to the system `diff` command; default is `-Nup` for contents and `-U0` for others.
- `libmsi` is the underlying library used by these tools for GObject-based MSI manipulation.