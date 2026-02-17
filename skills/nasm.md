---
name: nasm
description: Assemble x86 source code into binary or object files and disassemble binary files. Use when developing exploits, writing shellcode, performing reverse engineering, or analyzing x86/x64 malware. It supports multiple output formats including flat binaries, ELF, COFF, and Mach-O.
---

# nasm

## Overview
The Netwide Assembler (NASM) is a portable 80x86 and x86-64 assembler. It is designed for efficiency and modularity, supporting a wide range of executable formats. It includes `ndisasm`, a companion binary file disassembler. Category: Exploitation / Reverse Engineering.

## Installation (if not already installed)
Assume nasm is already installed. If you get a "command not found" error:

```bash
sudo apt install nasm
```

## Common Workflows

### Assemble shellcode to a flat binary
```bash
nasm -f bin shellcode.asm -o shellcode.bin
```

### Assemble for Linux 64-bit (ELF64)
```bash
nasm -f elf64 payload.asm -o payload.o
ld payload.o -o payload
```

### Disassemble a raw binary file (32-bit)
```bash
ndisasm -b 32 shellcode.bin
```

### Preprocess only (view macro expansions)
```bash
nasm -E input.asm
```

## Complete Command Reference

### nasm (Assembler)

```
nasm [-@ response_file] [options...] [--] filename
```

| Flag | Description |
|------|-------------|
| `-v`, `--v` | Print the NASM version number and exit |
| `-@ file` | Response file; one command line option per line |
| `-h` | List command line options and exit (also `--help`) |
| `-h -opt` | Show additional help for specific option `-opt` |
| `-h all` | Show all available command line help |
| `-h topics` | Show list of help topics (also `-h list`) |
| `-o outfile` | Write output to outfile |
| `--keep-all` | Output files will not be removed even if an error happens |
| `-Xformat` | Specify error reporting format (see `-h -X`) |
| `-s` | Redirect messages to stdout |
| `-Zfile` | Redirect messages to file |
| `--info[=lvl]` | Display optional informational messages |
| `--debug[=lvl]` | Display NASM internal debugging messages |
| `-M...` | Generate Makefile dependencies (see `-h -M`) |
| `-f format` | Select output file format (e.g., bin, elf32, elf64, win32, win64) |
| `-g` | Generate debugging information |
| `-F format` | Select a debugging format (see `-h -F`) |
| `-gformat` | Same as `-g -F format` |
| `-l listfile` | Write listing to a list file |
| `-Lflags...` | Add information to the list file (see `-h -L`) |
| `-Oflags...` | Select optimization (see `-h -O`) |
| `-t` | Assemble in limited SciTech TASM compatible mode |
| `-E`, `-e` | Preprocess only (writes output to stdout by default) |
| `-a` | Don't preprocess (assemble only) |
| `-Ipath` | Add a pathname to the include file path |
| `-Pfile` | Pre-include a file (also `--include`) |
| `-Dmacro[=str]` | Pre-define a macro |
| `-Umacro` | Undefine a macro |
| `-w+x` | Enable warning `x` (see `-h -w`) (also `-Wx`) |
| `-w-x` | Disable warning `x` (also `-Wno-x`) |
| `-w[+-]error` | Promote all warnings to errors (also `-Werror`) |
| `-w[+-]error=x` | Promote warning `x` to errors (also `-Werror=x`) |
| `--pragma str` | Pre-executes a specific `%pragma` |
| `--before str` | Add line (usually a preprocessor statement) before the input |
| `--bits nn` | Set bits to `nn` (equivalent to `--before "BITS nn"`) |
| `--no-line` | Ignore `%line` directives in input |
| `--gprefix str` | Prepend string to all extern, common, and global symbols |
| `--gpostfix str` | Append string to all extern, common, and global symbols |
| `--lprefix str` | Prepend string to local symbols |
| `--lpostfix str` | Append string to local symbols |
| `--reproducible` | Attempt to produce run-to-run identical output |
| `--limit-X val` | Set execution limit X (see `-h --limit`) |

### ndisasm (Disassembler)

```
ndisasm [-aihlruvw] [-b bits] [-o origin] [-s sync...] [-e bytes] [-k start,bytes] [-p vendor] file
```

| Flag | Description |
|------|-------------|
| `-a`, `-i` | Activates auto (intelligent) sync |
| `-b 16/32/64` | Sets the processor mode (16, 32, or 64-bit) |
| `-u` | Same as `-b 32` |
| `-l` | Same as `-b 64` |
| `-w` | Wide output (avoids continuation lines) |
| `-h` | Displays help text |
| `-r`, `-v` | Displays the version number |
| `-e bytes` | Skips `<bytes>` bytes of header |
| `-k start,bytes` | Avoids disassembling `<bytes>` bytes from position `<start>` |
| `-p vendor` | Selects preferred vendor instruction set (`intel`, `amd`, `cyrix`, `idt`) |
| `-o origin` | Specifies the nominal address (origin) of the first byte |

## Notes
- When creating shellcode for exploitation, always use `-f bin` to get the raw opcodes.
- `ndisasm` does not understand object file formats (like ELF); it treats files as raw binary streams. Use `objdump` for disassembling object files.
- Use `-h -f` to see all supported output formats on your specific installation.