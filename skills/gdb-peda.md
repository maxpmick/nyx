---
name: gdb-peda
description: Enhance GDB with Python Exploit Development Assistance (PEDA) for binary analysis and exploit development. Use when performing reverse engineering, vulnerability research, or exploit crafting to gain better visualization of registers, stack, and memory, and to access specialized commands for pattern generation, shellcode searching, and ROP chain construction.
---

# gdb-peda

## Overview
PEDA (Python Exploit Development Assistance for GDB) is a powerful GDB plugin designed to streamline the exploit development process. It provides a colorized interface showing registers, code disassembly, and stack information at every step, along with specialized commands for memory searching, pattern creation, and security mitigation checks. Category: Reverse Engineering / Exploitation.

## Installation (if not already installed)
Assume gdb-peda is already installed. If the commands are not available within GDB, you may need to load the script:

```bash
sudo apt install gdb-peda
```

To use it, start GDB. If it doesn't load automatically, run this inside GDB:
```gdb
source /usr/share/gdb-peda/peda.py
```

## Common Workflows

### Basic Debugging with Enhanced Visualization
```bash
gdb ./vulnerable_binary
gdb-peda$ break main
gdb-peda$ run
```
PEDA will automatically display the register state, the current instruction disassembly, and the top of the stack.

### Finding a Buffer Overflow Offset
```gdb
gdb-peda$ pattern create 200
gdb-peda$ run
# After crash
gdb-peda$ pattern offset $rsp
```

### Searching for ROP Gadgets and Security Mitigations
```gdb
gdb-peda$ checksec
gdb-peda$ searchmem "/bin/sh"
gdb-peda$ ropsearch "pop rdi; ret"
```

## Complete Command Reference

PEDA adds a wide array of commands to the standard GDB environment.

### Control and Configuration
| Command | Description |
|---------|-------------|
| `peda help` | Display help for PEDA commands |
| `peda set <option> <value>` | Set PEDA runtime options (e.g., `context`, `autosave`) |
| `peda show <option>` | Show PEDA runtime options |
| `peda reload` | Reload PEDA script and its commands |

### Context Display
| Command | Description |
|---------|-------------|
| `context` | Display various information: register, code, stack |
| `context_code` | Display only the code context |
| `context_register` | Display only the register context |
| `context_stack` | Display only the stack context |
| `set context_layout` | Change the layout of the context display |

### Exploit Development & Pattern
| Command | Description |
|---------|-------------|
| `pattern create <size> [file]` | Generate a cyclic pattern for overflow distance determination |
| `pattern offset <value/address>` | Search for the offset of a value in the cyclic pattern |
| `pattern search` | Search all pattern chunks in memory |
| `shellcode generate <type>` | Generate common shellcodes (e.g., x86/linux/exec) |
| `shellcode display` | Display available shellcodes |
| `jmpcall [reg/addr]` | Search for `jmp/call` instructions to a specific register or address |

### Memory and Search
| Command | Description |
|---------|-------------|
| `searchmem <pattern> [range]` | Search for a pattern in memory; supports strings and hex |
| `searchmem_ret` | Search for return addresses in memory |
| `ropgadget [objfile]` | Get common ROP gadgets of a library or binary |
| `ropsearch <expr> [range]` | Search for ROP gadgets in memory |
| `nearpc [lines]` | Disassemble instructions around the current PC |
| `telescope [addr] [count]` | Display memory content with smart pointer dereferencing |
| `vmmap` | Get virtual memory map ranges of the process |
| `readmem <addr> <size> <file>` | Read content of memory to a file |
| `writemem <addr> <file/string>` | Write content to memory from a file or string |

### Binary Analysis
| Command | Description |
|---------|-------------|
| `checksec` | Check for binary security features (NX, ASLR, Canary, PIE, RELRO) |
| `elfheader` | Get headers information from the ELF file |
| `elfsymbol` | Get non-debugging symbol information from the ELF file |
| `lookup <symbol> [library]` | Search for address of a symbol |
| `patch <addr> <value>` | Patch memory at address with a value |
| `strings [range]` | Display printable strings in memory |
| `xinfo <addr/symbol>` | Display detailed information about an address or symbol |
| `xprint <expr>` | Print expression with extra detail |

### Utilities
| Command | Description |
|---------|-------------|
| `asmscan` | Scan for ASM instructions in memory |
| `asmpause` | Pause GDB execution at every instruction |
| `crashdump` | Display status of registers and stack at the time of crash |
| `distance <addr1> <addr2>` | Calculate distance between two addresses |
| `headers` | Display section headers of the loaded binary |
| `procinfo` | Display information from `/proc/pid/` |

## Notes
- PEDA is specifically optimized for Linux environments.
- It is highly recommended to use PEDA alongside `pwntools` for complex exploit automation.
- If the display becomes corrupted, use the `context` command to redraw the interface.
- PEDA may conflict with other GDB plugins like GEF or Pwndbg; ensure only one is sourced in your `.gdbinit` at a time.