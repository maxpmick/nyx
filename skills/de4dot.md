---
name: de4dot
description: Deobfuscate and unpack .NET assemblies to restore them to a readable state. Use when analyzing malware, reverse engineering protected .NET binaries, or recovering source code from obfuscated assemblies. It supports a wide range of obfuscators including Dotfuscator, .NET Reactor, Confuser, and SmartAssembly.
---

# de4dot

## Overview
de4dot is an open-source .NET deobfuscator and unpacker. It attempts to restore packed and obfuscated assemblies to their original form by decrypting strings, fixing control flow, and renaming symbols where possible. Category: Reverse Engineering.

## Installation (if not already installed)
Assume de4dot is already installed. If not, use:
```bash
sudo apt update
sudo apt install de4dot
```

## Common Workflows

### Detect Obfuscator
Identify which obfuscator was used on a file without processing it.
```bash
de4dot -d -f target.exe
```

### Basic Deobfuscation
Deobfuscate a single file with default settings.
```bash
de4dot target.exe -o cleaned.exe
```

### Recursive Directory Processing
Scan a directory for .NET files and output cleaned versions to a new directory.
```bash
de4dot -r ./input_dir -ro ./output_dir
```

### Deobfuscate with Specific String Decryption
Force a specific decryption method (e.g., delegate) and method token.
```bash
de4dot target.exe --strtyp delegate --strtok 06000123
```

## Complete Command Reference

### General Options
| Flag | Description |
|------|-------------|
| `-r DIR` | Scan for .NET files in all subdirectories |
| `-ro DIR` | Output base directory for recursively found files |
| `-ru` | Skip recursively found files with unsupported obfuscators |
| `-d` | Detect obfuscators and exit |
| `--asm-path PATH` | Add an assembly search path |
| `--dont-rename` | Don't rename classes, methods, etc. |
| `--keep-names FLAGS` | Don't rename: `n`(amespaces), `t`(ypes), `p`(rops), `e`(vents), `f`(ields), `m`(ethods), `a`(rgs), `g`(enericparams), `d`(elegate fields). Example: `efm` |
| `--dont-create-params` | Don't create method params when renaming |
| `--dont-restore-props` | Don't restore properties/events |
| `--default-strtyp TYPE` | Default string decrypter type (none, default, static, delegate, emulate) |
| `--default-strtok METHOD` | Default string decrypter method token or `[type::][name][(args,...)]` |
| `--no-cflow-deob` | No control flow deobfuscation (NOT recommended) |
| `--only-cflow-deob` | Only perform control flow deobfuscation |
| `--load-new-process` | Load executed assemblies into a new process |
| `--keep-types` | Keep obfuscator types, fields, and methods |
| `--preserve-tokens` | Preserve important tokens, #US, #Blob, extra sig data |
| `--preserve-table FLAGS` | Preserve rids in table: `tr` (TypeRef), `td` (TypeDef), `fd` (Field), `md` (Method), `pd` (Param), `mr` (MemberRef), `s` (StandAloneSig), `ed` (Event), `pr` (Property), `ts` (TypeSpec), `ms` (MethodSpec), `all`. Use `-` to disable (e.g., `all,-pd`) |
| `--preserve-strings` | Preserve #Strings heap offsets |
| `--preserve-us` | Preserve #US heap offsets |
| `--preserve-blob` | Preserve #Blob heap offsets |
| `--preserve-sig-data` | Preserve extra data at the end of signatures |
| `--one-file` | Deobfuscate one file at a time |
| `-v` | Verbose output |
| `-vv` | Very verbose output |
| `-h`, `--help` | Show help message |

### File Options
| Flag | Description |
|------|-------------|
| `-f FILE` | Name of .NET file to process |
| `-o FILE` | Name of output file |
| `-p TYPE` | Force obfuscator type (e.g., `cr`, `dr4`, `sa`) |
| `--strtyp TYPE` | String decrypter type for this specific file |
| `--strtok METHOD` | String decrypter method token for this specific file |

### Deobfuscator Specific Options

#### Type an (Agile.NET)
- `--an-name REGEX`: Valid name regex pattern
- `--an-methods BOOL`: Decrypt methods (Default: True)
- `--an-rsrc BOOL`: Decrypt resources (Default: True)
- `--an-stack BOOL`: Remove all StackFrameHelper code (Default: True)
- `--an-vm BOOL`: Restore VM code (Default: True)
- `--an-initlocals BOOL`: Set initlocals in method header (Default: True)

#### Type bl (Babel .NET)
- `--bl-name REGEX`: Valid name regex pattern
- `--bl-inline BOOL`: Inline short methods (Default: True)
- `--bl-remove-inlined BOOL`: Remove inlined methods (Default: True)
- `--bl-methods BOOL`: Decrypt methods (Default: True)
- `--bl-rsrc BOOL`: Decrypt resources (Default: True)
- `--bl-consts BOOL`: Decrypt constants and arrays (Default: True)
- `--bl-embedded BOOL`: Dump embedded assemblies (Default: True)

#### Type cf (CodeFort)
- `--cf-name REGEX`: Valid name regex pattern
- `--cf-embedded BOOL`: Dump embedded assemblies (Default: True)

#### Type cw (CodeWall)
- `--cw-name REGEX`: Valid name regex pattern
- `--cw-embedded BOOL`: Dump embedded assemblies (Default: True)
- `--cw-decrypt-main BOOL`: Decrypt main embedded assembly (Default: True)

#### Type cr (Confuser)
- `--cr-name REGEX`: Valid name regex pattern
- `--cr-antidb BOOL`: Remove anti debug code (Default: True)
- `--cr-antidump BOOL`: Remove anti dump code (Default: True)
- `--cr-decrypt-main BOOL`: Decrypt main embedded assembly (Default: True)

#### Type co (Crypto Obfuscator)
- `--co-name REGEX`: Valid name regex pattern
- `--co-tamper BOOL`: Remove tamper protection code (Default: True)
- `--co-consts BOOL`: Decrypt constants (Default: True)
- `--co-inline BOOL`: Inline short methods (Default: True)
- `--co-ldnull BOOL`: Restore ldnull instructions (Default: True)

#### Type ds (DeepSea)
- `--ds-name REGEX`: Valid name regex pattern
- `--ds-inline BOOL`: Inline short methods (Default: True)
- `--ds-remove-inlined BOOL`: Remove inlined methods (Default: True)
- `--ds-rsrc BOOL`: Decrypt resources (Default: True)
- `--ds-embedded BOOL`: Dump embedded assemblies (Default: True)
- `--ds-fields BOOL`: Restore fields (Default: True)
- `--ds-keys BOOL`: Rename resource keys (Default: True)
- `--ds-casts BOOL`: Deobfuscate casts (Default: True)

#### Type dr3/dr4 (.NET Reactor)
- `--dr[34]-name REGEX`: Valid name regex pattern
- `--dr[34]-types BOOL`: Restore types (object -> real type)
- `--dr[34]-inline BOOL`: Inline short methods
- `--dr[34]-remove-inlined BOOL`: Remove inlined methods
- `--dr4-methods BOOL`: Decrypt methods (dr4 only)
- `--dr4-embedded BOOL`: Dump embedded assemblies (dr4 only)
- `--dr[34]-sn BOOL`: Remove anti strong name code

#### Type sa (SmartAssembly)
- `--sa-name REGEX`: Valid name regex pattern
- `--sa-error BOOL`: Remove automated error reporting code (Default: True)
- `--sa-tamper BOOL`: Remove tamper protection code (Default: True)
- `--sa-memory BOOL`: Remove memory manager code (Default: True)

#### Type sn (Spices.Net)
- `--sn-name REGEX`: Valid name regex pattern
- `--sn-inline BOOL`: Inline short methods (Default: True)
- `--sn-ns1 BOOL`: Clear namespace if only one class exists (Default: True)
- `--sn-rsrc BOOL`: Restore resource names (Default: True)

## Notes
- **Symbol Renaming**: Original names (classes/methods) are usually lost during obfuscation; de4dot renames them to readable strings but cannot recover the original source names.
- **Regex**: Multiple regexes can be used if separated by `&`. Use `!` to invert. Example: `!^[a-z\d]{1,2}$&^[\w.]+$`.
- **String Decryption**: If default detection fails, try `--strtyp emulate` or `--strtyp delegate`.