---
name: chaosreader
description: Trace network sessions and export them to HTML format from packet capture files (pcap/snoop). Use when performing network forensics, traffic analysis, or session reconstruction to extract HTTP transfers, FTP files, emails, and interactive session replays (Telnet, IRC, VNC) during post-exploitation or incident response.
---

# chaosreader

## Overview
Chaosreader is a network forensics tool that processes tcpdump or snoop logs to fetch application data. It reconstructs TCP/UDP sessions and extracts files (HTML, GIF, JPEG, etc.), emails, and creates realtime replay programs for interactive sessions like Telnet, Rlogin, IRC, X11, and VNC. Category: Digital Forensics / Sniffing & Spoofing.

## Installation (if not already installed)
Assume chaosreader is already installed. If not:

```bash
sudo apt install chaosreader
```

## Common Workflows

### Basic Session Extraction
Analyze a pcap file and generate an HTML index of all discovered sessions:
```bash
chaosreader output.pcap
```

### Comprehensive Extraction
Create HTML 2-way hex dumps and info files for every connection:
```bash
chaosreader -ve output.pcap
```

### Target Specific Protocols
Extract only FTP (20, 21) and Telnet (23) sessions:
```bash
chaosreader -p 20,21,23 output.pcap
```

### Standalone Sniffing
Capture network traffic directly for 5 minutes and process it:
```bash
chaosreader -s 5
```

## Complete Command Reference

### General Usage
```bash
chaosreader [Options] infile [infile2 ...]
chaosreader -s [mins] | -S [mins[,count]] [-z] [-f 'filter']
```

### Processing Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-a` | `--application` | Create application session files (default) |
| `-d` | `--preferdns` | Show DNS names instead of IP addresses |
| `-e` | `--everything` | Create HTML 2-way & hex files for everything |
| `-h` | | Print a brief help |
| `--help` | | Print verbose help and version |
| `--help2` | | Print massive help |
| `-i` | `--info` | Create info file |
| `-q` | `--quiet` | Quiet, no output to screen |
| `-r` | `--raw` | Create raw files |
| `-v` | `--verbose` | Verbose - Create ALL files (except -e) |
| `-x` | `--index` | Create index files (default) |
| `-k` | `--keydata` | Create extra files for keystroke analysis |
| `-n` | `--names` | Include hostnames in hyperlinked HTTPlog (HTML) |

### Exclusion Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-A` | `--noapplication`| Exclude application session files |
| `-H` | `--hex` | Include hex dumps (slow) |
| `-I` | `--noinfo` | Exclude info files |
| `-R` | `--noraw` | Exclude raw files |
| `-T` | `--notcp` | Exclude TCP traffic |
| `-U` | `--noudp` | Exclude UDP traffic |
| `-Y` | `--noicmp` | Exclude ICMP traffic |
| `-X` | `--noindex` | Exclude index files |

### Filtering & Output Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-D <dir>` | `--dir <dir>` | Output all files to this directory |
| `-b <ports>` | `--playtcp <ports>` | Replay these TCP ports (comma separated) |
| `-B <ports>` | `--playudp <ports>` | Replay these UDP ports (comma separated) |
| `-l <ports>` | `--htmltcp <ports>` | Create HTML for these TCP ports |
| `-L <ports>` | `--htmludp <ports>` | Create HTML for these UDP ports |
| `-m <size>` | `--min <size>` | Min size of connection to save (e.g., "1k") |
| `-M <size>` | `--max <size>` | Max size of connection to save (e.g., "1024k") |
| `-o <order>` | `--sort <order>` | Sort order: `time`, `size`, `type`, or `ip` (Default: time) |
| `-p <ports>` | `--port <ports>` | Only examine these ports (TCP & UDP) |
| `-P <ports>` | `--noport <ports>` | Exclude these ports (TCP & UDP) |
| `-j <IPs>` | `--ipaddr <IPs>` | Only examine these IP addresses |
| `-J <IPs>` | `--noipaddr <IPs>` | Exclude these IP addresses |

### Standalone Mode Options

| Flag | Alias | Description |
|------|-------|-------------|
| `-s <mins>` | `--runonce <mins>` | Run tcpdump/snoop for X minutes |
| `-S <m,c>` | `--runmany <m,c>` | X samples of Y minutes each |
| `-z` | `--runredo` | Rereads last run's logs |
| `-f <filter>`| `--filter <filter>`| Use this dump filter (tcpdump syntax) |

## Notes
- When using `tcpdump` to create input files, use `-s0` or `-s9000` to ensure the full packet payload is captured, otherwise sessions cannot be reconstructed.
- The tool creates many small files; using the `-D` flag to specify an output directory is highly recommended to avoid cluttering the working directory.
- Replay files for Telnet/IRC can be played back in the terminal to see exactly what the user saw.