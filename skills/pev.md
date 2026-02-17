---
name: pev
description: A multi-tool toolkit for analyzing PE32/PE32+ executables (EXE, DLL, OCX). Use it to perform static analysis, malware triage, and digital forensics on Windows binaries by inspecting headers, sections, resources, imports, and security features.
---

# pev

## Overview
pev is a comprehensive suite of tools designed to get information from PE32/PE32+ executables. It belongs to the Digital Forensics and Incident Response domains, allowing analysts to disassemble code, calculate hashes, check for packers, and identify suspicious characteristics in Windows binaries.

## Installation (if not already installed)
Assume pev is already installed. If you encounter a "command not found" error:

```bash
sudo apt update && sudo apt install pev
```

## Common Workflows

### Basic Static Analysis
Get a full overview of the PE headers and sections:
```bash
readpe --all malware.exe
```

### Malware Triage
Check if a file is packed and scan for suspicious characteristics:
```bash
pepack suspicious.exe
pescan suspicious.exe
```

### Resource Extraction
List and extract all resources (icons, manifests, etc.) from a binary:
```bash
peres -a putty.exe
```

### Security Feature Audit
Check for exploit mitigations like ASLR, DEP, and digital signatures:
```bash
pesec wordpad.exe
```

## Complete Command Reference

### readpe
Displays information about PE file headers and structures.
- `-A, --all`: Full output (default).
- `-H, --all-headers`: Show all PE headers.
- `-S, --all-sections`: Show PE section headers.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-d, --dirs`: Show data directories.
- `-h, --header <dos|coff|optional>`: Show specific header (can be used multiple times).
- `-i, --imports`: Show imported functions.
- `-e, --exports`: Show exported functions.
- `-V, --version`: Show version.

### pedis
Disassemble PE sections and functions.
- `--att`: Set AT&T assembly syntax (default: Intel).
- `-e, --entrypoint`: Disassemble the entire entrypoint function.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-m, --mode <16|32|64>`: Disassembly mode (default: auto).
- `-i <number>`: Number of instructions to disassemble.
- `-n <number>`: Number of bytes to disassemble.
- `-o, --offset <offset>`: Disassemble at specified raw offset.
- `-r, --rva <rva>`: Disassemble at specified RVA.
- `-s, --section <section_name>`: Disassemble an entire section.

### pehash
Calculate hashes of PE pieces.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-a, --all`: Hash file, sections, and headers with md5, sha1, sha256, ssdeep, and imphash.
- `-c, --content`: Hash only the file content (default).
- `-h, --header <dos|coff|optional>`: Hash only the specified header.
- `-s, --section <section_name>`: Hash only the specified section.
- `--section-index <index>`: Hash only the section at the specified index (1..n).

### peres
Analyze and extract PE file resources.
- `-a, --all`: Show all information, statistics, and extract resources.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-i, --info`: Show resources information.
- `-l, --list`: Show list view.
- `-s, --statistics`: Show resources statistics.
- `-x, --extract`: Extract resources.
- `-X, --named-extract`: Extract resources with path names.
- `-v, --file-version`: Show File Version from PE resource directory.

### pescan
Identify suspicious characteristics in PE files.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-v, --verbose`: Show more information about found items.

### pesec
Check for security protections (ASLR, DEP, CFG, etc.) and certificates.
- `-f, --format <xml|html|json|text|csv>`: Change output format.
- `-c, --certoutform <text|pem>`: Certificate output format (default: text).
- `-o, --certout <filename>`: Output filename for certificates (default: stdout).

### pestr
Search for strings in PE files.
- `-n, --min-length <num>`: Set minimum string length (default: 4).
- `-o, --offset`: Show string offset in file.
- `-s, --section`: Show string section, if exists.

### pepack
Search for packers in PE files.
- `-d, --database <file>`: Use custom database file (default: ./userdb.txt).
- `-f, --format <xml|html|json|text|csv>`: Change output format.

### peldd
Shows library dependencies (imported DLLs).
- `-f, --format <xml|html|json|text|csv>`: Change output format.

### Address Conversion Tools
- **ofs2rva `<offset> <FILE>`**: Converts a PE raw file offset to Relative Virtual Address (RVA).
- **rva2ofs `<rva> <FILE>`**: Converts a PE Relative Virtual Address (RVA) to raw file offset.

## Notes
- The tools in the `pev` suite are designed for static analysis; they do not execute the binary.
- When using `pedis`, the tool disassembles until a `RET` or `LEAVE` instruction is found by default unless specified otherwise.
- `pehash -a` is highly recommended for generating "Imphash" (Import Hash), which is useful for identifying malware families.