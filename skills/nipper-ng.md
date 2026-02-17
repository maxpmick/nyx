---
name: nipper-ng
description: Perform security configuration reviews of network infrastructure devices including routers, firewalls, and switches. Use when auditing device configurations (Cisco, CheckPoint, etc.) for security weaknesses, misconfigurations, and compliance during penetration testing or security assessments.
---

# nipper-ng

## Overview
Nipper-ng (Network Infrastructure Parser) is a tool designed to analyze the configuration files of network devices. It identifies security-related issues and provides detailed recommendations for remediation. It supports various device types and can output reports in multiple formats including HTML, LaTeX, and CSV. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume nipper-ng is already installed. If the `nipper` command is missing:

```bash
sudo apt install nipper-ng
```

## Common Workflows

### Audit a Cisco IOS Router configuration
```bash
nipper --ios-router --input=ios.conf --output=report.html
```

### Audit a CheckPoint Firewall configuration
Note: For CheckPoint, the input should be the directory containing the configuration files.
```bash
nipper --checkpoint --input=/path/to/conf/dir/ --output=audit.html
```

### Export network filtering rules to CSV
```bash
nipper --ios-switch --input=switch.conf --csv=rules.csv
```

### Process configuration from stdin
```bash
cat running-config.conf | nipper --ios-router > report.html
```

## Complete Command Reference

### General Options

| Flag | Description |
|------|-------------|
| `--input=<file>` | Specifies a device configuration file to process. For CheckPoint, specify the `conf` directory. |
| `--output=<file>` | Specifies an output file for the report. |
| `--report=<file>` | Alias for `--output`. |
| `--csv=<file>` | Output the network filtering configuration to a CSV file. |
| `--version` | Displays the program version. |
| `--help[=<topic>]` | Show online help or help for a specific topic (see Help Topics below). |

### Help Topics
Use `--help=<topic>` to access detailed documentation for specific areas:

| Topic | Description |
|-------|-------------|
| `GENERAL` | General usage and options |
| `DEVICES` | Supported device types and basic device options |
| `DEVICES-ADV` | Advanced device-specific configuration options |
| `SNMP` | SNMP configuration and auditing options |
| `REPORT` | Basic report generation options |
| `REPORT-ADV` | Advanced report customization |
| `REPORT-SECT` | Options to include/exclude specific report sections |
| `REPORT-HTML` | HTML-specific output formatting |
| `REPORT-LATEX` | LaTeX-specific output formatting |
| `AUDIT-ACL` | Access Control List (ACL) auditing options |
| `AUDIT-PASS` | Password strength and policy auditing |
| `AUDIT-ADV` | Advanced auditing parameters |
| `CONFIG-FILE` | Usage of nipper configuration files |

## Notes
- By default, `nipper` reads from `stdin` and outputs HTML to `stdout`.
- When auditing CheckPoint Firewall-1, ensure you point the `--input` flag to the directory containing the configuration files, not a single file.
- Nipper-ng is a fork of the original GPL Nipper 0.11.10 and remains free and open source.