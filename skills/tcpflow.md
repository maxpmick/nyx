---
name: tcpflow
description: Capture and reconstruct TCP data streams (flows) into separate files or console output. Unlike tcpdump which shows packet summaries, tcpflow reconstructs the actual data transmitted, handling sequence numbers and out-of-order delivery. Use when performing protocol analysis, debugging network traffic, sniffing cleartext credentials, or extracting files from captured network traffic during forensics and incident response.
---

# tcpflow

## Overview
tcpflow is a specialized packet capture tool that reconstructs TCP streams and stores each flow in a separate file for analysis. It supports the same filtering expressions as tcpdump and can process live interface traffic or existing pcap files. Category: Digital Forensics / Sniffing & Spoofing.

## Installation (if not already installed)
Assume tcpflow is already installed. If not:
```bash
sudo apt install tcpflow
```

## Common Workflows

### Capture all HTTP traffic on eth0 to the console
```bash
tcpflow -i eth0 -c port 80
```

### Reconstruct flows from a pcap file into a specific directory
```bash
mkdir output_flows
tcpflow -r traffic.pcap -o output_flows
```

### Capture and display traffic in alternating colors without headers
```bash
tcpflow -C -g
```

### Extract data from a specific host and port
```bash
tcpflow -i wlan0 host 192.168.1.50 and port 443
```

## Complete Command Reference

```
tcpflow [-aBcCDhIpsvVZ] [-b max_bytes] [-d debug_level] [-[eE] scanner] [-f max_fds] [-F[ctTXMkmg]] [-h|--help] [-i iface] [-l files...] [-L semlock] [-m min_bytes] [-o outdir] [-r file] [-R file] [-S name=value] [-T template] [-U|--relinquish-privileges user] [-v|--verbose] [-w file] [-x scanner] [-X xmlfile] [-z|--chroot dir] [expression]
```

### General Options

| Flag | Description |
|------|-------------|
| `-a` | Do ALL post-processing |
| `-b max_bytes` | Max number of bytes per flow to save |
| `-d debug_level` | Debug level (default is 1) |
| `-f` | Maximum number of file descriptors to use |
| `-h`, `--help` | Print help message (`-hh` for more help) |
| `-H` | Print detailed information about each scanner |
| `-i` | Network interface on which to listen |
| `-I` | Write for each flow another file `*.findx` to provide byte-indexed timestamps |
| `-l` | Treat non-flag arguments as input files rather than a pcap expression |
| `-L semlock` | Specifies that writes are locked using a named semaphore |
| `-p` | Don't use promiscuous mode |
| `-q` | Quiet mode - do not print warnings |
| `-r file` | Read packets from tcpdump pcap file (may be repeated) |
| `-R file` | Read packets from tcpdump pcap file TO FINISH CONNECTIONS |
| `-v`, `--verbose` | Verbose operation equivalent to `-d 10` |
| `-V` | Print version number and exit |
| `-w file` | Write packets not processed to file |
| `-o outdir` | Specify output directory (default '.') |
| `-X filename` | DFXML output to filename |
| `-m bytes` | Specifies skip that starts a new stream (default 16777216) |
| `-F{p}` | Filename prefix/suffix (`-hh` for options) |
| `-T{t}` | Filename template (default `%A.%a-%B.%b%V%v%C%c`) |
| `-Z` | Do not decompress gzip-compressed HTTP transactions |
| `-K` | Output/keep pcap flow structure |

### Console Output Options

| Flag | Description |
|------|-------------|
| `-B` | Binary output, even with `-c` or `-C` |
| `-c` | Console print only (don't create files) |
| `-C` | Console print only, without the display of source/dest header |
| `-g` | Output each flow in alternating colors |
| `-0` | Don't print newlines after packets when printing to console |
| `-s` | Strip non-printable characters (change to '.') |
| `-J` | Output in JSON format |
| `-D` | Output in hex (useful to combine with `-c` or `-C`) |

### Scanner Control

| Flag | Description |
|------|-------------|
| `-E scanner` | Turn off all scanners except specified scanner |
| `-x scanner` | Exclude a specific scanner |
| `-S name=value` | Set a configuration parameter |

### Security Options

| Flag | Description |
|------|-------------|
| `-U user` | Relinquish privileges and become user (if running as root) |
| `-z dir`, `--chroot dir` | Chroot to directory (requires that `-U` be used) |

### Filtering
| Argument | Description |
|----------|-------------|
| `expression` | Standard tcpdump-like BPF filtering expression (e.g., `tcp port 80`) |

## Notes
- tcpflow does not currently understand IP fragments; flows containing fragments will not be recorded properly.
- When using `-c` or `-C`, binary data may mess up your terminal unless `-s` or `-D` is used.
- The tool is highly effective for extracting files (like images or executables) sent over unencrypted protocols.