---
name: lynis
description: Perform comprehensive security auditing, system hardening, and vulnerability scanning on Unix-based systems. Use when conducting local security assessments, compliance audits (HIPAA, PCI-DSS, ISO27001), system hardening, or identifying points of interest during post-exploitation and forensics.
---

# lynis

## Overview
Lynis is an open-source security auditing tool designed for Unix-based systems like Linux, macOS, and BSD. It assists in system hardening by scanning the configuration and creating an overview of security issues, configuration errors, and suggestions for improvement. Category: Vulnerability Analysis / Digital Forensics / Post-Exploitation.

## Installation (if not already installed)
Assume lynis is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install lynis
```

## Common Workflows

### Standard Local Security Audit
Perform a comprehensive scan of the local system with interactive prompts.
```bash
sudo lynis audit system
```

### Non-interactive Audit (Cron/CI/CD)
Run a full audit without waiting for user input, suitable for automated scripts.
```bash
sudo lynis audit system --quick --cronjob
```

### Pentesting Mode
Run as a non-privileged user to identify potential privilege escalation vectors and points of interest.
```bash
lynis audit system --pentest
```

### Dockerfile Analysis
Analyze a Dockerfile for security best practices before building an image.
```bash
lynis audit dockerfile /path/to/Dockerfile
```

## Complete Command Reference

### Commands

| Command | Subcommand | Description |
|---------|------------|-------------|
| **audit** | `system` | Perform a local security scan |
| | `system remote <host>` | Perform a remote security scan |
| | `dockerfile <file>` | Analyze a Dockerfile for security issues |
| **show** | | Show all available commands |
| | `version` | Show Lynis version |
| | `help` | Show help message |
| | `options` | Show all available command-line options |
| **update** | `info` | Show update details for the tool |

### Options

#### Alternative System Audit Modes
| Flag | Description |
|------|-------------|
| `--forensics` | Perform forensics on a running or mounted system |
| `--pentest` | Non-privileged scan; shows points of interest for penetration testing |

#### Layout Options
| Flag | Description |
|------|-------------|
| `--no-colors` | Disable colors in output |
| `--quiet`, `-q` | Suppress all output except warnings/errors |
| `--reverse-colors` | Optimize color display for light backgrounds |
| `--reverse-colours` | Optimize colour display for light backgrounds (UK spelling) |

#### Misc Options
| Flag | Description |
|------|-------------|
| `--debug` | Enable debug logging to the screen |
| `--no-log` | Do not create a log file |
| `--profile <profile>` | Scan the system using a specific profile file |
| `--view-manpage`, `--man` | View the tool's man page |
| `--verbose` | Show more details on screen during the scan |
| `--version`, `-V` | Display version number and exit |
| `--wait` | Wait between sets of tests for easier reading |
| `--slow-warning <sec>` | Threshold for slow test warning in seconds (default: 10) |
| `--quick`, `-Q` | Do not wait for user input (Quick mode) |
| `--cronjob` | Run in cron mode (includes `--quick` and specific formatting) |

#### Enterprise Options
| Flag | Description |
|------|-------------|
| `--plugindir <path>` | Define the path where available plugins are located |
| `--upload` | Upload the audit data to a central node |

## Notes
- **Privileges**: While Lynis can run as a normal user (especially with `--pentest`), it provides the most comprehensive results when run as **root**.
- **Logs**: By default, logs are stored at `/var/log/lynis.log` and the report data at `/var/log/lynis-report.dat`.
- **Hardening Index**: At the end of a scan, Lynis provides a "Hardening Index" score and a list of "Suggestions" and "Warnings" that should be reviewed for system improvement.