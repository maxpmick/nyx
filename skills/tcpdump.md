---
name: tcpdump
description: Capture and analyze network traffic by dumping packet headers or full payloads. Use for network troubleshooting, security monitoring, protocol analysis, and traffic sniffing during penetration testing or digital forensics.
---

# tcpdump

## Overview
A powerful command-line packet analyzer that allows users to intercept and display TCP/IP and other packets being transmitted or received over a network. It supports a wide range of protocols including IPv4, IPv6, TCP, UDP, ICMP, and many application-layer protocols. Category: Sniffing & Spoofing / Information Gathering / Digital Forensics.

## Installation (if not already installed)
Assume tcpdump is already installed. If you get a "command not found" error:

```bash
sudo apt install tcpdump
```

## Common Workflows

### Capture traffic on a specific interface
```bash
tcpdump -i eth0
```

### Capture and save to a PCAP file for later analysis
```bash
tcpdump -i eth0 -w capture.pcap
```

### Read from a PCAP file with filters
```bash
tcpdump -r capture.pcap 'tcp port 80 and host 192.168.1.10'
```

### Capture full packet payloads in Hex and ASCII
```bash
tcpdump -i any -nn -vv -XX
```

## Complete Command Reference

```
tcpdump [-AbdDefhHIJKlLnNOpqStuUvxX#] [ -B size ] [ -c count ] [--count]
        [ -C file_size ] [ -E algo:secret ] [ -F file ] [ -G seconds ]
        [ -i interface ] [ --immediate-mode ] [ -j tstamptype ]
        [ -M secret ] [ --number ] [ --print ] [ -Q in|out|inout ]
        [ -r file ] [ -s snaplen ] [ -T type ] [ --version ]
        [ -V file ] [ -w file ] [ -W filecount ] [ -y datalinktype ]
        [ --time-stamp-precision precision ] [ --micro ] [ --nano ]
        [ -z postrotate-command ] [ -Z user ] [ expression ]
```

### General Options

| Flag | Description |
|------|-------------|
| `-A` | Print each packet (minus link level header) in ASCII |
| `-b` | Print the AS number in BGP packets |
| `-B <size>` | Set the operating system capture buffer size to `size` KiB |
| `-c <count>` | Exit after receiving `count` packets |
| `--count` | Print only the packet count upon finishing |
| `-C <file_size>` | Before writing a raw packet to a savefile, check if file is larger than `file_size` (MB) |
| `-d` | Dump the compiled packet-matching code in human readable form to stdout |
| `-dd` | Dump packet-matching code as a C program fragment |
| `-ddd` | Dump packet-matching code as decimal numbers (preceded with a count) |
| `-D`, `--list-interfaces` | Print the list of the network interfaces available on the system |
| `-e` | Print the link-level header on each dump line |
| `-E <algo:secret>` | Use `algo:secret` for decrypting IPsec ESP packets |
| `-f` | Print 'foreign' IPv4 addresses numerically |
| `-F <file>` | Use `file` as input for the filter expression; additional expressions on command line are ignored |
| `-G <seconds>` | Rotate the dump file specified by `-w` every `seconds` seconds |
| `-h`, `--help` | Print version and usage information |
| `-H` | Attempt to detect 802.11s draft mesh headers |
| `-i <interface>` | Listen on `interface`. If unspecified, searches the system list for the lowest numbered, configured up interface |
| `--immediate-mode` | Deliver packets immediately to the output rather than buffering |
| `-I`, `--monitor-mode` | Put the interface in "monitor mode" (IEEE 802.11 Wi-Fi only) |
| `-j <tstamptype>` | Set the time stamp type for the capture |
| `-J`, `--list-time-stamp-types` | List the supported time stamp types for the interface |
| `-K` | Don't attempt to verify IP, TCP, or UDP checksums |
| `-l` | Make stdout line buffered (useful for piping) |
| `-L`, `--list-data-link-types` | List the known data link types for the interface |
| `-m <module>` | Load SMI MIB module definitions from file `module` |
| `-M <secret>` | Use `secret` as a shared secret for validating the digest in TCP segments with the TCP-MD5 option |
| `-n` | Don't convert addresses (host addresses, port numbers, etc.) to names |
| `-N` | Don't print domain name qualification of host names |
| `--number` | Print an optional packet number at the beginning of the line |
| `-O` | Do not run the packet-matching code optimizer |
| `-p` | Don't put the interface into promiscuous mode |
| `--print` | Print packets even when writing to a file with `-w` |
| `-q` | Quick (quiet) output. Print less protocol information |
| `-Q <direction>` | Choose send/receive direction (`in`, `out`, or `inout`) |
| `-r <file>` | Read packets from `file` (created with `-w`) |
| `-s <snaplen>` | Snarf `snaplen` bytes of data from each packet rather than the default (262144 bytes) |
| `-S`, `--absolute-tcp-sequence-numbers` | Print absolute, rather than relative, TCP sequence numbers |
| `-t` | Don't print a timestamp on each dump line |
| `-tt` | Print an unformatted timestamp on each dump line |
| `-ttt` | Print a delta (microsecond resolution) between current and previous line |
| `-tttt` | Print a timestamp in default format proceeded by date on each dump line |
| `-ttttt` | Print a delta (microsecond resolution) between current and first line |
| `-T <type>` | Force packets selected by "expression" to be interpreted as the specified `type` |
| `-u` | Print undecoded NFS handles |
| `-U`, `--packet-buffered` | If `-w` is specified, make the raw packet output "packet-buffered" |
| `-v` | Verbose output (slightly more detail) |
| `-vv` | Even more verbose output |
| `-vvv` | Most verbose output |
| `-V <file>` | Read a list of filenames from `file` |
| `-w <file>` | Write the raw packets to `file` rather than parsing and printing them |
| `-W <filecount>` | Limit the number of files created by `-C` or `-G` |
| `-x` | Print each packet (minus link level header) in hex |
| `-xx` | Print each packet, including link level header, in hex |
| `-X` | Print each packet (minus link level header) in hex and ASCII |
| `-XX` | Print each packet, including link level header, in hex and ASCII |
| `-y <datalinktype>` | Set the data link type to use while capturing |
| `-z <command>` | Run `command` on savefiles after rotation |
| `-Z <user>` | Drops privileges from root and changes user ID to `user` |
| `#` | Print an optional packet number at the beginning of the line |
| `--time-stamp-precision <p>` | Set the time stamp precision (`micro` or `nano`) |
| `--micro` | Alias for `--time-stamp-precision micro` |
| `--nano` | Alias for `--time-stamp-precision nano` |
| `--version` | Print the tcpdump and libpcap version strings |

## Notes
- Running `tcpdump` usually requires root privileges (`sudo`).
- Use `-nn` to disable both name and port resolution for faster performance and cleaner output.
- The `expression` at the end of the command uses BPF (Berkeley Packet Filter) syntax (e.g., `host 10.0.0.1`, `port 443`, `net 192.168.1.0/24`).
- To stop a capture, use `Ctrl+C`.