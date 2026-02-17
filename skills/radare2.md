---
name: radare2
description: A complete, portable, multi-architecture reverse engineering framework. It includes a hexadecimal editor, debugger, disassembler, and binary analysis tools. Use for static and dynamic analysis of binaries, exploit development, malware analysis, and digital forensics.
---

# radare2

## Overview
Radare2 (r2) is an open-source framework for reverse engineering and binary analysis. It provides a suite of tools for inspecting, modifying, and debugging binaries across numerous architectures (x86, ARM, MIPS, PowerPC, etc.) and file formats (ELF, PE, Mach-O, etc.). Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume radare2 is already installed. If missing:
```bash
sudo apt install radare2
```

## Common Workflows

### Basic Binary Analysis
```bash
r2 -A /path/to/binary
```
Opens the file and runs `aaa` (analyze all) to find functions, symbols, and cross-references.

### Extracting Binary Information
```bash
rabin2 -I -s -z /path/to/binary
```
Displays binary info, symbols, and strings from the data section.

### Quick Disassembly of a String
```bash
rasm2 -a x86 -b 64 -d "9090"
```
Disassembles the hex pairs `9090` (NOP NOP) for x86_64.

### Binary Diffing
```bash
radiff2 binary_v1 binary_v2
```
Compares two binaries to identify changes in code or data.

## Complete Command Reference

### r2 (radare2)
Advanced command-line hexadecimal editor, disassembler, and debugger.

| Flag | Description |
|------|-------------|
| `--` | Run radare2 without opening any file |
| `-` | Same as `r2 malloc://512` |
| `=` | Read file from stdin |
| `-=` | Perform `!=!` command to run all commands remotely |
| `-0` | Print `\x00` after init and every command |
| `-1` | Redirect stderr to stdout |
| `-2` | Close stderr file descriptor |
| `-a [arch]` | Set asm.arch |
| `-A` | Run `aaa` command to analyze all referenced code |
| `-b [bits]` | Set asm.bits |
| `-B [baddr]` | Set base address for PIE binaries |
| `-c 'cmd..'` | Execute radare command |
| `-C` | File is host:port (alias for `-c+=http://%s/cmd/`) |
| `-d` | Debug the executable 'file' or running process 'pid' |
| `-D [backend]` | Enable debug mode (e cfg.debug=true) |
| `-e k=v` | Evaluate config var |
| `-f` | Block size = file size |
| `-F [binplug]` | Force to use that rbin plugin |
| `-h, -hh` | Show help message, -hh for long |
| `-H ([var])` | Display variable |
| `-i [file]` | Run rlang program, r2script file or load plugin |
| `-I [file]` | Run script file before the file is opened |
| `-j` | Use json for -v, -L and others |
| `-k [OS/kern]` | Set asm.os (linux, macos, w32, netbsd, ...) |
| `-L, -LL` | List supported IO plugins (-LL for core plugins) |
| `-m [addr]` | Map file at given address (loadaddr) |
| `-M` | Do not demangle symbol names |
| `-n, -nn` | Do not load RBin info (-nn only load bin structures) |
| `-N` | Do not load user settings and scripts |
| `-NN` | Do not load any script or plugin |
| `-q` | Quiet mode (no prompt) and quit after -i |
| `-qq` | Quit after running all -c and -i |
| `-Q` | Quiet mode and quit faster (quickLeak=true) |
| `-p [prj]` | Use project, list if no arg, load if no file |
| `-P [file]` | Apply rapatch file and quit |
| `-r [rarun2]` | Specify rarun2 profile to load |
| `-R [rr2rule]` | Specify custom rarun2 directive |
| `-s [addr]` | Initial seek |
| `-S` | Start r2 in sandbox mode |
| `-t` | Load rabin2 info in thread |
| `-u` | Set bin.filter=false to get raw names |
| `-v, -V` | Show version (-V for lib versions) |
| `-w` | Open file in write mode |
| `-x` | Open without exec-flag |
| `-X` | Same as `-e bin.usextr=false` |
| `-z, -zz` | Do not load strings or load them even in raw |

### rabin2
Binary Information Extractor.

| Flag | Description |
|------|-------------|
| `-@ [addr]` | Show section, symbol or import at addr |
| `-A` | List sub-binaries and their arch-bits pairs |
| `-a [arch]` | Set arch (x86, arm, ..) |
| `-b [bits]` | Set bits (32, 64 ...) |
| `-B [addr]` | Override base address (pie bins) |
| `-c` | List classes |
| `-cc` | List classes in header format |
| `-C [fmt:C:D]` | Create [elf,mach0,pe] with Code and Data hexpairs |
| `-d` | Show debug/dwarf information |
| `-D lang name` | Demangle symbol name |
| `-e` | Program entrypoint |
| `-ee` | Constructor/destructor entrypoints |
| `-E` | Globally exportable symbols |
| `-f [str]` | Select sub-bin named str |
| `-F [binfmt]` | Force to use that bin plugin |
| `-g` | Show all info (same as -SMZIHVResizcld -SS -SSS -ee) |
| `-G [addr]` | Load address to header |
| `-h` | Help message |
| `-H` | Header fields |
| `-i` | Imports |
| `-I` | Binary info |
| `-j` | Output in json |
| `-k [query]` | Run sdb query |
| `-K [algo]` | Calculate checksums (md5, sha1, ..) |
| `-l` | Linked libraries |
| `-L [plugin]` | List supported bin plugins |
| `-m [addr]` | Show source line at addr |
| `-M` | Main (show address of main symbol) |
| `-n [str]` | Show section, symbol or import named str |
| `-N [min:max]` | Force min:max number of chars per string |
| `-o [str]` | Output file/folder |
| `-O [str]` | Write/extract operations |
| `-p` | Show always physical addresses |
| `-P` | Show debug/pdb information |
| `-PP` | Download pdb file for binary |
| `-q, -qq` | Quiet mode, show less info |
| `-Q` | Show load address used by dlopen |
| `-r` | Radare output |
| `-R` | Relocations |
| `-s` | Symbols |
| `-S` | Sections |
| `-SS` | Segments |
| `-SSS` | Sections mapping to segments |
| `-t` | Display file hashes |
| `-T` | Display file signature |
| `-u` | Unfiltered names |
| `-U` | Resources |
| `-v, -V` | Version info |
| `-w` | Display try/catch blocks |
| `-x` | Extract bins contained in file |
| `-X [fmt] [f]` | Package in fat or zip |
| `-z` | Strings (from data section) |
| `-zz` | Strings (from raw bins) |
| `-zzz` | Dump raw strings to stdout |
| `-Z` | Guess size of binary program |

### rasm2
Radare2 Assembler and Disassembler Tool.

| Flag | Description |
|------|-------------|
| `-a [arch]` | Set architecture (x86, arm, etc.) |
| `-A` | Show Analysis information from hexpairs |
| `-b [bits]` | Set register size (8, 16, 32, 64) |
| `-B` | Binary input/output |
| `-c [cpu]` | Select specific CPU |
| `-C` | Output in C format |
| `-d, -D` | Disassemble from hexpair bytes (-D shows hexpairs) |
| `-e` | Use big endian |
| `-E` | Display ESIL expression |
| `-f [file]` | Read data from file |
| `-F [parser]` | Specify parse filter |
| `-h, -hh` | Help message |
| `-i [len]` | Ignore/skip N bytes |
| `-j` | Output in json |
| `-k [kernel]` | Select operating system |
| `-l [len]` | Input/Output length |
| `-L` | List RArch plugins |
| `-LL` | List RAsm parse plugins |
| `-o [file]` | Output file name |
| `-p` | Run SPP over input |
| `-q` | Quiet mode |
| `-r` | Output in radare commands |
| `-s [addr]` | Define start/seek address |
| `-S [syntax]` | Select syntax (intel, att) |
| `-v` | Version info |
| `-x` | Use hex dwords instead of hex pairs |
| `-w` | Describe opcode |

### radiff2
Binary diffing utility.

| Flag | Description |
|------|-------------|
| `-a [arch]` | Specify architecture |
| `-A [-A]` | Run analysis (aaa/aaaa) after loading |
| `-b [bits]` | Specify register size |
| `-B [baddr]` | Define base address |
| `-c [cmd]` | Run command on every RCore instance |
| `-C` | Graphdiff code |
| `-d` | Use delta diffing |
| `-D` | Show disasm instead of hexpairs |
| `-e [k=v]` | Set eval config var |
| `-f [fmt]` | Select output format |
| `-g [arg]` | Graph diff of symbol or range |
| `-i [help]` | Compare bin information |
| `-j` | Output in json |
| `-l [addr]` | Specify final offset (length) |
| `-m [mode]` | Choose graph output mode (aditsjJ) |
| `-n` | Count of changes |
| `-o [addr]` | Initial offset for diffing |
| `-O` | Code diffing with opcode bytes only |
| `-p` | Use physical addressing |
| `-q` | Quiet mode |
| `-r` | Output in radare commands |
| `-s, -ss` | Compute edit distance (Myers or Levenshtein) |
| `-S [name]` | Sort code diff |
| `-t [0-100]` | Set threshold for code diff (default 70%) |
| `-T` | Analyze files in threads |
| `-x` | Show two column hexdump diffing |
| `-X` | Use xpatch format |
| `-u, -U` | Unified output |

### rafind2
Advanced command-line byte pattern search.

| Flag | Description |
|------|-------------|
| `-a [align]` | Only accept aligned hits |
| `-b [size]` | Set block size |
| `-B` | Use big endian |
| `-c` | Disable color |
| `-e [regex]` | Search for regex |
| `-E` | Search using ESIL expression |
| `-f [from]` | Start address |
| `-F [file]` | Use file content as keyword |
| `-i` | Identify filetype |
| `-j` | Output in JSON |
| `-m` | Magic search (carver) |
| `-M [str]` | Set binary mask |
| `-n` | Do not stop on read errors |
| `-r` | Print radare commands |
| `-s [str]` | Search for string |
| `-S [str]` | Search for wide string |
| `-t [to]` | Stop address |
| `-q` | Quiet mode |
| `-V [val]` | Search for value/range in specific endian |
| `-x [hex]` | Search for hexpair string |
| `-X` | Show hexdump of results |
| `-z` | Search for zero-terminated strings |
| `-Z` | Show string found on each hit |

### rahash2
Block-Based Hashing, Encoding, and Encryption Utility.

| Flag | Description |
|------|-------------|
| `-a algo` | Algorithms (default: sha256) |
| `-b bsize` | Block size |
| `-B` | Show per-block hash |
| `-c hash` | Compare with hash |
| `-e` | Swap endian |
| `-E algo` | Encrypt (use -S for key, -I for IV) |
| `-D algo` | Decrypt (use -S for key, -I for IV) |
| `-f from` | Start address |
| `-i num` | Iterations |
| `-I iv` | Initialization vector |
| `-j, -J` | JSON output |
| `-S seed` | Seed/Key (hexa or s:string) |
| `-k` | OpenSSH randomkey algorithm |
| `-q, -qq` | Quiet mode |
| `-L` | List plugins |
| `-r` | Output radare commands |
| `-s string` | Hash string |
| `-t to` | Stop address |
| `-x hexstr` | Hash hexpair string |
| `-X` | Output in hexpairs |

### rax2
Radare2 Base Converter.

| Flag | Description |
|------|-------------|
| `-a` | Show ascii table |
| `-b <base>` | Output in specific base |
| `-c` | Output in C string |
| `-C` | Dump as C byte array |
| `-d` | Force integer output |
| `-e` | Swap endianness |
| `-D` | Base64 decode |
| `-E` | Base64 encode |
| `-f` | Floating point expression |
| `-F` | Stdin slurp code hex |
| `-H` | Hash string |
| `-i` | IP address <-> LONG conversion |
| `-j` | JSON format |
| `-k` | Keep base |
| `-K` | Randomart |
| `-n` | Append newline |
| `-o` | Octal string -> raw |
| `-q` | Quiet mode |
| `-r` | r2 style output |
| `-s` | Hexstr -> raw |
| `-S` | Raw -> hexstr |
| `-t` | Timestamp -> string |
| `-u` | Units (human readable) |
| `-w` | Signed word |
| `-x` | Output in hexpairs |
| `-X` | Bin -> hex (bignum) |
| `-z` | Str -> bin |
| `-Z` | Bin -> str |

### ragg2
Frontend for r_egg; compiles programs into tiny binaries.

| Flag | Description |
|------|-------------|
| `-a [arch]` | Architecture (x86, mips, arm) |
| `-b [bits]` | Bits (32, 64) |
| `-B [hex]` | Append hexpair bytes |
| `-c k=v` | Config options |
| `-C [file]` | Append file contents |
| `-d [o:d]` | Patch dword at offset |
| `-D [o:q]` | Patch qword at offset |
| `-e [expr]` | Egg program from string |
| `-E [enc]` | Use specific encoder |
| `-f [fmt]` | Output format (raw, c, pe, elf, mach0, etc.) |
| `-F` | Output native format |
| `-i [sc]` | Include shellcode plugin |
| `-I [path]` | Include path |
| `-k [os]` | Kernel (linux, bsd, osx, w32) |
| `-L` | List plugins |
| `-n [dw]` | Append 32bit number |
| `-N [dw]` | Append 64bit number |
| `-o [file]` | Output file |
| `-p [pad]` | Add padding (e.g., n10s32) |
| `-P [size]` | Prepend De Bruijn pattern |
| `-q [frag]` | De Bruijn pattern offset |
| `-r` | Show raw bytes |
| `-s` | Show assembler |
| `-S [str]` | Append string |
| `-w [o:h]` | Patch hexpairs at offset |
| `-x` | Execute |
| `-X [hex]` | Execute ROP chain |
| `-z` | Output in C string syntax |

### rarun2
Run programs in exotic environments (chroot, setuid, etc.).
Usage: `rarun2 script.rr2` or `rarun2 directive=value`.
Key directives: `program`, `arg[N]`, `setenv`, `listen`, `connect`, `pty`, `chroot`, `setuid`, `stdio`.

### r2agent
Radare2 Agent HTTP Server.

| Flag | Description |
|------|-------------|
| `-a` | Listen for everyone |
| `-d` | Daemon mode |
| `-s` | Sandbox mode |
| `-u` | Enable HTTP auth |
| `-t` | Auth file (user:password) |
| `-p [port]` | Port (default 8080) |
| `-L` | List sessions |

### r2pm
Radare2 Package Manager.

| Flag | Description |
|------|-------------|
| `-a [repo]` | Add/delete repository |
| `-c` | Clear cache |
| `-ci` | Clean + install |
| `-i <pkg>` | Install/update package |
| `-l` | List installed |
| `-s <str>` | Search packages |
| `-u <pkg>` | Uninstall |
| `-U` | Update database |

### rasign2
Signature management tool.

| Flag | Description |
|------|-------------|
| `-a` | Signatures from .a files |
| `-A` | Run analysis |
| `-f` | Interpret as FLIRT .sig |
| `-o [file]` | Output signature file |
| `-s [space]` | Set signspace |

### ravc2
Version Control Interface.
Actions: `init`, `branch`, `commit`, `checkout`, `status`, `reset`, `log`.

### r2r
Regression Test Runner.
Flags: `-C` (chdir), `-F` (fuzz), `-j` (threads), `-t` (timeout), `-i` (interactive).

### r2sdb
Simple DataBase (SDB) utility.
Flags: `-c` (count), `-D` (diff), `-g` (grep), `-j` (json), `-J` (journaling).

### rapatch2
Patching utility.
Flags: `-p` (patch level), `-R` (reverse), `-s` (sandbox).

## Notes
- Radare2 is highly modular; use `r2pm` to install additional plugins like decompilers (r2ghidra).
- Visual mode in `r2` can be entered by typing `V` then `p` to cycle views.
- Use `?` inside the `r2` shell for command help.
- The `rax2` tool is invaluable for quick base conversions during exploit development.