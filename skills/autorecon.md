---
name: autorecon
description: Multi-threaded network reconnaissance tool that automates service enumeration. It performs port scanning and then automatically triggers relevant enumeration plugins based on the services discovered. Use during the information gathering and vulnerability analysis phases of a penetration test or CTF to save time and ensure consistent coverage across multiple targets.
---

# autorecon

## Overview
AutoRecon is a multi-threaded network reconnaissance tool designed to automate the process of service enumeration. It identifies open ports and then launches a suite of security tools (nmap, nikto, gobuster, enum4linux, etc.) tailored to the specific services found. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume AutoRecon is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install autorecon
```

## Common Workflows

### Scan a single target with default settings
```bash
autorecon 10.10.10.1
```

### Scan multiple targets from a file
```bash
autorecon -t targets.txt
```

### Scan a CIDR range with custom output directory
```bash
autorecon 192.168.1.0/24 -o /root/engagement/recon
```

### Scan specific ports and use a specific directory busting tool
```bash
autorecon 10.10.10.1 -p 80,443,22 --dirbuster.tool gobuster
```

## Complete Command Reference

```bash
autorecon [options] [targets ...]
```

### Positional Arguments
| Argument | Description |
|----------|-------------|
| `targets` | IP addresses (10.0.0.1), CIDR (10.0.0.1/24), or hostnames to scan. |

### General Options
| Flag | Description |
|------|-------------|
| `-t, --target-file <FILE>` | Read targets from file. |
| `-p, --ports <PORTS>` | Ports to scan. E.g., `53,T:21-25,80,U:123,B:123` (T:TCP, U:UDP, B:Both). |
| `-m, --max-scans <INT>` | Max concurrent scans (Default: 50). |
| `-mp, --max-port-scans <INT>` | Max concurrent port scans (Default: 10). |
| `-c, --config <FILE>` | Location of config file. |
| `-g, --global-file <FILE>` | Location of global file. |
| `--tags <TAGS>` | Filter plugins by tags (Default: default). |
| `--exclude-tags <TAGS>` | Exclude plugins by tags. |
| `--port-scans <PLUGINS>` | Override tags for specific PortScan plugins. |
| `--service-scans <PLUGINS>` | Override tags for specific ServiceScan plugins. |
| `--reports <PLUGINS>` | Override tags for specific Report plugins. |
| `--plugins-dir <DIR>` | Main plugins directory. |
| `--add-plugins-dir <DIR>` | Additional plugins directory. |
| `-l, --list [TYPE]` | List plugins (all, port, or service). |
| `-o, --output <DIR>` | Output directory (Default: results). |
| `--single-target` | Don't create target-named subdirectories. |
| `--only-scans-dir` | Only create the "scans" directory. |
| `--no-port-dirs` | Store all results directly in "scans" without port subdirs. |
| `--heartbeat <INT>` | Status message interval in seconds (Default: 60). |
| `--timeout <MIN>` | Max runtime for AutoRecon in minutes. |
| `--target-timeout <MIN>` | Max runtime per target in minutes. |
| `--nmap <ARGS>` | Override default nmap extra flags (`-vv --reason -Pn -T4`). |
| `--nmap-append <ARGS>` | Append to default nmap extra flags. |
| `--proxychains` | Run via proxychains. |
| `--disable-sanity-checks` | Disable pre-run sanity checks. |
| `--disable-keyboard-control` | Disable interactive keyboard commands. |
| `--ignore-plugin-checks` | Ignore errors from plugin check functions. |
| `--force-services <SVC>` | Force service identification (e.g., `tcp/80/http`). |
| `-mpti <PLUGIN:N>` | Max plugin instances per target. |
| `-mpgi <PLUGIN:N>` | Max global plugin instances. |
| `--accessible` | Make output screenreader friendly. |
| `-v, --verbose` | Increase verbosity (repeatable). |
| `--version` | Print version. |
| `-h, --help` | Show help message. |

### Plugin Specific Arguments
| Flag | Description |
|------|-------------|
| `--curl.path <VAL>` | Path on web server to curl (Default: /). |
| `--dirbuster.tool <TOOL>` | Tool: `feroxbuster`, `gobuster`, `dirsearch`, `ffuf`, `dirb`. |
| `--dirbuster.wordlist <VAL>` | Wordlist(s) for directory busting. |
| `--dirbuster.threads <VAL>` | Threads for directory busting (Default: 10). |
| `--dirbuster.ext <VAL>` | Extensions to fuzz (e.g., txt,html,php). |
| `--dirbuster.recursive` | Enable recursive searching. |
| `--dirbuster.extras <VAL>` | Extra options for the dirbuster tool. |
| `--enum4linux.tool <TOOL>` | Tool: `enum4linux-ng`, `enum4linux`. |
| `--onesixtyone.community-strings <FILE>` | SNMP community strings file. |
| `--redirect-host-discovery.update-hosts` | Add discovered hostnames to `/etc/hosts`. |
| `--subdomain-enum.domain <VAL>` | Base domain for subdomain enumeration. |
| `--subdomain-enum.wordlist <VAL>` | Wordlist(s) for subdomain enumeration. |
| `--subdomain-enum.threads <VAL>` | Threads for subdomain enumeration. |
| `--vhost-enum.hostname <VAL>` | Base host for vhost enumeration. |
| `--vhost-enum.wordlist <VAL>` | Wordlist(s) for vhost enumeration. |
| `--vhost-enum.threads <VAL>` | Threads for vhost enumeration. |
| `--wpscan.api-token <VAL>` | API Token for WPScan. |

### Global Plugin Arguments
| Flag | Description |
|------|-------------|
| `--global.username-wordlist <VAL>` | Default username wordlist for brute forcing. |
| `--global.password-wordlist <VAL>` | Default password wordlist for brute forcing. |
| `--global.domain <VAL>` | Domain to use for DNS/Active Directory plugins. |

## Notes
- AutoRecon creates a structured directory for each target: `scans/` (tool outputs), `exploit/`, `loot/`, and `report/`.
- It relies on many external tools; ensure `seclists` is installed for default wordlists to work.
- Use `[s]` during execution to see the current status of all running and queued scans.