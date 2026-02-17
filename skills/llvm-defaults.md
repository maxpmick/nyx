---
name: llvm-defaults
description: A comprehensive suite of LLVM-based tools for compilation, static analysis, debugging, and binary manipulation. Use for vulnerability research, exploit development, reverse engineering, and automated code auditing. Includes Clang for compilation/analysis, LLDB for debugging, and various LLVM utilities for bitcode and object file processing.
---

# llvm-defaults

## Overview
LLVM is a collection of modular and reusable compiler and toolchain technologies. In security contexts, it is used for static analysis (Clang Analyzer), fuzzing (Sanitizers), and reverse engineering (LLVM-MC, LLVM-ObjDump). Categories: Reconnaissance / Information Gathering, Vulnerability Analysis, Reverse Engineering, Fuzzing.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install clang clang-format clang-tidy clang-tools clangd flang lld lldb llvm llvm-bolt llvm-dev llvm-runtime
```

## Common Workflows

### Static Analysis with Clang
```bash
scan-build -o ./reports/ make
```
Runs the Clang static analyzer during the build process and generates HTML reports.

### Symbolizing ASan Logs
```bash
asan_symbolize -d -l asan.log > symbolized.log
```
Demangles and symbolizes function names in AddressSanitizer logs.

### Disassembling Binaries
```bash
llvm-objdump -d -S --print-imm-hex binary_file
```
Disassembles a binary with source code interleaving and hexadecimal immediate values.

### Binary Optimization with BOLT
```bash
llvm-bolt original_bin -o optimized_bin -data profile.fdata -reorder-blocks=ext-tsp -reorder-functions=hfsort+
```
Optimizes an executable's layout based on profiling data.

## Complete Command Reference

### Clang (Compiler & Analyzer)
`clang [options] file...`

| Flag | Description |
|------|-------------|
| `--analyze` | Run the static analyzer |
| `-fsanitize=<check>` | Turn on runtime checks (address, thread, memory, undefined) |
| `-emit-llvm` | Use LLVM representation for assembler and object files |
| `-S` | Only run preprocess and compilation steps (output assembly) |
| `-c` | Only run preprocess, compile, and assemble steps |
| `-o <file>` | Write output to `<file>` |
| `-###` | Print (but do not run) the commands for this compilation |
| `-Xanalyzer <arg>` | Pass `<arg>` to the static analyzer |

### Clang-Format
`clang-format [options] [<file> ...]`

| Flag | Description |
|------|-------------|
| `-i` | Inplace edit files |
| `--style=<string>` | Set coding style (LLVM, Google, Chromium, Mozilla, WebKit) |
| `--dump-config` | Dump configuration options to stdout |
| `--dry-run` | Do not actually make formatting changes |

### Clang-Tidy (Linter)
`clang-tidy [options] <source> ...`

| Flag | Description |
|------|-------------|
| `--checks=<string>` | Comma-separated list of globs for enabled checks |
| `--fix` | Apply suggested fixes |
| `--list-checks` | List all enabled checks |
| `-p <string>` | Build path (to read `compile_commands.json`) |

### LLDB (Debugger)
`lldb [options]`

| Flag | Description |
|------|-------------|
| `-p <pid>` | Attach to a process with the given PID |
| `-n <name>` | Attach to a process with the given name |
| `-c <core>` | Use the specified core file |
| `-o <command>` | Execute a one-line lldb command after loading |
| `--batch` | Run commands and then quit |

### LLVM Utilities

#### llvm-objdump
| Flag | Description |
|------|-------------|
| `-d`, `--disassemble` | Disassemble executable sections |
| `-D`, `--disassemble-all` | Disassemble all sections |
| `-S`, `--source` | Interleave source code with disassembly |
| `--macho` | Use MachO specific object file parser |

#### llvm-nm
| Flag | Description |
|------|-------------|
| `-a`, `--debug-syms` | Show all symbols, even debugger only |
| `-D`, `--dynamic` | Display dynamic symbols |
| `-u`, `--undefined-only` | Show only undefined symbols |

#### sancov (Sanitizer Coverage)
| Flag | Description |
|------|-------------|
| `-print-coverage-stats` | Print coverage statistics |
| `-symbolize` | Produce a symbolized JSON report |
| `-merge` | Merge reports |

#### llvm-bolt (Binary Optimization)
| Flag | Description |
|------|-------------|
| `--dyno-stats` | Print execution info based on profile |
| `--reorder-blocks=<mode>` | Change layout of basic blocks |
| `--instrument` | Instrument code to generate profile data |

## Notes
- Use `scan-build` for high-level automated analysis of C/C++ projects.
- LLVM tools often require debug symbols (`-g`) to be effective for analysis.
- `llvm-symbolizer` is a critical dependency for reading human-readable traces from sanitizers.