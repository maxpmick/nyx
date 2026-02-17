---
name: multimon-ng
description: Decode digital radio transmission modes including POCSAG, FLEX, EAS, DTMF, and various AFSK/FSK modulations. Use when performing signal intelligence (SIGINT), monitoring pager traffic, decoding emergency alert systems, or analyzing VHF/UHF digital radio signals via SDR or sound card input.
---

# multimon-ng

## Overview
The successor to multimon, multimon-ng is a digital radio transmission decoder for VHF/UHF bands. It supports concurrent decoding of multiple modes from a single signal source, such as a radio sound card, GNU Radio sink, or RTL-SDR pipe. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume multimon-ng is already installed. If you encounter an error:

```bash
sudo apt install multimon-ng
```

## Common Workflows

### Decode Pager Traffic (POCSAG) from RTL-SDR
Pipes raw audio from `rtl_fm` at the required 22050 Hz sample rate into multimon-ng to decode common pager speeds.
```bash
rtl_fm -f 149.614M -s 22050 | multimon-ng -t raw -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha -
```

### Decode DTMF Tones from a WAV file
Uses SoX (automatically called by multimon-ng for non-raw files) to process a recorded audio file for DTMF tones.
```bash
multimon-ng -a DTMF recording.wav
```

### Monitor Multiple Modes Simultaneously
Decodes APRS (AFSK1200) and ZVEI selective calling tones from the default sound card.
```bash
multimon-ng -a AFSK1200 -a ZVEI1 -a ZVEI2
```

## Complete Command Reference

```bash
multimon-ng [options] [file] [file] ...
```
If no file is given, input is read from the default sound hardware. Use `-` for standard input.

### Demodulator Selection

| Flag | Description |
|------|-------------|
| `-a <demod>` | Add a demodulator to the active list |
| `-s <demod>` | Subtract (remove) a demodulator from the active list |
| `-c` | Remove all demodulators (must be followed by `-a` to add specific ones) |

**Available Demodulators:**
POCSAG512, POCSAG1200, POCSAG2400, FLEX, FLEX_NEXT, EAS, UFSK1200, CLIPFSK, FMSFSK, AFSK1200, AFSK2400, AFSK2400_2, AFSK2400_3, HAPN4800, FSK9600, DTMF, ZVEI1, ZVEI2, ZVEI3, DZVEI, PZVEI, EEA, EIA, CCIR, MORSE_CW, DUMPCSV, X10, SCOPE.

### General Options

| Flag | Description |
|------|-------------|
| `-t <type>` | Input file type (any type other than `raw` requires `sox` installed) |
| `-q` | Quiet mode |
| `-v <level>` | Verbosity level (e.g., `-v 3`). For POCSAG/MORSE_CW, `-v 1` prints decoding stats |
| `-h` | Display help message |
| `-A` | APRS mode (TNC2 text output) |
| `-n` | Don't flush stdout (increases performance) |
| `--timestamp` | Add a time stamp to the front of every printed line |
| `--label` | Add a label to the front of every printed line |

### SoX Integration Options

| Flag | Description |
|------|-------------|
| `-m` | Mute SoX warnings |
| `-r` | Call SoX in repeatable mode (fixed random seed for dithering) |

### POCSAG Specific Options

| Flag | Description |
|------|-------------|
| `-e` | Hide empty messages |
| `-u` | Heuristically prune unlikely decodes |
| `-i` | Invert input samples (useful if decoding fails due to signal polarity) |
| `-p` | Show partially received messages |
| `-f <mode>` | Force decoding of data as `<mode>` (`numeric`, `alpha`, `skyper`, or `auto`) |
| `-b <level>` | BCH bit error correction level (default: 2, set 0 to disable) |
| `-C <cs>` | Set Charset |

### CW (Morse) Specific Options

| Flag | Description |
|------|-------------|
| `-o` | Set threshold for dit detection (default: 500) |
| `-d` | Dit length in ms (default: 50) |
| `-g` | Gap length in ms (default: 50) |
| `-x` | Disable auto threshold detection |
| `-y` | Disable auto timing detection |

### FMS Specific Options

| Flag | Description |
|------|-------------|
| `-j` | Just output hex data and CRC, no parsing |

## Notes
- **Input Requirements**: Raw input requires 1 channel, 16-bit signed integer samples at 22050 Hz.
- **Piping**: When piping from tools like `rtl_fm`, always use `-t raw` and ensure the sample rate matches (usually 22050 Hz).
- **Performance**: Use the `-n` flag if you are processing high volumes of data to prevent stdout flushing bottlenecks.