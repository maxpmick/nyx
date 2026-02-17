---
name: pack2
description: Analyze password datasets to generate statistical cracking masks and perform wordlist filtering. Use when performing password analysis, mask generation for Hashcat/John the Ripper, or optimizing brute-force attacks by targeting common password patterns found in leaked datasets.
---

# pack2

## Overview
Password Analysis and Cracking Kit 2 (pack2) is a tool designed to aid in "better than brute-force" password attacks. It analyzes wordlists to identify common patterns (charsets, lengths, and structures) and generates optimized attack masks. It is a modern replacement for the original PACK (Password Analysis and Cracking Kit). Category: Password Attacks.

## Installation (if not already installed)
Assume pack2 is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install pack2
```

## Common Workflows

### Generate masks from a password leak
```bash
pack2 statsgen passwords.txt --output patterns.masks
```
Analyzes `passwords.txt`, outputs statistics to stderr, and writes generated masks to `patterns.masks`.

### Filter a wordlist by a specific mask
```bash
pack2 filtermask ?u?l?l?l?d?d wordlist.txt
```
Outputs only the words from `wordlist.txt` that match the pattern: one uppercase, three lowercase, and two digits.

### Decode HEX-encoded passwords
```bash
cat leaked_hashes.txt | pack2 unhex
```
Decodes lines formatted as `$HEX[...]` into standard strings for further analysis.

### Split lines by charset boundaries
```bash
echo "Password123!" | pack2 cgrams
```
Useful for identifying how users combine different character sets (Uppercase, Lowercase, Digits, Specials).

## Complete Command Reference

### pack2 Subcommands

| Subcommand | Description |
|------------|-------------|
| `cgrams` | Splits each line on the charset boundary |
| `filtermask` | Filters a wordlist by a given mask |
| `statsgen` | Generates statistics from an input and writes masks to output |
| `unhex` | Decodes `$HEX[]` encoded lines |
| `help` | Prints help information for pack2 or a specific subcommand |

### Subcommand: statsgen
Generates statistical data and masks from a wordlist.
```
pack2 statsgen [FLAGS] [OPTIONS] [input]
```
**Flags:**
- `-h, --help`: Prints help information

**Options:**
- `-o, --output <output>`: File to write the generated masks to (stats are sent to stderr)

### Subcommand: filtermask
Filters a wordlist based on a Hashcat-style mask.
```
pack2 filtermask [FLAGS] <mask> [input]
```
**Flags:**
- `-h, --help`: Prints help information

### Subcommand: cgrams
Analyzes character set transitions within strings.
```
pack2 cgrams [FLAGS] [input]
```
**Flags:**
- `-h, --help`: Prints help information

### Subcommand: unhex
Decodes hex-encoded strings often found in database dumps.
```
pack2 unhex [FLAGS] [input]
```
**Flags:**
- `-h, --help`: Prints help information

---

# pack200 / unpack200

*Note: These are legacy Java utilities included in the package for JAR compression and are unrelated to password cracking.*

## pack200 Command Reference
Packages a JAR file into a compressed pack200 file.

**Options:**
- `-r, --repack`: Repack/normalize a jar for signing
- `-g, --no-gzip`: Output plain pack file (no gzip)
- `--gzip`: (Default) Compress output with gzip
- `-G, --strip-debug`: Remove debugging attributes
- `-O, --no-keep-file-order`: Do not transmit file ordering
- `--keep-file-order`: (Default) Preserve file ordering
- `-S{N}, --segment-limit={N}`: Limit segment sizes
- `-E{N}, --effort={N}`: Packing effort (0-9)
- `-H{h}, --deflate-hint={h}`: Transmit deflate hint (true/false/keep)
- `-m{V}, --modification-time={V}`: Transmit modtimes (latest/keep)
- `-P{F}, --pass-file={F}`: Transmit input element unchanged
- `-U{a}, --unknown-attribute={a}`: Action for unknown attributes (error/strip/pass)
- `-C{N}={L}`: User-defined class attribute
- `-F{N}={L}`: User-defined field attribute
- `-M{N}={L}`: User-defined method attribute
- `-D{N}={L}`: User-defined code attribute
- `-f{F}, --config-file={F}`: Read Pack200.Packer properties file
- `-v, --verbose`: Increase verbosity
- `-q, --quiet`: Lowest verbosity
- `-l{F}, --log-file={F}`: Output to log file
- `-J{X}`: Pass option X to Java VM

## unpack200 Command Reference
Restores a packed file to a JAR.

**Options:**
- `-H{h}, --deflate-hint={h}`: Override deflate hint (true/false/keep)
- `-r, --remove-pack-file`: Remove input file after unpacking
- `-v, --verbose`: Increase verbosity
- `-q, --quiet`: Lowest verbosity
- `-l{F}, --log-file={F}`: Output to log file

## Notes
- `pack2` does not crack passwords itself; it generates the logic (masks) used by tools like Hashcat or John the Ripper.
- The `pack200` and `unpack200` tools are deprecated in modern JDKs and are unrelated to the `pack2` password toolkit functionality.