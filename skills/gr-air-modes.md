---
name: gr-air-modes
description: A software-defined radio (SDR) receiver for Mode S transponder signals and ADS-B reports from aircraft. Use this tool to intercept aviation telemetry, track aircraft in real-time, and export flight data to formats like KML, SQLite, or SBS-1. It is essential for wireless reconnaissance and signal analysis within the SDR domain.
---

# gr-air-modes

## Overview
`gr-air-modes` is a GNU Radio-based receiver for Mode S and ADS-B transponder signals. It allows for the collection of aircraft data including position, altitude, and velocity using SDR hardware. It supports multiple output formats including parsed text, SQLite, KML for Google Earth, and SBS-1 for PlanePlotter. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
The tool is typically pre-installed in Kali Linux. If missing:

```bash
sudo apt update && sudo apt install gr-air-modes
```

## Common Workflows

### Basic ADS-B Reception with RTL-SDR
Use the `osmocom` source to receive signals at the default 1090MHz frequency:
```bash
modes_rx -s osmocom -g 40
```

### Tracking Aircraft for Google Earth (KML)
Save live flight paths to a KML file for real-time viewing in Google Earth:
```bash
modes_rx -s osmocom -K flights.kml -l 37.7749,-122.4194
```
*(Note: `-l` provides the station's GPS coordinates for better distance calculations).*

### Feeding Data to Virtual Radar Server (SBS-1)
Open a server on port 30003 to provide data to external visualization software:
```bash
modes_rx -s osmocom -P
```

### Processing a Captured IQ File
Analyze a pre-recorded radio capture file:
```bash
modes_rx -s capture.iq -r 2000000
```

## Complete Command Reference

### modes_rx
The primary receiver application.

#### General Options
| Flag | Description |
|------|-------------|
| `-h`, `--help` | Show help message and exit |
| `-l LOCATION`, `--location=LOCATION` | GPS coordinates of receiving station (format: `xx.xxxxx,xx.xxxxx`) |
| `-a REMOTE`, `--remote=REMOTE` | Specify additional servers to take data from (format: `tcp://x.x.x.x:y,tcp://...`) |
| `-n`, `--no-print` | Disable printing decoded packets to stdout |
| `-K KML`, `--kml=KML` | Filename for Google Earth KML output |
| `-P`, `--sbs1` | Open an SBS-1-compatible server on port 30003 |
| `-m MULTIPLAYER`, `--multiplayer=MULTIPLAYER` | FlightGear server to send aircraft data (format: `host:port`) |

#### Receiver Setup Options
| Flag | Description |
|------|-------------|
| `-s SOURCE`, `--source=SOURCE` | Choose source: `uhd`, `osmocom`, `<filename>`, or `<ip:port>` [default: `uhd`] |
| `-t PORT`, `--tcp=PORT` | Open a TCP server on this port to publish reports |
| `-R SUBDEV`, `--subdev=SUBDEV` | Select USRP Rx side A or B |
| `-A ANTENNA`, `--antenna=ANTENNA` | Select which antenna to use on daughterboard |
| `-D ARGS`, `--args=ARGS` | Arguments to pass to radio constructor (e.g., serial number) |
| `-f FREQ`, `--freq=FREQ` | Set receive frequency in Hz [default: `1090000000.0`] |
| `-g dB`, `--gain=dB` | Set RF gain |
| `-r RATE`, `--rate=RATE` | Set sample rate [default: `4000000.0`] |
| `-T THRESHOLD`, `--threshold=THRESHOLD` | Set pulse detection threshold above noise in dB [default: `7.0`] |
| `-p`, `--pmf` | Use pulse matched filtering [default: `True`] |
| `-d`, `--dcblock` | Use a DC blocking filter (recommended for HackRF Jawbreaker) [default: `False`] |

## Notes
- **Hardware Support**: Works with most SDRs supported by Gr-OsmoSDR (RTL-SDR, HackRF, BladeRF) and UHD (Ettus USRP).
- **Dependencies**: The FlightGear interface requires `python3-numpy` and `python3-scipy`. If these are missing, the multiplayer feature will be disabled.
- **Performance**: High sample rates (`-r`) provide better timing resolution but require more CPU power. 4Msps is the recommended default for Mode S.