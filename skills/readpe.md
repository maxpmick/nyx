---
name: readpe
description: Analyze, manipulate, and extract information from Windows Portable Executable (PE) files including EXE, DLL, and OCX. Use for malware analysis, digital forensics, incident response, and security research to inspect headers, sections, resources, imports/exports, and security mitigations.
---

# readpe

## Overview
The `readpe` toolkit is a suite of command-line utilities designed to parse and analyze Windows PE32/PE32+ files. It allows for deep inspection of file structures, disassembly, packer detection, and security feature verification. Category: Digital Forensics / Malware Analysis.

## Installation (if not already installed)
The toolkit is usually pre-installed on Kali Linux. If missing:
```bash
sudo apt update && sudo apt install readpe
```

## Common Workflows

### Basic File Analysis
View all headers, sections, and imports for a suspicious binary:
```bash
readpe --all malware.exe
```

### Security Mitigation Check
Check if a binary has ASLR, DEP, SafeSEH, or Control Flow Guard enabled:
```bash
pesec suspicious.dll
```

### Malware Triage
Scan for suspicious characteristics and check for known packers:
```bash
pescan suspicious.exe
pepack suspicious.exe
```

### Resource Extraction
List and extract all resources (icons, manifests, etc.) from a PE file:
```bash
peres -a sample.exe
```

## Complete Command Reference

### readpe
Displays comprehensive information about PE file headers.
- `-A, --all`: Full output (default).
- `-H, --all-headers`: Show all PE headers.
- `-S, --all-sections`: Show PE section headers.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-d, --dirs`: Show data directories.
- `-h, --header <dos|coff|optional>`: Show specific header (can be used multiple times).
- `-i, --imports`: Show imported functions.
- `-e, --exports`: Show exported functions.
- `-V, --version`: Show version.

### pesec
Check for security features and protections.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-c, --certoutform <text|pem>`: Certificate output format (default: text).
- `-o, --certout <filename>`: Write certificates to file (default: stdout).

### pescan
Identify suspicious characteristics.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-v, --verbose`: Show more information about found items.

### pepack
Search for packers in PE files.
- `-d, --database <file>`: Use custom database file (default: `./userdb.txt`).
- `-f, --format <csv|json|xml|html|text>`: Change output format.

### pedis
Disassemble PE sections and functions.
- `--att`: Set AT&T assembly syntax (default: Intel).
- `-e, --entrypoint`: Disassemble the entire entrypoint function.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-m, --mode <16|32|64>`: Disassembly mode (default: auto).
- `-i <number>`: Number of instructions to disassemble.
- `-n <number>`: Number of bytes to disassemble.
- `-o, --offset <offset>`: Disassemble at specified raw offset.
- `-r, --rva <rva>`: Disassemble at specified RVA.
- `-s, --section <section_name>`: Disassemble an entire section.

### pehash
Calculate hashes of PE pieces.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-a, --all`: Hash file, sections, and headers (MD5, SHA1, SHA256, ssdeep, imphash).
- `-c, --content`: Hash only the file content (default).
- `-h, --header <dos|coff|optional>`: Hash specific header.
- `-s, --section <section_name>`: Hash specific section.
- `--section-index <index>`: Hash section at specified index (1..n).

### peres
Analyze and extract PE file resources.
- `-a, --all`: Show all info, stats, and extract resources.
- `-f, --format <csv|json|xml|html|text>`: Change output format.
- `-i, --info`: Show resources information.
- `-l, --list`: Show list view.
- `-s, --statistics`: Show resources statistics.
- `-x, --extract`: Extract resources.
- `-X, --named-extract`: Extract resources with path names.
- `-v, --file-version`: Show File Version from resource directory.

### pestr
Search for strings within the PE file.
- `-n, --min-length`: Set minimum string length (default: 4).
- `-o, --offset`: Show string offset in file.
- `-s, --section`: Show string section, if exists.

### peldd
Display library dependencies (similar to `ldd` for ELF).
- `-f, --format <csv|json|xml|html|text>`: Change output format.

### Address Conversion Tools
- `ofs2rva <offset> FILE`: Convert raw file offset to Relative Virtual Address (RVA).
- `rva2ofs <rva> FILE`: Convert RVA to raw file offset.

## Notes
- The toolkit is highly modular; use the specific sub-tool for the task (e.g., `pesec` for security, `pepack` for packers) rather than parsing the raw `readpe` output.
- Address conversion (`ofs2rva`/`rva2ofs`) is essential when mapping static analysis findings to runtime memory addresses.