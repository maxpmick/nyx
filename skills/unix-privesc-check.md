---
name: unix-privesc-check
description: Shell script to check for common Unix privilege escalation vectors caused by misconfigurations. Use when performing local enumeration on a Linux/Unix target to identify weak file permissions, insecure cron jobs, writable binaries, or sensitive information disclosure that could allow an unprivileged user to escalate to root or another user.
---

# unix-privesc-check

## Overview
A standalone shell script designed to find misconfigurations on Unix-like systems (Linux, Solaris, HPUX, FreeBSD) that could allow local unprivileged users to escalate privileges. It checks file permissions, environment settings, and application configurations. Category: Vulnerability Analysis.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt install unix-privesc-check
```

## Common Workflows

### Standard Security Audit
Perform a speed-optimized check of common security settings and misconfigurations.
```bash
unix-privesc-check standard
```

### Deep Analysis
Perform a thorough check including open file handles and linked shared objects (.so files). Note: This is slower and may produce false positives.
```bash
unix-privesc-check detailed
```

### Saving Output for Analysis
Since the script produces voluminous output, it is best to pipe it to a file and grep for vulnerabilities.
```bash
unix-privesc-check standard > output.txt
grep "WARNING" output.txt
```

## Complete Command Reference

```bash
unix-privesc-check { standard | detailed }
```

### Modes

| Mode | Description |
|------|-------------|
| `standard` | Speed-optimised check of security settings. Ideal for initial enumeration. |
| `detailed` | Includes all standard checks plus permissions of open file handles and called files (parsed from shell scripts, linked .so files, etc.). |

### General Information
- **Trigger Keyword**: Search the tool output for the word **'WARNING'** to identify potential vulnerabilities.
- **Execution**: Can be run as a normal user or root. Running as root allows the script to read more sensitive configuration files, providing a more accurate audit.

## Notes
- **Scope**: This tool checks for "simple" vectors like writable `/etc/passwd`, insecure cron jobs, and world-writable binaries. It does not typically include kernel exploit suggestions.
- **False Positives**: The `detailed` mode is prone to false positives as it recursively checks dependencies and scripts which might not be exploitable in practice.
- **Portability**: Being a single shell script, it is designed to be easily uploaded to a target machine via `scp`, `curl`, or `wget` during a penetration test.