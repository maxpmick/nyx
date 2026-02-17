---
name: ropper
description: Find ROP gadgets and display binary information for multiple architectures and file formats. Use when performing exploit development, building ROP chains, searching for specific instruction sequences (gadgets), or analyzing binary headers (ELF, PE, Mach-O).
---

# ropper

## Overview
Ropper is a powerful gadget finder and binary information tool. It supports x86/x86_64, ARM/ARM64, MIPS, PowerPC, and SPARC architectures. It allows for advanced searching, semantic analysis, and automatic ROP chain generation for specific payloads like `execve` or `mprotect`. Category: Exploitation.

## Installation (if not already installed)
Assume ropper is already installed. If you encounter a "command not found" error:

```bash
sudo apt update
sudo apt install ropper
```

## Common Workflows

### Basic Gadget Search
Search for all gadgets in a binary:
```bash
ropper --file /usr/bin/ls --all
```

### Search for Specific Instructions
Find gadgets containing specific instructions like `pop` followed by `ret`:
```bash
ropper --file ./vulnerable_bin --search "pop %; ret"
```

### Generate a ROP Chain
Automatically generate a ROP chain for `execve` on Linux x86_64:
```bash
ropper --file ./vulnerable_bin --chain "execve cmd=/bin/sh"
```

### Filter by Bad Bytes
Find gadgets that do not contain null bytes (`00`) or newlines (`0a`):
```bash
ropper --file ./vulnerable_bin --badbytes 000a --search "jmp esp"
```

### Interactive Console
Start the interactive shell for complex analysis:
```bash
ropper --file ./vulnerable_bin --console
```

## Complete Command Reference

```
ropper [options]
```

### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `--help-examples` | Print usage examples |
| `-v`, `--version` | Print version information |
| `--console` | Starts interactive commandline |
| `-f`, `--file <file>` | The file(s) to load |
| `-r`, `--raw` | Loads the file as a raw binary |
| `-a`, `--arch <arch>` | Specify architecture (x86, x86_64, MIPS, ARM, etc.) |
| `--nocolor` | Disables colored output |
| `--clear-cache` | Clears the gadget cache |
| `--no-load` | Don't load gadgets automatically when starting console |
| `--single` | Disable multi-processing for gadget scanning |

### Binary Information Options
| Flag | Description |
|------|-------------|
| `-i`, `--info` | Shows file header [ELF/PE/Mach-O] |
| `-e` | Shows EntryPoint |
| `--imagebase` | Shows ImageBase [ELF/PE/Mach-O] |
| `-c`, `--dllcharacteristics` | Shows DllCharacteristics [PE] |
| `-s`, `--sections` | Shows file sections [ELF/PE/Mach-O] |
| `-S`, `--segments` | Shows file segments [ELF/Mach-O] |
| `--imports` | Shows imported functions [ELF/PE] |
| `--symbols` | Shows symbols [ELF] |
| `--section <section>` | Print data of a specific section |
| `--string [<string>]` | Look for a string in all data sections |
| `--hex` | Prints selected sections in hex format |

### Disassembly & Assembly
| Flag | Description |
|------|-------------|
| `--asm [<asm> [fmt]]` | Assemble a string. Formats: H (Hex), S (String), R (Raw) |
| `--disasm <opcode>` | Disassemble specific opcode (e.g., ffe4) |
| `--disassemble-address <addr:len>` | Disassemble at address (e.g., 0x12345678:L3) |

### Gadget Search & Filtering
| Flag | Description |
|------|-------------|
| `--search <regex>` | Search for gadgets using regex |
| `--instructions <instr>` | Search for specific instructions (e.g., "jmp esp") |
| `--opcode <opcode>` | Search for opcodes (e.g., ffe4 or ffe?) |
| `-p`, `--ppr` | Search for 'pop reg; pop reg; ret' [x86/x86_64 only] |
| `-j`, `--jmp <reg>` | Search for 'jmp reg' instructions |
| `--stack-pivot` | Print all stack pivot gadgets |
| `--type <type>` | Gadget type: `rop`, `jop`, `sys`, `all` (default: all) |
| `--inst-count <n>` | Max instructions in a gadget (default: 6) |
| `--quality <n>` | Quality for search results (1 = best) |
| `--all` | Do not remove duplicate gadgets |
| `--detailed` | Print detailed gadget information |
| `-b`, `--badbytes <hex>` | Set bytes to exclude from gadgets |
| `--cfg-only` | Filter gadgets failing Microsoft CFG check [PE] |

### Advanced Analysis & Chains
| Flag | Description |
|------|-------------|
| `--chain <gen>` | Generate ROP chain (execve, mprotect, virtualprotect) |
| `--semantic <cons>` | Semantic search for gadgets with constraints |
| `--analyse <quality>` | Implementation of semantic search |
| `--count-of-findings <n>` | Max gadgets for semantic search (default: 5) |
| `--set <option>` | Set options (e.g., `aslr`, `nx`) |
| `--unset <option>` | Unset options (e.g., `aslr`, `nx`) |
| `-I <imagebase>` | Use a custom imagebase for gadget addresses |

## Notes
- **Supported Formats**: ELF, PE, Mach-O, Raw.
- **Supported Archs**: x86, x86_64, MIPS, MIPS64, ARM, ARMTHUMB, ARM64, PPC, PPC64, SPARC64.
- **ROP Chain Generators**:
  - `execve`: Linux x86, x86_64
  - `mprotect`: Linux x86, x86_64
  - `virtualprotect`: Windows x86
- Ropper uses the **Capstone Framework** for disassembly.