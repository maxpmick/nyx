---
name: sfuzz
description: A flexible black box testing suite used for fuzzing network protocols and software. It supports TCP, UDP, and local output modes to identify vulnerabilities like buffer overflows or crashes. Use when performing protocol fuzzing, vulnerability analysis, or stress testing network services during penetration testing.
---

# sfuzz

## Overview
sfuzz (Simple Fuzzer) is a black box testing utility designed to be simple yet powerful. It automates the process of sending malformed or unexpected data to a target to identify security flaws. It supports both literal and sequence-based fuzzing. Category: Vulnerability Analysis / Fuzzing.

## Installation (if not already installed)
Assume sfuzz is already installed. If the command is missing:

```bash
sudo apt install sfuzz
```

## Common Workflows

### Fuzzing a Network Service (TCP)
Fuzz a target web server using a sample HTTP configuration file:
```bash
sfuzz -S 192.168.1.1 -p 80 -T -f /usr/share/sfuzz/sfuzz-sample/basic.http
```

### Silent Fuzzing with Hex Output
Useful for scripting or when dealing with binary protocols:
```bash
sfuzz -S 10.0.0.5 -p 445 -T -q -X -f smb_config.txt
```

### Testing a Specific Range of Test Cases
Start fuzzing from test case 50 and stop immediately if a failure is detected:
```bash
sfuzz -S 192.168.1.50 -p 21 -T -b 50 -e -f ftp_config.txt
```

### Local Output Mode
Test how the fuzzer generates data without sending it over the network:
```bash
sfuzz -O -f /usr/share/sfuzz/sfuzz-sample/basic.http
```

## Complete Command Reference

### sfuzz Options

| Flag | Description |
|------|-------------|
| `-h` | Display help message |
| `-V` | Display version information |
| `-v` | Verbose output |
| `-q` | Silent output mode (generally for CLI fuzzing) |
| `-X` | Print the output in hex |
| `-b <num>` | Begin fuzzing at the test case specified |
| `-e` | End testing on failure |
| `-t <ms>` | Wait time for reading the socket |
| `-S <host>` | Remote host address |
| `-p <port>` | Port number |
| `-T` | Use TCP mode |
| `-U` | Use UDP mode |
| `-O` | Use Output mode (standard out) |
| `-R` | Refrain from closing connections (leaks them) |
| `-f <file>` | Path to the configuration file |
| `-L <file>` | Path to the log file |
| `-n` | Create a new logfile after each fuzzing iteration |
| `-r` | Trim the trailing newline |
| `-D <X=y>` | Define a symbol and value |
| `-l` | Only perform literal fuzzing |
| `-s` | Only perform sequence fuzzing |

### sfo (sfuzz-oracle)
The `sfo` utility is used to spawn and monitor tasks, typically to detect crashes during the fuzzing process.

```bash
sfo [options] -- /path/to/executable
```

## Notes
- Configuration files for sfuzz typically define literals (static strings) and sequences (generated patterns).
- Sample configuration files are usually located in `/usr/share/sfuzz/sfuzz-sample/`.
- When using `-T` or `-U`, ensure the target host and port are reachable to avoid false negatives.