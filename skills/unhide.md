---
name: unhide
description: Detect hidden processes and TCP/UDP ports used by rootkits or kernel modules. Use during forensic investigations, incident response, or security audits to identify malicious activity that evades standard system tools like ps, netstat, or ss.
---

# unhide

## Overview
Unhide is a forensic tool designed to find processes and TCP/UDP ports hidden by rootkits, Linux kernel modules, or other techniques. It compares information from multiple sources (e.g., /proc, system calls, PIDs brute-forcing) against standard tool outputs to identify discrepancies. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume the tool is installed. If missing:
```bash
sudo apt install unhide
```

## Common Workflows

### Quick Process Scan
Perform a fast check combining proc, procfs, and sys techniques.
```bash
unhide quick
```

### Deep Process Investigation
Run comprehensive checks including PID brute-forcing and reverse verification with logging.
```bash
sudo unhide -m -d -f sys procall brute reverse
```

### Identify Hidden Listening Ports
Scan for TCP/UDP ports that are listening but hidden from netstat/ss.
```bash
sudo unhide-tcp -l -v
```

### Legacy System Check
For systems with Linux kernel < 2.6.
```bash
unhide-posix proc
```

## Complete Command Reference

### unhide / unhide-linux
Used for systems with Linux kernel >= 2.6.

**Usage:** `unhide [options] test_list`

| Flag | Description |
|------|-------------|
| `-V` | Show version and exit |
| `-v` | Verbose mode (can be repeated) |
| `-h` | Display help |
| `-m` | More checks (affects procfs, procall, checkopendir, checkchdir) |
| `-r` | Use alternate sysinfo test in meta-test |
| `-f`, `-o` | Log results into `unhide-linux.log` |
| `-d` | Do a double check in brute test to avoid false positives |
| `-u` | Inhibit stdout buffering (useful for piping or GUIs) |
| `-H` | Human-friendly output with ending messages |

**Standard Tests:**
- `brute`: Bruteforce all process IDs.
- `proc`: Compare `/proc` with `/bin/ps` output.
- `procall`: Combines `proc` and `procfs` tests.
- `procfs`: Compare `/bin/ps` with information from walking the procfs.
- `quick`: Fast combination of `proc`, `procfs`, and `sys` (higher false positive risk).
- `reverse`: Verify all threads seen by `ps` are seen by kernel (detects fake processes).
- `sys`: Compare `/bin/ps` with system call information.

**Elementary Tests:**
- `checkbrute`, `checkchdir`, `checkgetaffinity`, `checkgetparam`, `checkgetpgid`, `checkgetprio`, `checkRRgetinterval`, `checkgetsched`, `checkgetsid`, `checkkill`, `checknoprocps`, `checkopendir`, `checkproc`, `checkquick`, `checkreaddir`, `checkreverse`, `checksysinfo`, `checksysinfo2`, `checksysinfo3`.

---

### unhide-tcp
Used to find hidden TCP/UDP ports.

**Usage:** `unhide-tcp [options]`

| Flag | Description |
|------|-------------|
| `-V` | Show version and exit |
| `-v` | Verbose mode |
| `-h` | Display help |
| `-f` | Show `fuser` output for hidden ports |
| `-l` | Show `lsof` output for hidden ports |
| `-o` | Log results into `unhide-tcp.log` |
| `-s` | Quick version for servers with many open ports |
| `-n` | Use `netstat` instead of `ss` |

---

### unhide-posix
Legacy version for Linux < 2.6 or other UNIX systems.

**Usage:** `unhide-posix proc | sys`

- `proc`: Compare `/proc` with `ps`.
- `sys`: Compare syscalls with `ps`.

## Notes
- **Root Privileges**: Most tests require root permissions to access `/proc` and execute system calls effectively.
- **False Positives**: On kernels > 2.6.33, `sysinfo` tests may report false positives due to scheduler optimizations or `systemd`. Use the `-d` (double check) flag to mitigate this.
- **Exit Status**: Returns `0` if no hidden processes are found, and `1` if a hidden or fake thread is detected.