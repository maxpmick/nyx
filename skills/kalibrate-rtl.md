---
name: kalibrate-rtl
description: Calculate local oscillator frequency offset for RTL-SDR devices using GSM base stations. Use when calibrating SDR hardware, performing radio frequency reconnaissance, or ensuring frequency accuracy for wireless signal analysis and GSM monitoring.
---

# kalibrate-rtl

## Overview
Kalibrate (kal) scans for GSM base stations in specific frequency bands and uses their signals to calculate the local oscillator frequency offset of RTL-SDR devices. This calibration is essential for accurate frequency tuning in Software Defined Radio (SDR) applications. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
Assume the tool is installed. If the `kal` command is missing:

```bash
sudo apt install kalibrate-rtl
```

## Common Workflows

### Scan for GSM Base Stations
Scan a specific band (e.g., GSM900) to find nearby base stations and their signal power.
```bash
kal -s GSM900
```

### Calculate Clock Offset by Channel
After finding a strong channel (e.g., channel 128), calculate the frequency error in PPM (parts per million).
```bash
kal -c 128
```

### Calculate Clock Offset by Frequency
Calculate the offset using a known specific frequency of a nearby base station.
```bash
kal -f 869.2M
```

### Use Specific RTL-SDR Device with Gain
Specify a device index and set a manual gain for better signal reception during calibration.
```bash
kal -s EGSM -d 1 -g 45
```

## Complete Command Reference

### Usage Modes

| Mode | Command |
|------|---------|
| **GSM Base Station Scan** | `kal <-s band indicator> [options]` |
| **Clock Offset Calculation** | `kal <-f frequency \| -c channel> [options]` |

### Options

| Flag | Description |
|------|-------------|
| `-s` | Band to scan. Supported: `GSM850`, `GSM-R`, `GSM900`, `EGSM`, `DCS`, `PCS` |
| `-f` | Frequency of nearby GSM base station |
| `-c` | Channel of nearby GSM base station |
| `-b` | Band indicator. Supported: `GSM850`, `GSM-R`, `GSM900`, `EGSM`, `DCS`, `PCS` |
| `-g` | Gain in dB |
| `-d` | RTL-SDR device index (default: 0) |
| `-e` | Initial frequency error in ppm |
| `-E` | Manual frequency offset in Hz |
| `-v` | Verbose output |
| `-D` | Enable debug messages |
| `-h` | Show help message |

## Notes
- **PPM Error**: Most RTL-SDR dongles have a frequency offset. Once `kal` provides the "average absolute error" in ppm, you should use this value in other SDR software (like GQRX or RTL_433) to ensure you are tuned to the correct frequency.
- **Signal Strength**: For accurate calibration, choose a channel with the highest "power" value reported during the scan.
- **Hardware**: Requires a compatible RTL2832U-based SDR dongle.