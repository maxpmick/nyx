---
name: rtpinsertsound
description: Insert custom audio into a live RTP (VoIP) stream by spoofing RTP packets. Use this tool during penetration testing of VoIP infrastructure to perform audio injection attacks, stream manipulation, or to test the resilience of VoIP sessions against unauthorized media insertion.
---

# rtpinsertsound

## Overview
rtpinsertsound is a security tool designed to inject audio into a specified live RTP (Real-time Transport Protocol) stream. It works by capturing legitimate RTP packets to synchronize sequence numbers and timestamps, then transmitting spoofed audio packets into the stream. Category: Vulnerability Analysis / VoIP Testing.

## Installation (if not already installed)
The tool is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update
sudo apt install rtpinsertsound
```

## Common Workflows

### Basic Audio Injection
Inject a WAV file into a detected RTP stream on the default interface:
```bash
rtpinsertsound /usr/share/rtpinsertsound/stapler.wav -v
```

### Targeted Injection with Specific Endpoints
Inject audio into a specific stream between two known IP addresses and ports:
```bash
rtpinsertsound input.wav -a 192.168.1.50 -A 16384 -b 192.168.1.60 -B 16385 -i eth1
```

### Injection with Jitter and Spoofing Adjustments
Inject audio while delaying the spoofed packet transmission to 20% of the codec interval (jitter factor) and using a custom spoof increment:
```bash
rtpinsertsound message.wav -j 20 -f 5 -v
```

## Complete Command Reference

```bash
rtpinsertsound [Mandatory Path] [Optional Flags]
```

### Mandatory Argument

| Argument | Description |
|----------|-------------|
| `pathname` | Path to the audio file to be mixed into the live stream. |

**Audio File Requirements:**
- **If .wav extension:** Must be a standard Microsoft RIFF WAVE file.
  - Chunks: `RIFF, fmt, fact, data` OR `RIFF, fmt, data`.
  - Compression: PCM/Uncompressed (Code 1).
  - Channels: 1 (Mono).
  - Sample Rate: 8000 Hz.
  - Bits/Sample: Signed linear 16-bit or Unsigned linear 8-bit.
- **If NOT .wav extension:** Presumed to be a `tcpdump` formatted file containing exclusively G.711 u-law RTP/UDP/IP/Ethernet messages.

### Optional Flags

| Flag | Description |
|------|-------------|
| `-a <addr>` | Source RTP IPv4 address to target. |
| `-A <port>` | Source RTP port to target. |
| `-b <addr>` | Destination RTP IPv4 address to target. |
| `-B <port>` | Destination RTP port to target. |
| `-f <factor>` | **Spoof factor**: Amount to increment RTP sequence numbers, multiply payload length for timestamps, and increment IP header IDs. [Range: +/- 1000, Default: 2] |
| `-i <interface>` | Network interface to use (e.g., eth0). |
| `-j <factor>` | **Jitter factor**: Determines when the spoofed packet is transmitted relative to the next expected legitimate packet. [Range: 0-80, Default: 80 (ASAP)]. A factor > 10 is advised. |
| `-p <seconds>` | Seconds to pause between setup and injection. |
| `-h` | Print help/usage message. |
| `-v` | Enable verbose output mode. |

## Notes
- **Jitter Logic:** A jitter factor of 10 means the tool waits until the time-of-day is within 10% of the expected arrival of the next legitimate packet before sending the spoofed one.
- **Multi-interface Warning:** On hosts with multiple active interfaces, Linux routing tables may cause spoofed packets to exit via a different interface than the one specified. This usually only causes issues if packets loop back to the source interface.
- **Synchronization:** The tool requires the reception of legitimate RTP packets to enable the output of spoofed packets.