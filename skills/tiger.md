---
name: tiger
description: Perform security auditing and host intrusion detection on UNIX/Linux systems. Use to identify system vulnerabilities, misconfigurations, file integrity issues, and deviations from security baselines. It is ideal for system hardening, periodic security reviews, and detecting unauthorized changes via cron.
---

# tiger

## Overview
Tiger is a comprehensive security auditing and intrusion detection toolset consisting of shell scripts and C programs. It evaluates system components to report potential compromises, performs MD5 checksum verification of installed files, and analyzes local listening processes. Category: Reconnaissance / Information Gathering / Vulnerability Analysis.

## Installation (if not already installed)
Assume the tool is installed. If missing:
```bash
sudo apt install tiger
```

## Common Workflows

### Run a standard security audit
```bash
sudo tiger
```
Generates a security report in `/var/log/tiger/`.

### Run audit with detailed explanations for each finding
```bash
sudo tiger -e
```

### Generate system binary signatures (MD5/Permissions)
```bash
sudo tiger -G
```

### Run in test mode with HTML output
```bash
sudo tiger -t -H
```

## Complete Command Reference

### tiger / tigercron
Both utilities share the same command-line interface. `tiger` is used for manual audits, while `tigercron` is typically used for scheduled checks.

| Flag | Description |
|------|-------------|
| `-v` | Show the Tiger version |
| `-t` | Run in test mode |
| `-h` | Show usage/help |
| `-q` | Quiet mode: suppress status messages, only show security messages |
| `-B <dir>` | Specify installation directory (default: `/usr/lib/tiger`) |
| `-l <dir\|@host>` | Specify report directory (default: `/var/log/tiger`). If starts with `@`, logs to a tiger server |
| `-w <dir>` | Specify directory for scratch/work files (default: `/var/lib/tiger/work`) |
| `-b <dir>` | Specify directory containing C module binaries |
| `-c <file>` | Specify alternate `tigerrc` control file (default: `/etc/tiger/tigerrc`) |
| `-e` | Insert explanations into the security report following each message |
| `-E` | Create a separate explanation report (`explain.report...`) with unique explanations |
| `-G` | Generate signatures (MD5 hashes and file permissions) for system binary files |
| `-H` | Format the report into HTML with local links to problem descriptions |
| `-S` | Perform surface-level check of diskless clients served by this machine |

### Configuration Overrides
Used to manually specify system details if detection fails or when auditing remote filesystems.

| Flag | Description |
|------|-------------|
| `-A <arch>` | Specify an alternate architecture |
| `-O <os>` | Specify an alternate operating system |
| `-R <release>` | Specify an alternate operating system release |

### tigexp
Utility to generate explanations for Tiger security IDs.
```bash
tigexp <msgid>
```

## Notes
- Reports are saved with the naming convention: `security.report.<hostname>.<date>.<time>`.
- Tiger relies on external tools like John the Ripper or Chkrootkit if configured in `tigerrc`.
- On Debian/Kali, Tiger includes specific checks for `md5sums` of installed packages and identifies files not belonging to any package.
- For periodic auditing, ensure the `cron` service is running to allow `tigercron` to execute.