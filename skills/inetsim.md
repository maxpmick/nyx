---
name: inetsim
description: Simulate common internet services (HTTP, DNS, SMTP, etc.) in a lab environment to analyze the network behavior of unknown malware samples. Use when performing malware analysis, network forensics, or setting up isolated research environments to capture and log malicious network traffic.
---

# inetsim

## Overview
INetSim is a software suite for simulating common internet services in a lab environment. It is primarily used for analyzing the network behavior of unknown malware samples by providing fake responses for protocols like HTTP, DNS, SMTP, and more. Category: Digital Forensics / Incident Response.

## Installation (if not already installed)
Assume inetsim is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install inetsim
```

## Common Workflows

### Start with default configuration
```bash
sudo inetsim
```
Starts all enabled services using the default configuration file (usually `/etc/inetsim/inetsim.conf`).

### Run with a custom configuration and bind address
```bash
sudo inetsim --config /path/to/custom.conf --bind-address 192.168.1.10
```
Useful for multi-homed analysis machines or specific lab setups.

### Malware analysis with custom log and report directories
```bash
sudo inetsim --log-dir ./logs --report-dir ./reports --session malware_sample_01
```
Organizes output for a specific analysis session.

### Adjusting Faketime for time-sensitive malware
```bash
sudo inetsim --faketime-init-delta -86400 --faketime-auto-delay 60 --faketime-auto-incr 3600
```
Sets the initial time back 24 hours and increments the fake clock by 1 hour every 60 seconds.

## Complete Command Reference

```
inetsim [options]
```

### General Options

| Flag | Description |
|------|-------------|
| `--help` | Print the help message |
| `--version` | Show version information |
| `--config=<filename>` | Configuration file to use (Default: `/etc/inetsim/inetsim.conf`) |
| `--log-dir=<directory>` | Directory logfiles are written to |
| `--data-dir=<directory>` | Directory containing service data (e.g., fake files for HTTP/FTP) |
| `--report-dir=<directory>` | Directory reports are written to |
| `--bind-address=<IP>` | Default IP address to bind services to. Overrides `default_bind_address` in config |
| `--max-childs=<num>` | Default maximum number of child processes per service. Overrides `default_max_childs` |
| `--user=<username>` | Default user to run services. Overrides `default_run_as_user` |
| `--session=<id>` | Session id to use. Defaults to main process id |
| `--pidfile=<filename>` | Pid file to use. Defaults to `/var/run/inetsim.pid` |

### Faketime Options

| Flag | Description |
|------|-------------|
| `--faketime-init-delta=<secs>` | Initial faketime delta in seconds. Overrides `faketime_init_delta` |
| `--faketime-auto-delay=<secs>` | Delay for auto incrementing faketime in seconds. Overrides `faketime_auto_delay` |
| `--faketime-auto-incr=<secs>` | Delta for auto incrementing faketime in seconds. Overrides `faketime_auto_increment` |

### Supported Services
INetSim simulates the following services:
- **Web**: HTTP, HTTPS
- **Mail**: SMTP, SMTPS, POP3, POP3S
- **Infrastructure**: DNS, NTP, TFTP, Syslog, Ident, Finger
- **Chat/Other**: IRC, FTP, FTPS
- **Small Servers**: Daytime, Time, Echo, Chargen, Discard, Quotd

## Notes
- **Root Privileges**: INetSim must be run as root to bind to privileged ports (e.g., 80, 53, 25).
- **DNS Redirection**: When using the INetSim DNS service, ensure the victim machine's DNS settings point to the INetSim server's IP.
- **Configuration**: Most service-specific behavior (like what file to return for an HTTP request) is managed via the `inetsim.conf` file and the `data-dir`.
- **Reports**: Upon stopping INetSim (Ctrl+C), a report is generated in the `report-dir` summarizing all connections and actions observed during the session.