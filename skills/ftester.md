---
name: ftester
description: Test firewall filtering policies and Intrusion Detection System (IDS) capabilities by injecting custom packets and analyzing reception. Use to verify firewall rules, test IDS evasion techniques (fragmentation/segmentation), and simulate real TCP connections for stateful inspection testing during security audits.
---

# ftester

## Overview
The Firewall Tester (FTester) is a toolset designed for testing firewall filtering policies and IDS capabilities. It consists of a packet generator (`ftest`), a sniffer/receiver (`ftestd`), and a reporting tool (`freport`). It supports TCP connection spoofing, IP fragmentation, TCP segmentation, and various IDS evasion techniques. Category: Reconnaissance / Information Gathering, Web Application Testing.

## Installation (if not already installed)
Assume ftester is already installed. If the command is missing:

```bash
sudo apt install ftester
```

## Common Workflows

### Basic Firewall Policy Testing
1. **On the Receiver (Destination):** Run the daemon to listen for incoming test packets.
   ```bash
   ftestd -i eth0 -p 80,443,22 -l ftestd.log
   ```
2. **On the Sender (Source):** Send packets defined in a configuration file.
   ```bash
   ftest -f firewall_test.conf -v 1
   ```
3. **Generate Report:** Compare the logs to see which packets were filtered.
   ```bash
   freport ftest.log ftestd.log
   ```

### Testing IDS Evasion with Fragmentation
Send packets split into 4 IP fragments to test if the IDS correctly reassembles and detects the payload.
```bash
ftest -c 192.168.1.5:1025:192.168.1.10:80:S:TCP:0 -g 4 -v 1
```

### Simulating a Stateful TCP Connection
Send a SYN packet followed by a FIN to test stateful inspection handling.
```bash
ftest -c 192.168.1.5:1025:192.168.1.10:80:S:TCP:0 -F
```

## Complete Command Reference

### ftest (Client/Packet Generator)
Used to inject custom packets into the network.

| Flag | Argument | Description |
|------|----------|-------------|
| `-f` | `<conf_file>` | Load test parameters from a configuration file |
| `-c` | `<src_ip>:<src_port>:<dst_ip>:<dst_port>:<flags>:<proto>:<tos>` | Define a single manual connection string |
| `-v` | `<level>` | Set verbosity level |
| `-d` | `<delay>` | Delay between packets (e.g., 0.25 for 250ms) |
| `-s` | `<sleep>` | Sleep time between tests (e.g., 1 for 1 second) |
| `-e` | `<method>` | Specify IDS evasion method |
| `-t` | `<ids_ttl>` | Set a specific TTL for IDS evasion testing |
| `-r` | None | Reset connection (send RST) |
| `-F` | None | End connection (send FIN) |
| `-g` | `<num\|size>` | IP fragmentation: specify number of fragments (e.g., `4`) or size (e.g., `16b`) |
| `-p` | `<num\|size>` | TCP segmentation: specify number of segments (e.g., `4`) or size (e.g., `6b`) |
| `-k` | `<value>` | Set a custom checksum value (e.g., `60000`) |
| `-m` | `<marker>` | Set a specific marker for the test |

### ftestd (Sniffer/Receiver)
The daemon that listens on the destination side to record which packets successfully bypassed the firewall.

*Note: While the source documentation provided minimal help output for ftestd, it is typically used with `-i` (interface) and `-l` (logfile) in standard ftester deployments.*

### freport (Reporting Tool)
Compares the log from the sender and the receiver to identify filtered packets.

```bash
freport <ftest.log> <ftestd.log>
```

## Notes
- **Configuration File Format**: When using `-f`, the file typically follows the format: `source_ip:source_port:dest_ip:dest_port:flags:protocol:tos`.
- **TCP Flags**: Common flags for the connection string include `S` (SYN), `A` (ACK), `P` (PSH), `U` (URG), `F` (FIN), `R` (RST).
- **Permissions**: Both `ftest` and `ftestd` require root privileges to craft and sniff raw packets.