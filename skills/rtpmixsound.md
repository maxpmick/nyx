---
name: rtpmixsound
description: Mix pre-recorded audio in real-time into a live RTP audio stream. Use when performing VoIP security testing, audio injection attacks, or man-in-the-middle scenarios where you need to overlay or replace audio in a target's active call.
---

# rtpmixsound

## Overview
rtpmixsound is a tool designed to mix pre-recorded audio into a live RTP (Real-time Transport Protocol) stream. It identifies a target audio stream and injects audio packets, synchronizing sequence numbers and timestamps to blend the audio. Category: Vulnerability Analysis / Sniffing & Spoofing / VoIP.

## Installation (if not already installed)
Assume the tool is already installed. If missing:

```bash
sudo apt install rtpmixsound
```

## Common Workflows

### Basic Audio Injection
Inject a WAV file into the first detected RTP stream on the default interface:
```bash
rtpmixsound /path/to/audio.wav -v
```

### Targeted Injection
Inject audio into a specific call between two known IP addresses and ports:
```bash
rtpmixsound /path/to/audio.wav -a 192.168.1.50 -A 16384 -b 192.168.1.60 -B 16388
```

### Injection with Jitter and Spoof Adjustments
Inject audio with a specific jitter factor to control timing and a spoof factor to adjust header increments:
```bash
rtpmixsound /path/to/audio.wav -j 20 -f 5 -i eth1
```

## Complete Command Reference

```bash
rtpmixsound <audio_file_path> [Options]
```

### Mandatory Argument

| Argument | Description |
|----------|-------------|
| `audio_file_path` | Path to the file to be mixed. If `.wav`, it must be RIFF PCM mono, 8000Hz, 8 or 16-bit. If no extension, it is treated as a `tcpdump` file containing G.711 u-law RTP/UDP/IP/Ethernet messages. |

### Optional Flags

| Flag | Description |
|------|-------------|
| `-a <addr>` | Source RTP IPv4 address to target. |
| `-A <port>` | Source RTP port to target. |
| `-b <addr>` | Destination RTP IPv4 address to target. |
| `-B <port>` | Destination RTP port to target. |
| `-f <factor>` | **Spoof factor**: Amount to increment RTP sequence numbers, multiply payload length for timestamps, and increment IP ID numbers. [Range: +/- 1000, Default: 2] |
| `-i <iface>` | Network interface to use (e.g., `eth0`). |
| `-j <factor>` | **Jitter factor**: Determines timing of spoofed packet transmission relative to legitimate packets. A factor of 10 means 10% of the codec's interval. [Range: 0 - 80, Default: 80 (ASAP)] |
| `-p <sec>` | Seconds to pause between setup and injection. |
| `-h` | Print help and usage information. |
| `-v` | Enable verbose output mode. |

## Notes

### Audio File Requirements (.wav)
To ensure compatibility, the WAV file must meet these strict constraints:
1. **Format**: Standard Microsoft RIFF WAVE.
2. **Chunks**: Must be `RIFF, fmt, fact, data` or `RIFF, fmt, data`.
3. **Compression**: Code 1 (PCM/Uncompressed).
4. **Channels**: 1 (Mono).
5. **Sample Rate**: 8000 Hz.
6. **Bit Depth**: Signed linear 16-bit or Unsigned linear 8-bit.

### Networking Gotchas
- **Interface Routing**: On hosts with multiple active interfaces, Linux may route spoofed packets through an interface other than the one specified if the routing table dictates.
- **Feedback Loops**: If spoofed packets arrive back at the host through the specified interface (e.g., via a hub), it may interfere with the tool's operation.
- **Jitter**: A jitter factor (`-j`) of 10 or higher is advised to ensure packets are sent before the next legitimate packet arrives.