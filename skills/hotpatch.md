---
name: hotpatch
description: Hot patch Linux executables by injecting shared library (.so) files into running processes without stopping them. Use when performing live process manipulation, dynamic instrumentation, or runtime patching of binaries during exploitation or post-exploitation phases.
---

# hotpatch

## Overview
Hotpatch is a library and command-line utility used to dynamically load a shared library (.so) into an already running Linux process. It allows for code injection and execution within the target process's memory space without affecting its overall execution flow. Category: Exploitation / Post-Exploitation.

## Installation (if not already installed)
Assume hotpatch is already installed. If you get a "command not found" error:

```bash
sudo apt install hotpatch
```

## Common Workflows

### Inject a shared library into a running process
```bash
hotpatcher -l /tmp/exploit.so 1234
```
Injects `exploit.so` into the process with PID 1234.

### Inject and invoke a specific function
```bash
hotpatcher -l /tmp/tools.so -s my_init_func 1234
```
Loads the library and immediately executes the symbol `my_init_func`.

### Dry run to verify process access
```bash
hotpatcher -N 1234
```
Checks if the process can be patched without actually modifying it.

### High-verbosity injection for debugging
```bash
hotpatcher -vvvv -l /tmp/payload.so 1234
```

## Complete Command Reference

```
hotpatcher [options] <PID of process to patch>
```

### Options

| Flag | Description |
|------|-------------|
| `-h` | Display the help message |
| `-V` | Display version number |
| `-v[vvvv]` | Enable verbose logging. Add more 'v' characters for increased verbosity |
| `-N` | Dry run. Do not modify anything in the target process |
| `-l <.so>` | Path or name of the `.so` file to load. Note: This switches off the execution pointer reset |
| `-s <name>` | Symbol to invoke during the DLL injection (Optional) |
| `-x <name>` | Set execution pointer to the specified symbol. **Cannot** be used simultaneously with the `-s` option |

## Notes
- The tool requires sufficient privileges (usually root) to attach to and modify other running processes via `ptrace`.
- Using `-x` will redirect the execution flow of the target process to the specified symbol, which may crash the process if not handled correctly.
- Ensure the `.so` file being injected is compiled for the same architecture as the target process (i.e., 32-bit vs 64-bit).