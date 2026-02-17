---
name: bpf-linker
description: Statically link BPF object files and LLVM bitcode into a single BPF program. Use when developing modern eBPF applications, optimizing BPF bytecode for specific kernel versions, or combining multiple Rust/C BPF modules into a single executable object.
---

# bpf-linker

## Overview
bpf-linker is a tool used to statically link multiple BPF object files together. It operates on LLVM bitcode, allowing it to perform optimizations necessary for targeting older kernels, such as loop unrolling and inlining. It is essential for modern BPF development workflows, particularly those involving Rust (Aya). Category: Exploitation / Development Tools.

## Installation (if not already installed)
Assume bpf-linker is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install bpf-linker
```

## Common Workflows

### Basic Linking
Link multiple bitcode files into a single BPF object file:
```bash
bpf-linker -o output.o input1.bc input2.bc
```

### Targeting Older Kernels
Link with aggressive loop unrolling and forced inlining for kernels that do not support bounded loops or function calls:
```bash
bpf-linker --unroll-loops --ignore-inline-never -o optimized.o input.o
```

### Generating BTF Information
Link and include BPF Type Format (BTF) debug information for CO-RE (Compile Once – Run Everywhere) support:
```bash
bpf-linker --btf -o program.o input.o
```

### High Optimization for Size
Link with size optimization (z) and specific CPU features:
```bash
bpf-linker -O z --cpu v3 --cpu-features=+alu32 -o small_prog.o input.o
```

## Complete Command Reference

```bash
bpf-linker [OPTIONS] --output <OUTPUT> <INPUTS>...
```

### Arguments
| Argument | Description |
|----------|-------------|
| `<INPUTS>...` | Input files. Can be object files (.o), LLVM bitcode (.bc), or static libraries (.a) |

### Options
| Flag | Description |
|------|-------------|
| `--target <TARGET>` | LLVM target triple. If omitted, inferred from inputs |
| `--cpu <CPU>` | Target BPF processor: `generic`, `probe`, `v1`, `v2`, `v3` [default: `generic`] |
| `--cpu-features <features>` | Enable/disable features (e.g., `+alu32`, `-dwarfris`). Available: `alu32`, `dummy`, `dwarfris` |
| `-o`, `--output <OUTPUT>` | Write output to the specified path |
| `--emit <EMIT>` | Output type: `llvm-bc`, `asm`, `llvm-ir`, `obj` [default: `obj`] |
| `--btf` | Emit BTF (BPF Type Format) information |
| `-L <LIBS>` | Add a directory to the library search path |
| `-O <OPTIMIZE>` | Optimization level: `0`-`3`, `s`, or `z` [default: `2`] |
| `--export-symbols <path>` | Export symbols listed in the file (one per line) |
| `--export <symbols>` | Comma-separated list of symbols to export |
| `--log-file <path>` | Output logs to the given path |
| `--log-level <level>` | Set log level: `error`, `warn`, `info`, `debug`, `trace` |
| `--unroll-loops` | Force loop unrolling (useful for older kernels) |
| `--ignore-inline-never` | Ignore `noinline` attributes to force inlining |
| `--dump-module <path>` | Dump final IR module to path before code generation |
| `--llvm-args <args>` | Extra command line arguments to pass directly to LLVM |
| `--disable-expand-memcpy-in-order` | Disable passing `--bpf-expand-memcpy-in-order` to LLVM |
| `--disable-memory-builtins` | Disable exporting `memcpy`, `memmove`, `memset`, `memcmp`, and `bcmp` |
| `--fatal-errors <bool>` | Treat LLVM errors as fatal [default: `true`] |
| `-h`, `--help` | Print help information |
| `-V`, `--version` | Print version information |

## Notes
- **Input Types**: The tool requires inputs to contain LLVM bitcode. This means object files must have been compiled with `-fembed-bitcode` (C/C++) or be Rust-generated BPF objects.
- **Kernel Compatibility**: Use `--unroll-loops` and `--ignore-inline-never` when targeting Linux kernels older than 5.3 (for loops) or 4.16 (for function calls).
- **Memory Intrinsics**: If you encounter errors regarding missing `memcpy` or `memset` in the kernel, ensure you are NOT using `--disable-memory-builtins` unless you have provided custom implementations.