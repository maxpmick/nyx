---
name: rkhunter
description: Scan systems for rootkits, backdoors, sniffers, and local exploits by checking for SHA256 hash changes, suspicious files, anomalous permissions, and hidden directories. Use during digital forensics, incident response, or post-exploitation audits to verify system integrity and detect compromise.
---

# rkhunter

## Overview
Rootkit Hunter (rkhunter) is a Unix-based tool that scans for rootkits, backdoors, and local exploits. It functions by comparing SHA256 hashes of important files with known good values, searching for default directories used by rootkits, checking for suspicious strings in kernel modules, and identifying hidden files. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume rkhunter is already installed. If the command is missing:

```bash
sudo apt update
sudo apt install rkhunter
```

## Common Workflows

### Update databases and check the system
Always update the properties database after OS updates to avoid false positives, then run a check.
```bash
sudo rkhunter --propupd
sudo rkhunter --check --sk
```

### Interactive system audit
Run a full check and wait for user confirmation after each group of tests.
```bash
sudo rkhunter --check
```

### Non-interactive scan with warning report
Run a scan automatically (skipping keypresses) and only output warnings to the console.
```bash
sudo rkhunter --check --sk --report-warnings-only
```

### Check configuration validity
Verify the syntax of the rkhunter configuration file.
```bash
rkhunter --config-check
```

## Complete Command Reference

### Primary Operations (Commands)
Only one of these may be specified at a time.

| Command | Description |
|---------|-------------|
| `-c`, `--check` | Check the local system for rootkits and vulnerabilities |
| `--unlock` | Unlock (remove) the lock file if a previous run crashed |
| `--update` | Check for and download updates to the database files |
| `--versioncheck` | Check for the latest version of the rkhunter program |
| `--propupd [file\|dir\|pkg]...` | Update the entire file properties database, or specific entries |
| `--list [type]` | List available `tests`, `languages`, `rootkits`, `perl` (module status), or `propfiles` |
| `-C`, `--config-check` | Check the configuration file(s) for errors and exit |
| `-V`, `--version` | Display the version number and exit |
| `-h`, `--help` | Display the help menu and exit |

### General Options

| Flag | Description |
|------|-------------|
| `--append-log` | Append to the logfile instead of overwriting |
| `--noappend-log` | Overwrite the logfile (default) |
| `--bindir <directory>...` | Use the specified command directories (space separated) |
| `--configfile <file>` | Use a specific configuration file instead of the default |
| `--dbdir <directory>` | Use the specified database directory |
| `--tmpdir <directory>` | Use the specified temporary directory |
| `--cronjob` | Run as a cron job (implies `-c`, `--sk`, and `--nocolors`) |
| `--debug` | Enable debug mode (use only for troubleshooting) |
| `--nocolors` | Use black and white output |
| `--cs2`, `--color-set2` | Use the second color set for output |
| `--lang`, `--language <lang>` | Specify the language (Default: English) |
| `-q`, `--quiet` | Quiet mode (no output to stdout) |
| `--sk`, `--skip-keypress` | Do not wait for a keypress after each test set |
| `-x`, `--autox` | Automatically detect if X Window System is in use |
| `-X`, `--no-autox` | Do not automatically detect if X is in use |

### Test Selection Options

| Flag | Description |
|------|-------------|
| `--disable <test>[,<test>...]` | Disable specific tests (Default: none) |
| `--enable <test>[,<test>...]` | Enable specific tests (Default: all) |
| `--nocf` | Do not use config file entries for disabled tests (only with `--disable`) |

### Logging and Output Options

| Flag | Description |
|------|-------------|
| `-l`, `--logfile [file]` | Write to a logfile (Default: `/var/log/rkhunter.log`) |
| `--nolog` | Do not write to a logfile |
| `--display-logfile` | Display the logfile content at the end of the check |
| `--vl`, `--verbose-logging` | Use verbose logging (on by default) |
| `--novl`, `--no-verbose-logging`| Disable verbose logging |
| `--rwo`, `--report-warnings-only`| Show only warning messages during the check |
| `--ns`, `--nosummary` | Do not show the summary of check results |
| `--summary` | Show the summary of check results (Default) |
| `--syslog [facility.priority]` | Log start/finish times to syslog (Default: `authpriv.notice`) |
| `--nomow`, `--no-mail-on-warning`| Do not send an email if warnings occur |

### Verification Options

| Flag | Description |
|------|-------------|
| `--hash <func>` | Use specified hash: `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, `SHA512`, `NONE`, or `<command>` |
| `--pkgmgr <manager>` | Use package manager to verify properties: `RPM`, `DPKG`, `BSD`, `BSDng`, `SOLARIS`, or `NONE` |

## Notes
- **False Positives**: Running `rkhunter --check` immediately after a package update often triggers "File properties changed" warnings. Run `sudo rkhunter --propupd` after intentional system updates to refresh the baseline.
- **Root Privileges**: Most rkhunter operations require `sudo` or root access to read system directories and kernel information.
- **Complementary Tools**: It is recommended to use rkhunter alongside other tools like `chkrootkit` for better detection coverage.