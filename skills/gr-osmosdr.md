---
name: gr-osmosdr
description: A software interface and set of tools for interacting with various Software Defined Radio (SDR) hardware. It provides a common API for devices like RTL-SDR, HackRF, bladeRF, and USRP. Use it for spectrum analysis, signal generation, and radio frequency reconnaissance during wireless security audits or signal intelligence tasks.
---

# gr-osmosdr

## Overview
gr-osmosdr is a family of Gnuradio blocks and applications that provide a unified interface for a wide range of SDR hardware. It allows users to perform spectrum browsing and signal generation regardless of the underlying radio hardware. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tool is installed. If commands are missing:
```bash
sudo apt install gr-osmosdr
```

## Common Workflows

### Spectrum Analysis with RTL-SDR
Launch a graphical spectrum analyzer using the first available RTL-SDR dongle:
```bash
osmocom_fft -a rtl=0 -v -f 100e6 -s 2.4e6 -g 15
```

### Signal Generation (No GUI)
Generate a constant carrier at 433MHz using a HackRF:
```bash
osmocom_siggen_nogui -a hackrf -f 433e6 --const --amplitude 0.5
```

### Spectrum Browsing with Waterfall
Enable the waterfall display for better signal visualization:
```bash
osmocom_fft -a hackrf -W -f 915e6 -s 10e6
```

## Complete Command Reference

### osmocom_fft
Spectrum Browser application.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-a ARGS, --args=ARGS` | Device arguments (e.g., `rtl=0`, `hackrf`) |
| `-A ANTENNA, --antenna=ANTENNA` | Select RX antenna where appropriate |
| `-s SAMP_RATE, --samp-rate=SAMP_RATE` | Set sample rate (bandwidth) |
| `-f FREQ, --center-freq=FREQ` | Set center frequency |
| `-c FREQ_CORR, --freq-corr=FREQ_CORR` | Set frequency correction (ppm) |
| `-g GAIN, --gain=GAIN` | Set gain in dB (default is midpoint) |
| `-W, --waterfall` | Enable waterfall display |
| `-S, --oscilloscope` | Enable oscilloscope display |
| `--avg-alpha=AVG_ALPHA` | Set fftsink averaging factor (default: 0.1) |
| `--averaging` | Enable fftsink averaging |
| `--ref-scale=REF_SCALE` | Set dBFS=0dB input value (default: 1.0) |
| `--fft-size=FFT_SIZE` | Set number of FFT bins (default: 1024) |
| `--fft-rate=FFT_RATE` | Set FFT update rate (default: 30) |
| `-v, --verbose` | Use verbose console output |

### osmocom_siggen_nogui
Command-line signal generator.

| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message and exit |
| `-a ARGS, --args=ARGS` | Device arguments |
| `-A ANTENNA, --antenna=ANTENNA` | Select TX antenna where appropriate |
| `--clock-source=SOURCE` | Set clock source (internal, external, gpsdo, etc.) |
| `-s SAMP_RATE, --samp-rate=SAMP_RATE` | Set sample rate |
| `-g GAIN, --gain=GAIN` | Set gain in dB |
| `-G GAINS, --gains=GAINS` | Set named gains (name:gain,name:gain,...) |
| `-f FREQ, --tx-freq=FREQ` | Set carrier frequency |
| `-c FREQ_CORR, --freq-corr=FREQ_CORR` | Set carrier frequency correction |
| `-x FREQ, --waveform-freq=FREQ` | Set baseband waveform frequency |
| `-y FREQ, --waveform2-freq=FREQ` | Set 2nd waveform frequency |
| `--sine` | Generate carrier modulated by complex sine wave |
| `--const` | Generate a constant carrier |
| `--offset=OFFSET` | Set waveform phase offset |
| `--gaussian` | Generate Gaussian random output |
| `--uniform` | Generate Uniform random output |
| `--2tone` | Generate Two Tone signal for IMD testing |
| `--sweep` | Generate a swept sine wave |
| `--gsm` | Generate GMSK modulated GSM Burst Sequence |
| `--amplitude=AMPL` | Set output amplitude (0.1-1.0, default: 0.3) |
| `-v, --verbose` | Use verbose console output |

### Device Specification Arguments (`-a` or `--args`)

#### RTL-SDR
- `rtl=<index>`: 0-based index or serial number.
- `rtl_xtal=<freq>`: Frequency for RTL chip.
- `tuner_xtal=<freq>`: Frequency for tuner chip.
- `buffers=<num>`: Number of buffers (default: 32).
- `buflen=<len>`: Buffer length (default: 256kB, multiple of 512).
- `direct_samp=0|1|2`: Direct sampling (0: Off, 1: I, 2: Q).
- `offset_tune=0|1`: Offset tune for E4000 tuners.

#### HackRF
- `hackrf`: Use without value.
- `buffers=<num>`: Number of buffers (default: 32).

#### bladeRF
- `bladerf[=0]`: 0-based device identifier.
- `fw='/path/to/firmware.img'`: Path to MCU firmware.
- `fpga='/path/to/bitstream.rbf'`: Path to FPGA bitstream.

#### UHD (USRP)
- `uhd`: Use without value.
- `nchan=<count>`: Channel count.
- `subdev=<spec>`: Subdevice specification (e.g., "A:0").
- `lo_offset=<freq>`: Local Oscillator offset in Hz.

#### RTL-SDR TCP
- `rtl_tcp=<host>:<port>`: Defaults to localhost:1234.
- `psize=<size>`: Payload size (default: 16384).

#### FUNcube Dongle (FCD)
- `fcd=<index>`: 0-based device identifier.
- `device=hw:2`: Override audio device.
- `type=1|2`: 1 for Classic, 2 for Pro+.

#### IQ File Source
- `file=<path>`: Path to file.
- `freq=<freq>`: Center frequency.
- `rate=<rate>`: Mandatory sampling rate.
- `repeat=true|false`: Default true.
- `throttle=true|false`: Default true.

## Notes
- When using RTL-SDR, you can use `rtl_eeprom -s` to program a custom serial number to distinguish between multiple dongles.
- HackRF transmit support is available but should be used with caution and appropriate licensing/shielding.
- For UHD devices, additional argument/value pairs are passed directly to the underlying Ettus driver.