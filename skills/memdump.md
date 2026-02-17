---
name: memdump
description: Dump system memory contents to standard output while skipping holes in memory maps. Use when performing digital forensics, incident response, or security testing to capture physical or kernel memory for analysis.
---

# memdump

## Overview
A utility that dumps system memory to the standard output stream. It is designed to skip over holes in memory maps to ensure a continuous stream of accessible data. By default, it targets physical memory. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)

Assume memdump is already installed. If you get a "command not found" error:

```bash
sudo apt install memdump
```

## Common Workflows

### Dump physical memory to a file
```bash
sudo memdump > physical_memory.img
```

### Dump kernel memory with a specific buffer size
```bash
sudo memdump -k -b 4096 > kernel_memory.img
```

### Print the memory map without dumping data
```bash
sudo memdump -m memory_map.txt
```

### Capture a specific size of memory
```bash
sudo memdump -s 1073741824 > first_gb_phys_mem.img
```

## Complete Command Reference

```
memdump [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-b <read_buffer_size>` | Set the read buffer size (default 0, uses the system page size) |
| `-k` | Dump kernel memory instead of physical memory |
| `-m <map_file>` | Print the memory map to the specified file |
| `-p <memory_page_size>` | Set the memory page size (default 0, uses the system page size) |
| `-s <memory_dump_size>` | Set the amount of memory to dump (default 0, dumps all memory) |
| `-v` | Enable verbose mode for debugging |

## Notes
- **Kernel Restrictions**: This tool will not work if `CONFIG_STRICT_DEVMEM` is enabled in the Linux kernel. Many modern kernels (2.6+) enable this by default, which restricts access to `/dev/mem`.
- **Permissions**: Root privileges are typically required to access system memory devices.
- **Output**: The tool writes to `stdout`. Always redirect the output to a file or pipe it to another tool (like `nc` or `sha256sum`) to avoid flooding the terminal.