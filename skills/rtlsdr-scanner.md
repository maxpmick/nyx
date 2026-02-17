---
name: rtlsdr-scanner
description: Scan a range of radio frequencies using RTL-SDR hardware to visualize signal strength and spectral activity. Use when performing wireless reconnaissance, signal hunting, frequency interference analysis, or spectrum monitoring during wireless security audits.
---

# rtlsdr-scanner

## Overview
A cross-platform Python frequency scanning tool for the OsmoSDR rtl-sdr library. It overcomes tuner frequency response limitations by averaging scans from both positive and negative frequency offsets of the baseband data. Category: Wireless Attacks / SDR.

## Installation (if not already installed)

Assume rtlsdr-scanner is already installed. If you get a "command not found" error:

```bash
sudo apt install rtlsdr-scanner
```

Dependencies: python3, python3-ipdb, python3-matplotlib, python3-numpy, python3-pil, python3-rtlsdr, python3-serial, python3-visvis, python3-wxgtk4.0.

## Common Workflows

### Launch the GUI
```bash
rtlsdr-scanner
```

### Scan a specific range and save to CSV
```bash
rtlsdr-scanner -s 88 -e 108 -w 5 -g 20 scan_results.rfs.csv
```
Scans the FM broadcast band (88-108 MHz) for 5 sweeps with a 20dB gain.

### Remote scanning
```bash
rtlsdr-scanner -r 192.168.1.50:1234 -s 433 -e 435 results.plt
```
Connects to a remote RTL-SDR server to scan the 433 MHz ISM band.

### High-resolution scan with specific dwell time
```bash
rtlsdr-scanner -s 900 -e 915 -f 1024 -d 0.5 -i 0 gsm_band.sdb2
```
Scans with a larger FFT size and longer dwell time on device index 0.

## Complete Command Reference

```
rtlsdr_scan.py [-h] [-s START] [-e END] [-w SWEEPS] [-p DELAY]
               [-g GAIN] [-d DWELL] [-f FFT] [-l LO] [-c CONF]
               [-i INDEX | -r REMOTE]
               [file]
```

### Positional Arguments

| Argument | Description |
|----------|-------------|
| `file` | Output file. Supported extensions: `.rfs.csv`, `.plt`, `.m`, or `.sdb2` |

### Options

| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-s START`, `--start START` | Start frequency in MHz |
| `-e END`, `--end END` | End frequency in MHz |
| `-w SWEEPS`, `--sweeps SWEEPS` | Number of sweeps to perform |
| `-p DELAY`, `--delay DELAY` | Delay between sweeps in seconds |
| `-g GAIN`, `--gain GAIN` | Gain in dB |
| `-d DWELL`, `--dwell DWELL` | Dwell time in seconds |
| `-f FFT`, `--fft FFT` | Number of FFT bins |
| `-l LO`, `--lo LO` | Local oscillator offset |
| `-c CONF`, `--conf CONF` | Load settings from a configuration file |
| `-i INDEX`, `--index INDEX` | Device index (starting from 0) |
| `-r REMOTE`, `--remote REMOTE` | Server IP and port for remote hardware access |

## Notes
- The tool requires compatible RTL-SDR hardware to be plugged in and recognized by the system.
- If no arguments are provided, the tool typically launches in GUI mode.
- Using a high number of FFT bins (`-f`) increases resolution but requires more processing power and time.