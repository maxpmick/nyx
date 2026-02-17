---
name: glibc
description: A collection of core system utilities and libraries provided by the GNU C Library. Use for system configuration queries, administrative database lookups (passwd, hosts), character encoding conversion, shared library dependency analysis, memory profiling, and tracing shared library calls during exploitation or reverse engineering.
---

# glibc

## Overview
The GNU C Library (glibc) provides the core libraries and basic desktop utilities for the system. In a security context, its utilities are essential for environment enumeration, identifying library dependencies (LD_PRELOAD/RPATH), profiling memory for exploit development, and tracing library calls. Category: Core / Exploitation / Reverse Engineering.

## Installation (if not already installed)
Glibc utilities are typically pre-installed. If specific development tools are missing:
```bash
sudo apt install libc-bin libc-devtools libc6-dev
```

## Common Workflows

### Identify Library Dependencies
Check which shared libraries an executable depends on and where they resolve:
```bash
ldd /usr/bin/python3
```

### Trace Shared Library Calls
Trace calls made by a program to shared libraries (similar to ltrace):
```bash
sotruss /usr/bin/id
```

### Memory Profiling
Profile memory usage of a program to identify leaks or allocation patterns:
```bash
memusage -p output.png ./vulnerable_binary
```

### Query System Databases
Retrieve information from system databases like `passwd` or `hosts`:
```bash
getent passwd root
getent hosts google.com
```

## Complete Command Reference

### libc-bin Utilities

#### getconf
Query system configuration variables.
- `getconf [-v SPEC] VAR`: Get value for variable VAR.
- `getconf [-v SPEC] PATH_VAR PATH`: Get value for PATH_VAR for a specific path.
- `-v SPEC`: Give values for compilation environment SPEC.

#### getent
Get entries from Name Service Switch libraries.
- `getent [OPTION...] database [key ...]`
- `-A, --no-addrconfig`: Do not filter out unsupported IPv4/IPv6 addresses.
- `-i, --no-idn`: Disable IDN encoding.
- `-s, --service=CONFIG`: Service configuration to be used.
- **Databases**: `ahosts`, `ahostsv4`, `ahostsv6`, `aliases`, `ethers`, `group`, `gshadow`, `hosts`, `initgroups`, `netgroup`, `networks`, `passwd`, `protocols`, `rpc`, `services`, `shadow`.

#### iconv
Convert text encoding.
- `-f, --from-code=NAME`: Encoding of original text.
- `-t, --to-code=NAME`: Encoding for output.
- `-l, --list`: List all known coded character sets.
- `-c`: Omit invalid characters from output.
- `-o, --output=FILE`: Output file.
- `-s, --silent`: Suppress warnings.
- `--verbose`: Print progress information.

#### ld.so (Dynamic Linker)
Invoke the program interpreter directly.
- `--list`: List all dependencies and how they are resolved.
- `--verify`: Verify object is a dynamically linked object.
- `--inhibit-cache`: Do not use `/etc/ld.so.cache`.
- `--library-path PATH`: Use PATH instead of `LD_LIBRARY_PATH`.
- `--glibc-hwcaps-prepend LIST`: Search subdirectories in LIST.
- `--glibc-hwcaps-mask LIST`: Only search built-in subdirectories if in LIST.
- `--inhibit-rpath LIST`: Ignore RUNPATH and RPATH in object names in LIST.
- `--audit LIST`: Use objects in LIST as auditors.
- `--preload LIST`: Preload objects in LIST.
- `--argv0 STRING`: Set `argv[0]` to STRING.
- `--list-tunables`: List all tunables.
- `--list-diagnostics`: List diagnostics information.

#### ldconfig
Configure dynamic linker run-time bindings.
- `-c, --format=FORMAT`: Format (new, old, or compat).
- `-C CACHE`: Use CACHE as cache file.
- `-f CONF`: Use CONF as configuration file.
- `-i, --ignore-aux-cache`: Ignore auxiliary cache file.
- `-l`: Manually link individual libraries.
- `-n`: Only process directories on command line.
- `-N`: Don't build cache.
- `-p, --print-cache`: Print cache.
- `-r ROOT`: Use ROOT as root directory.
- `-v, --verbose`: Verbose messages.
- `-X`: Don't update symbolic links.

#### ldd
Print shared object dependencies.
- `-d, --data-relocs`: Process data relocations.
- `-r, --function-relocs`: Process data and function relocations.
- `-u, --unused`: Print unused direct dependencies.
- `-v, --verbose`: Print all information.

#### locale / localedef
Manage locale definitions.
- `locale -a`: List available locales.
- `locale -m`: List available charmaps.
- `localedef -f CHARMAP -i INPUT NAME`: Compile locale.

### libc-devtools Utilities

#### memusage
Profile memory usage.
- `-n, --progname=NAME`: Name of program.
- `-p, --png=FILE`: Generate PNG graphic.
- `-d, --data=FILE`: Generate binary data file.
- `-u, --unbuffered`: Don't buffer output.
- `-b, --buffer=SIZE`: Collect SIZE entries before writing.
- `--no-timer`: No timer info.
- `-m, --mmap`: Trace mmap.
- `-t, --time-based`: Linear in time graph.
- `-T, --total`: Draw total memory use.
- `--x-size=SIZE` / `--y-size=SIZE`: Graphic dimensions.

#### sotruss
Trace shared library calls.
- `-F, --from FROMLIST`: Trace calls FROM objects in list.
- `-T, --to TOLIST`: Trace calls TO objects in list.
- `-e, --exit`: Show exits from function calls.
- `-f, --follow`: Trace child processes.
- `-o, --output FILE`: Write to file.

#### sprof
Read shared object profiling data.
- `-c, --call-pairs`: Print count paths.
- `-p, --flat-profile`: Generate flat profile.
- `-q, --graph`: Generate call graph.

### nscd (Name Service Cache Daemon)
- `-d, --debug`: Debug mode.
- `-f, --config-file=NAME`: Configuration file.
- `-g, --statistics`: Print statistics.
- `-i, --invalidate=TABLE`: Invalidate cache (passwd, group, hosts, etc).
- `-K, --shutdown`: Shut down server.

## Notes
- **Security**: `ldd` can be dangerous if run on untrusted binaries as it may execute the binary to determine dependencies. Use `objdump -p` or `readelf -d` for a safer static analysis.
- **Exploitation**: `ld.so --preload` and `LD_PRELOAD` are common vectors for local privilege escalation or persistence.
- **Tracing**: `sotruss` is excellent for identifying which library functions are called during a specific program execution path.