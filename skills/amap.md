---
name: amap
description: Identify applications running on specific ports by sending trigger packets and analyzing responses. Use when performing service version detection, identifying non-standard port usage, or fingerprinting applications that do not provide clear banners during reconnaissance and vulnerability analysis.
---

# amap

## Overview
AMAP (Application MAPper) is a next-generation scanning tool that identifies applications even if they are running on a different port than normal. It works by sending trigger packets and matching responses against a database of known application signatures, supporting both ASCII and non-ASCII based applications. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Assume amap is already installed. If the command is missing:

```bash
sudo apt install amap
```

## Common Workflows

### Recommended Identification Scan
Perform application mapping with banners enabled, quiet mode (hide closed ports), and verbosity.
```bash
amap -bqv 192.168.1.15 80
```

### Fast Identification
Stop sending triggers to a port as soon as the first identification is made.
```bash
amap -1q 192.168.1.15 21-443
```

### Scanning from Nmap Output
Read an Nmap machine-readable file to perform deep application identification on discovered ports.
```bash
amap -i nmap_results.gnmap -bqv
```

### Generating New Signatures (amapcrap)
Send random data to a silent port to elicit a response for creating new application definitions.
```bash
amapcrap -n 10 -m a 192.168.1.15 12345
```

## Complete Command Reference

### amap / amap6
`amap` and `amap6` share the same syntax. `amap6` defaults to IPv6.

```
amap [-A|-B|-P|-W] [-1buSRHUdqv] [[-m] -o <file>] [-D <file>] [-t/-T sec] [-c cons] [-C retries] [-p proto] [-i <file>] [target port [port] ...]
```

#### Modes
| Flag | Description |
|------|-------------|
| `-A` | Map applications: send triggers and analyse responses (default) |
| `-B` | Just grab banners, do not send triggers |
| `-P` | No banner or application stuff - be a (full connect) port scanner |

#### Options
| Flag | Description |
|------|-------------|
| `-1` | Only send triggers to a port until 1st identification (Fast mode) |
| `-4` | Use IPv4 instead of IPv6 (specific to `amap6`) |
| `-6` | Use IPv6 instead of IPv4 (specific to `amap`) |
| `-b` | Print ascii banner of responses |
| `-i FILE` | Nmap machine readable output file to read ports from |
| `-u` | Ports specified on command line are UDP (default is TCP) |
| `-R` | Do NOT identify RPC services |
| `-S` | Do NOT identify SSL services |
| `-H` | Do NOT send application triggers marked as potentially harmful |
| `-U` | Do NOT dump unrecognised responses (better for scripting) |
| `-d` | Dump all responses |
| `-v` | Verbose mode (use multiple times for debug) |
| `-q` | Do not report closed ports, and do not print them as unidentified |
| `-o FILE` | Write output to specified file |
| `-m` | Used with `-o`, creates machine readable output |
| `-c CONS` | Amount of parallel connections to make (default 32, max 256) |
| `-C RETRIES` | Number of reconnects on connect timeouts (default 3) |
| `-T SEC` | Connect timeout on connection attempts in seconds (default 5) |
| `-t SEC` | Response wait timeout in seconds (default 5) |
| `-p PROTO` | Only send triggers for this protocol (e.g., ftp) |
| `-D FILE` | Use a custom trigger/response file |

### amapcrap
Used to send random data to a port to elicit responses for signature generation.

```
amapcrap [-S] [-u] [-m 0ab] [-M min,max] [-n connects] [-N delay] [-w delay] [-e] [-v] TARGET PORT
```

| Flag | Description |
|------|-------------|
| `-S` | Use SSL after TCP connect (not usable with `-u`) |
| `-u` | Use UDP protocol (default: TCP) |
| `-n connects` | Maximum number of connects (default: unlimited) |
| `-N delay` | Delay between connects in ms (default: 0) |
| `-w delay` | Delay before closing the port (default: 250ms) |
| `-e` | Do NOT stop when a response was made by the server |
| `-v` | Verbose mode |
| `-m 0ab` | Send random crap: `0` (nullbytes), `a` (letters+spaces), `b` (binary) |
| `-M min,max` | Minimum and maximum length of random crap |

## Notes
- **Usage Hint**: The developers recommend using `-bqv` for standard scans and adding `-1` for high-speed checks.
- **Trigger Files**: amap uses files typically located in `/etc/amap/` (appdefs.trig, appdefs.resp, appdefs.rpc).
- **amapcrap Output**: This tool outputs proper `amap` appdefs definitions that can be added to the response database.