---
name: chkrootkit
description: Scan the local system for signs of rootkits, trojans, and malicious modifications. It checks system binaries for modifications, looks for known rootkit signatures, and inspects log files for deletions. Use during digital forensics, incident response, or routine security auditing to detect compromised hosts.
---

# chkrootkit

## Overview
chkrootkit is a tool to locally check for signs of a rootkit. It contains a main shell script that sequences various checks and several C programs to check for lastlog/wtmp modifications and sniffer interfaces. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume chkrootkit is already installed. If you get a "command not found" error:

```bash
sudo apt install chkrootkit
```

## Common Workflows

### Standard System Scan
Run a full scan of the system with default settings:
```bash
sudo chkrootkit
```

### Quiet Mode (Report only Problems)
Useful for automated scripts or focused manual review:
```bash
sudo chkrootkit -q
```

### Expert Mode
Provides more technical output, showing the results of every internal test:
```bash
sudo chkrootkit -x
```

### Forensic Analysis of a Mounted Drive
Scan a suspect filesystem mounted at `/mnt/suspect`:
```bash
sudo chkrootkit -r /mnt/suspect
```

### Check for Log Tampering
Manually check for deleted entries in login databases:
```bash
chklastlog
chkwtmp
```

## Complete Command Reference

### chkrootkit (Main Scanner)
```
chkrootkit [options] [test ...]
```

| Flag | Description |
|------|-------------|
| `-h` | Show help and exit |
| `-V` | Show version information and exit |
| `-l` | Show available tests and exit |
| `-d` | Debug mode |
| `-q` | Quiet mode (only output messages with 'INFECTED', 'ADVISED', or 'found') |
| `-x` | Expert mode (show more detailed output) |
| `-e 'FILE1 FILE2'` | Exclude space-separated list of files/dirs from results |
| `-s REGEXP` | Filter results of sniffer test through `grep -Ev REGEXP` to exclude expected sniffers |
| `-r DIR` | Use DIR as the root directory (useful for forensic analysis of mounted drives) |
| `-p DIR1:DIR2` | Define the path for external commands used by chkrootkit |
| `-n` | Skip NFS mount points |
| `-T FSTYPE` | Skip mount points of the specified file system type |
| `[test ...]` | Optional list of specific tests to run (e.g., `aliens`, `bindshell`, `lkm`) |

### chklastlog
Checks the `lastlog` file for deleted entries by comparing `/var/log/wtmp` against `/var/log/lastlog`.
- **Usage**: `chklastlog`
- **Files**: `/var/log/wtmp`, `/var/log/lastlog`

### chkwtmp
Examines `/var/log/wtmp` for entries that have been overwritten with null bytes, indicating log tampering.
- **Usage**: `chkwtmp`
- **Files**: `/var/log/wtmp`

### chkrootkit-daily
A Debian-specific script to run chkrootkit and email results.
- **Usage**: `chkrootkit-daily`
- **Configuration**: `/etc/chkrootkit/chkrootkit.conf`

## Notes
- **Root Privileges**: Most tests require root privileges to access system binaries and log files.
- **False Positives**: Automated tools cannot guarantee a system is uncompromised. Some reports may be false positives; always verify findings manually.
- **Binary Integrity**: If the system is heavily compromised, the very binaries `chkrootkit` relies on (like `ls`, `ps`, `netstat`) might be subverted. Use the `-p` flag to point to known-good binaries from a trusted source if necessary.
- **Limitations**: `chklastlog` and `chkwtmp` were originally designed for SunOS; on modern Linux systems, results should be interpreted with caution.