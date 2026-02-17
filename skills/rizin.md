---
name: rizin
description: A comprehensive reverse engineering framework and toolset for binary analysis, disassembly, debugging, and forensics. Use when performing static or dynamic analysis of binaries, patching files, calculating hashes, or searching for patterns in executables. It is a fork of radare2 focused on usability and code cleanliness.
---

# rizin

## Overview
Rizin is a portable, multi-purpose reverse engineering framework. It functions as a command-line hexadecimal editor, disassembler, and debugger. It supports a wide range of architectures and file formats, making it suitable for malware analysis, exploit development, and digital forensics. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume rizin is already installed. If you get a "command not found" error:

```bash
sudo apt update
sudo apt install rizin
```

## Common Workflows

### Basic Binary Analysis
```bash
rizin -A /path/to/binary
```
Opens the file and runs `aaa` (analyze all) to identify functions, symbols, and sections.

### Debugging a Process
```bash
rizin -d /path/to/executable
```
Starts the executable in debug mode.

### Quick String Search
```bash
rz-bin -z /path/to/binary
```
Extracts strings from the data sections of a binary.

### Disassembling Hex to Assembly
```bash
rz-asm -a x86 -b 64 -d 9090
```
Disassembles the hex pairs `9090` (NOP NOP) for x86-64.

## Complete Command Reference

### rizin (Main Tool)
Advanced command-line hex editor, disassembler, and debugger.

| Flag | Description |
|------|-------------|
| `--` | Run rizin without opening any file |
| `=` | Same as `rizin malloc://512` |
| `-` | Read file from stdin |
| `-=` | Perform R=! command to run all commands remotely |
| `-0` | Print `\x00` after init and every command |
| `-1` | Redirect stderr to stdout |
| `-2` | Close stderr file descriptor (silent warning messages) |
| `-a [arch]` | Set asm.arch |
| `-A` | Run 'aaa' command to analyze all referenced code |
| `-b [bits]` | Set asm.bits |
| `-B [baddr]` | Set base address for PIE binaries |
| `-c 'cmd..'` | Execute rizin command |
| `-C` | File is host:port (alias for -cR+http://%s/cmd/) |
| `-d` | Debug the executable 'file' or running process 'pid' |
| `-D [backend]` | Enable debug mode (e cfg.debug=true) |
| `-e k=v` | Evaluate config var |
| `-f` | Block size = file size |
| `-F [binplug]` | Force to use that rbin plugin |
| `-h, -hh` | Show help message, -hh for long |
| `-H ([var])` | Display variable |
| `-i [file]` | Run script file |
| `-I [file]` | Run script file before the file is opened |
| `-k [OS/kern]` | Set asm.os (linux, macos, w32, netbsd, ...) |
| `-l [lib]` | Load plugin file |
| `-L` | List supported IO plugins |
| `-m [addr]` | Map file at given address (loadaddr) |
| `-M` | Do not demangle symbol names |
| `-n, -nn` | Do not load RzBin info (-nn only load bin structures) |
| `-N` | Do not load user settings and scripts |
| `-NN` | Do not load any script or plugin |
| `-q` | Quiet mode (no prompt) and quit after -i and -c |
| `-qq` | Quiet mode (no prompt) and force quit |
| `-p [p.rzdb]` | Load project file |
| `-r [rz-run]` | Specify rz-run profile to load (same as -e dbg.profile=X) |
| `-R [rule]` | Specify custom rz-run directive |
| `-s [addr]` | Initial seek |
| `-T` | Do not compute file hashes |
| `-u` | Set bin.filter=false to get raw sym/sec/cls names |
| `-v, -V` | Show rizin version (-V show lib versions) |
| `-w` | Open file in write mode |
| `-x` | Open without exec-flag (asm.emu will not work) |
| `-X` | Same as -e bin.usextr=false (useful for dyldcache) |
| `-z, -zz` | Do not load strings or load them even in raw |

### rz-asm (Assembler/Disassembler)

| Flag | Description |
|------|-------------|
| `-a [arch]` | Set architecture to assemble/disassemble |
| `-A` | Show Analysis information from given hexpairs |
| `-b [bits]` | Set cpu register size (8, 16, 32, 64) |
| `-B` | Binary input/output (-l is mandatory for binary input) |
| `-c [cpu]` | Select specific CPU |
| `-C` | Output in C format |
| `-d, -D` | Disassemble from hexpair bytes (-D show hexpairs) |
| `-e` | Use big endian instead of little endian |
| `-I` | Display lifted RzIL code |
| `-E` | Display ESIL expression |
| `-f [file]` | Read data from file |
| `-F [in:out]` | Specify input and/or output filters |
| `-h, -hh` | Show help |
| `-i [len]` | Ignore N bytes of the input buffer |
| `-j` | Output in JSON format |
| `-k [kernel]` | Select operating system |
| `-l [len]` | Input/Output length |
| `-L` | List Asm plugins |
| `-m [plugin]` | List supported CPUs for the chosen plugin |
| `-o, -@ [addr]` | Set start address for code (default 0) |
| `-O [file]` | Output file name |
| `-p` | Run SPP over input for assembly |
| `-q` | Quiet mode |
| `-r` | Output in rizin commands |
| `-s [syntax]` | Select syntax (intel, att) |
| `-v` | Show version information |
| `-x` | Use hex dwords instead of hex pairs when assembling |
| `-w` | Describe opcode |

### rz-ax (Base Converter)

| Flag | Description |
|------|-------------|
| `=[base]` | Output in specific base (e.g., =10) |
| `-a` | Show ascii table |
| `-b` | bin -> str |
| `-B` | str -> bin |
| `-d` | Force integer (3 instead of 0x3) |
| `-e` | Swap endianness |
| `-D` | Base64 decode |
| `-E` | Base64 encode |
| `-f` | Floating point expression |
| `-F` | Stdin slurp code hex |
| `-i` | Dump as C byte array |
| `-I` | IP address <-> LONG conversion |
| `-k` | Keep base |
| `-L` | bin -> hex (bignum) |
| `-n` | Int value -> hexpairs |
| `-o` | Octalstr -> raw |
| `-N` | Binary number |
| `-r` | Rizin style output |
| `-s` | Hexstr -> raw |
| `-S` | Raw -> hexstr |
| `-t` | Unix tstamp -> str |
| `-m` | MS-DOS tstamp -> str |
| `-W` | Win32 tstamp -> str |
| `-x` | Hash string |
| `-u` | Units (e.g., 317.0M) |
| `-w` | Signed word |
| `-p` | Position of set bits |

### rz-bin (Binary Info Extractor)

| Flag | Description |
|------|-------------|
| `-@ [addr]` | Show section, symbol, or import at address |
| `-A` | List sub-binaries and arch-bits pairs |
| `-a [arch]` | Set arch |
| `-b [bits]` | Set bits |
| `-B [addr]` | Override base address |
| `-c, -cc` | List classes (header format with -cc) |
| `-C [fmt:C:D]` | Create binary with Code and Data hexpairs |
| `-d, -dd` | Show debug/dwarf info (-dd for debuginfod) |
| `-D lang name` | Demangle symbol name |
| `-e, -ee` | Entrypoint (constructor/destructor with -ee) |
| `-E` | Globally exportable symbols |
| `-f [str]` | Select sub-bin named str |
| `-F [binfmt]` | Force bin plugin |
| `-g` | Show all info (SMZIHVResizcld -SS -SSS -ee) |
| `-G [addr]` | Load address . offset to header |
| `-H` | Header fields |
| `-i` | Imports |
| `-I` | Binary info |
| `-j` | JSON output |
| `-k [query]` | Run sdb query |
| `-K [algo]` | Calculate checksums |
| `-l` | Linked libraries |
| `-L [plugin]` | List bin plugins |
| `-m [addr]` | Show source line at addr |
| `-M` | Main address |
| `-n [str]` | Show section, symbol, or import named str |
| `-N [min:max]` | Force char range for strings |
| `-o [str]` | Output file/folder |
| `-O [str]` | Write/extract operations |
| `-p` | Physical addresses |
| `-P, -PP` | PDB info (-PP to download) |
| `-q, -qq` | Quiet mode |
| `-Q` | Load address used by dlopen |
| `-r` | Rizin format output |
| `-R` | Relocations |
| `-s` | Symbols |
| `-S, -SS, -SSS`| Sections, Segments, or Mapping |
| `-T` | File signature |
| `-u` | Unfiltered names |
| `-U` | Resources |
| `-x` | Extract bins contained in file |
| `-X [fmt] [f]` | Package in fat or zip |
| `-Y [fw file]` | Calculate base address candidates |
| `-z, -zz, -zzz`| Strings (data, raw, or huge file dump) |
| `-Z` | Guess binary size |

### rz-diff (Binary Diffing)

| Flag | Description |
|------|-------------|
| `-a [arch]` | Specify architecture |
| `-b [bits]` | Specify bits |
| `-d [algo]` | Edit distance algorithm (myers, leven, ssdeep) |
| `-i` | Use arguments instead of files |
| `-H` | Hexadecimal visual mode |
| `-j` | JSON output |
| `-q` | Quiet output |
| `-v` | Verbose |
| `-e [k=v]` | Set config variable |
| `-A` | Compare virtual and physical addresses |
| `-B` | Run 'aaa' on load |
| `-C` | Disable colors |
| `-T` | Show timestamp |
| `-S [WxH]` | Set terminal size |
| `-0 [cmd]` | Input for file0 |
| `-1 [cmd]` | Input for file1 |
| `-t [type]` | Diff type (bytes, lines, functions, classes, command, entries, fields, graphs, imports, libraries, sections, strings, symbols) |

### rz-find (Pattern Search)

| Flag | Description |
|------|-------------|
| `-a [align]` | Only accept aligned hits |
| `-b [size]` | Set block size |
| `-e [regex]` | Search for regex |
| `-E [cmd]` | Execute command for each hit |
| `-f [from]` | Start address |
| `-F [file]` | Use file content as keyword |
| `-i` | Identify filetype |
| `-j` | JSON output |
| `-m` | Magic search (carver) |
| `-M [str]` | Binary mask |
| `-n` | Do not stop on read errors |
| `-r` | Rizin command output |
| `-s [str]` | Search for string |
| `-w [str]` | Search for wide string |
| `-I [str]` | Search in import table |
| `-S [str]` | Search in symbol table |
| `-t [to]` | Stop address |
| `-q` | Quiet mode |
| `-x [hex]` | Search for hexpair |
| `-X` | Show hexdump of hits |
| `-z` | Search for zero-terminated strings |
| `-Z` | Show string found on each hit |

### rz-gg (Egg Compiler/Shellcode Tool)

| Flag | Description |
|------|-------------|
| `-a [arch]` | Select architecture |
| `-b [bits]` | Set bits |
| `-B [hex]` | Append hexpair bytes |
| `-c [k=v]` | Set config options |
| `-C [file]` | Append file contents |
| `-d [o:d]` | Patch dword at offset |
| `-D [o:q]` | Patch qword at offset |
| `-e [enc]` | Use specific encoder |
| `-f [fmt]` | Output format (raw, c, pe, elf, mach0, python, javascript) |
| `-F` | Native format |
| `-i [sc]` | Include shellcode plugin |
| `-I [path]` | Add include path |
| `-k [kern]` | Operating system kernel |
| `-L` | List plugins |
| `-n [dword]` | Append 32bit number |
| `-N [dword]` | Append 64bit number |
| `-o [file]` | Output file |
| `-O` | Use default output file |
| `-p [pad]` | Add padding (e.g., n10s32) |
| `-P [size]` | Prepend debruijn sequence |
| `-q [frag]` | Debruijn pattern offset |
| `-r` | Show raw bytes |
| `-s` | Show assembler |
| `-S [str]` | Append string |
| `-w [o:h]` | Patch hexpairs at offset |
| `-x` | Execute |
| `-X [hex]` | Execute ROP chain |
| `-z` | Output in C string syntax |

### rz-hash (Hashing Utility)

| Flag | Description |
|------|-------------|
| `-a algo` | Hash algorithm (comma separated for multiple) |
| `-B` | Output value for each block |
| `-b size` | Set block size |
| `-c value` | Compare with hex value |
| `-e endian`| Set endianness (big/little) |
| `-D algo` | Decrypt input |
| `-E algo` | Encrypt input |
| `-f from` | Start offset |
| `-t to` | Stop offset |
| `-I iv` | Set IV |
| `-i times` | Repeat calculation N times |
| `-j` | JSON output |
| `-k` | OpenSSH randomkey algorithm |
| `-L` | List algorithms |
| `-q, -qq` | Quiet mode |
| `-S seed` | Set seed (prefix '^' for prepend, '@' for file) |
| `-K key` | Set HMAC/encryption key |
| `-s string`| Input from string |
| `-x hex` | Input from hex value |

### rz-run (Execution Utility)

| Flag | Description |
|------|-------------|
| `-l` | Show profile options |
| `-t` | Output template profile |
| `-w` | Wait for incoming terminal process |
| `--` | Run commands |

### rz-sign (Signature Utility)

| Flag | Description |
|------|-------------|
| `-a` | Add extra 'a' to analysis |
| `-e [k=v]` | Set config variable |
| `-c [out] [in]` | Convert FLIRT signature format |
| `-o [out] [in]` | Generate FLIRT signature from binary |
| `-d [sig]` | Dump FLIRT signature content |
| `-q` | Quiet mode |

### rz-test (Testing Utility)

| Flag | Description |
|------|-------------|
| `-q, -V` | Quiet or Verbose |
| `-i, -y` | Interactive mode (accept changes with -y) |
| `-n` | Dry run |
| `-L` | Log mode |
| `-F [dir]` | Run fuzz tests on directory |
| `-j [n]` | Thread count |
| `-r [path]` | Path to rizin |
| `-m [path]` | Path to rz-asm |
| `-f [file]` | JSON test file |
| `-C [dir]` | Change directory |
| `-t [sec]` | Timeout per test |
| `-o [file]` | JSON output file |
| `-e [dir]` | Exclude directory |
| `-s [num]` | Expected successes |
| `-x [num]` | Expected failures |

## Notes
- Rizin is a fork of radare2; many commands and concepts are similar but with a focus on a more stable API and cleaner codebase.
- Use `rizin -L` to see available IO plugins and `rz-asm -L` for architecture support.
- The framework is highly scriptable via Python, JavaScript, and other languages using `rz-pipe`.