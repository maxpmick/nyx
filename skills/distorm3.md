---
name: distorm3
description: Decompose and disassemble x86/AMD64 binary streams into structured data. Use when performing advanced binary code analysis, malware analysis, reverse engineering, or forensics to inspect shellcode, payloads, or executable streams.
---

# distorm3

## Overview
diStorm3 is a powerful binary stream disassembler library for x86/AMD64. Unlike traditional disassemblers that return static text, diStorm3 is a "decomposer" that returns binary structures describing each instruction, making it ideal for automated binary analysis. Category: Digital Forensics / Reverse Engineering.

## Installation (if not already installed)
Assume the library is installed. If you encounter missing dependency errors, use:

```bash
sudo apt install libdistorm3-3 python3-distorm3 libdistorm3-dev
```

## Common Workflows

### Disassembling a Binary File (Python)
Use the Python bindings to read a raw binary file (like shellcode) and print the offset, size, instruction hex, and mnemonic.

```python
from distorm3 import Decode, Decode32Bits

offset = 0x100
code = open("payload.bin", "rb").read()
iterable = Decode(offset, code, Decode32Bits)

for (offset, size, instruction, hex_data) in iterable:
    print("0x%08x (%02x) %-20s %s" % (offset, size, hex_data, instruction))
```

### Quick Shellcode Analysis
To quickly inspect a staged reverse shell or exploit payload:

```python
import distorm3
# Decode64Bits for x64 architecture
data = b"\x55\x48\x89\xe5\x48\x83\xec\x10"
l = distorm3.Decode(0, data, distorm3.Decode64Bits)
for i in l:
    print(i)
```

## Complete Command Reference

### Python API Reference
The `distorm3` module provides the following primary functions and constants:

#### Functions
| Function | Description |
|----------|-------------|
| `Decode(offset, code, mode)` | The main decoding function. Returns a list of tuples: `(offset, size, instruction, hex)` |
| `Decompose(offset, code, mode)` | Returns a list of instruction objects with detailed metadata (operands, registers, etc.) |
| `Decode16Bits` | Constant for 16-bit (80286) decoding mode |
| `Decode32Bits` | Constant for 32-bit (x86) decoding mode |
| `Decode64Bits` | Constant for 64-bit (AMD64/x64) decoding mode |

#### Tuple Structure (Decode)
When using `Decode()`, each returned instruction is a tuple containing:
1.  **Offset**: The address of the instruction.
2.  **Size**: The length of the instruction in bytes.
3.  **Instruction**: The mnemonic and operands as a string.
4.  **Hex**: The raw hexadecimal representation of the instruction.

### Library Files
- `/usr/lib/x86_64-linux-gnu/libdistorm3.so.3`: Shared library for C/C++ integration.
- `/usr/include/distorm.h`: Header file for development.
- `/usr/include/mnemonics.h`: Header file containing instruction mnemonics.

## Notes
- diStorm3 is designed for speed and accuracy in stream disassembly.
- It supports all instruction sets for x86/AMD64 including FPU, MMX, SSE, SSE2, SSE3, SSSE3, SSE4, 3DNow! (with extensions), and new VEX instructions (AVX).
- When analyzing unknown binary blobs, ensure you select the correct mode (`Decode16Bits`, `Decode32Bits`, or `Decode64Bits`) as choosing the wrong architecture will result in incorrect disassembly.