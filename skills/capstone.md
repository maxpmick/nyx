---
name: capstone
description: Disassemble hexadecimal strings into assembly instructions across multiple hardware architectures. Use when performing reverse engineering, malware analysis, exploit development, or verifying shellcode. It supports a vast range of architectures including x86, ARM, MIPS, PowerPC, and more.
---

# Capstone (cstool)

## Overview
Capstone is a lightweight multi-platform, multi-architecture disassembly framework. The `cstool` utility is a command-line interface for the engine that allows users to quickly disassemble hex strings into human-readable assembly. Category: Reverse Engineering / Digital Forensics.

## Installation (if not already installed)
Assume `cstool` is already installed. If the command is missing:

```bash
sudo apt install capstone-tool
```

For development headers or Python bindings:
```bash
sudo apt install libcapstone-dev python3-capstone
```

## Common Workflows

### Disassemble x64 Shellcode
```bash
cstool x64 "554889e54883ec10"
```

### Show Detailed Instruction Information
Useful for seeing implicit registers and instruction groups.
```bash
cstool -d arm64 "e10300aa"
```

### Disassemble with a Specific Start Address
```bash
cstool x32 "909090" 0x1000
```

### Disassemble MIPS Big Endian
```bash
cstool mipsbe "24040001"
```

## Complete Command Reference

### Syntax
```bash
cstool [-d|-s|-u|-v] <arch+mode> <assembly-hexstring> [start-address-in-hex-format]
```

### Options
| Flag | Description |
|------|-------------|
| `-d` | Show detailed information of the instructions (groups, registers read/written) |
| `-s` | Decode in SKIPDATA mode |
| `-u` | Show immediates as unsigned |
| `-v` | Show version & Capstone core build info |

### Supported <arch+mode>

| Architecture | Modes / Options |
|--------------|-----------------|
| **X86** | `x16`, `x32`, `x64`, `x16att`, `x32att`, `x64att` |
| **ARM** | `arm`, `armbe`, `thumb`, `thumbbe`, `cortexm`, `armv8`, `thumbv8`, `armv8be`, `thumbv8be` |
| **ARM64** | `arm64`, `arm64be` |
| **MIPS** | `mips`, `mipsbe`, `mips64`, `mips64be` |
| **PowerPC** | `ppc32`, `ppc32be`, `ppc32qpx`, `ppc32beqpx`, `ppc32ps`, `ppc32beps`, `ppc64`, `ppc64be`, `ppc64qpx`, `ppc64beqpx` |
| **M68K** | `m68k`, `m68k40` |
| **M680X** | `m6800`, `m6801`, `m6805`, `m6808`, `m6809`, `m6811`, `cpu12`, `hd6301`, `hd6309`, `hcs08` |
| **BPF** | `bpf`, `bpfbe`, `ebpf`, `ebpfbe` |
| **RISC-V** | `riscv32`, `riscv64` |
| **SuperH** | `sh`, `sh2`, `sh2e`, `sh2dsp`, `sh2a`, `sh2afpu`, `sh3`, `sh3be`, `sh3e`, `sh3ebe`, `sh3-dsp`, `sh3-dspbe`, `sh4`, `sh4be`, `sh4a`, `sh4abe`, `sh4al-dsp`, `sh4al-dspbe` |
| **TriCore** | `tc110`, `tc120`, `tc130`, `tc131`, `tc160`, `tc161`, `tc162` |
| **MOS 65XX** | `6502`, `65c02`, `w65c02`, `65816` |
| **Others** | `sparc`, `systemz`, `xcore`, `tms320c64x`, `evm`, `wasm` |

## Notes
- The `<assembly-hexstring>` should be a string of hex bytes without spaces (e.g., `9090`).
- The `start-address-in-hex-format` is optional and defaults to `0`.
- Capstone is highly thread-safe and designed for high-performance analysis, making it suitable for integration into custom security tools via its Python, C++, or Go bindings.