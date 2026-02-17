---
name: gdb
description: The GNU Debugger (GDB) is a source-level debugger used to inspect running programs, analyze core dumps, and debug application crashes. Use it for exploit development, reverse engineering, vulnerability analysis, and digital forensics to step through code, view memory, and examine CPU registers.
---

# gdb

## Overview
GDB is a powerful tool for investigating the internal state of programs. It supports multiple languages (C, C++, Go, Assembly, etc.) and architectures. It is essential for identifying memory corruption vulnerabilities, analyzing malware, and developing exploits. Category: Digital Forensics / Vulnerability Analysis.

## Installation (if not already installed)
Assume gdb is installed. If missing:

```bash
sudo apt install gdb gdbserver gdb-multiarch
```

## Common Workflows

### Debugging a local executable with arguments
```bash
gdb --args ./vulnerable_binary $(python3 -c "print('A'*100)")
```

### Attaching to a running process
```bash
gdb --pid $(pidof target_process)
```

### Analyzing a core dump
```bash
gdb --core=core.dump ./original_binary
```

### Remote debugging (Server side)
```bash
gdbserver 0.0.0.0:1234 ./target_binary
```

### Remote debugging (Client side)
```bash
gdb ./target_binary -ex "target remote 192.168.1.10:1234"
```

## Complete Command Reference

### gdb / gdb-multiarch / gdbtui
Usage: `gdb [options] [executable-file [core-file or process-id]]`

#### Selection of debuggee and its files
| Flag | Description |
|------|-------------|
| `--args` | Arguments after executable-file are passed to inferior |
| `--core=COREFILE` | Analyze the core dump COREFILE |
| `--exec=EXECFILE` | Use EXECFILE as the executable |
| `--pid=PID` | Attach to running process PID |
| `--directory=DIR` | Search for source files in DIR |
| `--se=FILE` | Use FILE as symbol file and executable file |
| `--symbols=SYMFILE` | Read symbols from SYMFILE |
| `--readnow` | Fully read symbol files on first access |
| `--readnever` | Do not read symbol files |
| `--write` | Set writing into executable and core files |

#### Initial commands and command files
| Flag | Description |
|------|-------------|
| `--command=FILE`, `-x` | Execute GDB commands from FILE |
| `--init-command=FILE`, `-ix` | Like -x but execute commands before loading inferior |
| `--eval-command=CMD`, `-ex` | Execute a single GDB command (can be used multiple times) |
| `--init-eval-command=CMD`, `-iex` | Like -ex but before loading inferior |
| `--nh` | Do not read `~/.gdbinit` |
| `--nx` | Do not read any `.gdbinit` files |

#### Output and user interface control
| Flag | Description |
|------|-------------|
| `--fullname` | Output information used by emacs-GDB interface |
| `--interpreter=INTERP` | Select a specific interpreter / user interface |
| `--tty=TTY` | Use TTY for input/output by the program being debugged |
| `-w` | Use the GUI interface |
| `--nw` | Do not use the GUI interface |
| `--tui` | Use a terminal user interface |
| `-q`, `--quiet`, `--silent` | Do not print version number on startup |

#### Operating modes
| Flag | Description |
|------|-------------|
| `--batch` | Exit after processing options |
| `--batch-silent` | Like --batch, but suppress all gdb stdout output |
| `--return-child-result` | GDB exit code will be the child's exit code |
| `--configuration` | Print details about GDB configuration and then exit |
| `--help` | Print help message |
| `--version` | Print version information |

#### Remote debugging and Other
| Flag | Description |
|------|-------------|
| `-b BAUDRATE` | Set serial port baud rate used for remote debugging |
| `-l TIMEOUT` | Set timeout in seconds for remote debugging |
| `--cd=DIR` | Change current directory to DIR |
| `--data-directory=DIR`, `-D` | Set GDB's data-directory to DIR |

---

### gdbserver
Usage: `gdbserver [OPTIONS] COMM PROG [ARGS ...]`

| Flag | Description |
|------|-------------|
| `--attach` | Attach to running process PID |
| `--multi` | Start server without a specific program |
| `--once` | Exit after the first connection has closed |
| `--wrapper WRAPPER --` | Run WRAPPER to start new programs |
| `--disable-randomization` | Run PROG with ASLR disabled |
| `--no-disable-randomization` | Don't disable ASLR |
| `--startup-with-shell` | Start PROG using a shell (default) |
| `--no-startup-with-shell` | Exec PROG directly instead of using a shell |
| `--debug[=OPT1,...]` | Enable debug output (all, threads, event-loop, remote) |
| `--debug-format=OPT1` | Specify extra content (all, none, timestamp) |
| `--disable-packet=OPT1` | Disable RSP packets (vCont, T, Tthread, qC, qfThreadInfo, threads) |

---

### gcore
Generate core files for running processes.
Usage: `gcore [-a] [-o prefix] [-d data-directory] pid1 [pid2...pidN]`

| Flag | Description |
|------|-------------|
| `-a` | Dump all memory (including shared libraries) |
| `-o prefix` | Specify output filename prefix |
| `-d dir` | Set data directory |

---

### gstack
Print a stack trace of a running program.
Usage: `gstack [-h|--help] [-v|--version] PID`

## Notes
- Use `gdb-multiarch` when debugging binaries from different architectures (e.g., ARM binaries on x86_64).
- For exploit development, it is highly recommended to use GDB extensions like **GEF**, **Pwnbg**, or **peda** for better visualization of registers and stack.
- Use `--batch` and `-ex` to automate GDB tasks from the command line.