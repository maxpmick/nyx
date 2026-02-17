---
name: ohrwurm
description: A small and simple RTP fuzzer designed to test SIP phones and VoIP infrastructure by injecting bit errors into RTP streams. Use when performing VoIP security assessments, fuzzing RTP traffic, or testing the robustness of SIP phone codecs and RTP handling. It requires a Man-in-the-Middle (MitM) position, typically achieved via arpspoof.
---

# ohrwurm

## Overview
ohrwurm is an RTP fuzzer that targets VoIP traffic. It can either sniff SIP messages to automatically identify RTP port numbers or take manual port definitions to fuzz any RTP stream. It operates by introducing a configurable Bit Error Ratio (BER) into the payload to simulate a "noisy line" and break RTP handling. Category: Vulnerability Analysis / Sniffing & Spoofing.

## Installation (if not already installed)
Assume ohrwurm is already installed. If the command is missing:

```bash
sudo apt update && sudo apt install ohrwurm dsniff
```
*Note: `dsniff` is required for the `arpspoof` utility to perform the necessary MitM attack.*

## Common Workflows

### Fuzzing via SIP Sniffing
To automatically detect RTP ports by monitoring SIP signaling between two phones:
```bash
ohrwurm -a 192.168.1.123 -b 192.168.1.15 -i eth0
```

### Fuzzing Specific RTP Ports
To bypass SIP sniffing and immediately fuzz known RTP ports (e.g., port 6970 on both targets):
```bash
ohrwurm -a 192.168.1.123 -b 192.168.1.15 -A 6970 -B 6970 -i eth0
```

### High Intensity Fuzzing with RTCP Suppression
To increase the error rate to 5% and suppress RTCP packets (preventing codecs from adapting to the noise):
```bash
ohrwurm -a 192.168.1.123 -b 192.168.1.15 -e 5.0 -t
```

## Complete Command Reference

```
usage: ohrwurm -a <IP target a> -b <IP target b> [-s <randomseed>] [-e <bit error ratio in %>] [-i <interface>] [-A <RTP port a> -B <RTP port b>]
```

### Options

| Flag | Description |
|------|-------------|
| `-a <address>` | IPv4 address of SIP phone A (dot-decimal notation) |
| `-b <address>` | IPv4 address of SIP phone B (dot-decimal notation) |
| `-s <integer>` | Random seed for fuzzing patterns (default: read from `/dev/urandom`) |
| `-e <double>` | Bit error ratio (BER) in % (default: 1.230000) |
| `-i <interface>` | Network interface to use (default: `eth0`) |
| `-t` | Suppress RTCP packets to prevent codecs from learning about the "noisy line" |
| `-A <port>` | Manual RTP port number on IP address A (requires `-B`) |
| `-B <port>` | Manual RTP port number on IP address B (requires `-A`) |

## Notes
- **MitM Requirement**: ohrwurm requires the attacker to be in a Man-in-the-Middle position between the two targets. Use `arpspoof` (from the `dsniff` package) to redirect traffic through your machine before running ohrwurm.
- **Environment**: This tool is designed for switched LAN environments. Gateway (GW) operation is only partially supported.
- **SIP Sniffing**: If `-A` and `-B` are omitted, the tool waits for a SIP INVITE/OK exchange to extract the dynamic RTP ports.
- **Safety**: Fuzzing RTP can cause SIP phones to crash, reboot, or exhibit unexpected audio behavior. Use with caution on production hardware.