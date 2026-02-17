---
name: hurl
description: Encode and decode data between various formats including Hexadecimal, URL, Base64, HTML, and Binary. Use when performing web application testing, manual payload crafting, decoding obfuscated strings in malware analysis, or converting data types during exploitation development.
---

# hURL

## Overview
hURL is a versatile hexadecimal and URL encoder/decoder. It supports a wide range of conversions including Base64, HTML entities, ROT13, and various numeric bases (Integer, Float, Octal, Binary), as well as cryptographic hashing (MD5, SHA family). Category: Web Application Testing / Exploitation.

## Installation (if not already installed)
Assume hURL is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install hurl
```

## Common Workflows

### URL and Base64 Decoding
Quickly decode strings found in web requests or scripts:
```bash
hURL -u "hello%20world"
hURL -b "S2FsaSBMaW51eAo="
```

### Payload Crafting for Shellcode
Convert a string into a stack-push format for exploit development (Corelan style):
```bash
hURL -9 "cmd.exe" --esc
```

### File-based Binary to Hex Conversion
Convert a binary file to a hex-escaped string for use in scripts:
```bash
hURL -r -f /tmp/payload.bin --esc
```

### Quick Hashing
Generate a SHA256 hash of a string:
```bash
hURL -4 "password123"
```

## Complete Command Reference

### General Usage
```bash
hURL [ -flag|--flag ] [ -f <file1>,<file2> ] [ string ]
```

### Encoding and Decoding Options

| Flag | Description | Example |
|------|-------------|---------|
| `-M`, `--menu` | Launch Menu-driven GUI | `hURL -M` |
| `-U`, `--URL` | URL encode | `hURL -U "hello world"` |
| `-u`, `--url` | URL decode | `hURL -u "hello%20world"` |
| `-D`, `--DURL` | Double URL encode | `hURL -D "hello world"` |
| `-d`, `--durl` | Double URL decode | `hURL -d "hello%2520world"` |
| `-B`, `--BASE64` | Base64 encode | `hURL -B "hello world"` |
| `-b`, `--base64` | Base64 decode | `hURL -b "aGVsbG8gd29ybGQ="` |
| `-H`, `--HTML` | HTML encode | `hURL -H "<hello world>"` |
| `-h`, `--html` | HTML decode | `hURL -h "&lt;hello world&gt;"` |
| `-7`, `--ROT13` | ROT13 encode | `hURL -7 "hello world"` |
| `-8`, `--rot13` | ROT13 decode | `hURL -8 "uryyb jbeyq"` |

### Hexadecimal and Numeric Conversions

| Flag | Description | Example |
|------|-------------|---------|
| `-X`, `--HEX` | ASCII to Hex | `hURL -X "hello world"` |
| `-x`, `--hex` | Hex to ASCII | `hURL -x "68656c6c6f20776f726c64"` |
| `-I`, `--INT` | Integer to Hex | `hURL -I "10"` |
| `-i`, `--int` | Hex to Integer | `hURL -i "0xa"` |
| `-n`, `--nint` | Negative Integer to Hex | `hURL -n -- -77` |
| `-N`, `--NHEX` | Negative Hex to Integer | `hURL -N 0xffffffb3` |
| `-T`, `--INTB` | Integer to Binary | `hURL -T 30` |
| `-t`, `--bint` | Binary to Integer | `hURL -t 1010` |
| `-F`, `--FLOATH` | Float to Hex | `hURL -F 3.33` |
| `-l`, `--hfloat` | Hex to Float | `hURL -l 0x40551ed8` |
| `-o`, `--octh` | Octal to Hex | `hURL -o 35` |
| `-O`, `--HOCT` | Hex to Octal | `hURL -O 0x12` |
| `-0`, `--binh` | Binary to Hex | `hURL -0 1100011` |
| `-1`, `--hexb` | Hex to Binary | `hURL -1 0x63` |
| `-e`, `--net` | Int to Hex (Network Byte Order) | `hURL -e 4444` |
| `-E`, `--NET` | Hex (Network Byte Order) to Int | `hURL -E 5c11` |

### Hashing Options

| Flag | Description |
|------|-------------|
| `-m`, `--md5` | MD5 digest |
| `-2`, `--SHA1` | SHA1 checksum |
| `-3`, `--SHA224` | SHA224 checksum |
| `-4`, `--SHA256` | SHA256 checksum |
| `-5`, `--SHA384` | SHA384 checksum |
| `-6`, `--SHA512` | SHA512 checksum |

### Specialized and File Options

| Flag | Description |
|------|-------------|
| `-9`, `--stack` | Push string to stack (Corelan format) |
| `-w`, `--wbin` | Hex [file] to binary [file] (`-f <INfile> <OUTfile>`) |
| `-r`, `--rbin` | Binary [file] to hex (Corelan format) |
| `-f`, `--file` | Use file(s) as input |
| `-s` | Suppress (display result only, no headers) |

### Formatting Modifiers
Used with `-X`, `-9`, or `-r`:
- `--esc`: Output in escaped string (`\x00\x01...`)
- `--pair`: Output in hexpair format (`00010203...`)
- `--ansiC`: Output in C format (`0x00, 0x01...`)

### Miscellaneous

| Flag | Description |
|------|-------------|
| `--color` | Enable colored output (default) |
| `--nocolor` | Disable colored output |
| `--corelan` | Display Corelan reference |
| `--help` | Display help |
| `--man` | Display extended help with examples |
| `--version` | Display version information |

## Notes
- When using negative integers (`-n`), use `--` to prevent the shell from interpreting the negative sign as a flag.
- The `-s` (suppress) flag is highly recommended when piping hURL output to other tools.