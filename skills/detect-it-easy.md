---
name: detect-it-easy
description: Identify file types, packers, compilers, and linkers using signature-based and heuristic analysis. Use when performing malware analysis, reverse engineering, or initial file triage to determine how a binary was built or if it is obfuscated/packed.
---

# detect-it-easy

## Overview
Detect It Easy (DiE) is a versatile program for determining types of files. It is primarily used by malware analysts and reverse engineers to identify file signatures, compilers, packers, and entropy. It supports Windows, Linux, and MacOS binaries and features a script-driven detection architecture. Category: Reverse Engineering.

## Installation (if not already installed)
Assume the tool is installed. If the `diec` command is missing:

```bash
sudo apt update
sudo apt install detect-it-easy
```

## Common Workflows

### Basic file identification
```bash
diec malware.exe
```
Identifies the file type, compiler, and any detected packers.

### Deep scan with entropy analysis
```bash
diec -d -e suspicious_file.bin
```
Performs a deep scan and displays entropy levels to help identify packed or encrypted sections.

### Recursive directory scan with JSON output
```bash
diec -r /path/to/samples/ --json > results.json
```
Scans all files in a directory recursively and saves the structured results to a file.

### Calculate specific hashes
```bash
diec -S "Hash#SHA256" target_file
```
Uses a special method to calculate and display the SHA256 hash of the target.

## Complete Command Reference

The package provides three main interfaces:
- `die`: Graphical User Interface (GUI)
- `diec`: Command Line Interface (CLI)
- `diel`: Library/Lite version

### diec (CLI) Options

```
Usage: diec [options] target
```

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Displays help on commandline options |
| `--help-all` | Displays help including Qt specific options |
| `-v`, `--version` | Displays version information |
| `-r`, `--recursivescan` | Recursive scan of directories |
| `-d`, `--deepscan` | Deep scan for more thorough identification |
| `-u`, `--heuristicscan` | Heuristic scan to identify unknown patterns |
| `-b`, `--verbose` | Verbose output |
| `-g`, `--aggressivecscan` | Aggressive scan mode |
| `-a`, `--alltypes` | Scan all file types |
| `-l`, `--profiling` | Profiling signatures |
| `-U`, `--hideunknown` | Hide unknown results |
| `-e`, `--entropy` | Show file entropy |
| `-i`, `--info` | Show general file info |
| `-S`, `--special <method>` | Special file info for `<method>` (e.g., `-S "Hash"` or `-S "Hash#MD5"`) |
| `-x`, `--xml` | Output result as XML |
| `-j`, `--json` | Output result as JSON |
| `-c`, `--csv` | Output result as CSV |
| `-t`, `--tsv` | Output result as TSV |
| `-p`, `--plaintext` | Output result as Plain Text |
| `-D`, `--database <path>` | Set primary database path |
| `-E`, `--extradatabase <path>` | Set extra database path |
| `-C`, `--customdatabase <path>` | Set custom database path |
| `-s`, `--showdatabase` | Show current database being used |
| `-m`, `--showmethods` | Show all special methods available for the file |

### Arguments
| Argument | Description |
|----------|-------------|
| `target` | The file or directory to analyze |

## Notes
- DiE is highly extensible via its signature database, which uses a JavaScript-like syntax for detection rules.
- High entropy (close to 8.0) usually indicates that a file is packed, compressed, or encrypted.
- Use the `-m` flag first if you are unsure what special methods (like specific hash types) are supported for a particular file format.